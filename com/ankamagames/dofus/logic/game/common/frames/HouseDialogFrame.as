package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.LockableUseCodeAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableUseCodeMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class HouseDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseDialogFrame));


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
            var _local_2:LockableUseCodeAction;
            var _local_3:LockableUseCodeMessage;
            var _local_4:LeaveDialogMessage;
            switch (true)
            {
                case (msg is LockableUseCodeAction):
                    _local_2 = (msg as LockableUseCodeAction);
                    _local_3 = new LockableUseCodeMessage();
                    _local_3.initLockableUseCodeMessage(_local_2.code);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is LeaveDialogMessage):
                    _local_4 = (msg as LeaveDialogMessage);
                    if ((((_local_4.dialogType == DialogTypeEnum.DIALOG_PURCHASABLE)) || ((_local_4.dialogType == DialogTypeEnum.DIALOG_LOCKABLE))))
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

