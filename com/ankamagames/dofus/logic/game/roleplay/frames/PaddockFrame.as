package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockBuyRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.PaddockBuyRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.PaddockBuyResultMessage;
    import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockSellRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.PaddockSellRequestMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.jerakine.messages.Message;

    public class PaddockFrame implements Frame 
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
            var _local_2:PaddockBuyRequestAction;
            var _local_3:PaddockBuyRequestMessage;
            var _local_4:PaddockBuyResultMessage;
            var _local_5:PaddockSellRequestAction;
            var _local_6:PaddockSellRequestMessage;
            var _local_7:LeaveDialogMessage;
            switch (true)
            {
                case (msg is PaddockBuyRequestAction):
                    _local_2 = (msg as PaddockBuyRequestAction);
                    _local_3 = new PaddockBuyRequestMessage();
                    _local_3.initPaddockBuyRequestMessage(_local_2.proposedPrice);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is PaddockBuyResultMessage):
                    _local_4 = (msg as PaddockBuyResultMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.PaddockBuyResult, _local_4.paddockId, _local_4.bought, _local_4.realPrice);
                    return (true);
                case (msg is PaddockSellRequestAction):
                    _local_5 = (msg as PaddockSellRequestAction);
                    _local_6 = new PaddockSellRequestMessage();
                    _local_6.initPaddockSellRequestMessage(_local_5.price);
                    ConnectionsHandler.getConnection().send(_local_6);
                    return (true);
                case (msg is LeaveDialogRequestAction):
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return (true);
                case (msg is LeaveDialogMessage):
                    _local_7 = (msg as LeaveDialogMessage);
                    if (_local_7.dialogType == DialogTypeEnum.DIALOG_PURCHASABLE)
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

