package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightShieldPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightShieldPointsVariationStep(entityId:int, value:int, actionId:int) {
         super(COLOR,value.toString(),entityId,BLOCKING);
         this._intValue = value;
         this._actionId = actionId;
         _virtual = true;
      }
      
      public static const COLOR:uint = 10053324;
      
      private static const BLOCKING:Boolean = false;
      
      private var _intValue:int;
      
      private var _actionId:int;
      
      public function get stepType() : String {
         return "shieldPointsVariation";
      }
      
      public function get value() : int {
         return this._intValue;
      }
      
      override public function start() : void {
         var permanentLifeLoss:* = 0;
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
         if(!fighterInfos)
         {
            super.executeCallbacks();
            return;
         }
         if(this._intValue < 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SHIELD_LOSS,[_targetId,Math.abs(this._intValue),this._actionId],_targetId,castingSpellId);
         }
         else if(this._intValue > 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SHIELD_GAIN,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId);
         }
         else
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_NO_CHANGE,[_targetId],_targetId,castingSpellId);
         }
         
         super.start();
      }
   }
}
