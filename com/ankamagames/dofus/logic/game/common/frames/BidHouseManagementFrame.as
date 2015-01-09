package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidSellerMessage;
    import com.ankamagames.dofus.misc.lists.ExchangeHookList;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidBuyerMessage;
    import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseSearchAction;
    import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseListAction;
    import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseTypeAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseTypeMessage;
    import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseBuyAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseBuyMessage;
    import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHousePriceAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHousePriceMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidPriceForSellerMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidPriceMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseItemAddOkMessage;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseItemRemoveOkMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseGenericItemAddedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseGenericItemRemovedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectModifyPricedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListUpdatedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListAddedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListRemovedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeTypesExchangerDescriptionForUserMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeTypesItemsExchangerDescriptionForUserMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidSearchOkMessage;
    import com.ankamagames.dofus.logic.game.common.actions.bid.BidHouseStringSearchAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseSearchMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseListMessage;
    import com.ankamagames.dofus.network.types.game.data.items.BidExchangerObjectInfo;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToBuyerModeAction;
    import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToSellerModeAction;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import __AS3__.vec.*;

    public class BidHouseManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BidHouseManagementFrame));

        private var _bidHouseObjects:Array;
        private var _vendorObjects:Array;
        private var _typeAsk:uint;
        private var _GIDAsk:uint;
        private var _NPCId:uint;
        private var _listItemsSearchMode:Array;
        private var _itemsTypesAllowed:Vector.<uint>;
        private var _switching:Boolean = false;
        private var _success:Boolean;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get switching():Boolean
        {
            return (this._switching);
        }

        public function set switching(switching:Boolean):void
        {
            this._switching = switching;
        }

        public function processExchangeStartedBidSellerMessage(msg:ExchangeStartedBidSellerMessage):void
        {
            var objectInfo:ObjectItemToSellInBid;
            var iw:ItemWrapper;
            var price:uint;
            var unsoldDelay:uint;
            this._switching = false;
            var esbsmsg:ExchangeStartedBidSellerMessage = (msg as ExchangeStartedBidSellerMessage);
            this._NPCId = esbsmsg.sellerDescriptor.npcContextualId;
            this.initSearchMode(esbsmsg.sellerDescriptor.types);
            this._vendorObjects = new Array();
            for each (objectInfo in esbsmsg.objectsInfos)
            {
                iw = ItemWrapper.create(63, objectInfo.objectUID, objectInfo.objectGID, objectInfo.quantity, objectInfo.effects);
                price = objectInfo.objectPrice;
                unsoldDelay = objectInfo.unsoldDelay;
                this._vendorObjects.push(new ItemSellByPlayer(iw, price, unsoldDelay));
            };
            this._vendorObjects.sortOn("unsoldDelay", Array.NUMERIC);
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidSeller, esbsmsg.sellerDescriptor, esbsmsg.objectsInfos);
            this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate, this._vendorObjects);
        }

        public function processExchangeStartedBidBuyerMessage(msg:ExchangeStartedBidBuyerMessage):void
        {
            var typeObject:uint;
            this._switching = false;
            var esbbmsg:ExchangeStartedBidBuyerMessage = (msg as ExchangeStartedBidBuyerMessage);
            this._NPCId = esbbmsg.buyerDescriptor.npcContextualId;
            this.initSearchMode(esbbmsg.buyerDescriptor.types);
            this._bidHouseObjects = new Array();
            for each (typeObject in esbbmsg.buyerDescriptor.types)
            {
                this._bidHouseObjects.push(new TypeObjectData(typeObject, null));
            };
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidBuyer, esbbmsg.buyerDescriptor);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:ExchangeBidHouseSearchAction;
            var _local_3:ExchangeBidHouseListAction;
            var _local_4:ExchangeBidHouseTypeAction;
            var _local_5:ExchangeBidHouseTypeMessage;
            var _local_6:ExchangeBidHouseBuyAction;
            var _local_7:ExchangeBidHouseBuyMessage;
            var _local_8:ExchangeBidHousePriceAction;
            var _local_9:ExchangeBidHousePriceMessage;
            var _local_10:ExchangeBidPriceForSellerMessage;
            var _local_11:ExchangeBidPriceMessage;
            var _local_12:ExchangeBidHouseItemAddOkMessage;
            var _local_13:Item;
            var _local_14:ItemWrapper;
            var _local_15:uint;
            var _local_16:uint;
            var _local_17:ExchangeBidHouseItemRemoveOkMessage;
            var _local_18:uint;
            var _local_19:ExchangeBidHouseGenericItemAddedMessage;
            var _local_20:TypeObjectData;
            var _local_21:ExchangeBidHouseGenericItemRemovedMessage;
            var _local_22:TypeObjectData;
            var _local_23:int;
            var _local_24:ExchangeObjectModifyPricedAction;
            var _local_25:ExchangeObjectModifyPricedMessage;
            var _local_26:ExchangeBidHouseInListUpdatedMessage;
            var _local_27:TypeObjectData;
            var _local_28:GIDObjectData;
            var _local_29:ExchangeBidHouseInListAddedMessage;
            var _local_30:TypeObjectData;
            var _local_31:GIDObjectData;
            var _local_32:ExchangeBidHouseInListRemovedMessage;
            var _local_33:uint;
            var _local_34:GIDObjectData;
            var _local_35:uint;
            var _local_36:ExchangeTypesExchangerDescriptionForUserMessage;
            var _local_37:TypeObjectData;
            var _local_38:ExchangeTypesItemsExchangerDescriptionForUserMessage;
            var _local_39:GIDObjectData;
            var _local_40:GIDObjectData;
            var _local_41:ExchangeBidSearchOkMessage;
            var _local_42:BidHouseStringSearchAction;
            var _local_43:String;
            var _local_44:int;
            var _local_45:int;
            var _local_46:int;
            var _local_47:Vector.<uint>;
            var _local_48:NpcGenericActionRequestMessage;
            var _local_49:NpcGenericActionRequestMessage;
            var _local_50:ExchangeLeaveMessage;
            var ebhsmsg:ExchangeBidHouseSearchMessage;
            var ebhlmsg:ExchangeBidHouseListMessage;
            var _local_53:ExchangeBidHouseListMessage;
            var objectToSell:ItemSellByPlayer;
            var ugoda:GIDObjectData;
            var objectUpdate:ItemSellByBid;
            var objectsuPrice:Vector.<int>;
            var priceu:uint;
            var goda:GIDObjectData;
            var itemwra:ItemWrapper;
            var objectsPrice:Vector.<int>;
            var pric:uint;
            var newGIDObject:GIDObjectData;
            var itemwra2:ItemWrapper;
            var objectsPrice2:Vector.<int>;
            var pric2:uint;
            var _local_67:ItemSellByBid;
            var tod1:TypeObjectData;
            var tempObjects:Array;
            var objectGIDD:GIDObjectData;
            var objectGID:uint;
            var tod0:TypeObjectData;
            var goTest:GIDObjectData;
            var objectInfo:BidExchangerObjectInfo;
            var itemW:ItemWrapper;
            var objectsPrices:Vector.<int>;
            var pri:uint;
            var lsItems:Array;
            var currentItem:Object;
            var currentName:String;
            switch (true)
            {
                case (msg is ExchangeBidHouseSearchAction):
                    _local_2 = (msg as ExchangeBidHouseSearchAction);
                    if (((!((this._typeAsk == _local_2.type))) || ((this._typeAsk == _local_2.type))))
                    {
                        ebhsmsg = new ExchangeBidHouseSearchMessage();
                        ebhsmsg.initExchangeBidHouseSearchMessage(_local_2.type, _local_2.genId);
                        this._typeAsk = _local_2.type;
                        this._GIDAsk = _local_2.genId;
                        ConnectionsHandler.getConnection().send(ebhsmsg);
                    };
                    return (true);
                case (msg is ExchangeBidHouseListAction):
                    _local_3 = (msg as ExchangeBidHouseListAction);
                    if (this._GIDAsk != _local_3.id)
                    {
                        this._GIDAsk = _local_3.id;
                        ebhlmsg = new ExchangeBidHouseListMessage();
                        ebhlmsg.initExchangeBidHouseListMessage(_local_3.id);
                        ConnectionsHandler.getConnection().send(ebhlmsg);
                    }
                    else
                    {
                        _local_53 = new ExchangeBidHouseListMessage();
                        _local_53.initExchangeBidHouseListMessage(_local_3.id);
                        ConnectionsHandler.getConnection().send(_local_53);
                    };
                    return (true);
                case (msg is ExchangeBidHouseTypeAction):
                    _local_4 = (msg as ExchangeBidHouseTypeAction);
                    _local_5 = new ExchangeBidHouseTypeMessage();
                    if (this._typeAsk != _local_4.type)
                    {
                        this._typeAsk = _local_4.type;
                        _local_5.initExchangeBidHouseTypeMessage(_local_4.type);
                        ConnectionsHandler.getConnection().send(_local_5);
                    }
                    else
                    {
                        _local_5.initExchangeBidHouseTypeMessage(_local_4.type);
                        ConnectionsHandler.getConnection().send(_local_5);
                    };
                    return (true);
                case (msg is ExchangeBidHouseBuyAction):
                    _local_6 = (msg as ExchangeBidHouseBuyAction);
                    _local_7 = new ExchangeBidHouseBuyMessage();
                    _local_7.initExchangeBidHouseBuyMessage(_local_6.uid, _local_6.qty, _local_6.price);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is ExchangeBidHousePriceAction):
                    _local_8 = (msg as ExchangeBidHousePriceAction);
                    _local_9 = new ExchangeBidHousePriceMessage();
                    _local_9.initExchangeBidHousePriceMessage(_local_8.genId);
                    ConnectionsHandler.getConnection().send(_local_9);
                    return (true);
                case (msg is ExchangeBidPriceForSellerMessage):
                    _local_10 = (msg as ExchangeBidPriceForSellerMessage);
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPriceForSeller, _local_10.genericId, _local_10.averagePrice, _local_10.minimalPrices, _local_10.allIdentical);
                    return (true);
                case (msg is ExchangeBidPriceMessage):
                    _local_11 = (msg as ExchangeBidPriceMessage);
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPrice, _local_11.genericId, _local_11.averagePrice);
                    return (true);
                case (msg is ExchangeBidHouseItemAddOkMessage):
                    _local_12 = (msg as ExchangeBidHouseItemAddOkMessage);
                    _local_13 = Item.getItemById(_local_12.itemInfo.objectGID);
                    _local_14 = ItemWrapper.create(63, _local_12.itemInfo.objectUID, _local_12.itemInfo.objectGID, _local_12.itemInfo.quantity, _local_12.itemInfo.effects);
                    _local_15 = _local_12.itemInfo.objectPrice;
                    _local_16 = _local_12.itemInfo.unsoldDelay;
                    this._vendorObjects.push(new ItemSellByPlayer(_local_14, _local_15, _local_16));
                    this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate, this._vendorObjects);
                    return (true);
                case (msg is ExchangeBidHouseItemRemoveOkMessage):
                    _local_17 = (msg as ExchangeBidHouseItemRemoveOkMessage);
                    _local_18 = 0;
                    for each (objectToSell in this._vendorObjects)
                    {
                        if (objectToSell.itemWrapper.objectUID == _local_17.sellerId)
                        {
                            this._vendorObjects.splice(_local_18, 1);
                        };
                        _local_18++;
                    };
                    this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate, this._vendorObjects);
                    return (true);
                case (msg is ExchangeBidHouseGenericItemAddedMessage):
                    _local_19 = (msg as ExchangeBidHouseGenericItemAddedMessage);
                    _local_20 = this.getTypeObject(this._typeAsk);
                    _local_20.objects.push(new GIDObjectData(_local_19.objGenericId, new Array()));
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _local_20.objects);
                    return (true);
                case (msg is ExchangeBidHouseGenericItemRemovedMessage):
                    _local_21 = (msg as ExchangeBidHouseGenericItemRemovedMessage);
                    _local_22 = this.getTypeObject(this._typeAsk);
                    _local_23 = this.getGIDObjectIndex(this._typeAsk, _local_21.objGenericId);
                    if (_local_23 == -1)
                    {
                        return (true);
                    };
                    _local_22.objects.splice(_local_23, 1);
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _local_22.objects);
                    return (true);
                case (msg is ExchangeObjectModifyPricedAction):
                    _local_24 = (msg as ExchangeObjectModifyPricedAction);
                    _local_25 = new ExchangeObjectModifyPricedMessage();
                    _local_25.initExchangeObjectModifyPricedMessage(_local_24.objectUID, _local_24.quantity, _local_24.price);
                    ConnectionsHandler.getConnection().send(_local_25);
                    return (true);
                case (msg is ExchangeBidHouseInListUpdatedMessage):
                    _local_26 = (msg as ExchangeBidHouseInListUpdatedMessage);
                    _local_27 = this.getTypeObject(this._typeAsk);
                    for each (ugoda in _local_27.objects)
                    {
                        if (ugoda.GIDObject == _local_26.objGenericId)
                        {
                            _local_28 = ugoda;
                            for each (objectUpdate in ugoda.objects)
                            {
                                if (objectUpdate.itemWrapper.objectUID == _local_26.itemUID)
                                {
                                    objectUpdate.itemWrapper.update(63, _local_26.itemUID, _local_26.objGenericId, 1, _local_26.effects);
                                    objectsuPrice = new Vector.<int>();
                                    for each (priceu in _local_26.prices)
                                    {
                                        objectsuPrice.push((priceu as int));
                                    };
                                    objectUpdate.prices = objectsuPrice;
                                };
                            };
                        };
                    };
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _local_28.objects);
                    return (true);
                case (msg is ExchangeBidHouseInListAddedMessage):
                    _local_29 = (msg as ExchangeBidHouseInListAddedMessage);
                    _local_30 = this.getTypeObject(this._typeAsk);
                    for each (goda in _local_30.objects)
                    {
                        if (goda.GIDObject == _local_29.objGenericId)
                        {
                            _local_31 = goda;
                            if (goda.objects == null)
                            {
                                goda.objects = new Array();
                            };
                            itemwra = ItemWrapper.create(63, _local_29.itemUID, _local_29.objGenericId, 1, _local_29.effects);
                            objectsPrice = new Vector.<int>();
                            for each (pric in _local_29.prices)
                            {
                                objectsPrice.push((pric as int));
                            };
                            goda.objects.push(new ItemSellByBid(itemwra, objectsPrice));
                        };
                    };
                    if (!(_local_31))
                    {
                        newGIDObject = new GIDObjectData(_local_29.objGenericId, new Array());
                        _local_31 = newGIDObject;
                        itemwra2 = ItemWrapper.create(63, _local_29.itemUID, _local_29.objGenericId, 1, _local_29.effects);
                        objectsPrice2 = new Vector.<int>();
                        for each (pric2 in _local_29.prices)
                        {
                            objectsPrice2.push((pric2 as int));
                        };
                        newGIDObject.objects.push(new ItemSellByBid(itemwra2, objectsPrice2));
                        _local_30.objects.push(newGIDObject);
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _local_30.objects);
                    };
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _local_31.objects);
                    return (true);
                case (msg is ExchangeBidHouseInListRemovedMessage):
                    _local_32 = (msg as ExchangeBidHouseInListRemovedMessage);
                    _local_33 = 0;
                    _local_34 = this.getGIDObject(this._typeAsk, this._GIDAsk);
                    _local_35 = 0;
                    if (_local_34 == null)
                    {
                        return (true);
                    };
                    for each (_local_67 in _local_34.objects)
                    {
                        if (_local_32.itemUID == _local_67.itemWrapper.objectUID)
                        {
                            _local_34.objects.splice(_local_35, 1);
                        };
                        _local_35++;
                    };
                    if (_local_34.objects.length == 0)
                    {
                        tod1 = this.getTypeObject(this._typeAsk);
                        tempObjects = new Array();
                        for each (objectGIDD in tod1.objects)
                        {
                            if (objectGIDD.GIDObject != this._GIDAsk)
                            {
                                tempObjects.push(objectGIDD);
                            };
                        };
                        tod1.objects = tempObjects;
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, tod1.objects);
                    };
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _local_34.objects);
                    return (true);
                case (msg is ExchangeTypesExchangerDescriptionForUserMessage):
                    _local_36 = (msg as ExchangeTypesExchangerDescriptionForUserMessage);
                    _local_37 = this.getTypeObject(this._typeAsk);
                    _local_37.objects = new Array();
                    for each (objectGID in _local_36.typeDescription)
                    {
                        _local_37.objects.push(new GIDObjectData(objectGID, new Array()));
                    };
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _local_37.objects);
                    return (true);
                case (msg is ExchangeTypesItemsExchangerDescriptionForUserMessage):
                    _local_38 = (msg as ExchangeTypesItemsExchangerDescriptionForUserMessage);
                    _local_39 = this.getGIDObject(this._typeAsk, this._GIDAsk);
                    if (!(_local_39))
                    {
                        tod0 = this.getTypeObject(this._typeAsk);
                        goTest = new GIDObjectData(this._GIDAsk, new Array());
                        if (!(tod0.objects))
                        {
                            tod0.objects = new Array();
                        };
                        if (tod0.objects.indexOf(goTest) == -1)
                        {
                            tod0.objects.push(goTest);
                        };
                    };
                    _local_40 = this.getGIDObject(this._typeAsk, this._GIDAsk);
                    if (_local_40)
                    {
                        _local_40.objects = new Array();
                        for each (objectInfo in _local_38.itemTypeDescriptions)
                        {
                            itemW = ItemWrapper.create(63, objectInfo.objectUID, this._GIDAsk, 1, objectInfo.effects);
                            objectsPrices = new Vector.<int>();
                            for each (pri in objectInfo.prices)
                            {
                                objectsPrices.push((pri as int));
                            };
                            _local_40.objects.push(new ItemSellByBid(itemW, objectsPrices));
                        };
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _local_40.objects, false, true);
                    }
                    else
                    {
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, null, false, true);
                    };
                    return (true);
                case (msg is ExchangeBidSearchOkMessage):
                    _local_41 = (msg as ExchangeBidSearchOkMessage);
                    return (true);
                case (msg is BidHouseStringSearchAction):
                    _local_42 = (msg as BidHouseStringSearchAction);
                    _local_43 = _local_42.searchString;
                    _local_46 = getTimer();
                    _local_47 = new Vector.<uint>();
                    if (this._listItemsSearchMode == null)
                    {
                        this._listItemsSearchMode = new Array();
                        lsItems = Item.getItems();
                        _local_45 = lsItems.length;
                        _local_44 = 0;
                        while (_local_44 < _local_45)
                        {
                            currentItem = lsItems[_local_44];
                            if (((currentItem) && (!((this._itemsTypesAllowed.indexOf(currentItem.typeId) == -1)))))
                            {
                                if (currentItem.name)
                                {
                                    this._listItemsSearchMode.push(currentItem.name.toLowerCase(), currentItem.id);
                                };
                            };
                            _local_44++;
                        };
                        _log.debug((("Initialisation recherche HDV en " + (getTimer() - _local_46)) + " ms."));
                    };
                    _local_45 = this._listItemsSearchMode.length;
                    _local_44 = 0;
                    while (_local_44 < _local_45)
                    {
                        currentName = this._listItemsSearchMode[_local_44];
                        if (currentName.indexOf(_local_43) != -1)
                        {
                            _local_47.push(this._listItemsSearchMode[(_local_44 + 1)]);
                        };
                        _local_44 = (_local_44 + 2);
                    };
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _local_47, true);
                    return (true);
                case (msg is BidSwitchToBuyerModeAction):
                    this._switching = true;
                    _local_48 = new NpcGenericActionRequestMessage();
                    _local_48.initNpcGenericActionRequestMessage(this._NPCId, 6, PlayedCharacterManager.getInstance().currentMap.mapId);
                    ConnectionsHandler.getConnection().send(_local_48);
                    return (true);
                case (msg is BidSwitchToSellerModeAction):
                    this._switching = true;
                    _local_49 = new NpcGenericActionRequestMessage();
                    _local_49.initNpcGenericActionRequestMessage(this._NPCId, 5, PlayedCharacterManager.getInstance().currentMap.mapId);
                    ConnectionsHandler.getConnection().send(_local_49);
                    return (true);
                case (msg is ExchangeLeaveMessage):
                    _local_50 = (msg as ExchangeLeaveMessage);
                    if (_local_50.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _local_50.success;
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        public function pushed():Boolean
        {
            this._success = false;
            return (true);
        }

        public function pulled():Boolean
        {
            if (!(this.switching))
            {
                if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
                {
                    Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
                };
                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            };
            return (true);
        }

        private function get _kernelEventsManager():KernelEventsManager
        {
            return (KernelEventsManager.getInstance());
        }

        private function getTypeObject(pType:uint):TypeObjectData
        {
            var tod:TypeObjectData;
            if (this._bidHouseObjects == null)
            {
                return (null);
            };
            for each (tod in this._bidHouseObjects)
            {
                if (tod.typeObject == pType)
                {
                    return (tod);
                };
            };
            return (null);
        }

        private function getGIDObject(pType:uint, pGID:uint):GIDObjectData
        {
            var god:GIDObjectData;
            if (this._bidHouseObjects == null)
            {
                return (null);
            };
            var typeObjectData:TypeObjectData = this.getTypeObject(pType);
            if (typeObjectData == null)
            {
                return (null);
            };
            for each (god in typeObjectData.objects)
            {
                if (god.GIDObject == pGID)
                {
                    return (god);
                };
            };
            return (null);
        }

        private function getGIDObjectIndex(pType:uint, pGID:uint):int
        {
            var god:GIDObjectData;
            if (this._bidHouseObjects == null)
            {
                return (-1);
            };
            var typeObjectData:TypeObjectData = this.getTypeObject(pType);
            if (typeObjectData == null)
            {
                return (-1);
            };
            var index:int;
            for each (god in typeObjectData.objects)
            {
                if (god.GIDObject == pGID)
                {
                    return (index);
                };
                index++;
            };
            return (-1);
        }

        private function initSearchMode(types:Vector.<uint>):void
        {
            var nTypes:int;
            var reset:Boolean;
            var i:int;
            if (this._itemsTypesAllowed)
            {
                nTypes = types.length;
                if (nTypes == this._itemsTypesAllowed.length)
                {
                    reset = false;
                    i = 0;
                    while (i < nTypes)
                    {
                        if (types[i] != this._itemsTypesAllowed[i])
                        {
                            reset = true;
                            break;
                        };
                        i++;
                    };
                    if (reset)
                    {
                        this._listItemsSearchMode = null;
                    };
                }
                else
                {
                    this._listItemsSearchMode = null;
                };
            }
            else
            {
                this._listItemsSearchMode = null;
            };
            this._itemsTypesAllowed = types;
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
import __AS3__.vec.Vector;

class ItemSellByPlayer 
{

    public var itemWrapper:ItemWrapper;
    public var price:int;
    public var unsoldDelay:uint;

    public function ItemSellByPlayer(pItemWrapper:ItemWrapper, pPrice:int, pUnsoldDelay:uint)
    {
        this.itemWrapper = pItemWrapper;
        this.price = pPrice;
        this.unsoldDelay = pUnsoldDelay;
    }

}
class ItemSellByBid 
{

    public var itemWrapper:ItemWrapper;
    public var prices:Vector.<int>;

    public function ItemSellByBid(pItemWrapper:ItemWrapper, pPrices:Vector.<int>)
    {
        this.itemWrapper = pItemWrapper;
        this.prices = pPrices;
    }

}
class TypeObjectData 
{

    public var objects:Array;
    public var typeObject:uint;

    public function TypeObjectData(pTypeObject:uint, pObjects:Array)
    {
        this.objects = pObjects;
        this.typeObject = pTypeObject;
    }

}
class GIDObjectData 
{

    public var objects:Array;
    public var GIDObject:uint;

    public function GIDObjectData(pGIDObject:uint, pObjects:Array)
    {
        this.objects = pObjects;
        this.GIDObject = pGIDObject;
    }

}

