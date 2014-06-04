package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.modificator.AreaFightModificatorUpdateMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.spells.SpellPair;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   
   public class WorldFrame extends Object implements Frame
   {
      
      public function WorldFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      private var _settings:Array = null;
      
      private var _currentFightModificator:int = -1;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get settings() : Array {
         return this._settings;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var afmumsg:AreaFightModificatorUpdateMessage = null;
         var updateModificatorText:String = null;
         switch(true)
         {
            case msg is AreaFightModificatorUpdateMessage:
               afmumsg = msg as AreaFightModificatorUpdateMessage;
               if(this._currentFightModificator != afmumsg.spellPairId)
               {
                  KernelEventsManager.getInstance().processCallback(QuestHookList.AreaFightModificatorUpdate,afmumsg.spellPairId);
                  if(afmumsg.spellPairId > -1)
                  {
                     if(this._currentFightModificator > -1)
                     {
                        updateModificatorText = I18n.getUiText("ui.spell.newFightModficator",[SpellPair.getSpellPairById(afmumsg.spellPairId).name]);
                     }
                     else
                     {
                        updateModificatorText = I18n.getUiText("ui.spell.currentFightModficator",[SpellPair.getSpellPairById(afmumsg.spellPairId).name]);
                     }
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,updateModificatorText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  this._currentFightModificator = afmumsg.spellPairId;
               }
               return true;
            default:
               return false;
         }
      }
   }
}
