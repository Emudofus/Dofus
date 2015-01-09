package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogQuestionMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.NpcDialogReplyAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogReplyMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.RoleplayHookList;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class NpcDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:NpcDialogQuestionMessage;
            var _local_3:NpcDialogReplyAction;
            var _local_4:NpcDialogReplyMessage;
            var _local_5:LeaveDialogMessage;
            switch (true)
            {
                case (msg is NpcDialogQuestionMessage):
                    _local_2 = (msg as NpcDialogQuestionMessage);
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogQuestion, _local_2.messageId, _local_2.dialogParams, _local_2.visibleReplies);
                    return (true);
                case (msg is NpcDialogReplyAction):
                    _local_3 = (msg as NpcDialogReplyAction);
                    _local_4 = new NpcDialogReplyMessage();
                    _local_4.initNpcDialogReplyMessage(_local_3.replyId);
                    ConnectionsHandler.getConnection().send(_local_4);
                    return (true);
                case (msg is LeaveDialogRequestAction):
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return (true);
                case (msg is LeaveDialogMessage):
                    _local_5 = (msg as LeaveDialogMessage);
                    if ((((_local_5.dialogType == DialogTypeEnum.DIALOG_DIALOG)) || ((_local_5.dialogType == DialogTypeEnum.DIALOG_MARRIAGE))))
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

