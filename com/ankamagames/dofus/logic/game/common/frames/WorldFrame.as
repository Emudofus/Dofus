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
      
      public function WorldFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldFrame));
      
      private var _settings:Array = null;
      
      private var _currentFightModificator:int = -1;
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get settings() : Array
      {
         return this._settings;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:AreaFightModificatorUpdateMessage = null;
         var _loc3_:String = null;
         switch(true)
         {
            case param1 is AreaFightModificatorUpdateMessage:
               _loc2_ = param1 as AreaFightModificatorUpdateMessage;
               if(this._currentFightModificator != _loc2_.spellPairId)
               {
                  KernelEventsManager.getInstance().processCallback(QuestHookList.AreaFightModificatorUpdate,_loc2_.spellPairId);
                  if(_loc2_.spellPairId > -1)
                  {
                     if(this._currentFightModificator > -1)
                     {
                        _loc3_ = I18n.getUiText("ui.spell.newFightModficator",[SpellPair.getSpellPairById(_loc2_.spellPairId).name]);
                     }
                     else
                     {
                        _loc3_ = I18n.getUiText("ui.spell.currentFightModficator",[SpellPair.getSpellPairById(_loc2_.spellPairId).name]);
                     }
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc3_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  this._currentFightModificator = _loc2_.spellPairId;
               }
               return true;
            default:
               return false;
         }
      }
   }
}
