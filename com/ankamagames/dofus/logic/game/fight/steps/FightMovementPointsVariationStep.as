package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class FightMovementPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightMovementPointsVariationStep(param1:int, param2:int, param3:Boolean, param4:Boolean = true, param5:Boolean = true)
      {
         super(COLOR,param2 > 0?"+" + param2:param2.toString(),param1,GameContextEnum.FIGHT,BLOCKING);
         this._showChatmessage = param5;
         this._intValue = param2;
         this._voluntarlyUsed = param3;
         _virtual = (this._voluntarlyUsed) && !OptionManager.getOptionManager("dofus").showUsedPaPm;
         this._updateCharacteristicManager = param4;
      }
      
      public static const COLOR:uint = 26112;
      
      private static const BLOCKING:Boolean = false;
      
      private var _intValue:int;
      
      private var _voluntarlyUsed:Boolean;
      
      private var _updateCharacteristicManager:Boolean;
      
      private var _showChatmessage:Boolean;
      
      public function get stepType() : String
      {
         return "movementPointsVariation";
      }
      
      public function get value() : int
      {
         return this._intValue;
      }
      
      override public function start() : void
      {
         var _loc2_:CharacterCharacteristicsInformations = null;
         var _loc1_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
         if(this._updateCharacteristicManager)
         {
            _loc1_.stats.movementPoints = _loc1_.stats.movementPoints + this._intValue;
            _loc2_ = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(_targetId);
            if(_loc2_)
            {
               _loc2_.movementPointsCurrent = _loc1_.stats.movementPoints;
            }
            FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_targetId,-this._intValue,true);
         }
         if(this._showChatmessage)
         {
            if(this._intValue > 0)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_MP_GAINED,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
            }
            else if(this._intValue < 0)
            {
               if(this._voluntarlyUsed)
               {
                  FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_MP_USED,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
               }
               else
               {
                  FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_MP_LOST,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
               }
            }
            
         }
         super.start();
      }
   }
}
