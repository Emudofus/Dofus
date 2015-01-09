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
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectsModifiedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectAddedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectsAddedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectRemovedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectsRemovedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeIsReadyMessage;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeKamaModifiedMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
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
            var _local_10:ExchangeObjectsModifiedMessage;
            var _local_11:Array;
            var _local_12:ExchangeObjectAddedMessage;
            var _local_13:ItemWrapper;
            var _local_14:ExchangeObjectsAddedMessage;
            var _local_15:*;
            var _local_16:ExchangeObjectRemovedMessage;
            var _local_17:ExchangeObjectsRemovedMessage;
            var _local_18:Array;
            var _local_19:uint;
            var _local_20:ExchangeObjectMoveAction;
            var _local_21:ItemWrapper;
            var _local_22:ExchangeObjectMoveMessage;
            var _local_23:ExchangeIsReadyMessage;
            var _local_24:RoleplayEntitiesFrame;
            var _local_25:String;
            var _local_26:ExchangeKamaModifiedMessage;
            var anModifiedItem:ObjectItem;
            var iwsModified:ItemWrapper;
            var anAddedObje:ObjectItem;
            var iwsAdded:ItemWrapper;
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
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectModified, _local_9, _local_8.remote);
                    return (true);
                case (msg is ExchangeObjectsModifiedMessage):
                    _local_10 = (msg as ExchangeObjectsModifiedMessage);
                    this._numCurrentSequence++;
                    _local_11 = new Array();
                    for each (anModifiedItem in _local_10.object)
                    {
                        iwsModified = ItemWrapper.create(anModifiedItem.position, anModifiedItem.objectUID, anModifiedItem.objectGID, anModifiedItem.quantity, anModifiedItem.effects, false);
                        switch (this._exchangeType)
                        {
                            case ExchangeTypeEnum.CRAFT:
                                this.craftFrame.modifyCraftComponent(_local_10.remote, iwsModified);
                                break;
                        };
                        _local_11.push(iwsModified);
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectListModified, _local_11, _local_10.remote);
                    return (true);
                case (msg is ExchangeObjectAddedMessage):
                    _local_12 = (msg as ExchangeObjectAddedMessage);
                    this._numCurrentSequence++;
                    _local_13 = ItemWrapper.create(_local_12.object.position, _local_12.object.objectUID, _local_12.object.objectGID, _local_12.object.quantity, _local_12.object.effects, false);
                    switch (this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                            this.craftFrame.addCraftComponent(_local_12.remote, _local_13);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectAdded, _local_13, _local_12.remote);
                    return (true);
                case (msg is ExchangeObjectsAddedMessage):
                    _local_14 = (msg as ExchangeObjectsAddedMessage);
                    this._numCurrentSequence++;
                    _local_15 = new Array();
                    for each (anAddedObje in _local_14.object)
                    {
                        iwsAdded = ItemWrapper.create(anAddedObje.position, anAddedObje.objectUID, anAddedObje.objectGID, anAddedObje.quantity, anAddedObje.effects, false);
                        switch (this._exchangeType)
                        {
                            case ExchangeTypeEnum.CRAFT:
                                this.craftFrame.addCraftComponent(_local_14.remote, iwsAdded);
                                break;
                        };
                        _local_15.push(iwsAdded);
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectListAdded, _local_15, _local_14.remote);
                    return (true);
                case (msg is ExchangeObjectRemovedMessage):
                    _local_16 = (msg as ExchangeObjectRemovedMessage);
                    this._numCurrentSequence++;
                    switch (this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                            this.craftFrame.removeCraftComponent(_local_16.remote, _local_16.objectUID);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectRemoved, _local_16.objectUID, _local_16.remote);
                    return (true);
                case (msg is ExchangeObjectsRemovedMessage):
                    _local_17 = (msg as ExchangeObjectsRemovedMessage);
                    this._numCurrentSequence++;
                    _local_18 = new Array();
                    for each (_local_19 in _local_17.objectUID)
                    {
                        switch (this._exchangeType)
                        {
                            case ExchangeTypeEnum.CRAFT:
                                this.craftFrame.removeCraftComponent(_local_16.remote, _local_19);
                                break;
                        };
                        _local_18.push(_local_19);
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectListRemoved, _local_18, _local_17.remote);
                    return (true);
                case (msg is ExchangeObjectMoveAction):
                    _local_20 = (msg as ExchangeObjectMoveAction);
                    _local_21 = InventoryManager.getInstance().inventory.getItem(_local_20.objectUID);
                    if (!(_local_21))
                    {
                        _local_21 = InventoryManager.getInstance().bankInventory.getItem(_local_20.objectUID);
                    };
                    if (((_local_21) && ((_local_21.quantity == Math.abs(_local_20.quantity)))))
                    {
                        TooltipManager.hide();
                    };
                    _local_22 = new ExchangeObjectMoveMessage();
                    _local_22.initExchangeObjectMoveMessage(_local_20.objectUID, _local_20.quantity);
                    ConnectionsHandler.getConnection().send(_local_22);
                    return (true);
                case (msg is ExchangeIsReadyMessage):
                    _local_23 = (msg as ExchangeIsReadyMessage);
                    _local_24 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    _local_25 = (_local_24.getEntityInfos(_local_23.id) as GameRolePlayNamedActorInformations).name;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeIsReady, _local_25, _local_23.ready);
                    return (true);
                case (msg is ExchangeKamaModifiedMessage):
                    _local_26 = (msg as ExchangeKamaModifiedMessage);
                    this._numCurrentSequence++;
                    if (!(_local_26.remote))
                    {
                        InventoryManager.getInstance().inventory.hiddedKamas = _local_26.quantity;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeKamaModified, _local_26.quantity, _local_26.remote);
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

