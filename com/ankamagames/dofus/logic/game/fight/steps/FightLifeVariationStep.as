package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightLifeVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightLifeVariationStep(entityId:int, delta:int, permanentDamages:int, actionId:int) {
         super(COLOR,delta.toString(),entityId,BLOCKING);
         _virtual = true;
         this._delta = delta;
         this._permanentDamages = permanentDamages;
         this._actionId = actionId;
      }
      
      public static const COLOR:uint = 16711680;
      
      private static const BLOCKING:Boolean = false;
      
      private var _delta:int;
      
      private var _permanentDamages:int;
      
      private var _actionId:int;
      
      public var skipTextEvent:Boolean = false;
      
      public function get stepType() : String {
         return "lifeVariation";
      }
      
      public function get value() : int {
         return this._delta;
      }
      
      public function get delta() : int {
         return this._delta;
      }
      
      public function get permanentDamages() : int {
         return this._permanentDamages;
      }
      
      public function get actionId() : int {
         return this._actionId;
      }
      
      override public function start() : void {
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
         if(!fighterInfos)
         {
            super.executeCallbacks();
            return;
         }
         var res:int = fighterInfos.stats.lifePoints + this._delta;
         fighterInfos.stats.lifePoints = Math.max(0,res);
         fighterInfos.stats.maxLifePoints = Math.max(1,fighterInfos.stats.maxLifePoints + this._permanentDamages);
         if(fighterInfos.stats.lifePoints > fighterInfos.stats.maxLifePoints)
         {
            fighterInfos.stats.lifePoints = fighterInfos.stats.maxLifePoints;
         }
         if(fighterInfos is GameFightCharacterInformations)
         {
            TooltipManager.updateContent("PlayerShortInfos" + fighterInfos.contextualId,"tooltipOverEntity_" + fighterInfos.contextualId,fighterInfos);
         }
         else
         {
            TooltipManager.updateContent("EntityShortInfos" + fighterInfos.contextualId,"tooltipOverEntity_" + fighterInfos.contextualId,fighterInfos);
         }
         var characteristics:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(_targetId);
         if(characteristics)
         {
            characteristics.lifePoints = fighterInfos.stats.lifePoints;
            characteristics.maxLifePoints = fighterInfos.stats.maxLifePoints;
         }
         if((this._delta < 0) || (this._delta == 0) && (!this.skipTextEvent))
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LIFE_LOSS,[_targetId,Math.abs(this._delta),this._actionId],_targetId,castingSpellId,false,2);
         }
         else
         {
            if(this._delta > 0)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LIFE_GAIN,[_targetId,Math.abs(this._delta),this._actionId],_targetId,castingSpellId,false,2);
            }
         }
         super.start();
      }
   }
}
