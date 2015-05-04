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
      
      public function StatBuff(param1:FightTemporaryBoostEffect = null, param2:CastingSpell = null, param3:int = 0)
      {
         if(param1)
         {
            super(param1,param2,param3,param1.delta,null,null);
            this._statName = ActionIdConverter.getActionStatName(param3);
            this._isABoost = ActionIdConverter.getIsABoost(param3);
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StatBuff));
      
      private var _statName:String;
      
      private var _isABoost:Boolean;
      
      private var _zeroDiff:int;
      
      override public function get type() : String
      {
         return "StatBuff";
      }
      
      public function get statName() : String
      {
         return this._statName;
      }
      
      public function get delta() : int
      {
         if(_effect is EffectInstanceDice)
         {
            return this._isABoost?EffectInstanceDice(_effect).diceNum:-EffectInstanceDice(_effect).diceNum;
         }
         return 0;
      }
      
      public function get zeroDiff() : int
      {
         return this._zeroDiff;
      }
      
      override public function onApplyed() : void
      {
         var _loc1_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
         if(_loc2_)
         {
            if(_loc2_.hasOwnProperty(this._statName))
            {
               CharacterBaseCharacteristic(_loc2_[this._statName]).contextModif = CharacterBaseCharacteristic(_loc2_[this._statName]).contextModif + this.delta;
            }
            switch(this.statName)
            {
               case "vitality":
                  _loc1_ = _loc2_.maxLifePoints;
                  if(_loc1_ + this.delta < 0)
                  {
                     _loc2_.maxLifePoints = 0;
                  }
                  else
                  {
                     _loc2_.maxLifePoints = _loc2_.maxLifePoints + this.delta;
                  }
                  _loc1_ = _loc2_.lifePoints;
                  if(_loc1_ + this.delta < 0)
                  {
                     _loc2_.lifePoints = 0;
                  }
                  else
                  {
                     _loc2_.lifePoints = _loc2_.lifePoints + this.delta;
                  }
                  break;
               case "lifePoints":
               case "lifePointsMalus":
                  _loc1_ = _loc2_.lifePoints;
                  if(_loc1_ + this.delta < 0)
                  {
                     _loc2_.lifePoints = 0;
                  }
                  else
                  {
                     _loc2_.lifePoints = _loc2_.lifePoints + this.delta;
                  }
                  break;
               case "movementPoints":
                  _loc2_.movementPointsCurrent = _loc2_.movementPointsCurrent + this.delta;
                  break;
               case "actionPoints":
                  _loc2_.actionPointsCurrent = _loc2_.actionPointsCurrent + this.delta;
                  break;
               case "summonableCreaturesBoost":
                  SpellWrapper.refreshAllPlayerSpellHolder(targetId);
                  break;
               case "range":
                  FightSpellCastFrame.updateRangeAndTarget();
                  break;
               case "invisibilityState":
                  break;
            }
         }
         var _loc3_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(targetId) as GameFightFighterInformations;
         switch(this.statName)
         {
            case "vitality":
               _loc3_.stats["lifePoints"] = _loc3_.stats["lifePoints"] + this.delta;
               _loc3_.stats["maxLifePoints"] = _loc3_.stats["maxLifePoints"] + this.delta;
               break;
            case "lifePointsMalus":
               _loc3_.stats["lifePoints"] = _loc3_.stats["lifePoints"] + this.delta;
               break;
            case "lifePoints":
            case "shieldPoints":
            case "dodgePALostProbability":
            case "dodgePMLostProbability":
               _loc1_ = _loc3_.stats[this._statName];
               if(_loc1_ + this.delta < 0)
               {
                  _loc3_.stats[this._statName] = 0;
               }
               else
               {
                  _loc3_.stats[this._statName] = _loc3_.stats[this._statName] + this.delta;
               }
               break;
            case "agility":
               _loc3_.stats["tackleEvade"] = _loc3_.stats["tackleEvade"] + this.delta / 10;
               _loc3_.stats["tackleBlock"] = _loc3_.stats["tackleBlock"] + this.delta / 10;
               break;
            case "globalResistPercentBonus":
            case "globalResistPercentMalus":
               _loc4_ = this.statName == "globalResistPercentMalus"?-1:1;
               _loc3_.stats["neutralElementResistPercent"] = _loc3_.stats["neutralElementResistPercent"] + this.delta * _loc4_;
               _loc3_.stats["airElementResistPercent"] = _loc3_.stats["airElementResistPercent"] + this.delta * _loc4_;
               _loc3_.stats["waterElementResistPercent"] = _loc3_.stats["waterElementResistPercent"] + this.delta * _loc4_;
               _loc3_.stats["earthElementResistPercent"] = _loc3_.stats["earthElementResistPercent"] + this.delta * _loc4_;
               _loc3_.stats["fireElementResistPercent"] = _loc3_.stats["fireElementResistPercent"] + this.delta * _loc4_;
               break;
            case "actionPoints":
               _loc3_.stats["actionPoints"] = _loc3_.stats["actionPoints"] + this.delta;
               _loc3_.stats["maxActionPoints"] = _loc3_.stats["maxActionPoints"] + this.delta;
               break;
            case "movementPoints":
               _loc3_.stats["movementPoints"] = _loc3_.stats["movementPoints"] + this.delta;
               _loc3_.stats["maxMovementPoints"] = _loc3_.stats["maxMovementPoints"] + this.delta;
               break;
            case "tackleBlock":
            case "tackleEvade":
               if(_loc3_.stats[this._statName] + this.delta < 0)
               {
                  this._zeroDiff = _loc3_.stats[this._statName] + this.delta;
                  _loc3_.stats[this._statName] = 0;
               }
               else
               {
                  _loc3_.stats[this._statName] = _loc3_.stats[this._statName] + this.delta;
               }
               break;
            case "invisibilityState":
               break;
            default:
               if(_loc3_)
               {
                  if(_loc3_.stats.hasOwnProperty(this._statName))
                  {
                     _loc3_.stats[this._statName] = _loc3_.stats[this._statName] + this.delta;
                  }
               }
               else
               {
                  _log.fatal("ATTENTION, le serveur essaye de buffer une entité qui n\'existe plus ! id=" + targetId);
               }
         }
         super.onApplyed();
      }
      
      override public function onRemoved() : void
      {
         var _loc1_:Effect = null;
         if(!_removed)
         {
            _loc1_ = Effect.getEffectById(actionId);
            if(!_loc1_.active)
            {
               this.decrementStats();
            }
         }
         super.onRemoved();
      }
      
      override public function onDisabled() : void
      {
         var _loc1_:Effect = null;
         if(!_disabled)
         {
            _loc1_ = Effect.getEffectById(actionId);
            if(_loc1_.active)
            {
               this.decrementStats();
            }
         }
         super.onDisabled();
      }
      
      private function decrementStats() : void
      {
         var _loc1_:* = 0;
         var _loc2_:CharacterCharacteristicsInformations = null;
         var _loc4_:CharacterCharacteristicsInformations = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         _loc2_ = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
         if(_loc2_)
         {
            if(_loc2_.hasOwnProperty(this._statName))
            {
               CharacterBaseCharacteristic(_loc2_[this._statName]).contextModif = CharacterBaseCharacteristic(_loc2_[this._statName]).contextModif - this.delta;
            }
            switch(this._statName)
            {
               case "movementPoints":
                  _loc2_.movementPointsCurrent = _loc2_.movementPointsCurrent - this.delta;
                  break;
               case "actionPoints":
                  _loc2_.actionPointsCurrent = _loc2_.actionPointsCurrent - this.delta;
                  break;
               case "vitality":
                  _loc2_.maxLifePoints = _loc2_.maxLifePoints - this.delta;
                  if(_loc2_.lifePoints > this.delta)
                  {
                     _loc2_.lifePoints = _loc2_.lifePoints - this.delta;
                  }
                  else
                  {
                     _loc2_.lifePoints = 0;
                  }
                  break;
               case "lifePoints":
               case "lifePointsMalus":
                  _loc4_ = _loc2_;
                  if(_loc4_.lifePoints > this.delta)
                  {
                     if(_loc4_.maxLifePoints >= _loc4_.lifePoints - this.delta)
                     {
                        _loc4_.lifePoints = _loc4_.lifePoints - this.delta;
                     }
                     else
                     {
                        _loc4_.lifePoints = _loc4_.maxLifePoints;
                     }
                  }
                  else
                  {
                     _loc4_.lifePoints = 0;
                  }
                  break;
               case "summonableCreaturesBoost":
               case "range":
               case "invisibilityState":
                  break;
            }
         }
         var _loc3_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(targetId) as GameFightFighterInformations;
         switch(this.statName)
         {
            case "vitality":
               _loc3_.stats["lifePoints"] = _loc3_.stats["lifePoints"] - this.delta;
               _loc3_.stats["maxLifePoints"] = _loc3_.stats["maxLifePoints"] - this.delta;
               break;
            case "lifePointsMalus":
               _loc3_.stats["lifePoints"] = _loc3_.stats["lifePoints"] - this.delta;
               if(_loc3_.stats["lifePoints"] > _loc3_.stats["maxLifePoints"])
               {
                  _loc3_.stats["lifePoints"] = _loc3_.stats["maxLifePoints"];
               }
               break;
            case "lifePoints":
            case "shieldPoints":
            case "dodgePALostProbability":
            case "dodgePMLostProbability":
               _loc1_ = _loc3_.stats[this._statName];
               if(_loc1_ - this.delta < 0)
               {
                  _loc3_.stats[this._statName] = 0;
               }
               else
               {
                  _loc3_.stats[this._statName] = _loc3_.stats[this._statName] - this.delta;
               }
               break;
            case "globalResistPercentBonus":
            case "globalResistPercentMalus":
               _loc5_ = this.statName == "globalResistPercentMalus"?-1:1;
               _loc3_.stats["neutralElementResistPercent"] = _loc3_.stats["neutralElementResistPercent"] - this.delta * _loc5_;
               _loc3_.stats["airElementResistPercent"] = _loc3_.stats["airElementResistPercent"] - this.delta * _loc5_;
               _loc3_.stats["waterElementResistPercent"] = _loc3_.stats["waterElementResistPercent"] - this.delta * _loc5_;
               _loc3_.stats["earthElementResistPercent"] = _loc3_.stats["earthElementResistPercent"] - this.delta * _loc5_;
               _loc3_.stats["fireElementResistPercent"] = _loc3_.stats["fireElementResistPercent"] - this.delta * _loc5_;
               break;
            case "agility":
               _loc3_.stats["tackleEvade"] = _loc3_.stats["tackleEvade"] - this.delta / 10;
               _loc3_.stats["tackleBlock"] = _loc3_.stats["tackleBlock"] - this.delta / 10;
               break;
            case "actionPoints":
               _loc3_.stats["actionPoints"] = _loc3_.stats["actionPoints"] - this.delta;
               _loc3_.stats["maxActionPoints"] = _loc3_.stats["maxActionPoints"] - this.delta;
               break;
            case "movementPoints":
               _loc3_.stats["movementPoints"] = _loc3_.stats["movementPoints"] - this.delta;
               _loc3_.stats["maxMovementPoints"] = _loc3_.stats["maxMovementPoints"] - this.delta;
               break;
            case "tackleBlock":
            case "tackleEvade":
               if(_loc3_.stats[this._statName] == 0)
               {
                  _loc6_ = this._zeroDiff;
                  if(stack)
                  {
                     _loc8_ = stack.length;
                     _loc7_ = 1;
                     while(_loc7_ < _loc8_)
                     {
                        _loc6_ = _loc6_ + (stack[_loc7_] as StatBuff).zeroDiff;
                        _loc7_++;
                     }
                  }
                  _loc3_.stats[this._statName] = _loc3_.stats[this._statName] - this.delta + _loc6_;
               }
               else
               {
                  _loc3_.stats[this._statName] = _loc3_.stats[this._statName] - this.delta;
               }
               break;
            case "invisibilityState":
               break;
            default:
               if(_loc3_)
               {
                  if(_loc3_.stats.hasOwnProperty(this._statName))
                  {
                     _loc3_.stats[this._statName] = _loc3_.stats[this._statName] - this.delta;
                  }
                  else
                  {
                     _log.fatal("On essaye de supprimer une stat non prise en compte : " + this.statName);
                  }
               }
               else
               {
                  _log.fatal("ATTENTION, Le serveur essaye de buffer une entité qui n\'existe plus ! id=" + targetId);
               }
         }
      }
      
      override public function clone(param1:int = 0) : BasicBuff
      {
         var _loc2_:StatBuff = new StatBuff();
         _loc2_._statName = this._statName;
         _loc2_._isABoost = this._isABoost;
         _loc2_.id = uid;
         _loc2_.uid = uid;
         _loc2_.actionId = actionId;
         _loc2_.targetId = targetId;
         _loc2_.castingSpell = castingSpell;
         _loc2_.duration = duration;
         _loc2_.dispelable = dispelable;
         _loc2_.source = source;
         _loc2_.aliveSource = aliveSource;
         _loc2_.parentBoostUid = parentBoostUid;
         _loc2_.initParam(param1,param2,param3);
         return _loc2_;
      }
   }
}
