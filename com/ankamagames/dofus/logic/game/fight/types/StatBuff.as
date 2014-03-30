package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   
   public class StatBuff extends BasicBuff
   {
      
      public function StatBuff(effect:FightTemporaryBoostEffect=null, castingSpell:CastingSpell=null, actionId:int=0) {
         if(effect)
         {
            super(effect,castingSpell,actionId,effect.delta,null,null);
            this._statName = ActionIdConverter.getActionStatName(actionId);
            this._isABoost = ActionIdConverter.getIsABoost(actionId);
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StatBuff));
      
      private var _statName:String;
      
      private var _isABoost:Boolean;
      
      override public function get type() : String {
         return "StatBuff";
      }
      
      public function get statName() : String {
         return this._statName;
      }
      
      public function get delta() : int {
         if(_effect is EffectInstanceDice)
         {
            return this._isABoost?EffectInstanceDice(_effect).diceNum:-EffectInstanceDice(_effect).diceNum;
         }
         return 0;
      }
      
      override public function onApplyed() : void {
         var tempValue:* = 0;
         var multi:* = 0;
         var targetCaracs:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
         if(targetCaracs)
         {
            if(targetCaracs.hasOwnProperty(this._statName))
            {
               CharacterBaseCharacteristic(targetCaracs[this._statName]).contextModif = CharacterBaseCharacteristic(targetCaracs[this._statName]).contextModif + this.delta;
            }
            switch(this.statName)
            {
               case "vitality":
                  tempValue = targetCaracs.maxLifePoints;
                  if(tempValue + this.delta < 0)
                  {
                     targetCaracs.maxLifePoints = 0;
                  }
                  else
                  {
                     targetCaracs.maxLifePoints = targetCaracs.maxLifePoints + this.delta;
                  }
                  tempValue = targetCaracs.lifePoints;
                  if(tempValue + this.delta < 0)
                  {
                     targetCaracs.lifePoints = 0;
                  }
                  else
                  {
                     targetCaracs.lifePoints = targetCaracs.lifePoints + this.delta;
                  }
                  break;
               case "lifePoints":
               case "lifePointsMalus":
                  tempValue = targetCaracs.lifePoints;
                  if(tempValue + this.delta < 0)
                  {
                     targetCaracs.lifePoints = 0;
                  }
                  else
                  {
                     targetCaracs.lifePoints = targetCaracs.lifePoints + this.delta;
                  }
                  break;
               case "movementPoints":
                  targetCaracs.movementPointsCurrent = targetCaracs.movementPointsCurrent + this.delta;
                  break;
               case "actionPoints":
                  targetCaracs.actionPointsCurrent = targetCaracs.actionPointsCurrent + this.delta;
                  break;
               case "summonableCreaturesBoost":
                  SpellWrapper.refreshAllPlayerSpellHolder(targetId);
                  break;
               case "range":
                  FightSpellCastFrame.updateRangeAndTarget();
                  break;
            }
         }
         var infos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(targetId) as GameFightFighterInformations;
         switch(this.statName)
         {
            case "vitality":
               infos.stats["lifePoints"] = infos.stats["lifePoints"] + this.delta;
               infos.stats["maxLifePoints"] = infos.stats["maxLifePoints"] + this.delta;
               break;
            case "lifePointsMalus":
               infos.stats["lifePoints"] = infos.stats["lifePoints"] + this.delta;
               break;
            case "lifePoints":
            case "shieldPoints":
            case "dodgePALostProbability":
            case "dodgePMLostProbability":
               tempValue = infos.stats[this._statName];
               if(tempValue + this.delta < 0)
               {
                  infos.stats[this._statName] = 0;
               }
               else
               {
                  infos.stats[this._statName] = infos.stats[this._statName] + this.delta;
               }
               break;
            case "agility":
               infos.stats["tackleEvade"] = infos.stats["tackleEvade"] + this.delta / 10;
               infos.stats["tackleBlock"] = infos.stats["tackleBlock"] + this.delta / 10;
               break;
            case "globalResistPercentBonus":
            case "globalResistPercentMalus":
               multi = this.statName == "globalResistPercentMalus"?-1:1;
               infos.stats["neutralElementResistPercent"] = infos.stats["neutralElementResistPercent"] + this.delta * multi;
               infos.stats["airElementResistPercent"] = infos.stats["airElementResistPercent"] + this.delta * multi;
               infos.stats["waterElementResistPercent"] = infos.stats["waterElementResistPercent"] + this.delta * multi;
               infos.stats["earthElementResistPercent"] = infos.stats["earthElementResistPercent"] + this.delta * multi;
               infos.stats["fireElementResistPercent"] = infos.stats["fireElementResistPercent"] + this.delta * multi;
               break;
            case "actionPoints":
               infos.stats["actionPoints"] = infos.stats["actionPoints"] + this.delta;
               infos.stats["maxActionPoints"] = infos.stats["maxActionPoints"] + this.delta;
               break;
            case "movementPoints":
               infos.stats["movementPoints"] = infos.stats["movementPoints"] + this.delta;
               infos.stats["maxMovementPoints"] = infos.stats["maxMovementPoints"] + this.delta;
               break;
         }
         super.onApplyed();
      }
      
      override public function onRemoved() : void {
         var effect:Effect = null;
         if(!_removed)
         {
            effect = Effect.getEffectById(actionId);
            if(!effect.active)
            {
               this.decrementStats();
            }
         }
         super.onRemoved();
      }
      
      override public function onDisabled() : void {
         var effect:Effect = null;
         if(!_disabled)
         {
            effect = Effect.getEffectById(actionId);
            if(effect.active)
            {
               this.decrementStats();
            }
         }
         super.onDisabled();
      }
      
      private function decrementStats() : void {
         var tempValue:* = 0;
         var targetCaracs:CharacterCharacteristicsInformations = null;
         var playedcharacterCharac:CharacterCharacteristicsInformations = null;
         var multi:* = 0;
         targetCaracs = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
         if(targetCaracs)
         {
            if(targetCaracs.hasOwnProperty(this._statName))
            {
               CharacterBaseCharacteristic(targetCaracs[this._statName]).contextModif = CharacterBaseCharacteristic(targetCaracs[this._statName]).contextModif - this.delta;
            }
            switch(this._statName)
            {
               case "movementPoints":
                  targetCaracs.movementPointsCurrent = targetCaracs.movementPointsCurrent - this.delta;
                  break;
               case "actionPoints":
                  targetCaracs.actionPointsCurrent = targetCaracs.actionPointsCurrent - this.delta;
                  break;
               case "vitality":
                  targetCaracs.maxLifePoints = targetCaracs.maxLifePoints - this.delta;
                  if(targetCaracs.lifePoints > this.delta)
                  {
                     targetCaracs.lifePoints = targetCaracs.lifePoints - this.delta;
                  }
                  else
                  {
                     targetCaracs.lifePoints = 0;
                  }
                  break;
               case "lifePoints":
               case "lifePointsMalus":
                  playedcharacterCharac = targetCaracs;
                  if(playedcharacterCharac.lifePoints > this.delta)
                  {
                     if(playedcharacterCharac.maxLifePoints >= playedcharacterCharac.lifePoints - this.delta)
                     {
                        playedcharacterCharac.lifePoints = playedcharacterCharac.lifePoints - this.delta;
                     }
                     else
                     {
                        playedcharacterCharac.lifePoints = playedcharacterCharac.maxLifePoints;
                     }
                  }
                  else
                  {
                     playedcharacterCharac.lifePoints = 0;
                  }
                  break;
               case "summonableCreaturesBoost":
                  break;
               case "range:":
                  break;
            }
         }
         var infos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(targetId) as GameFightFighterInformations;
         switch(this.statName)
         {
            case "vitality":
               infos.stats["lifePoints"] = infos.stats["lifePoints"] - this.delta;
               infos.stats["maxLifePoints"] = infos.stats["maxLifePoints"] - this.delta;
               break;
            case "lifePointsMalus":
               infos.stats["lifePoints"] = infos.stats["lifePoints"] - this.delta;
               if(infos.stats["lifePoints"] > infos.stats["maxLifePoints"])
               {
                  infos.stats["lifePoints"] = infos.stats["maxLifePoints"];
               }
               break;
            case "lifePoints":
            case "shieldPoints":
            case "dodgePALostProbability":
            case "dodgePMLostProbability":
               tempValue = infos.stats[this._statName];
               if(tempValue - this.delta < 0)
               {
                  infos.stats[this._statName] = 0;
               }
               else
               {
                  infos.stats[this._statName] = infos.stats[this._statName] - this.delta;
               }
               break;
            case "globalResistPercentBonus":
            case "globalResistPercentMalus":
               multi = this.statName == "globalResistPercentMalus"?-1:1;
               infos.stats["neutralElementResistPercent"] = infos.stats["neutralElementResistPercent"] - this.delta * multi;
               infos.stats["airElementResistPercent"] = infos.stats["airElementResistPercent"] - this.delta * multi;
               infos.stats["waterElementResistPercent"] = infos.stats["waterElementResistPercent"] - this.delta * multi;
               infos.stats["earthElementResistPercent"] = infos.stats["earthElementResistPercent"] - this.delta * multi;
               infos.stats["fireElementResistPercent"] = infos.stats["fireElementResistPercent"] - this.delta * multi;
               break;
            case "agility":
               infos.stats["tackleEvade"] = infos.stats["tackleEvade"] - this.delta / 10;
               infos.stats["tackleBlock"] = infos.stats["tackleBlock"] - this.delta / 10;
               break;
            case "actionPoints":
               infos.stats["actionPoints"] = infos.stats["actionPoints"] - this.delta;
               infos.stats["maxActionPoints"] = infos.stats["maxActionPoints"] - this.delta;
               break;
            case "movementPoints":
               infos.stats["movementPoints"] = infos.stats["movementPoints"] - this.delta;
               infos.stats["maxMovementPoints"] = infos.stats["maxMovementPoints"] - this.delta;
               break;
         }
      }
      
      override public function clone(id:int=0) : BasicBuff {
         var sb:StatBuff = new StatBuff();
         sb._statName = this._statName;
         sb._isABoost = this._isABoost;
         sb.id = uid;
         sb.uid = uid;
         sb.actionId = actionId;
         sb.targetId = targetId;
         sb.castingSpell = castingSpell;
         sb.duration = duration;
         sb.dispelable = dispelable;
         sb.source = source;
         sb.aliveSource = aliveSource;
         sb.parentBoostUid = parentBoostUid;
         sb.initParam(param1,param2,param3);
         return sb;
      }
   }
}
