package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.party.TeleportBuddiesAnswerAction;
    import com.ankamagames.dofus.network.messages.game.interactive.meeting.TeleportBuddiesAnswerMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class TeleportBuddiesDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TeleportBuddiesDialogFrame));


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
            var _local_2:TeleportBuddiesAnswerAction;
            var _local_3:TeleportBuddiesAnswerMessage;
            var _local_4:LeaveDialogMessage;
            switch (true)
            {
                case (msg is TeleportBuddiesAnswerAction):
                    _local_2 = (msg as TeleportBuddiesAnswerAction);
                    _local_3 = new TeleportBuddiesAnswerMessage();
                    _local_3.initTeleportBuddiesAnswerMessage(_local_2.accept);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is LeaveDialogMessage):
                    _local_4 = (msg as LeaveDialogMessage);
                    if (_local_4.dialogType == DialogTypeEnum.DIALOG_DUNGEON_MEETING)
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
}//package com.ankamagames.dofus.logic.game.common.frames

