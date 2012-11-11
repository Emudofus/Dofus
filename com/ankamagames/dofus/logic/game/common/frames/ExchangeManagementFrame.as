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
            var _loc_39:* = 0;
            var _loc_40:* = 0;
            var _loc_41:* = 0;
            var _loc_42:* = 0;
            var _loc_43:* = 0;
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = 0;
            var _loc_48:* = null;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = null;
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
                    _loc_5 = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
                    if (_loc_5)
                    {
                        _loc_5.resetEchangeSequence();
                    }
                    switch(_loc_7.exchangeType)
                    {
                        case ExchangeTypeEnum.PLAYER_TRADE:
                        {
                            _loc_34 = this._sourceInformations.name;
                            _loc_35 = this._targetInformations.name;
                            _loc_36 = EntityLookAdapter.getRiderLook(this._sourceInformations.look);
                            _loc_37 = EntityLookAdapter.getRiderLook(this._targetInformations.look);
                            if (_loc_7.getMessageId() == ExchangeStartedWithPodsMessage.protocolId)
                            {
                                _loc_38 = param1 as ExchangeStartedWithPodsMessage;
                            }
                            _loc_39 = -1;
                            _loc_40 = -1;
                            _loc_41 = -1;
                            _loc_42 = -1;
                            if (_loc_38 != null)
                            {
                                if (_loc_38.firstCharacterId == this._sourceInformations.contextualId)
                                {
                                    _loc_39 = _loc_38.firstCharacterCurrentWeight;
                                    _loc_40 = _loc_38.secondCharacterCurrentWeight;
                                    _loc_41 = _loc_38.firstCharacterMaxWeight;
                                    _loc_42 = _loc_38.secondCharacterMaxWeight;
                                }
                                else
                                {
                                    _loc_40 = _loc_38.firstCharacterCurrentWeight;
                                    _loc_39 = _loc_38.secondCharacterCurrentWeight;
                                    _loc_42 = _loc_38.firstCharacterMaxWeight;
                                    _loc_41 = _loc_38.secondCharacterMaxWeight;
                                }
                            }
                            if (PlayedCharacterManager.getInstance().id == _loc_38.firstCharacterId)
                            {
                                _loc_43 = _loc_38.secondCharacterId;
                            }
                            else
                            {
                                _loc_43 = _loc_38.firstCharacterId;
                            }
                            _log.debug("look : " + _loc_36.toString() + "    " + _loc_37.toString());
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStarted, _loc_34, _loc_35, _loc_36, _loc_37, _loc_39, _loc_40, _loc_41, _loc_42, _loc_43);
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
                    _loc_8 = param1 as StorageInventoryContentMessage;
                    InventoryManager.getInstance().bankInventory.kamas = _loc_8.kamas;
                    InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_loc_8.objects);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is ExchangeStartOkTaxCollectorMessage:
                {
                    _loc_9 = param1 as ExchangeStartOkTaxCollectorMessage;
                    InventoryManager.getInstance().bankInventory.kamas = _loc_9.goldInfo;
                    InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_loc_9.objectsInfos);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectUpdateMessage:
                {
                    _loc_10 = param1 as StorageObjectUpdateMessage;
                    _loc_11 = _loc_10.object;
                    _loc_12 = ItemWrapper.create(_loc_11.position, _loc_11.objectUID, _loc_11.objectGID, _loc_11.quantity, _loc_11.effects);
                    InventoryManager.getInstance().bankInventory.modifyItem(_loc_12);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectRemoveMessage:
                {
                    _loc_13 = param1 as StorageObjectRemoveMessage;
                    InventoryManager.getInstance().bankInventory.removeItem(_loc_13.objectUID);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectsUpdateMessage:
                {
                    _loc_14 = param1 as StorageObjectsUpdateMessage;
                    for each (_loc_44 in _loc_14.objectList)
                    {
                        
                        _loc_45 = _loc_44;
                        _loc_46 = ItemWrapper.create(_loc_45.position, _loc_45.objectUID, _loc_45.objectGID, _loc_45.quantity, _loc_45.effects);
                        InventoryManager.getInstance().bankInventory.modifyItem(_loc_46);
                    }
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageObjectsRemoveMessage:
                {
                    _loc_15 = param1 as StorageObjectsRemoveMessage;
                    for each (_loc_47 in _loc_15.objectUIDList)
                    {
                        
                        InventoryManager.getInstance().bankInventory.removeItem(_loc_47);
                    }
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return false;
                }
                case param1 is StorageKamasUpdateMessage:
                {
                    _loc_16 = param1 as StorageKamasUpdateMessage;
                    InventoryManager.getInstance().bankInventory.kamas = _loc_16.kamasTotal;
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.StorageKamasUpdate, _loc_16.kamasTotal);
                    return false;
                }
                case param1 is ExchangeObjectMoveKamaAction:
                {
                    _loc_17 = param1 as ExchangeObjectMoveKamaAction;
                    _loc_18 = new ExchangeObjectMoveKamaMessage();
                    _loc_18.initExchangeObjectMoveKamaMessage(_loc_17.kamas);
                    this._serverConnection.send(_loc_18);
                    return true;
                }
                case param1 is ExchangeObjectTransfertAllToInvAction:
                {
                    _loc_19 = param1 as ExchangeObjectTransfertAllToInvAction;
                    _loc_20 = new ExchangeObjectTransfertAllToInvMessage();
                    _loc_20.initExchangeObjectTransfertAllToInvMessage();
                    this._serverConnection.send(_loc_20);
                    return true;
                }
                case param1 is ExchangeObjectTransfertListToInvAction:
                {
                    _loc_21 = param1 as ExchangeObjectTransfertListToInvAction;
                    if (_loc_21.ids.length != 0)
                    {
                        _loc_48 = new ExchangeObjectTransfertListToInvMessage();
                        _loc_48.initExchangeObjectTransfertListToInvMessage(_loc_21.ids);
                        this._serverConnection.send(_loc_48);
                    }
                    return true;
                }
                case param1 is ExchangeObjectTransfertExistingToInvAction:
                {
                    _loc_22 = param1 as ExchangeObjectTransfertExistingToInvAction;
                    _loc_23 = new ExchangeObjectTransfertExistingToInvMessage();
                    _loc_23.initExchangeObjectTransfertExistingToInvMessage();
                    this._serverConnection.send(_loc_23);
                    return true;
                }
                case param1 is ExchangeObjectTransfertAllFromInvAction:
                {
                    _loc_24 = param1 as ExchangeObjectTransfertAllFromInvAction;
                    _loc_25 = new ExchangeObjectTransfertAllFromInvMessage();
                    _loc_25.initExchangeObjectTransfertAllFromInvMessage();
                    this._serverConnection.send(_loc_25);
                    return true;
                }
                case param1 is ExchangeObjectTransfertListFromInvAction:
                {
                    _loc_26 = param1 as ExchangeObjectTransfertListFromInvAction;
                    if (_loc_26.ids.length != 0)
                    {
                        _loc_49 = new ExchangeObjectTransfertListFromInvMessage();
                        _loc_49.initExchangeObjectTransfertListFromInvMessage(_loc_26.ids.slice(0, 1000));
                        this._serverConnection.send(_loc_49);
                    }
                    return true;
                }
                case param1 is ExchangeObjectTransfertExistingFromInvAction:
                {
                    _loc_27 = param1 as ExchangeObjectTransfertExistingFromInvAction;
                    _loc_28 = new ExchangeObjectTransfertExistingFromInvMessage();
                    _loc_28.initExchangeObjectTransfertExistingFromInvMessage();
                    this._serverConnection.send(_loc_28);
                    return true;
                }
                case param1 is ExchangeStartOkNpcShopMessage:
                {
                    _loc_29 = param1 as ExchangeStartOkNpcShopMessage;
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false, true));
                    _loc_30 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_29.npcSellerId);
                    _loc_31 = EntityLookAdapter.fromNetwork(_loc_30.look);
                    _loc_32 = new Array();
                    for each (_loc_50 in _loc_29.objectsInfos)
                    {
                        
                        _loc_51 = ItemWrapper.create(63, 0, _loc_50.objectGID, 0, _loc_50.effects, false);
                        _loc_32.push({item:_loc_51, price:_loc_50.objectPrice, criterion:new GroupItemCriterion(_loc_50.buyCriterion)});
                    }
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcShop, _loc_29.npcSellerId, _loc_32, _loc_31, _loc_29.tokenId);
                    return true;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
                    _loc_33 = param1 as ExchangeLeaveMessage;
                    if (_loc_33.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _loc_33.success;
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
