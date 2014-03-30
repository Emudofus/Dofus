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
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   
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
      
      public function process(msg:Message) : Boolean {
         var ndcmsg:NpcDialogQuestionMessage = null;
         var ndra:NpcDialogReplyAction = null;
         var ndrmsg:NpcDialogReplyMessage = null;
         var ldm:LeaveDialogMessage = null;
         switch(true)
         {
            case msg is NpcDialogQuestionMessage:
               ndcmsg = msg as NpcDialogQuestionMessage;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogQuestion,ndcmsg.messageId,ndcmsg.dialogParams,ndcmsg.visibleReplies);
               return true;
            case msg is NpcDialogReplyAction:
               ndra = msg as NpcDialogReplyAction;
               ndrmsg = new NpcDialogReplyMessage();
               ndrmsg.initNpcDialogReplyMessage(ndra.replyId);
               ConnectionsHandler.getConnection().send(ndrmsg);
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if((ldm.dialogType == DialogTypeEnum.DIALOG_DIALOG) || (ldm.dialogType == DialogTypeEnum.DIALOG_MARRIAGE))
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
