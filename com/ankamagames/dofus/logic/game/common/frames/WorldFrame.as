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
   
   public class WorldFrame extends Object implements Frame
   {
      
      public function WorldFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldFrame));
      
      private var _settings:Array = null;
      
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
         switch(true)
         {
            case msg is AreaFightModificatorUpdateMessage:
               afmumsg = msg as AreaFightModificatorUpdateMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AreaFightModificatorUpdate,afmumsg.spellPairId);
               return true;
         }
      }
   }
}
