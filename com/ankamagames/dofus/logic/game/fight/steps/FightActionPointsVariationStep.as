package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class FightActionPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightActionPointsVariationStep(entityId:int, value:int, voluntarlyUsed:Boolean, updateFighterInfos:Boolean=true, showChatmessage:Boolean=true) {
         super(COLOR,value > 0?"+" + value:value.toString(),entityId,BLOCKING);
         this._showChatmessage = showChatmessage;
         this._intValue = value;
         this._voluntarlyUsed = voluntarlyUsed;
         _virtual = (this._voluntarlyUsed) && (!OptionManager.getOptionManager("dofus").showUsedPaPm);
         this._updateFighterInfos = updateFighterInfos;
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
         var fighterInfos:GameFightFighterInformations = null;
         var characteristics:CharacterCharacteristicsInformations = null;
         if(this._updateFighterInfos)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
            fighterInfos.stats.actionPoints = fighterInfos.stats.actionPoints + this._intValue;
            if(!this._voluntarlyUsed)
            {
               characteristics = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(_targetId);
               if(characteristics)
               {
                  characteristics.actionPointsCurrent = fighterInfos.stats.actionPoints;
               }
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
