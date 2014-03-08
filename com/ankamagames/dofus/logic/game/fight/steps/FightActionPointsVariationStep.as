package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class FightActionPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightActionPointsVariationStep(param1:int, param2:int, param3:Boolean, param4:Boolean=true, param5:Boolean=true) {
         super(COLOR,param2 > 0?"+" + param2:param2.toString(),param1,BLOCKING);
         this._showChatmessage = param5;
         this._intValue = param2;
         this._voluntarlyUsed = param3;
         _virtual = (this._voluntarlyUsed) && !OptionManager.getOptionManager("dofus").showUsedPaPm;
         this._updateFighterInfos = param4;
      }
      
      public static const COLOR:uint = 255;
      
      private static const BLOCKING:Boolean = false;
      
      private var _intValue:int;
      
      private var _voluntarlyUsed:Boolean;
      
      private var _updateFighterInfos:Boolean;
      
      private var _showChatmessage:Boolean;
      
      public function get stepType() : String {
         return "actionPointsVariation";
      }
      
      public function get value() : int {
         return this._intValue;
      }
      
      public function get voluntarlyUsed() : Boolean {
         return this._voluntarlyUsed;
      }
      
      override public function start() : void {
         var _loc1_:GameFightFighterInformations = null;
         if(this._updateFighterInfos)
         {
            _loc1_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
            _loc1_.stats.actionPoints = _loc1_.stats.actionPoints + this._intValue;
            if(CurrentPlayedFighterManager.getInstance().currentFighterId == _targetId && !this._voluntarlyUsed)
            {
               CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent + this._intValue;
            }
         }
         SpellWrapper.refreshAllPlayerSpellHolder(_targetId);
         if(this._showChatmessage)
         {
            if(this._intValue > 0)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_GAINED,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
            }
            else
            {
               if(this._intValue < 0)
               {
                  if(this._voluntarlyUsed)
                  {
                     FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_USED,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
                  }
                  else
                  {
                     FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_LOST,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
                  }
               }
            }
         }
         super.start();
      }
   }
}
