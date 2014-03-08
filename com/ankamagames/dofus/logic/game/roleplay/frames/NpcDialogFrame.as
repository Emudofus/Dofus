package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogQuestionMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcDialogReplyAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogReplyMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   
   public class NpcDialogFrame extends Object implements Frame
   {
      
      public function NpcDialogFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:NpcDialogQuestionMessage = null;
         var _loc3_:NpcDialogReplyAction = null;
         var _loc4_:NpcDialogReplyMessage = null;
         var _loc5_:LeaveDialogMessage = null;
         switch(true)
         {
            case param1 is NpcDialogQuestionMessage:
               _loc2_ = param1 as NpcDialogQuestionMessage;
               KernelEventsManager.getInstance().processCallback(HookList.NpcDialogQuestion,_loc2_.messageId,_loc2_.dialogParams,_loc2_.visibleReplies);
               return true;
            case param1 is NpcDialogReplyAction:
               _loc3_ = param1 as NpcDialogReplyAction;
               _loc4_ = new NpcDialogReplyMessage();
               _loc4_.initNpcDialogReplyMessage(_loc3_.replyId);
               ConnectionsHandler.getConnection().send(_loc4_);
               return true;
            case param1 is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case param1 is LeaveDialogMessage:
               _loc5_ = param1 as LeaveDialogMessage;
               if(_loc5_.dialogType == DialogTypeEnum.DIALOG_DIALOG || _loc5_.dialogType == DialogTypeEnum.DIALOG_MARRIAGE)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
