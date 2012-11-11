package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.bid.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class BidHouseManagementFrame extends Object implements Frame
    {
        private var _bidHouseObjects:Array;
        private var _vendorObjects:Array;
        private var _typeAsk:uint;
        private var _GIDAsk:uint;
        private var _NPCId:uint;
        private var _listItemsSearchMode:Array;
        private var _itemsTypesAllowed:Vector.<uint>;
        private var _switching:Boolean = false;
        private var _success:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(BidHouseManagementFrame));

        public function BidHouseManagementFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get switching() : Boolean
        {
            return this._switching;
        }// end function

        public function set switching(param1:Boolean) : void
        {
            this._switching = param1;
            return;
        }// end function

        public function processExchangeStartedBidSellerMessage(param1:ExchangeStartedBidSellerMessage) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            this._switching = false;
            var _loc_2:* = param1 as ExchangeStartedBidSellerMessage;
            this._NPCId = _loc_2.sellerDescriptor.npcContextualId;
            this.initSearchMode(_loc_2.sellerDescriptor.types);
            this._vendorObjects = new Array();
            for each (_loc_3 in _loc_2.objectsInfos)
            {
                
                _loc_4 = ItemWrapper.create(63, _loc_3.objectUID, _loc_3.objectGID, _loc_3.quantity, _loc_3.effects);
                _loc_5 = _loc_3.objectPrice;
                _loc_6 = _loc_3.unsoldDelay;
                this._vendorObjects.push(new ItemSellByPlayer(_loc_4, _loc_5, _loc_6));
            }
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidSeller, _loc_2.sellerDescriptor, _loc_2.objectsInfos);
            this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate, this._vendorObjects);
            return;
        }// end function

        public function processExchangeStartedBidBuyerMessage(param1:ExchangeStartedBidBuyerMessage) : void
        {
            var _loc_3:* = 0;
            this._switching = false;
            var _loc_2:* = param1 as ExchangeStartedBidBuyerMessage;
            this._NPCId = _loc_2.buyerDescriptor.npcContextualId;
            this.initSearchMode(_loc_2.buyerDescriptor.types);
            this._bidHouseObjects = new Array();
            for each (_loc_3 in _loc_2.buyerDescriptor.types)
            {
                
                this._bidHouseObjects.push(new TypeObjectData(_loc_3, null));
            }
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidBuyer, _loc_2.buyerDescriptor);
            return;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = 0;
            var _loc_31:* = null;
            var _loc_32:* = 0;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = null;
            var _loc_41:* = 0;
            var _loc_42:* = 0;
            var _loc_43:* = 0;
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = null;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = null;
            var _loc_52:* = null;
            var _loc_53:* = null;
            var _loc_54:* = null;
            var _loc_55:* = 0;
            var _loc_56:* = null;
            var _loc_57:* = null;
            var _loc_58:* = null;
            var _loc_59:* = 0;
            var _loc_60:* = null;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = 0;
            var _loc_64:* = null;
            var _loc_65:* = null;
            var _loc_66:* = null;
            var _loc_67:* = null;
            var _loc_68:* = 0;
            var _loc_69:* = null;
            var _loc_70:* = null;
            var _loc_71:* = null;
            var _loc_72:* = null;
            var _loc_73:* = null;
            var _loc_74:* = 0;
            var _loc_75:* = null;
            var _loc_76:* = null;
            var _loc_77:* = null;
            switch(true)
            {
                case param1 is ExchangeBidHouseSearchAction:
                {
                    _loc_2 = param1 as ExchangeBidHouseSearchAction;
                    if (this._typeAsk != _loc_2.type || this._typeAsk == _loc_2.type)
                    {
                        _loc_48 = new ExchangeBidHouseSearchMessage();
                        _loc_48.initExchangeBidHouseSearchMessage(_loc_2.type, _loc_2.genId);
                        this._typeAsk = _loc_2.type;
                        this._GIDAsk = _loc_2.genId;
                        this._serverConnection.send(_loc_48);
                    }
                    return true;
                }
                case param1 is ExchangeBidHouseListAction:
                {
                    _loc_3 = param1 as ExchangeBidHouseListAction;
                    if (this._GIDAsk != _loc_3.id)
                    {
                        this._GIDAsk = _loc_3.id;
                        _loc_49 = new ExchangeBidHouseListMessage();
                        _loc_49.initExchangeBidHouseListMessage(_loc_3.id);
                        this._serverConnection.send(_loc_49);
                    }
                    else
                    {
                        _loc_50 = new ExchangeBidHouseListMessage();
                        _loc_50.initExchangeBidHouseListMessage(_loc_3.id);
                        this._serverConnection.send(_loc_50);
                    }
                    return true;
                }
                case param1 is ExchangeBidHouseTypeAction:
                {
                    _loc_4 = param1 as ExchangeBidHouseTypeAction;
                    _loc_5 = new ExchangeBidHouseTypeMessage();
                    if (this._typeAsk != _loc_4.type)
                    {
                        this._typeAsk = _loc_4.type;
                        _loc_5.initExchangeBidHouseTypeMessage(_loc_4.type);
                        this._serverConnection.send(_loc_5);
                    }
                    else
                    {
                        _loc_5.initExchangeBidHouseTypeMessage(_loc_4.type);
                        this._serverConnection.send(_loc_5);
                    }
                    return true;
                }
                case param1 is ExchangeBidHouseBuyAction:
                {
                    _loc_6 = param1 as ExchangeBidHouseBuyAction;
                    _loc_7 = new ExchangeBidHouseBuyMessage();
                    _loc_7.initExchangeBidHouseBuyMessage(_loc_6.uid, _loc_6.qty, _loc_6.price);
                    this._serverConnection.send(_loc_7);
                    return true;
                }
                case param1 is ExchangeBidHousePriceAction:
                {
                    _loc_8 = param1 as ExchangeBidHousePriceAction;
                    _loc_9 = new ExchangeBidHousePriceMessage();
                    _loc_9.initExchangeBidHousePriceMessage(_loc_8.genId);
                    this._serverConnection.send(_loc_9);
                    return true;
                }
                case param1 is ExchangeBidPriceMessage:
                {
                    _loc_10 = param1 as ExchangeBidPriceMessage;
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPrice, _loc_10.genericId, _loc_10.averagePrice);
                    return true;
                }
                case param1 is ExchangeBidHouseItemAddOkMessage:
                {
                    _loc_11 = param1 as ExchangeBidHouseItemAddOkMessage;
                    _loc_12 = Item.getItemById(_loc_11.itemInfo.objectGID);
                    _loc_13 = ItemWrapper.create(63, _loc_11.itemInfo.objectUID, _loc_11.itemInfo.objectGID, _loc_11.itemInfo.quantity, _loc_11.itemInfo.effects);
                    _loc_14 = _loc_11.itemInfo.objectPrice;
                    _loc_15 = _loc_11.itemInfo.unsoldDelay;
                    this._vendorObjects.push(new ItemSellByPlayer(_loc_13, _loc_14, _loc_15));
                    this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate, this._vendorObjects);
                    return true;
                }
                case param1 is ExchangeBidHouseItemRemoveOkMessage:
                {
                    _loc_16 = param1 as ExchangeBidHouseItemRemoveOkMessage;
                    _loc_17 = 0;
                    for each (_loc_51 in this._vendorObjects)
                    {
                        
                        if (_loc_51.itemWrapper.objectUID == _loc_16.sellerId)
                        {
                            this._vendorObjects.splice(_loc_17, 1);
                        }
                        _loc_17 = _loc_17 + 1;
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate, this._vendorObjects);
                    return true;
                }
                case param1 is ExchangeBidHouseGenericItemAddedMessage:
                {
                    _loc_18 = param1 as ExchangeBidHouseGenericItemAddedMessage;
                    _loc_19 = this.getTypeObject(this._typeAsk);
                    _loc_19.objects.push(new GIDObjectData(_loc_18.objGenericId, new Array()));
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _loc_19.objects);
                    return true;
                }
                case param1 is ExchangeBidHouseGenericItemRemovedMessage:
                {
                    _loc_20 = param1 as ExchangeBidHouseGenericItemRemovedMessage;
                    _loc_21 = this.getTypeObject(this._typeAsk);
                    _loc_22 = this.getGIDObjectIndex(this._typeAsk, _loc_20.objGenericId);
                    if (_loc_22 == -1)
                    {
                        return true;
                    }
                    _loc_21.objects.splice(_loc_22, 1);
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _loc_21.objects);
                    return true;
                }
                case param1 is ExchangeBidHouseInListUpdatedMessage:
                {
                    _loc_23 = param1 as ExchangeBidHouseInListUpdatedMessage;
                    _loc_24 = this.getTypeObject(this._typeAsk);
                    for each (_loc_52 in _loc_24.objects)
                    {
                        
                        if (_loc_52.GIDObject == _loc_23.objGenericId)
                        {
                            _loc_25 = _loc_52;
                            for each (_loc_53 in _loc_52.objects)
                            {
                                
                                if (_loc_53.itemWrapper.objectUID == _loc_23.itemUID)
                                {
                                    _loc_53.itemWrapper.update(63, _loc_23.itemUID, _loc_23.objGenericId, 1, _loc_23.effects);
                                    _loc_54 = new Vector.<int>;
                                    for each (_loc_55 in _loc_23.prices)
                                    {
                                        
                                        _loc_54.push(_loc_55 as int);
                                    }
                                    _loc_53.prices = _loc_54;
                                }
                            }
                        }
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _loc_25.objects);
                    return true;
                }
                case param1 is ExchangeBidHouseInListAddedMessage:
                {
                    _loc_26 = param1 as ExchangeBidHouseInListAddedMessage;
                    _loc_27 = this.getTypeObject(this._typeAsk);
                    for each (_loc_56 in _loc_27.objects)
                    {
                        
                        if (_loc_56.GIDObject == _loc_26.objGenericId)
                        {
                            _loc_28 = _loc_56;
                            if (_loc_56.objects == null)
                            {
                                _loc_56.objects = new Array();
                            }
                            _loc_57 = ItemWrapper.create(63, _loc_26.itemUID, _loc_26.objGenericId, 1, _loc_26.effects);
                            _loc_58 = new Vector.<int>;
                            for each (_loc_59 in _loc_26.prices)
                            {
                                
                                _loc_58.push(_loc_59 as int);
                            }
                            _loc_56.objects.push(new ItemSellByBid(_loc_57, _loc_58));
                        }
                    }
                    if (!_loc_28)
                    {
                        _loc_60 = new GIDObjectData(_loc_26.objGenericId, new Array());
                        _loc_28 = _loc_60;
                        _loc_61 = ItemWrapper.create(63, _loc_26.itemUID, _loc_26.objGenericId, 1, _loc_26.effects);
                        _loc_62 = new Vector.<int>;
                        for each (_loc_63 in _loc_26.prices)
                        {
                            
                            _loc_62.push(_loc_63 as int);
                        }
                        _loc_60.objects.push(new ItemSellByBid(_loc_61, _loc_62));
                        _loc_27.objects.push(_loc_60);
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _loc_27.objects);
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _loc_28.objects);
                    return true;
                }
                case param1 is ExchangeBidHouseInListRemovedMessage:
                {
                    _loc_29 = param1 as ExchangeBidHouseInListRemovedMessage;
                    _loc_30 = 0;
                    _loc_31 = this.getGIDObject(this._typeAsk, this._GIDAsk);
                    _loc_32 = 0;
                    if (_loc_31 == null)
                    {
                        return true;
                    }
                    for each (_loc_64 in _loc_31.objects)
                    {
                        
                        if (_loc_29.itemUID == _loc_64.itemWrapper.objectUID)
                        {
                            _loc_31.objects.splice(_loc_32, 1);
                        }
                        _loc_32 = _loc_32 + 1;
                    }
                    if (_loc_31.objects.length == 0)
                    {
                        _loc_65 = this.getTypeObject(this._typeAsk);
                        _loc_66 = new Array();
                        for each (_loc_67 in _loc_65.objects)
                        {
                            
                            if (_loc_67.GIDObject != this._GIDAsk)
                            {
                                _loc_66.push(_loc_67);
                            }
                        }
                        _loc_65.objects = _loc_66;
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _loc_65.objects);
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _loc_31.objects);
                    return true;
                }
                case param1 is ExchangeTypesExchangerDescriptionForUserMessage:
                {
                    _loc_33 = param1 as ExchangeTypesExchangerDescriptionForUserMessage;
                    _loc_34 = this.getTypeObject(this._typeAsk);
                    _loc_34.objects = new Array();
                    for each (_loc_68 in _loc_33.typeDescription)
                    {
                        
                        _loc_34.objects.push(new GIDObjectData(_loc_68, new Array()));
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _loc_34.objects);
                    return true;
                }
                case param1 is ExchangeTypesItemsExchangerDescriptionForUserMessage:
                {
                    _loc_35 = param1 as ExchangeTypesItemsExchangerDescriptionForUserMessage;
                    _loc_36 = this.getGIDObject(this._typeAsk, this._GIDAsk);
                    if (!_loc_36)
                    {
                        _loc_69 = this.getTypeObject(this._typeAsk);
                        _loc_70 = new GIDObjectData(this._GIDAsk, new Array());
                        if (!_loc_69.objects)
                        {
                            _loc_69.objects = new Array();
                        }
                        if (_loc_69.objects.indexOf(_loc_70) == -1)
                        {
                            _loc_69.objects.push(_loc_70);
                        }
                    }
                    _loc_37 = this.getGIDObject(this._typeAsk, this._GIDAsk);
                    if (_loc_37)
                    {
                        _loc_37.objects = new Array();
                        for each (_loc_71 in _loc_35.itemTypeDescriptions)
                        {
                            
                            _loc_72 = ItemWrapper.create(63, _loc_71.objectUID, this._GIDAsk, 1, _loc_71.effects);
                            _loc_73 = new Vector.<int>;
                            for each (_loc_74 in _loc_71.prices)
                            {
                                
                                _loc_73.push(_loc_74 as int);
                            }
                            _loc_37.objects.push(new ItemSellByBid(_loc_72, _loc_73));
                        }
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, _loc_37.objects, false, true);
                    }
                    else
                    {
                        this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate, null, false, true);
                    }
                    return true;
                }
                case param1 is ExchangeBidSearchOkMessage:
                {
                    _loc_38 = param1 as ExchangeBidSearchOkMessage;
                    return true;
                }
                case param1 is BidHouseStringSearchAction:
                {
                    _loc_39 = param1 as BidHouseStringSearchAction;
                    _loc_40 = _loc_39.searchString;
                    _loc_43 = getTimer();
                    _loc_44 = new Vector.<uint>;
                    if (this._listItemsSearchMode == null)
                    {
                        this._listItemsSearchMode = new Array();
                        _loc_75 = Item.getItems();
                        _loc_42 = _loc_75.length;
                        _loc_41 = 0;
                        while (_loc_41 < _loc_42)
                        {
                            
                            _loc_76 = _loc_75[_loc_41];
                            if (_loc_76 && this._itemsTypesAllowed.indexOf(_loc_76.typeId) != -1)
                            {
                                if (_loc_76.name)
                                {
                                    this._listItemsSearchMode.push(_loc_76.name.toLowerCase(), _loc_76.id);
                                }
                            }
                            _loc_41++;
                        }
                        _log.debug("Initialisation recherche HDV en " + (getTimer() - _loc_43) + " ms.");
                    }
                    _loc_42 = this._listItemsSearchMode.length;
                    _loc_41 = 0;
                    while (_loc_41 < _loc_42)
                    {
                        
                        _loc_77 = this._listItemsSearchMode[_loc_41];
                        if (_loc_77.indexOf(_loc_40) != -1)
                        {
                            _loc_44.push(this._listItemsSearchMode[(_loc_41 + 1)]);
                        }
                        _loc_41 = _loc_41 + 2;
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate, _loc_44, true);
                    return true;
                }
                case param1 is BidSwitchToBuyerModeAction:
                {
                    this._switching = true;
                    _loc_45 = new NpcGenericActionRequestMessage();
                    _loc_45.initNpcGenericActionRequestMessage(this._NPCId, 6, PlayedCharacterManager.getInstance().currentMap.mapId);
                    ConnectionsHandler.getConnection().send(_loc_45);
                    return true;
                }
                case param1 is BidSwitchToSellerModeAction:
                {
                    this._switching = true;
                    _loc_46 = new NpcGenericActionRequestMessage();
                    _loc_46.initNpcGenericActionRequestMessage(this._NPCId, 5, PlayedCharacterManager.getInstance().currentMap.mapId);
                    ConnectionsHandler.getConnection().send(_loc_46);
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
                    _loc_47 = param1 as ExchangeLeaveMessage;
                    if (_loc_47.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _loc_47.success;
                        Kernel.getWorker().removeFrame(this);
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pushed() : Boolean
        {
            this._success = false;
            return true;
        }// end function

        public function pulled() : Boolean
        {
            if (!this.switching)
            {
                if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
                {
                    Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
                }
                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            }
            return true;
        }// end function

        private function get _kernelEventsManager() : KernelEventsManager
        {
            return KernelEventsManager.getInstance();
        }// end function

        private function get _serverConnection() : IServerConnection
        {
            return ConnectionsHandler.getConnection();
        }// end function

        private function getTypeObject(param1:uint) : TypeObjectData
        {
            var _loc_2:* = null;
            if (this._bidHouseObjects == null)
            {
                return null;
            }
            for each (_loc_2 in this._bidHouseObjects)
            {
                
                if (_loc_2.typeObject == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function getGIDObject(param1:uint, param2:uint) : GIDObjectData
        {
            var _loc_4:* = null;
            if (this._bidHouseObjects == null)
            {
                return null;
            }
            var _loc_3:* = this.getTypeObject(param1);
            if (_loc_3 == null)
            {
                return null;
            }
            for each (_loc_4 in _loc_3.objects)
            {
                
                if (_loc_4.GIDObject == param2)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        private function getGIDObjectIndex(param1:uint, param2:uint) : int
        {
            var _loc_5:* = null;
            if (this._bidHouseObjects == null)
            {
                return -1;
            }
            var _loc_3:* = this.getTypeObject(param1);
            if (_loc_3 == null)
            {
                return -1;
            }
            var _loc_4:* = 0;
            for each (_loc_5 in _loc_3.objects)
            {
                
                if (_loc_5.GIDObject == param2)
                {
                    return _loc_4;
                }
                _loc_4++;
            }
            return -1;
        }// end function

        private function initSearchMode(param1:Vector.<uint>) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            if (this._itemsTypesAllowed)
            {
                _loc_2 = param1.length;
                if (_loc_2 == this._itemsTypesAllowed.length)
                {
                    _loc_3 = false;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_2)
                    {
                        
                        if (param1[_loc_4] != this._itemsTypesAllowed[_loc_4])
                        {
                            _loc_3 = true;
                            break;
                        }
                        _loc_4++;
                    }
                    if (_loc_3)
                    {
                        this._listItemsSearchMode = null;
                    }
                }
                else
                {
                    this._listItemsSearchMode = null;
                }
            }
            else
            {
                this._listItemsSearchMode = null;
            }
            this._itemsTypesAllowed = param1;
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.logic.game.common.actions.bid.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.network.*;

import com.ankamagames.jerakine.types.enums.*;

import flash.utils.*;

class ItemSellByPlayer extends Object
{
    public var itemWrapper:ItemWrapper;
    public var price:int;
    public var unsoldDelay:uint;

    function ItemSellByPlayer(param1:ItemWrapper, param2:int, param3:uint)
    {
        this.itemWrapper = param1;
        this.price = param2;
        this.unsoldDelay = param3;
        return;
    }// end function

}


import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.logic.game.common.actions.bid.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.network.*;

import com.ankamagames.jerakine.types.enums.*;

import flash.utils.*;

class ItemSellByBid extends Object
{
    public var itemWrapper:ItemWrapper;
    public var prices:Vector.<int>;

    function ItemSellByBid(param1:ItemWrapper, param2:Vector.<int>)
    {
        this.itemWrapper = param1;
        this.prices = param2;
        return;
    }// end function

}


import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.logic.game.common.actions.bid.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.network.*;

import com.ankamagames.jerakine.types.enums.*;

import flash.utils.*;

class TypeObjectData extends Object
{
    public var objects:Array;
    public var typeObject:uint;

    function TypeObjectData(param1:uint, param2:Array)
    {
        this.objects = param2;
        this.typeObject = param1;
        return;
    }// end function

}


import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.logic.game.common.actions.bid.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.network.*;

import com.ankamagames.jerakine.types.enums.*;

import flash.utils.*;

class GIDObjectData extends Object
{
    public var objects:Array;
    public var GIDObject:uint;

    function GIDObjectData(param1:uint, param2:Array)
    {
        this.objects = param2;
        this.GIDObject = param1;
        return;
    }// end function

}

