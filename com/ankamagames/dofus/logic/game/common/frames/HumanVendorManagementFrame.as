package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkHumanVendorMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockStartedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectModifyPricedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMovementUpdatedMessage;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMovementRemovedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMultiMovementUpdatedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMultiMovementRemovedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInHumanVendorShop;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ExchangeHookList;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.jerakine.messages.Message;

    public class HumanVendorManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanVendorManagementFrame));

        private var _success:Boolean = false;
        private var _shopStock:Array;

        public function HumanVendorManagementFrame()
        {
            this._shopStock = new Array();
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        private function get roleplayContextFrame():RoleplayContextFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame));
        }

        private function get commonExchangeManagementFrame():CommonExchangeManagementFrame
        {
            return ((Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame));
        }

        public function pushed():Boolean
        {
            this._success = false;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:ExchangeStartOkHumanVendorMessage;
            var _local_3:*;
            var _local_4:String;
            var _local_5:ExchangeShopStockStartedMessage;
            var _local_6:ExchangeObjectModifyPricedAction;
            var _local_7:ExchangeObjectModifyPricedMessage;
            var _local_8:ExchangeShopStockMovementUpdatedMessage;
            var _local_9:ItemWrapper;
            var _local_10:uint;
            var _local_11:Boolean;
            var _local_12:ExchangeShopStockMovementRemovedMessage;
            var _local_13:ExchangeShopStockMultiMovementUpdatedMessage;
            var _local_14:ExchangeShopStockMultiMovementRemovedMessage;
            var _local_15:ExchangeLeaveMessage;
            var objectToSell:ObjectItemToSellInHumanVendorShop;
            var iwrapper:ItemWrapper;
            var object:ObjectItemToSell;
            var iw:ItemWrapper;
            var cat:Object;
            var i:int;
            var cate:Object;
            var objectInfo:ObjectItemToSell;
            var newItem2:Boolean;
            var objectId:uint;
            switch (true)
            {
                case (msg is ExchangeStartOkHumanVendorMessage):
                    _local_2 = (msg as ExchangeStartOkHumanVendorMessage);
                    _local_3 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_2.sellerId);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    if (_local_3 == null)
                    {
                        _log.error("Impossible de trouver le personnage vendeur dans l'entitiesFrame");
                        return (true);
                    };
                    _local_4 = (_local_3 as GameRolePlayMerchantInformations).name;
                    this._shopStock = new Array();
                    for each (objectToSell in _local_2.objectsInfos)
                    {
                        iwrapper = ItemWrapper.create(0, objectToSell.objectUID, objectToSell.objectGID, objectToSell.quantity, objectToSell.effects);
                        this._shopStock.push({
                            "itemWrapper":iwrapper,
                            "price":objectToSell.objectPrice
                        });
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeStartOkHumanVendor, _local_4, this._shopStock);
                    return (true);
                case (msg is ExchangeShopStockStartedMessage):
                    _local_5 = (msg as ExchangeShopStockStartedMessage);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    this._shopStock = new Array();
                    for each (object in _local_5.objectsInfos)
                    {
                        iw = ItemWrapper.create(0, object.objectUID, object.objectGID, object.quantity, object.effects, false);
                        cat = Item.getItemById(iw.objectGID).category;
                        this._shopStock.push({
                            "itemWrapper":iw,
                            "price":object.objectPrice,
                            "category":cat
                        });
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockStarted, this._shopStock);
                    return (true);
                case (msg is ExchangeObjectModifyPricedAction):
                    _local_6 = (msg as ExchangeObjectModifyPricedAction);
                    _local_7 = new ExchangeObjectModifyPricedMessage();
                    _local_7.initExchangeObjectModifyPricedMessage(_local_6.objectUID, _local_6.quantity, _local_6.price);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is ExchangeShopStockMovementUpdatedMessage):
                    _local_8 = (msg as ExchangeShopStockMovementUpdatedMessage);
                    _local_9 = ItemWrapper.create(0, _local_8.objectInfo.objectUID, _local_8.objectInfo.objectGID, _local_8.objectInfo.quantity, _local_8.objectInfo.effects, false);
                    _local_10 = _local_8.objectInfo.objectPrice;
                    _local_11 = true;
                    i = 0;
                    while (i < this._shopStock.length)
                    {
                        if (this._shopStock[i].itemWrapper.objectUID == _local_9.objectUID)
                        {
                            if (_local_9.quantity > this._shopStock[i].itemWrapper.quantity)
                            {
                                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockAddQuantity);
                            }
                            else
                            {
                                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockRemoveQuantity);
                            };
                            cate = Item.getItemById(_local_9.objectGID).category;
                            this._shopStock.splice(i, 1, {
                                "itemWrapper":_local_9,
                                "price":_local_10,
                                "category":cate
                            });
                            _local_11 = false;
                            break;
                        };
                        i++;
                    };
                    if (_local_11)
                    {
                        cat = Item.getItemById(_local_9.objectGID).category;
                        this._shopStock.push({
                            "itemWrapper":_local_9,
                            "price":_local_8.objectInfo.objectPrice,
                            "category":cat
                        });
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock, _local_9);
                    return (true);
                case (msg is ExchangeShopStockMovementRemovedMessage):
                    _local_12 = (msg as ExchangeShopStockMovementRemovedMessage);
                    i = 0;
                    while (i < this._shopStock.length)
                    {
                        if (this._shopStock[i].itemWrapper.objectUID == _local_12.objectId)
                        {
                            this._shopStock.splice(i, 1);
                            break;
                        };
                        i++;
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock, null);
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMovementRemoved, _local_12.objectId);
                    return (true);
                case (msg is ExchangeShopStockMultiMovementUpdatedMessage):
                    _local_13 = (msg as ExchangeShopStockMultiMovementUpdatedMessage);
                    for each (objectInfo in _local_13.objectInfoList)
                    {
                        _local_9 = ItemWrapper.create(0, objectInfo.objectUID, _local_8.objectInfo.objectGID, objectInfo.quantity, objectInfo.effects, false);
                        newItem2 = true;
                        i = 0;
                        while (i < this._shopStock.length)
                        {
                            if (this._shopStock[i].itemWrapper.objectUID == _local_9.objectUID)
                            {
                                cat = Item.getItemById(_local_9.objectGID).category;
                                this._shopStock.splice(i, 1, {
                                    "itemWrapper":_local_9,
                                    "price":_local_8.objectInfo.objectPrice,
                                    "category":cat
                                });
                                newItem2 = false;
                                break;
                            };
                            i++;
                        };
                        if (newItem2)
                        {
                            this._shopStock.push({
                                "itemWrapper":_local_9,
                                "price":_local_8.objectInfo.objectPrice
                            });
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock);
                    return (true);
                case (msg is ExchangeShopStockMultiMovementRemovedMessage):
                    _local_14 = (msg as ExchangeShopStockMultiMovementRemovedMessage);
                    for each (objectId in _local_14.objectIdList)
                    {
                        i = 0;
                        while (i < this._shopStock.length)
                        {
                            if (this._shopStock[i].itemWrapper.objectUID == objectId)
                            {
                                this._shopStock.splice(i, 1);
                                break;
                            };
                            i++;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMouvmentRemoveOk, _local_12.objectId);
                    return (true);
                case (msg is LeaveDialogRequestAction):
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return (true);
                case (msg is ExchangeLeaveMessage):
                    _local_15 = (msg as ExchangeLeaveMessage);
                    if (_local_15.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _local_15.success;
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            };
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            this._shopStock = null;
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

