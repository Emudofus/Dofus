package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeAcceptMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReadyMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectModifiedMessage;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectAddedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectRemovedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeIsReadyMessage;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeKamaModifiedMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeAcceptAction;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ExchangeHookList;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
    import com.ankamagames.jerakine.messages.Message;

    public class CommonExchangeManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonExchangeManagementFrame));

        private var _exchangeType:uint;
        private var _numCurrentSequence:int;

        public function CommonExchangeManagementFrame(pExchangeType:uint)
        {
            this._exchangeType = pExchangeType;
            this._numCurrentSequence = 0;
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get craftFrame():CraftFrame
        {
            return ((Kernel.getWorker().getFrame(CraftFrame) as CraftFrame));
        }

        public function incrementEchangeSequence():void
        {
            this._numCurrentSequence++;
        }

        public function resetEchangeSequence():void
        {
            this._numCurrentSequence = 0;
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:LeaveDialogRequestMessage;
            var _local_3:BidHouseManagementFrame;
            var _local_4:ExchangeAcceptMessage;
            var _local_5:LeaveDialogRequestMessage;
            var _local_6:ExchangeReadyAction;
            var _local_7:ExchangeReadyMessage;
            var _local_8:ExchangeObjectModifiedMessage;
            var _local_9:ItemWrapper;
            var _local_10:ExchangeObjectAddedMessage;
            var _local_11:ItemWrapper;
            var _local_12:ExchangeObjectRemovedMessage;
            var _local_13:ExchangeObjectMoveAction;
            var _local_14:ItemWrapper;
            var _local_15:ExchangeObjectMoveMessage;
            var _local_16:ExchangeIsReadyMessage;
            var _local_17:RoleplayEntitiesFrame;
            var _local_18:String;
            var _local_19:ExchangeKamaModifiedMessage;
            switch (true)
            {
                case (msg is LeaveShopStockAction):
                    _local_2 = new LeaveDialogRequestMessage();
                    _local_2.initLeaveDialogRequestMessage();
                    _local_3 = (Kernel.getWorker().getFrame(BidHouseManagementFrame) as BidHouseManagementFrame);
                    if (_local_3)
                    {
                        _local_3.switching = false;
                    };
                    ConnectionsHandler.getConnection().send(_local_2);
                    return (true);
                case (msg is ExchangeAcceptAction):
                    _local_4 = new ExchangeAcceptMessage();
                    _local_4.initExchangeAcceptMessage();
                    ConnectionsHandler.getConnection().send(_local_4);
                    return (true);
                case (msg is ExchangeRefuseAction):
                    _local_5 = new LeaveDialogRequestMessage();
                    _local_5.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is ExchangeReadyAction):
                    _local_6 = (msg as ExchangeReadyAction);
                    _local_7 = new ExchangeReadyMessage();
                    _local_7.initExchangeReadyMessage(_local_6.isReady, this._numCurrentSequence);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is ExchangeObjectModifiedMessage):
                    _local_8 = (msg as ExchangeObjectModifiedMessage);
                    this._numCurrentSequence++;
                    _local_9 = ItemWrapper.create(_local_8.object.position, _local_8.object.objectUID, _local_8.object.objectGID, _local_8.object.quantity, _local_8.object.effects, false);
                    switch (this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                            this.craftFrame.modifyCraftComponent(_local_8.remote, _local_9);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectModified, _local_9);
                    return (true);
                case (msg is ExchangeObjectAddedMessage):
                    _local_10 = (msg as ExchangeObjectAddedMessage);
                    this._numCurrentSequence++;
                    _local_11 = ItemWrapper.create(_local_10.object.position, _local_10.object.objectUID, _local_10.object.objectGID, _local_10.object.quantity, _local_10.object.effects, false);
                    switch (this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                            this.craftFrame.addCraftComponent(_local_10.remote, _local_11);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectAdded, _local_11);
                    return (true);
                case (msg is ExchangeObjectRemovedMessage):
                    _local_12 = (msg as ExchangeObjectRemovedMessage);
                    this._numCurrentSequence++;
                    switch (this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                            this.craftFrame.removeCraftComponent(_local_12.remote, _local_12.objectUID);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectRemoved, _local_12.objectUID);
                    return (true);
                case (msg is ExchangeObjectMoveAction):
                    _local_13 = (msg as ExchangeObjectMoveAction);
                    _local_14 = InventoryManager.getInstance().inventory.getItem(_local_13.objectUID);
                    if (!(_local_14))
                    {
                        _local_14 = InventoryManager.getInstance().bankInventory.getItem(_local_13.objectUID);
                    };
                    if (((_local_14) && ((_local_14.quantity == Math.abs(_local_13.quantity)))))
                    {
                        TooltipManager.hide();
                    };
                    _local_15 = new ExchangeObjectMoveMessage();
                    _local_15.initExchangeObjectMoveMessage(_local_13.objectUID, _local_13.quantity);
                    ConnectionsHandler.getConnection().send(_local_15);
                    return (true);
                case (msg is ExchangeIsReadyMessage):
                    _local_16 = (msg as ExchangeIsReadyMessage);
                    _local_17 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    _local_18 = (_local_17.getEntityInfos(_local_16.id) as GameRolePlayNamedActorInformations).name;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeIsReady, _local_18, _local_16.ready);
                    return (true);
                case (msg is ExchangeKamaModifiedMessage):
                    _local_19 = (msg as ExchangeKamaModifiedMessage);
                    this._numCurrentSequence++;
                    if (!(_local_19.remote))
                    {
                        InventoryManager.getInstance().inventory.hiddedKamas = _local_19.quantity;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeKamaModified, _local_19.quantity, _local_19.remote);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            if (Kernel.getWorker().contains(CraftFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CraftFrame));
            };
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

