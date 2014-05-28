package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class FightMovementPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightMovementPointsVariationStep(entityId:int, value:int, voluntarlyUsed:Boolean, updateCharacteristicManager:Boolean = true, showChatMessage:Boolean = true) {
         super(COLOR,value > 0?"+" + value:value.toString(),entityId,BLOCKING);
         this._showChatmessage = showChatMessage;
         this._intValue = value;
         this._voluntarlyUsed = voluntarlyUsed;
         _virtual = (this._voluntarlyUsed) && (!OptionManager.getOptionManager("dofus").showUsedPaPm);
         this._updateCharacteristicManager = updateCharacteristicManager;
      }
      
      public static const COLOR:uint = 26112;
      
      private static const BLOCKING:Boolean = false;
      
      private var _intValue:int;
      
      private var _voluntarlyUsed:Boolean;
      
      private var _updateCharacteristicManager:Boolean;
      
      private var _showChatmessage:Boolean;
      
      public function get stepType() : String {
         return "movementPointsVariation";
      }
      
      public function get value() : int {
         return this._intValue;
      }
      
      override public function start() : void {
         var characteristics:CharacterCharacteristicsInformations = null;
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
         if(this._updateCharacteristicManager)
         {
            fighterInfos.stats.movementPoints = fighterInfos.stats.movementPoints + this._intValue;
            characteristics = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(_targetId);
            if(characteristics)
            {
               characteristics.movementPointsCurrent = fighterInfos.stats.movementPoints;
            }
            FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_targetId,-this._intValue,true);
         }
         if(fighterInfos.disposition.cellId == -1)
         {
            super.executeCallbacks();
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
         if(fighterInfos.disposition.cellId != -1)
         {
            super.start();
         }
      }
   }
}
