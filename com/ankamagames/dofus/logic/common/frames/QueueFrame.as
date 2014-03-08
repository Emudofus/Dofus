package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.queues.LoginQueueStatusMessage;
   import com.ankamagames.dofus.network.messages.queues.QueueStatusMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class QueueFrame extends Object implements Frame
   {
      
      public function QueueFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QueueFrame));
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:LoginQueueStatusMessage = null;
         var _loc3_:QueueStatusMessage = null;
         switch(true)
         {
            case param1 is LoginQueueStatusMessage:
               _loc2_ = param1 as LoginQueueStatusMessage;
               KernelEventsManager.getInstance().processCallback(HookList.LoginQueueStatus,_loc2_.position,_loc2_.total);
               return true;
            case param1 is QueueStatusMessage:
               _loc3_ = param1 as QueueStatusMessage;
               KernelEventsManager.getInstance().processCallback(HookList.QueueStatus,_loc3_.position,_loc3_.total);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
