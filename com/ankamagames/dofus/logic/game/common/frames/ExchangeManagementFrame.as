package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.items.criterion.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.messages.game.inventory.storage.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class ExchangeManagementFrame extends Object implements Frame
    {
        private var _priority:int = 0;
        private var _sourceInformations:GameRolePlayNamedActorInformations;
        private var _targetInformations:GameRolePlayNamedActorInformations;
        private var _meReady:Boolean = false;
        private var _youReady:Boolean = false;
        private var _exchangeInventory:Array;
        private var _success:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ExchangeManagementFrame));

        public function ExchangeManagementFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function set priority(param1:int) : void
        {
            this._priority = param1;
            return;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
        }// end function

        private function get roleplayMovementFrame() : RoleplayMovementFrame
        {
            return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
        }// end function

        public function initMountStock(param1:Vector.<ObjectItem>) : void
        {
            InventoryManager.getInstance().bankInventory.initializeFromObjectItems(param1);
            InventoryManager.getInstance().bankInventory.releaseHooks();
            return;
        }// end function

        public function processExchangeRequestedTradeMessage(param1:ExchangeRequestedTradeMessage) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1.exchangeType != ExchangeTypeEnum.PLAYER_TRADE)
            {
                return;
            }
            this._sourceInformations = this.roleplayEntitiesFrame.getEntityInfos(param1.source) as GameRolePlayNamedActorInformations;
            this._targetInformations = this.roleplayEntitiesFrame.getEntityInfos(param1.target) as GameRolePlayNamedActorInformations;
            var _loc_2:* = this._sourceInformations.name;
            var _loc_3:* = this._targetInformations.name;
            if (param1.source == PlayedCharacterManager.getInstance().id)
            {
                this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterFromMe, _loc_2, _loc_3);
            }
            else
            {
                _loc_4 = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
                if (_loc_4 && _loc_4.isIgnored(_loc_2))
                {
                    _loc_5 = new LeaveDialogAction();
                    Kernel.getWorker().process(_loc_5);
                    return;
                }
                this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterToMe, _loc_3, _loc_2);
            }
            return;
        }// end function

        public function processExchangeStartOkNpcTradeMessage(param1:ExchangeStartOkNpcTradeMessage) : void
        {
            var _loc_2:* = PlayedCharacterManager.getInstance().infos.name;
            var _loc_3:* = this.roleplayEntitiesFrame.getEntityInfos(param1.npcId).contextualId;
            var _loc_4:* = Npc.getNpcById(_loc_3);
            var _loc_5:* = Npc.getNpcById((this.roleplayEntitiesFrame.getEntityInfos(param1.npcId) as GameRolePlayNpcInformations).npcId).name;
            var _loc_6:* = EntityLookAdapter.getRiderLook(PlayedCharacterManager.getInstance().infos.entityLook);
            var _loc_7:* = EntityLookAdapter.getRiderLook(this.roleplayContextFrame.entitiesFrame.getEntityInfos(param1.npcId).look);
            var _loc_8:* = param1 as ExchangeStartOkNpcTradeMessage;
            PlayedCharacterManager.getInstance().isInExchange = true;
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcTrade, _loc_8.npcId, _loc_2, _loc_5, _loc_6, _loc_7);
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, ExchangeTypeEnum.NPC_TRADE);
            return;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = 0;
            var _loc_41:* = 0;
            var _loc_42:* = 0;
            var _loc_43:* = 0;
            var _loc_44:* = 0;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = 0;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = null;
            var _loc_52:* = null;
            switch(true)
            {
                case param1 is ExchangeStartedWithStorageMessage:
                {
                    _loc_4 = param1 as ExchangeStartedWithStorageMessage;
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    _loc_5 = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
                    if (_loc_5)
                    {
                        _loc_5.resetEchangeSequence();
                    }
                    _loc_6 = _loc_4.storageMaxSlot;
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBankStartedWithStorage, ExchangeTypeEnum.STORAGE, _loc_6);
                    return true;
                }
                case param1 is ExchangeStartedMessage:
                {
                    _loc_7 = param1 as ExchangeStartedMessage;
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    _loc_8 = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
                    if (_loc_8)
                    {
                        _loc_8.resetEchangeSequence();
                    }
                    switch(_loc_7.exchangeType)
                    {
                        case ExchangeTypeEnum.PLAYER_TRADE:
                        {
                            _loc_35 = this._sourceInformations.name;
                            _loc_36 = this._targetInformations.name;
                            _loc_37 = EntityLookAdapter.getRiderLook(this._sourceInformations.look);
                            _loc_38 = EntityLookAdapter.getRiderLook(this._targetInformations.look);
                            if (_loc_7.getMessageId() == ExchangeStartedWithPodsMessage.protocolId)
                            {
                                _loc_39 = param1 as ExchangeStartedWithPodsMessage;
                            }
                            _loc_40 = -1;
                            _loc_41 = -1;
                            _loc_42 = -1;
                            _loc_43 = -1;
                            if (_loc_39 != null)
                            {
                                if (_loc_39.firstCharacterId == this._sourceInformations.contextualId)
                                {
                                    _loc_40 = _loc_39.firstCharacterCurrentWeight;
                                    _loc_41 = _loc_39.secondCharacterCurrentWeight;
                                    _loc_42 = _loc_39.firstCharacterMaxWeight;
                                    _loc_43 = _loc_39.secondCharacterMaxWeight;
                                }
                                else
                                {
                                    _loc_41 = _loc_39.firstCharacterCurrentWeight;
                                    _loc_40 = _loc_39.secondCharacterCurrentWeight;
                                    _loc_43 = _loc_39.firstCharacterMaxWeight;
                                    _loc_42 = _loc_39.secondCharacterMaxWeight;
                                }
                            }
                            if (PlayedCharacterManager.getInstance().id == _loc_39.firstCharacterId)
                            {
                                _loc_44 = _loc_39.secondCharacterId;
                            }
                            else
                            {
                                _loc_44 = _loc_39.firstCharacterId;
                            }
                            _log.debug("look : " + _loc_37.toString() + "    " + _loc_38.toString());
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStarted, _loc_35, _loc_36, _loc_37, _loc_38, _loc_40, _loc_41, _loc_42, _loc_43, _loc_44);
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, _loc_7.exchangeType);
                            return true;
                        }
                        case ExchangeTypeEnum.STORAGE:
                        {
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, _loc_7.exchangeType);
                            return true;
                        }
                        case ExchangeTypeEnum.TAXCOLLECTOR:
                        {
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, _loc_7.exchangeType);
                            return true;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return false;
                }
                case param1 is StorageInventoryContentMessage:
                {
                    _loc_9 = param1 as StorageInventoryContentMessage;
                    InventoryManager.getInstance().bankInventory.kamas = _loc_9.kamas;
                    InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_loc_9.objects);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is ExchangeStartOkTaxCollectorMessage:
                {
                    _loc_10 = param1 as ExchangeStartOkTaxCollectorMessage;
                    InventoryManager.getInstance().bankInventory.kamas = _loc_10.goldInfo;
                    InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_loc_10.objectsInfos);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectUpdateMessage:
                {
                    _loc_11 = param1 as StorageObjectUpdateMessage;
                    _loc_12 = _loc_11.object;
                    _loc_13 = ItemWrapper.create(_loc_12.position, _loc_12.objectUID, _loc_12.objectGID, _loc_12.quantity, _loc_12.effects);
                    InventoryManager.getInstance().bankInventory.modifyItem(_loc_13);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectRemoveMessage:
                {
                    _loc_14 = param1 as StorageObjectRemoveMessage;
                    InventoryManager.getInstance().bankInventory.removeItem(_loc_14.objectUID);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectsUpdateMessage:
                {
                    _loc_15 = param1 as StorageObjectsUpdateMessage;
                    for each (_loc_45 in _loc_15.objectList)
                    {
                        
                        _loc_46 = _loc_45;
                        _loc_47 = ItemWrapper.create(_loc_46.position, _loc_46.objectUID, _loc_46.objectGID, _loc_46.quantity, _loc_46.effects);
                        InventoryManager.getInstance().bankInventory.modifyItem(_loc_47);
                    }
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectsRemoveMessage:
                {
                    _loc_16 = param1 as StorageObjectsRemoveMessage;
                    for each (_loc_48 in _loc_16.objectUIDList)
                    {
                        
                        InventoryManager.getInstance().bankInventory.removeItem(_loc_48);
                    }
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageKamasUpdateMessage:
                {
                    _loc_17 = param1 as StorageKamasUpdateMessage;
                    InventoryManager.getInstance().bankInventory.kamas = _loc_17.kamasTotal;
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.StorageKamasUpdate, _loc_17.kamasTotal);
                    return false;
                }
                case param1 is ExchangeObjectMoveKamaAction:
                {
                    _loc_18 = param1 as ExchangeObjectMoveKamaAction;
                    _loc_19 = new ExchangeObjectMoveKamaMessage();
                    _loc_19.initExchangeObjectMoveKamaMessage(_loc_18.kamas);
                    this._serverConnection.send(_loc_19);
                    return true;
                }
                case param1 is ExchangeObjectTransfertAllToInvAction:
                {
                    _loc_20 = param1 as ExchangeObjectTransfertAllToInvAction;
                    _loc_21 = new ExchangeObjectTransfertAllToInvMessage();
                    _loc_21.initExchangeObjectTransfertAllToInvMessage();
                    this._serverConnection.send(_loc_21);
                    return true;
                }
                case param1 is ExchangeObjectTransfertListToInvAction:
                {
                    _loc_22 = param1 as ExchangeObjectTransfertListToInvAction;
                    if (_loc_22.ids.length != 0)
                    {
                        _loc_49 = new ExchangeObjectTransfertListToInvMessage();
                        _loc_49.initExchangeObjectTransfertListToInvMessage(_loc_22.ids);
                        this._serverConnection.send(_loc_49);
                    }
                    return true;
                }
                case param1 is ExchangeObjectTransfertExistingToInvAction:
                {
                    _loc_23 = param1 as ExchangeObjectTransfertExistingToInvAction;
                    _loc_24 = new ExchangeObjectTransfertExistingToInvMessage();
                    _loc_24.initExchangeObjectTransfertExistingToInvMessage();
                    this._serverConnection.send(_loc_24);
                    return true;
                }
                case param1 is ExchangeObjectTransfertAllFromInvAction:
                {
                    _loc_25 = param1 as ExchangeObjectTransfertAllFromInvAction;
                    _loc_26 = new ExchangeObjectTransfertAllFromInvMessage();
                    _loc_26.initExchangeObjectTransfertAllFromInvMessage();
                    this._serverConnection.send(_loc_26);
                    return true;
                }
                case param1 is ExchangeObjectTransfertListFromInvAction:
                {
                    _loc_27 = param1 as ExchangeObjectTransfertListFromInvAction;
                    if (_loc_27.ids.length != 0)
                    {
                        _loc_50 = new ExchangeObjectTransfertListFromInvMessage();
                        _loc_50.initExchangeObjectTransfertListFromInvMessage(_loc_27.ids.slice(0, 1000));
                        this._serverConnection.send(_loc_50);
                    }
                    return true;
                }
                case param1 is ExchangeObjectTransfertExistingFromInvAction:
                {
                    _loc_28 = param1 as ExchangeObjectTransfertExistingFromInvAction;
                    _loc_29 = new ExchangeObjectTransfertExistingFromInvMessage();
                    _loc_29.initExchangeObjectTransfertExistingFromInvMessage();
                    this._serverConnection.send(_loc_29);
                    return true;
                }
                case param1 is ExchangeStartOkNpcShopMessage:
                {
                    _loc_30 = param1 as ExchangeStartOkNpcShopMessage;
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false, true));
                    _loc_31 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_30.npcSellerId);
                    _loc_32 = EntityLookAdapter.fromNetwork(_loc_31.look);
                    _loc_33 = new Array();
                    for each (_loc_51 in _loc_30.objectsInfos)
                    {
                        
                        _loc_52 = ItemWrapper.create(63, 0, _loc_51.objectGID, 0, _loc_51.effects, false);
                        _loc_33.push({item:_loc_52, price:_loc_51.objectPrice, criterion:new GroupItemCriterion(_loc_51.buyCriterion)});
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcShop, _loc_30.npcSellerId, _loc_33, _loc_32, _loc_30.tokenId);
                    return true;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
                    _loc_34 = param1 as ExchangeLeaveMessage;
                    if (_loc_34.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _loc_34.success;
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

        private function proceedExchange() : void
        {
            return;
        }// end function

        public function pushed() : Boolean
        {
            this._success = false;
            return true;
        }// end function

        public function pulled() : Boolean
        {
            if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            }
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            this._exchangeInventory = null;
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

    }
}
