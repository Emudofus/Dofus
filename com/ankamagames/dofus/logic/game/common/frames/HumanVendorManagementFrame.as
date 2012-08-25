package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class HumanVendorManagementFrame extends Object implements Frame
    {
        private var _success:Boolean = false;
        private var _shopStock:Array;
        private var _isTurningIntoVendor:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanVendorManagementFrame));

        public function HumanVendorManagementFrame()
        {
            this._shopStock = new Array();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        private function get roleplayMovementFrame() : RoleplayMovementFrame
        {
            return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
        }// end function

        private function get commonExchangeManagementFrame() : CommonExchangeManagementFrame
        {
            return Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
        }// end function

        public function get isTurningIntoVendor() : Boolean
        {
            return this._isTurningIntoVendor;
        }// end function

        public function pushed() : Boolean
        {
            this._success = false;
            this._isTurningIntoVendor = false;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:ExchangeOnHumanVendorRequestAction = null;
            var _loc_3:ExchangeRequestOnShopStockMessage = null;
            var _loc_4:ExchangeShopStockModifyObjectAction = null;
            var _loc_5:ExchangeObjectModifyPricedMessage = null;
            var _loc_6:ExchangeShopStockStartedMessage = null;
            var _loc_7:ExchangeShopStockMovementUpdatedMessage = null;
            var _loc_8:ItemWrapper = null;
            var _loc_9:uint = 0;
            var _loc_10:Boolean = false;
            var _loc_11:ExchangeShopStockMovementRemovedMessage = null;
            var _loc_12:ExchangeShopStockMultiMovementUpdatedMessage = null;
            var _loc_13:ExchangeShopStockMultiMovementRemovedMessage = null;
            var _loc_14:IEntity = null;
            var _loc_15:ExchangeStartAsVendorMessage = null;
            var _loc_16:ExchangeOnHumanVendorRequestAction = null;
            var _loc_17:IEntity = null;
            var _loc_18:ExchangeOnHumanVendorRequestMessage = null;
            var _loc_19:ExpectedSocketClosureMessage = null;
            var _loc_20:ExchangeShowVendorTaxMessage = null;
            var _loc_21:ExchangeReplyTaxVendorMessage = null;
            var _loc_22:ExchangeStartOkHumanVendorMessage = null;
            var _loc_23:GameContextActorInformations = null;
            var _loc_24:String = null;
            var _loc_25:ObjectItemToSell = null;
            var _loc_26:ItemWrapper = null;
            var _loc_27:Object = null;
            var _loc_28:int = 0;
            var _loc_29:Object = null;
            var _loc_30:ObjectItemToSell = null;
            var _loc_31:Boolean = false;
            var _loc_32:uint = 0;
            var _loc_33:ObjectItemToSellInHumanVendorShop = null;
            var _loc_34:ItemWrapper = null;
            switch(true)
            {
                case param1 is ExchangeRequestOnShopStockAction:
                {
                    _loc_2 = param1 as ExchangeOnHumanVendorRequestAction;
                    _loc_3 = new ExchangeRequestOnShopStockMessage();
                    _loc_3.initExchangeRequestOnShopStockMessage();
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is ExchangeShopStockModifyObjectAction:
                {
                    _loc_4 = param1 as ExchangeShopStockModifyObjectAction;
                    _loc_5 = new ExchangeObjectModifyPricedMessage();
                    _loc_5.initExchangeObjectModifyPricedMessage(_loc_4.objectUID, _loc_4.quantity, _loc_4.price);
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is ExchangeShopStockStartedMessage:
                {
                    _loc_6 = param1 as ExchangeShopStockStartedMessage;
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    this._shopStock = new Array();
                    for each (_loc_25 in _loc_6.objectsInfos)
                    {
                        
                        _loc_26 = ItemWrapper.create(0, _loc_25.objectUID, _loc_25.objectGID, _loc_25.quantity, _loc_25.effects, false);
                        _loc_27 = Item.getItemById(_loc_26.objectGID).category;
                        this._shopStock.push({itemWrapper:_loc_26, price:_loc_25.objectPrice, category:_loc_27});
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockStarted, this._shopStock);
                    return true;
                }
                case param1 is ExchangeShopStockMovementUpdatedMessage:
                {
                    _loc_7 = param1 as ExchangeShopStockMovementUpdatedMessage;
                    _loc_8 = ItemWrapper.create(0, _loc_7.objectInfo.objectUID, _loc_7.objectInfo.objectGID, _loc_7.objectInfo.quantity, _loc_7.objectInfo.effects, false);
                    _loc_9 = _loc_7.objectInfo.objectPrice;
                    _loc_10 = true;
                    _loc_28 = 0;
                    while (_loc_28 < this._shopStock.length)
                    {
                        
                        if (this._shopStock[_loc_28].itemWrapper.objectUID == _loc_8.objectUID)
                        {
                            if (_loc_8.quantity > this._shopStock[_loc_28].itemWrapper.quantity)
                            {
                                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockAddQuantity);
                            }
                            else
                            {
                                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockRemoveQuantity);
                            }
                            _loc_29 = Item.getItemById(_loc_8.objectGID).category;
                            this._shopStock.splice(_loc_28, 1, {itemWrapper:_loc_8, price:_loc_9, category:_loc_29});
                            _loc_10 = false;
                            break;
                        }
                        _loc_28++;
                    }
                    if (_loc_10)
                    {
                        _loc_27 = Item.getItemById(_loc_8.objectGID).category;
                        this._shopStock.push({itemWrapper:_loc_8, price:_loc_7.objectInfo.objectPrice, category:_loc_27});
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock, _loc_8);
                    return true;
                }
                case param1 is ExchangeShopStockMovementRemovedMessage:
                {
                    _loc_11 = param1 as ExchangeShopStockMovementRemovedMessage;
                    _loc_28 = 0;
                    while (_loc_28 < this._shopStock.length)
                    {
                        
                        if (this._shopStock[_loc_28].itemWrapper.objectUID == _loc_11.objectId)
                        {
                            this._shopStock.splice(_loc_28, 1);
                            break;
                        }
                        _loc_28++;
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock, null);
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMovementRemoved, _loc_11.objectId);
                    return true;
                }
                case param1 is ExchangeShopStockMultiMovementUpdatedMessage:
                {
                    _loc_12 = param1 as ExchangeShopStockMultiMovementUpdatedMessage;
                    for each (_loc_30 in _loc_12.objectInfoList)
                    {
                        
                        _loc_8 = ItemWrapper.create(0, _loc_30.objectUID, _loc_7.objectInfo.objectGID, _loc_30.quantity, _loc_30.effects, false);
                        _loc_31 = true;
                        _loc_28 = 0;
                        while (_loc_28 < this._shopStock.length)
                        {
                            
                            if (this._shopStock[_loc_28].itemWrapper.objectUID == _loc_8.objectUID)
                            {
                                _loc_27 = Item.getItemById(_loc_8.objectGID).category;
                                this._shopStock.splice(_loc_28, 1, {itemWrapper:_loc_8, price:_loc_7.objectInfo.objectPrice, category:_loc_27});
                                _loc_31 = false;
                                break;
                            }
                            _loc_28++;
                        }
                        if (_loc_31)
                        {
                            this._shopStock.push({itemWrapper:_loc_8, price:_loc_7.objectInfo.objectPrice});
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock);
                    return true;
                }
                case param1 is ExchangeShopStockMultiMovementRemovedMessage:
                {
                    _loc_13 = param1 as ExchangeShopStockMultiMovementRemovedMessage;
                    for each (_loc_32 in _loc_13.objectIdList)
                    {
                        
                        _loc_28 = 0;
                        while (_loc_28 < this._shopStock.length)
                        {
                            
                            if (this._shopStock[_loc_28].itemWrapper.objectUID == _loc_32)
                            {
                                this._shopStock.splice(_loc_28, 1);
                                break;
                            }
                            _loc_28++;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMouvmentRemoveOk, _loc_11.objectId);
                    return true;
                }
                case param1 is ExchangeStartAsVendorRequestAction:
                {
                    _loc_14 = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id);
                    if (_loc_14 && !DataMapProvider.getInstance().pointCanStop(_loc_14.position.x, _loc_14.position.y))
                    {
                        return true;
                    }
                    this._isTurningIntoVendor = true;
                    ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR);
                    _loc_15 = new ExchangeStartAsVendorMessage();
                    _loc_15.initExchangeStartAsVendorMessage();
                    ConnectionsHandler.getConnection().send(_loc_15);
                    return true;
                }
                case param1 is ExchangeOnHumanVendorRequestAction:
                {
                    _loc_16 = param1 as ExchangeOnHumanVendorRequestAction;
                    _loc_17 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    _loc_18 = new ExchangeOnHumanVendorRequestMessage();
                    _loc_18.initExchangeOnHumanVendorRequestMessage(_loc_16.humanVendorId, _loc_16.humanVendorCell);
                    if ((_loc_17 as IMovable).isMoving)
                    {
                        this.roleplayMovementFrame.setFollowingMessage(_loc_18);
                        (_loc_17 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_18);
                    }
                    return true;
                }
                case param1 is ExpectedSocketClosureMessage:
                {
                    _loc_19 = param1 as ExpectedSocketClosureMessage;
                    if (_loc_19.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
                    {
                        Kernel.getWorker().process(new ResetGameAction());
                        return true;
                    }
                    return false;
                }
                case param1 is ExchangeShowVendorTaxAction:
                {
                    _loc_20 = new ExchangeShowVendorTaxMessage();
                    _loc_20.initExchangeShowVendorTaxMessage();
                    ConnectionsHandler.getConnection().send(_loc_20);
                    return true;
                }
                case param1 is ExchangeReplyTaxVendorMessage:
                {
                    _loc_21 = param1 as ExchangeReplyTaxVendorMessage;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeReplyTaxVendor, _loc_21.totalTaxValue);
                    return true;
                }
                case param1 is ExchangeStartOkHumanVendorMessage:
                {
                    _loc_22 = param1 as ExchangeStartOkHumanVendorMessage;
                    _loc_23 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_22.sellerId);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    if (_loc_23 == null)
                    {
                        _log.error("Impossible de trouver le personnage vendeur dans l\'entitiesFrame");
                        return true;
                    }
                    _loc_24 = (_loc_23 as GameRolePlayMerchantInformations).name;
                    this._shopStock = new Array();
                    for each (_loc_33 in _loc_22.objectsInfos)
                    {
                        
                        _loc_34 = ItemWrapper.create(0, _loc_33.objectUID, _loc_33.objectGID, _loc_33.quantity, _loc_33.effects);
                        this._shopStock.push({itemWrapper:_loc_34, price:_loc_33.objectPrice});
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeStartOkHumanVendor, _loc_24, this._shopStock);
                    return true;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
                    PlayedCharacterManager.getInstance().isInExchange = false;
                    this._success = ExchangeLeaveMessage(param1).success;
                    Kernel.getWorker().removeFrame(this);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            if (!this.isTurningIntoVendor)
            {
                if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
                {
                    Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
                }
                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            }
            this._shopStock = null;
            return true;
        }// end function

    }
}
