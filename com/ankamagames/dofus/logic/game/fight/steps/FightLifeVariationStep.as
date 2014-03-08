package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightLifeVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightLifeVariationStep(param1:int, param2:int, param3:int, param4:int) {
         super(COLOR,param2.toString(),param1,BLOCKING);
         _virtual = true;
         this._delta = param2;
         this._permanentDamages = param3;
         this._actionId = param4;
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
         var _loc1_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
         if(!_loc1_)
         {
            super.executeCallbacks();
            return;
         }
         var _loc2_:int = _loc1_.stats.lifePoints + this._delta;
         _loc1_.stats.lifePoints = Math.max(0,_loc2_);
         _loc1_.stats.maxLifePoints = Math.max(1,_loc1_.stats.maxLifePoints + this._permanentDamages);
         if(_loc1_.stats.lifePoints > _loc1_.stats.maxLifePoints)
         {
            _loc1_.stats.lifePoints = _loc1_.stats.maxLifePoints;
         }
         if(_loc1_ is GameFightCharacterInformations)
         {
            TooltipManager.updateContent("PlayerShortInfos" + _loc1_.contextualId,"tooltipOverEntity_" + _loc1_.contextualId,_loc1_);
         }
         else
         {
            TooltipManager.updateContent("EntityShortInfos" + _loc1_.contextualId,"tooltipOverEntity_" + _loc1_.contextualId,_loc1_);
         }
         if(PlayedCharacterManager.getInstance().id == _targetId)
         {
            PlayedCharacterManager.getInstance().characteristics.lifePoints = _loc1_.stats.lifePoints;
            PlayedCharacterManager.getInstance().characteristics.maxLifePoints = _loc1_.stats.maxLifePoints;
         }
         if(this._delta < 0 || this._delta == 0 && !this.skipTextEvent)
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
