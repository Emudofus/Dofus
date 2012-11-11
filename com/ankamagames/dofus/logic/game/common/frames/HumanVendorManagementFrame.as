package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class HumanVendorManagementFrame extends Object implements Frame
    {
        private var _success:Boolean = false;
        private var _shopStock:Array;
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

        private function get commonExchangeManagementFrame() : CommonExchangeManagementFrame
        {
            return Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
        }// end function

        public function pushed() : Boolean
        {
            this._success = false;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = false;
            var _loc_25:* = 0;
            switch(true)
            {
                case param1 is ExchangeStartOkHumanVendorMessage:
                {
                    _loc_2 = param1 as ExchangeStartOkHumanVendorMessage;
                    _loc_3 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_2.sellerId);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    if (_loc_3 == null)
                    {
                        _log.error("Impossible de trouver le personnage vendeur dans l\'entitiesFrame");
                        return true;
                    }
                    _loc_4 = (_loc_3 as GameRolePlayMerchantInformations).name;
                    this._shopStock = new Array();
                    for each (_loc_16 in _loc_2.objectsInfos)
                    {
                        
                        _loc_17 = ItemWrapper.create(0, _loc_16.objectUID, _loc_16.objectGID, _loc_16.quantity, _loc_16.effects);
                        this._shopStock.push({itemWrapper:_loc_17, price:_loc_16.objectPrice});
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeStartOkHumanVendor, _loc_4, this._shopStock);
                    return true;
                }
                case param1 is ExchangeShopStockStartedMessage:
                {
                    _loc_5 = param1 as ExchangeShopStockStartedMessage;
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    this._shopStock = new Array();
                    for each (_loc_18 in _loc_5.objectsInfos)
                    {
                        
                        _loc_19 = ItemWrapper.create(0, _loc_18.objectUID, _loc_18.objectGID, _loc_18.quantity, _loc_18.effects, false);
                        _loc_20 = Item.getItemById(_loc_19.objectGID).category;
                        this._shopStock.push({itemWrapper:_loc_19, price:_loc_18.objectPrice, category:_loc_20});
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockStarted, this._shopStock);
                    return true;
                }
                case param1 is ExchangeShopStockModifyObjectAction:
                {
                    _loc_6 = param1 as ExchangeShopStockModifyObjectAction;
                    _loc_7 = new ExchangeObjectModifyPricedMessage();
                    _loc_7.initExchangeObjectModifyPricedMessage(_loc_6.objectUID, _loc_6.quantity, _loc_6.price);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is ExchangeShopStockMovementUpdatedMessage:
                {
                    _loc_8 = param1 as ExchangeShopStockMovementUpdatedMessage;
                    _loc_9 = ItemWrapper.create(0, _loc_8.objectInfo.objectUID, _loc_8.objectInfo.objectGID, _loc_8.objectInfo.quantity, _loc_8.objectInfo.effects, false);
                    _loc_10 = _loc_8.objectInfo.objectPrice;
                    _loc_11 = true;
                    _loc_21 = 0;
                    while (_loc_21 < this._shopStock.length)
                    {
                        
                        if (this._shopStock[_loc_21].itemWrapper.objectUID == _loc_9.objectUID)
                        {
                            if (_loc_9.quantity > this._shopStock[_loc_21].itemWrapper.quantity)
                            {
                                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockAddQuantity);
                            }
                            else
                            {
                                KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockRemoveQuantity);
                            }
                            _loc_22 = Item.getItemById(_loc_9.objectGID).category;
                            this._shopStock.splice(_loc_21, 1, {itemWrapper:_loc_9, price:_loc_10, category:_loc_22});
                            _loc_11 = false;
                            break;
                        }
                        _loc_21++;
                    }
                    if (_loc_11)
                    {
                        _loc_20 = Item.getItemById(_loc_9.objectGID).category;
                        this._shopStock.push({itemWrapper:_loc_9, price:_loc_8.objectInfo.objectPrice, category:_loc_20});
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock, _loc_9);
                    return true;
                }
                case param1 is ExchangeShopStockMovementRemovedMessage:
                {
                    _loc_12 = param1 as ExchangeShopStockMovementRemovedMessage;
                    _loc_21 = 0;
                    while (_loc_21 < this._shopStock.length)
                    {
                        
                        if (this._shopStock[_loc_21].itemWrapper.objectUID == _loc_12.objectId)
                        {
                            this._shopStock.splice(_loc_21, 1);
                            break;
                        }
                        _loc_21++;
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock, null);
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMovementRemoved, _loc_12.objectId);
                    return true;
                }
                case param1 is ExchangeShopStockMultiMovementUpdatedMessage:
                {
                    _loc_13 = param1 as ExchangeShopStockMultiMovementUpdatedMessage;
                    for each (_loc_23 in _loc_13.objectInfoList)
                    {
                        
                        _loc_9 = ItemWrapper.create(0, _loc_23.objectUID, _loc_8.objectInfo.objectGID, _loc_23.quantity, _loc_23.effects, false);
                        _loc_24 = true;
                        _loc_21 = 0;
                        while (_loc_21 < this._shopStock.length)
                        {
                            
                            if (this._shopStock[_loc_21].itemWrapper.objectUID == _loc_9.objectUID)
                            {
                                _loc_20 = Item.getItemById(_loc_9.objectGID).category;
                                this._shopStock.splice(_loc_21, 1, {itemWrapper:_loc_9, price:_loc_8.objectInfo.objectPrice, category:_loc_20});
                                _loc_24 = false;
                                break;
                            }
                            _loc_21++;
                        }
                        if (_loc_24)
                        {
                            this._shopStock.push({itemWrapper:_loc_9, price:_loc_8.objectInfo.objectPrice});
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate, this._shopStock);
                    return true;
                }
                case param1 is ExchangeShopStockMultiMovementRemovedMessage:
                {
                    _loc_14 = param1 as ExchangeShopStockMultiMovementRemovedMessage;
                    for each (_loc_25 in _loc_14.objectIdList)
                    {
                        
                        _loc_21 = 0;
                        while (_loc_21 < this._shopStock.length)
                        {
                            
                            if (this._shopStock[_loc_21].itemWrapper.objectUID == _loc_25)
                            {
                                this._shopStock.splice(_loc_21, 1);
                                break;
                            }
                            _loc_21++;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMouvmentRemoveOk, _loc_12.objectId);
                    return true;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
                    _loc_15 = param1 as ExchangeLeaveMessage;
                    if (_loc_15.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _loc_15.success;
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

        public function pulled() : Boolean
        {
            if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            }
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            this._shopStock = null;
            return true;
        }// end function

    }
}
