package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.lists.ExchangeHookList;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestedTradeMessage;
    import com.ankamagames.dofus.datacenter.npcs.Npc;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcTradeMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedWithStorageMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageInventoryContentMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkTaxCollectorMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectUpdateMessage;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectRemoveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectsUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectsRemoveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageKamasUpdateMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveKamaMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllToInvAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertAllToInvMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListToInvAction;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListWithQuantityToInvAction;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingToInvAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertExistingToInvMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertAllFromInvMessage;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertExistingFromInvMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcShopMessage;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedWithPodsMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListToInvMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListWithQuantityToInvMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListFromInvMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInNpcShop;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.jerakine.messages.Message;

    public class ExchangeManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExchangeManagementFrame));

        private var _priority:int = 0;
        private var _sourceInformations:GameRolePlayNamedActorInformations;
        private var _targetInformations:GameRolePlayNamedActorInformations;
        private var _meReady:Boolean = false;
        private var _youReady:Boolean = false;
        private var _exchangeInventory:Array;
        private var _success:Boolean;


        public function get priority():int
        {
            return (this._priority);
        }

        public function set priority(p:int):void
        {
            this._priority = p;
        }

        private function get roleplayContextFrame():RoleplayContextFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame));
        }

        private function get roleplayEntitiesFrame():RoleplayEntitiesFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame));
        }

        private function get roleplayMovementFrame():RoleplayMovementFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame));
        }

        public function initMountStock(objectsInfos:Vector.<ObjectItem>):void
        {
            InventoryManager.getInstance().bankInventory.initializeFromObjectItems(objectsInfos);
            InventoryManager.getInstance().bankInventory.releaseHooks();
        }

        public function processExchangeRequestedTradeMessage(msg:ExchangeRequestedTradeMessage):void
        {
            var _local_4:SocialFrame;
            var lda:LeaveDialogAction;
            if (msg.exchangeType != ExchangeTypeEnum.PLAYER_TRADE)
            {
                return;
            };
            this._sourceInformations = (this.roleplayEntitiesFrame.getEntityInfos(msg.source) as GameRolePlayNamedActorInformations);
            this._targetInformations = (this.roleplayEntitiesFrame.getEntityInfos(msg.target) as GameRolePlayNamedActorInformations);
            var sourceName:String = this._sourceInformations.name;
            var targetName:String = this._targetInformations.name;
            if (msg.source == PlayedCharacterManager.getInstance().id)
            {
                this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterFromMe, sourceName, targetName);
            }
            else
            {
                _local_4 = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame);
                if (((_local_4) && (_local_4.isIgnored(sourceName))))
                {
                    lda = new LeaveDialogAction();
                    Kernel.getWorker().process(lda);
                    return;
                };
                this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterToMe, targetName, sourceName);
            };
        }

        public function processExchangeStartOkNpcTradeMessage(msg:ExchangeStartOkNpcTradeMessage):void
        {
            var sourceName:String = PlayedCharacterManager.getInstance().infos.name;
            var NPCId:int = this.roleplayEntitiesFrame.getEntityInfos(msg.npcId).contextualId;
            var NPC:Npc = Npc.getNpcById(NPCId);
            var targetName:String = Npc.getNpcById((this.roleplayEntitiesFrame.getEntityInfos(msg.npcId) as GameRolePlayNpcInformations).npcId).name;
            var sourceLook:TiphonEntityLook = EntityLookAdapter.getRiderLook(PlayedCharacterManager.getInstance().infos.entityLook);
            var targetLook:TiphonEntityLook = EntityLookAdapter.getRiderLook(this.roleplayContextFrame.entitiesFrame.getEntityInfos(msg.npcId).look);
            var esonmsg:ExchangeStartOkNpcTradeMessage = (msg as ExchangeStartOkNpcTradeMessage);
            PlayedCharacterManager.getInstance().isInExchange = true;
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcTrade, esonmsg.npcId, sourceName, targetName, sourceLook, targetLook);
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, ExchangeTypeEnum.NPC_TRADE);
        }

        public function process(msg:Message):Boolean
        {
            var i:int;
            var inventorySize:int;
            var _local_4:ExchangeStartedWithStorageMessage;
            var _local_5:CommonExchangeManagementFrame;
            var _local_6:int;
            var _local_7:ExchangeStartedMessage;
            var _local_8:CommonExchangeManagementFrame;
            var _local_9:StorageInventoryContentMessage;
            var _local_10:ExchangeStartOkTaxCollectorMessage;
            var _local_11:StorageObjectUpdateMessage;
            var _local_12:ObjectItem;
            var _local_13:ItemWrapper;
            var _local_14:StorageObjectRemoveMessage;
            var _local_15:StorageObjectsUpdateMessage;
            var _local_16:StorageObjectsRemoveMessage;
            var _local_17:StorageKamasUpdateMessage;
            var _local_18:ExchangeObjectMoveKamaAction;
            var _local_19:ExchangeObjectMoveKamaMessage;
            var _local_20:ExchangeObjectTransfertAllToInvAction;
            var _local_21:ExchangeObjectTransfertAllToInvMessage;
            var _local_22:ExchangeObjectTransfertListToInvAction;
            var _local_23:ExchangeObjectTransfertListWithQuantityToInvAction;
            var _local_24:ExchangeObjectTransfertExistingToInvAction;
            var _local_25:ExchangeObjectTransfertExistingToInvMessage;
            var _local_26:ExchangeObjectTransfertAllFromInvAction;
            var _local_27:ExchangeObjectTransfertAllFromInvMessage;
            var _local_28:ExchangeObjectTransfertListFromInvAction;
            var _local_29:ExchangeObjectTransfertExistingFromInvAction;
            var _local_30:ExchangeObjectTransfertExistingFromInvMessage;
            var _local_31:ExchangeStartOkNpcShopMessage;
            var _local_32:GameContextActorInformations;
            var _local_33:TiphonEntityLook;
            var _local_34:Array;
            var _local_35:ExchangeLeaveMessage;
            var _local_36:String;
            var _local_37:String;
            var _local_38:TiphonEntityLook;
            var _local_39:TiphonEntityLook;
            var _local_40:ExchangeStartedWithPodsMessage;
            var _local_41:int;
            var _local_42:int;
            var _local_43:int;
            var _local_44:int;
            var _local_45:int;
            var sosuit:ObjectItem;
            var sosuobj:ObjectItem;
            var sosuic:ItemWrapper;
            var sosruid:uint;
            var eotltimsg:ExchangeObjectTransfertListToInvMessage;
            var eotlwqtoimsg:ExchangeObjectTransfertListWithQuantityToInvMessage;
            var eotlfimsg:ExchangeObjectTransfertListFromInvMessage;
            var oitsins:ObjectItemToSellInNpcShop;
            var itemwra:ItemWrapper;
            switch (true)
            {
                case (msg is ExchangeStartedWithStorageMessage):
                    _local_4 = (msg as ExchangeStartedWithStorageMessage);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    _local_5 = (Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame);
                    if (_local_5)
                    {
                        _local_5.resetEchangeSequence();
                    };
                    _local_6 = _local_4.storageMaxSlot;
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBankStartedWithStorage, ExchangeTypeEnum.STORAGE, _local_6);
                    return (false);
                case (msg is ExchangeStartedMessage):
                    _local_7 = (msg as ExchangeStartedMessage);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    _local_8 = (Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame);
                    if (_local_8)
                    {
                        _local_8.resetEchangeSequence();
                    };
                    switch (_local_7.exchangeType)
                    {
                        case ExchangeTypeEnum.PLAYER_TRADE:
                            _local_36 = this._sourceInformations.name;
                            _local_37 = this._targetInformations.name;
                            _local_38 = EntityLookAdapter.getRiderLook(this._sourceInformations.look);
                            _local_39 = EntityLookAdapter.getRiderLook(this._targetInformations.look);
                            if (_local_7.getMessageId() == ExchangeStartedWithPodsMessage.protocolId)
                            {
                                _local_40 = (msg as ExchangeStartedWithPodsMessage);
                            };
                            _local_41 = -1;
                            _local_42 = -1;
                            _local_43 = -1;
                            _local_44 = -1;
                            if (_local_40 != null)
                            {
                                if (_local_40.firstCharacterId == this._sourceInformations.contextualId)
                                {
                                    _local_41 = _local_40.firstCharacterCurrentWeight;
                                    _local_42 = _local_40.secondCharacterCurrentWeight;
                                    _local_43 = _local_40.firstCharacterMaxWeight;
                                    _local_44 = _local_40.secondCharacterMaxWeight;
                                }
                                else
                                {
                                    _local_42 = _local_40.firstCharacterCurrentWeight;
                                    _local_41 = _local_40.secondCharacterCurrentWeight;
                                    _local_44 = _local_40.firstCharacterMaxWeight;
                                    _local_43 = _local_40.secondCharacterMaxWeight;
                                };
                            };
                            if (PlayedCharacterManager.getInstance().id == _local_40.firstCharacterId)
                            {
                                _local_45 = _local_40.secondCharacterId;
                            }
                            else
                            {
                                _local_45 = _local_40.firstCharacterId;
                            };
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStarted, _local_36, _local_37, _local_38, _local_39, _local_41, _local_42, _local_43, _local_44, _local_45);
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, _local_7.exchangeType);
                            return (true);
                        case ExchangeTypeEnum.STORAGE:
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, _local_7.exchangeType);
                            return (true);
                        case ExchangeTypeEnum.TAXCOLLECTOR:
                            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType, _local_7.exchangeType);
                            return (true);
                    };
                    return (true);
                case (msg is StorageInventoryContentMessage):
                    _local_9 = (msg as StorageInventoryContentMessage);
                    InventoryManager.getInstance().bankInventory.kamas = _local_9.kamas;
                    InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_local_9.objects);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return (true);
                case (msg is ExchangeStartOkTaxCollectorMessage):
                    _local_10 = (msg as ExchangeStartOkTaxCollectorMessage);
                    InventoryManager.getInstance().bankInventory.kamas = _local_10.goldInfo;
                    InventoryManager.getInstance().bankInventory.initializeFromObjectItems(_local_10.objectsInfos);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return (true);
                case (msg is StorageObjectUpdateMessage):
                    _local_11 = (msg as StorageObjectUpdateMessage);
                    _local_12 = _local_11.object;
                    _local_13 = ItemWrapper.create(_local_12.position, _local_12.objectUID, _local_12.objectGID, _local_12.quantity, _local_12.effects);
                    InventoryManager.getInstance().bankInventory.modifyItem(_local_13);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return (true);
                case (msg is StorageObjectRemoveMessage):
                    _local_14 = (msg as StorageObjectRemoveMessage);
                    InventoryManager.getInstance().bankInventory.removeItem(_local_14.objectUID);
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return (true);
                case (msg is StorageObjectsUpdateMessage):
                    _local_15 = (msg as StorageObjectsUpdateMessage);
                    for each (sosuit in _local_15.objectList)
                    {
                        sosuobj = sosuit;
                        sosuic = ItemWrapper.create(sosuobj.position, sosuobj.objectUID, sosuobj.objectGID, sosuobj.quantity, sosuobj.effects);
                        InventoryManager.getInstance().bankInventory.modifyItem(sosuic);
                    };
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return (true);
                case (msg is StorageObjectsRemoveMessage):
                    _local_16 = (msg as StorageObjectsRemoveMessage);
                    for each (sosruid in _local_16.objectUIDList)
                    {
                        InventoryManager.getInstance().bankInventory.removeItem(sosruid);
                    };
                    InventoryManager.getInstance().bankInventory.releaseHooks();
                    return (true);
                case (msg is StorageKamasUpdateMessage):
                    _local_17 = (msg as StorageKamasUpdateMessage);
                    InventoryManager.getInstance().bankInventory.kamas = _local_17.kamasTotal;
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.StorageKamasUpdate, _local_17.kamasTotal);
                    return (true);
                case (msg is ExchangeObjectMoveKamaAction):
                    _local_18 = (msg as ExchangeObjectMoveKamaAction);
                    _local_19 = new ExchangeObjectMoveKamaMessage();
                    _local_19.initExchangeObjectMoveKamaMessage(_local_18.kamas);
                    ConnectionsHandler.getConnection().send(_local_19);
                    return (true);
                case (msg is ExchangeObjectTransfertAllToInvAction):
                    _local_20 = (msg as ExchangeObjectTransfertAllToInvAction);
                    _local_21 = new ExchangeObjectTransfertAllToInvMessage();
                    _local_21.initExchangeObjectTransfertAllToInvMessage();
                    ConnectionsHandler.getConnection().send(_local_21);
                    return (true);
                case (msg is ExchangeObjectTransfertListToInvAction):
                    _local_22 = (msg as ExchangeObjectTransfertListToInvAction);
                    if (_local_22.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.exchange.partialTransfert"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (_local_22.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
                    {
                        eotltimsg = new ExchangeObjectTransfertListToInvMessage();
                        eotltimsg.initExchangeObjectTransfertListToInvMessage(_local_22.ids.slice(0, ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                        ConnectionsHandler.getConnection().send(eotltimsg);
                    };
                    return (true);
                case (msg is ExchangeObjectTransfertListWithQuantityToInvAction):
                    _local_23 = (msg as ExchangeObjectTransfertListWithQuantityToInvAction);
                    if (_local_23.ids.length > (ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2))
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.exchange.partialTransfert"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if ((((_local_23.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)) && ((_local_23.ids.length == _local_23.qtys.length))))
                    {
                        eotlwqtoimsg = new ExchangeObjectTransfertListWithQuantityToInvMessage();
                        eotlwqtoimsg.initExchangeObjectTransfertListWithQuantityToInvMessage(_local_23.ids.slice(0, (ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2)), _local_23.qtys.slice(0, (ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2)));
                        ConnectionsHandler.getConnection().send(eotlwqtoimsg);
                    };
                    return (true);
                case (msg is ExchangeObjectTransfertExistingToInvAction):
                    _local_24 = (msg as ExchangeObjectTransfertExistingToInvAction);
                    _local_25 = new ExchangeObjectTransfertExistingToInvMessage();
                    _local_25.initExchangeObjectTransfertExistingToInvMessage();
                    ConnectionsHandler.getConnection().send(_local_25);
                    return (true);
                case (msg is ExchangeObjectTransfertAllFromInvAction):
                    _local_26 = (msg as ExchangeObjectTransfertAllFromInvAction);
                    _local_27 = new ExchangeObjectTransfertAllFromInvMessage();
                    _local_27.initExchangeObjectTransfertAllFromInvMessage();
                    ConnectionsHandler.getConnection().send(_local_27);
                    return (true);
                case (msg is ExchangeObjectTransfertListFromInvAction):
                    _local_28 = (msg as ExchangeObjectTransfertListFromInvAction);
                    if (_local_28.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.exchange.partialTransfert"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (_local_28.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
                    {
                        eotlfimsg = new ExchangeObjectTransfertListFromInvMessage();
                        eotlfimsg.initExchangeObjectTransfertListFromInvMessage(_local_28.ids.slice(0, ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                        ConnectionsHandler.getConnection().send(eotlfimsg);
                    };
                    return (true);
                case (msg is ExchangeObjectTransfertExistingFromInvAction):
                    _local_29 = (msg as ExchangeObjectTransfertExistingFromInvAction);
                    _local_30 = new ExchangeObjectTransfertExistingFromInvMessage();
                    _local_30.initExchangeObjectTransfertExistingFromInvMessage();
                    ConnectionsHandler.getConnection().send(_local_30);
                    return (true);
                case (msg is ExchangeStartOkNpcShopMessage):
                    _local_31 = (msg as ExchangeStartOkNpcShopMessage);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false, true));
                    _local_32 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_31.npcSellerId);
                    _local_33 = EntityLookAdapter.getRiderLook(_local_32.look);
                    _local_34 = new Array();
                    for each (oitsins in _local_31.objectsInfos)
                    {
                        itemwra = ItemWrapper.create(63, 0, oitsins.objectGID, 0, oitsins.effects, false);
                        _local_34.push({
                            "item":itemwra,
                            "price":oitsins.objectPrice,
                            "criterion":new GroupItemCriterion(oitsins.buyCriterion)
                        });
                    };
                    this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcShop, _local_31.npcSellerId, _local_34, _local_33, _local_31.tokenId);
                    return (true);
                case (msg is LeaveDialogRequestAction):
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return (true);
                case (msg is ExchangeLeaveMessage):
                    _local_35 = (msg as ExchangeLeaveMessage);
                    if (_local_35.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = _local_35.success;
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        private function proceedExchange():void
        {
        }

        public function pushed():Boolean
        {
            this._success = false;
            return (true);
        }

        public function pulled():Boolean
        {
            if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            };
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            this._exchangeInventory = null;
            return (true);
        }

        private function get _kernelEventsManager():KernelEventsManager
        {
            return (KernelEventsManager.getInstance());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

