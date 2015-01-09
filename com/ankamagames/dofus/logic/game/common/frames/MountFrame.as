package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.mount.MountClientData;
    import com.ankamagames.dofus.internalDatacenter.mount.MountData;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountInformationInPaddockRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountInformationInPaddockRequestMessage;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountFeedRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountReleaseRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountSterilizeRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountRenameRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountRenameRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountSetXpRatioRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountSetXpRatioRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountInformationRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestOnMountStockMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountRenamedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeHandleMountStableAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeHandleMountStableMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountStableBornAddMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountStableAddMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountStableRemoveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountPaddockAddMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountPaddockRemoveMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountDataMessage;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountEquipedErrorMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeWeightMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMountMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMountWithOutPaddockMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.UpdateMountBoostMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountEmoteIconUsedOkMessage;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountTakenFromPaddockMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountReleasedMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountToggleRidingRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountFeedRequestMessage;
    import com.ankamagames.dofus.datacenter.communication.Emoticon;
    import com.ankamagames.dofus.network.types.game.mount.UpdateMountBoost;
    import com.ankamagames.dofus.network.types.game.mount.UpdateMountIntBoost;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountReleaseRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.mount.MountSterilizeRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeRequestOnMountStockAction;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountSterilizedMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.MountHookList;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountXpRatioMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountRidingMessage;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.dofus.network.enums.MountEquipedErrorEnum;
    import com.ankamagames.dofus.misc.lists.ExchangeHookList;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountSetMessage;
    import com.ankamagames.dofus.network.messages.game.context.mount.MountUnSetMessage;
    import com.ankamagames.dofus.network.enums.UpdatableMountBoostEnum;
    import com.ankamagames.tiphon.sequence.PlayAnimationStep;
    import com.ankamagames.tiphon.sequence.SetAnimationStep;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.jerakine.messages.Message;

    public class MountFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MountFrame));
        public static const MAX_XP_RATIO:uint = 90;

        private var _mountDialogFrame:MountDialogFrame;
        private var _mountXpRatio:uint;
        private var _stableList:Array;
        private var _paddockList:Array;
        private var _inventoryWeight:uint;
        private var _inventoryMaxWeight:uint;


        public function get priority():int
        {
            return (0);
        }

        public function get mountXpRatio():uint
        {
            return (this._mountXpRatio);
        }

        public function get stableList():Array
        {
            return (this._stableList);
        }

        public function get paddockList():Array
        {
            return (this._paddockList);
        }

        public function pushed():Boolean
        {
            this._mountDialogFrame = new MountDialogFrame();
            return (true);
        }

        public function initializeMountLists(stables:Vector.<MountClientData>, paddocks:Vector.<MountClientData>):void
        {
            var mcd:MountClientData;
            this._stableList = new Array();
            if (stables)
            {
                for each (mcd in stables)
                {
                    this._stableList.push(MountData.makeMountData(mcd, true, this._mountXpRatio));
                };
            };
            this._paddockList = new Array();
            if (paddocks)
            {
                for each (mcd in paddocks)
                {
                    this._paddockList.push(MountData.makeMountData(mcd, true, this._mountXpRatio));
                };
            };
        }

        public function process(msg:Message):Boolean
        {
            var mount:MountData;
            var _local_3:MountInformationInPaddockRequestAction;
            var _local_4:MountInformationInPaddockRequestMessage;
            var _local_5:IMovable;
            var _local_6:MountFeedRequestAction;
            var _local_7:MountReleaseRequestMessage;
            var _local_8:MountSterilizeRequestMessage;
            var _local_9:MountRenameRequestAction;
            var _local_10:MountRenameRequestMessage;
            var _local_11:MountSetXpRatioRequestAction;
            var _local_12:MountSetXpRatioRequestMessage;
            var _local_13:MountInfoRequestAction;
            var _local_14:MountInformationRequestMessage;
            var _local_15:ExchangeRequestOnMountStockMessage;
            var _local_16:MountRenamedMessage;
            var _local_17:Number;
            var _local_18:String;
            var _local_19:ExchangeHandleMountStableAction;
            var _local_20:ExchangeHandleMountStableMessage;
            var _local_21:ExchangeMountStableBornAddMessage;
            var _local_22:ExchangeMountStableAddMessage;
            var _local_23:ExchangeMountStableRemoveMessage;
            var _local_24:ExchangeMountPaddockAddMessage;
            var _local_25:ExchangeMountPaddockRemoveMessage;
            var _local_26:MountDataMessage;
            var _local_27:Boolean;
            var _local_28:AnimatedCharacter;
            var _local_29:RoleplayEntitiesFrame;
            var _local_30:MountEquipedErrorMessage;
            var _local_31:String;
            var _local_32:ExchangeWeightMessage;
            var _local_33:ExchangeStartOkMountMessage;
            var _local_34:ExchangeStartOkMountWithOutPaddockMessage;
            var _local_35:UpdateMountBoostMessage;
            var _local_36:Object;
            var _local_37:MountEmoteIconUsedOkMessage;
            var _local_38:TiphonSprite;
            var _local_39:ExchangeMountTakenFromPaddockMessage;
            var _local_40:String;
            var _local_41:MountReleasedMessage;
            var mtrrmsg:MountToggleRidingRequestMessage;
            var mfrmsg:MountFeedRequestMessage;
            var i:int;
            var currentEmote:Emoticon;
            var lastStaticAnim:String;
            var m:Object;
            var _local_48:UpdateMountBoost;
            var intBoost:UpdateMountIntBoost;
            var animationName:String;
            var seq:SerialSequencer;
            switch (true)
            {
                case (msg is MountInformationInPaddockRequestAction):
                    _local_3 = (msg as MountInformationInPaddockRequestAction);
                    _local_4 = new MountInformationInPaddockRequestMessage();
                    _local_4.initMountInformationInPaddockRequestMessage(_local_3.mountId);
                    ConnectionsHandler.getConnection().send(_local_4);
                    return (true);
                case (msg is MountToggleRidingRequestAction):
                    _local_5 = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IMovable);
                    if (((_local_5) && (!(_local_5.isMoving))))
                    {
                        mtrrmsg = new MountToggleRidingRequestMessage();
                        mtrrmsg.initMountToggleRidingRequestMessage();
                        ConnectionsHandler.getConnection().send(mtrrmsg);
                    };
                    return (true);
                case (msg is MountFeedRequestAction):
                    _local_6 = (msg as MountFeedRequestAction);
                    if (Kernel.getWorker().getFrame(FightBattleFrame) == null)
                    {
                        mfrmsg = new MountFeedRequestMessage();
                        mfrmsg.initMountFeedRequestMessage(_local_6.mountId, _local_6.mountLocation, _local_6.mountFoodUid, _local_6.quantity);
                        ConnectionsHandler.getConnection().send(mfrmsg);
                    };
                    return (true);
                case (msg is MountReleaseRequestAction):
                    _local_7 = new MountReleaseRequestMessage();
                    _local_7.initMountReleaseRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is MountSterilizeRequestAction):
                    _local_8 = new MountSterilizeRequestMessage();
                    _local_8.initMountSterilizeRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_8);
                    return (true);
                case (msg is MountRenameRequestAction):
                    _local_9 = (msg as MountRenameRequestAction);
                    _local_10 = new MountRenameRequestMessage();
                    _local_10.initMountRenameRequestMessage(((_local_9.newName) ? _local_9.newName : ""), _local_9.mountId);
                    ConnectionsHandler.getConnection().send(_local_10);
                    return (true);
                case (msg is MountSetXpRatioRequestAction):
                    _local_11 = (msg as MountSetXpRatioRequestAction);
                    _local_12 = new MountSetXpRatioRequestMessage();
                    _local_12.initMountSetXpRatioRequestMessage((((_local_11.xpRatio > MAX_XP_RATIO)) ? MAX_XP_RATIO : _local_11.xpRatio));
                    ConnectionsHandler.getConnection().send(_local_12);
                    return (true);
                case (msg is MountInfoRequestAction):
                    _local_13 = (msg as MountInfoRequestAction);
                    _local_14 = new MountInformationRequestMessage();
                    _local_14.initMountInformationRequestMessage(_local_13.mountId, _local_13.time);
                    ConnectionsHandler.getConnection().send(_local_14);
                    return (true);
                case (msg is ExchangeRequestOnMountStockAction):
                    _local_15 = new ExchangeRequestOnMountStockMessage();
                    _local_15.initExchangeRequestOnMountStockMessage();
                    ConnectionsHandler.getConnection().send(_local_15);
                    return (true);
                case (msg is MountSterilizedMessage):
                    _local_17 = MountSterilizedMessage(msg).mountId;
                    mount = MountData.getMountFromCache(_local_17);
                    if (mount)
                    {
                        mount.reproductionCount = -1;
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountSterilized, _local_17);
                    return (true);
                case (msg is MountRenamedMessage):
                    _local_16 = (msg as MountRenamedMessage);
                    _local_17 = _local_16.mountId;
                    _local_18 = _local_16.name;
                    mount = MountData.getMountFromCache(_local_17);
                    if (mount)
                    {
                        mount.name = _local_18;
                    };
                    if (this._mountDialogFrame.inStable)
                    {
                        KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountRenamed, _local_17, _local_18);
                    return (true);
                case (msg is ExchangeHandleMountStableAction):
                    _local_19 = (msg as ExchangeHandleMountStableAction);
                    _local_20 = new ExchangeHandleMountStableMessage();
                    _local_20.initExchangeHandleMountStableMessage(_local_19.actionType, _local_19.rideId);
                    ConnectionsHandler.getConnection().send(_local_20);
                    return (true);
                case (msg is ExchangeMountStableBornAddMessage):
                    _local_21 = (msg as ExchangeMountStableBornAddMessage);
                    mount = MountData.makeMountData(_local_21.mountDescription, true, this._mountXpRatio);
                    mount.borning = true;
                    if (this._stableList)
                    {
                        this._stableList.push(mount);
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    return (true);
                case (msg is ExchangeMountStableAddMessage):
                    _local_22 = (msg as ExchangeMountStableAddMessage);
                    if (this._stableList)
                    {
                        this._stableList.push(MountData.makeMountData(_local_22.mountDescription, true, this._mountXpRatio));
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    return (true);
                case (msg is ExchangeMountStableRemoveMessage):
                    _local_23 = (msg as ExchangeMountStableRemoveMessage);
                    i = 0;
                    while (i < this._stableList.length)
                    {
                        if (this._stableList[i].id == _local_23.mountId)
                        {
                            this._stableList.splice(i, 1);
                            break;
                        };
                        i++;
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    return (true);
                case (msg is ExchangeMountPaddockAddMessage):
                    _local_24 = (msg as ExchangeMountPaddockAddMessage);
                    this._paddockList.push(MountData.makeMountData(_local_24.mountDescription, true, this._mountXpRatio));
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, null, this._paddockList, null);
                    return (true);
                case (msg is ExchangeMountPaddockRemoveMessage):
                    _local_25 = (msg as ExchangeMountPaddockRemoveMessage);
                    i = 0;
                    while (i < this._paddockList.length)
                    {
                        if (this._paddockList[i].id == _local_25.mountId)
                        {
                            this._paddockList.splice(i, 1);
                            break;
                        };
                        i++;
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, null, this._paddockList, null);
                    return (true);
                case (msg is MountXpRatioMessage):
                    this._mountXpRatio = MountXpRatioMessage(msg).ratio;
                    mount = PlayedCharacterManager.getInstance().mount;
                    if (mount)
                    {
                        mount.xpRatio = this._mountXpRatio;
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountXpRatio, this._mountXpRatio);
                    return (true);
                case (msg is MountDataMessage):
                    _local_26 = (msg as MountDataMessage);
                    if (this._mountDialogFrame.inStable)
                    {
                        KernelEventsManager.getInstance().processCallback(MountHookList.CertificateMountData, MountData.makeMountData(_local_26.mountData, false, this.mountXpRatio));
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(MountHookList.PaddockedMountData, MountData.makeMountData(_local_26.mountData, false, this.mountXpRatio));
                    };
                    return (true);
                case (msg is MountRidingMessage):
                    _local_27 = MountRidingMessage(msg).isRiding;
                    _local_28 = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter);
                    _local_29 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    if (((_local_28) && (_local_29)))
                    {
                        currentEmote = Emoticon.getEmoticonById(_local_29.currentEmoticon);
                        if (_local_28.getAnimation().indexOf("_Statique_") != -1)
                        {
                            lastStaticAnim = _local_28.getAnimation();
                        }
                        else
                        {
                            if (((currentEmote) && (currentEmote.persistancy)))
                            {
                                lastStaticAnim = _local_28.getAnimation().replace("_", "_Statique_");
                            };
                        };
                        if (lastStaticAnim)
                        {
                            (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).lastStaticAnimations[_local_28.id] = {"anim":lastStaticAnim};
                        };
                        _local_28.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    };
                    PlayedCharacterManager.getInstance().isRidding = _local_27;
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding, _local_27);
                    return (true);
                case (msg is MountEquipedErrorMessage):
                    _local_30 = MountEquipedErrorMessage(msg);
                    switch (_local_30.errorType)
                    {
                        case MountEquipedErrorEnum.UNSET:
                            _local_31 = "UNSET";
                            break;
                        case MountEquipedErrorEnum.SET:
                            _local_31 = "SET";
                            break;
                        case MountEquipedErrorEnum.RIDING:
                            _local_31 = "RIDING";
                            KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding, false);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountEquipedError, _local_31);
                    return (true);
                case (msg is ExchangeWeightMessage):
                    _local_32 = (msg as ExchangeWeightMessage);
                    this._inventoryWeight = _local_32.currentWeight;
                    this._inventoryMaxWeight = _local_32.maxWeight;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeWeight, _local_32.currentWeight, _local_32.maxWeight);
                    return (true);
                case (msg is ExchangeStartOkMountMessage):
                    _local_33 = (msg as ExchangeStartOkMountMessage);
                    TooltipManager.hideAll();
                    this.initializeMountLists(_local_33.stabledMountsDescription, _local_33.paddockedMountsDescription);
                    Kernel.getWorker().addFrame(this._mountDialogFrame);
                    return (true);
                case (msg is MountSetMessage):
                    PlayedCharacterManager.getInstance().mount = MountData.makeMountData(MountSetMessage(msg).mountData, false, this.mountXpRatio);
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountSet);
                    return (true);
                case (msg is MountUnSetMessage):
                    PlayedCharacterManager.getInstance().mount = null;
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountUnSet);
                    return (true);
                case (msg is ExchangeStartOkMountWithOutPaddockMessage):
                    _local_34 = (msg as ExchangeStartOkMountWithOutPaddockMessage);
                    this.initializeMountLists(_local_34.stabledMountsDescription, null);
                    Kernel.getWorker().addFrame(this._mountDialogFrame);
                    return (true);
                case (msg is UpdateMountBoostMessage):
                    _local_35 = (msg as UpdateMountBoostMessage);
                    _local_36 = null;
                    for each (m in this._paddockList)
                    {
                        if (m.id == _local_35.rideId)
                        {
                            _local_36 = m;
                            break;
                        };
                    };
                    if (!(_local_36))
                    {
                        _log.error((("Can't find " + _local_35.rideId) + " ride ID for update mount boost"));
                        return (true);
                    };
                    for each (_local_48 in _local_35.boostToUpdateList)
                    {
                        if ((_local_48 is UpdateMountIntBoost))
                        {
                            intBoost = (_local_48 as UpdateMountIntBoost);
                            switch (intBoost.type)
                            {
                                case UpdatableMountBoostEnum.ENERGY:
                                    _local_36.energy = intBoost.value;
                                    break;
                                case UpdatableMountBoostEnum.LOVE:
                                    _local_36.love = intBoost.value;
                                    break;
                                case UpdatableMountBoostEnum.MATURITY:
                                    _local_36.maturity = intBoost.value;
                                    break;
                                case UpdatableMountBoostEnum.SERENITY:
                                    _local_36.serenity = intBoost.value;
                                    break;
                                case UpdatableMountBoostEnum.STAMINA:
                                    _local_36.stamina = intBoost.value;
                                    break;
                                case UpdatableMountBoostEnum.TIREDNESS:
                                    _local_36.boostLimiter = intBoost.value;
                            };
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, null, this._paddockList, null);
                    return (true);
                case (msg is MountEmoteIconUsedOkMessage):
                    _local_37 = (msg as MountEmoteIconUsedOkMessage);
                    _local_38 = (DofusEntities.getEntity(_local_37.mountId) as TiphonSprite);
                    if (_local_38)
                    {
                        animationName = null;
                        switch (_local_37.reactionType)
                        {
                            case 1:
                                animationName = "AnimEmoteRest_Statique";
                                break;
                            case 2:
                                animationName = "AnimAttaque0";
                                break;
                            case 3:
                                animationName = "AnimEmoteCaresse";
                                break;
                            case 4:
                                animationName = "AnimEmoteReproductionF";
                                break;
                            case 5:
                                animationName = "AnimEmoteReproductionM";
                                break;
                        };
                        if (animationName)
                        {
                            seq = new SerialSequencer();
                            seq.addStep(new PlayAnimationStep(_local_38, animationName, false));
                            seq.addStep(new SetAnimationStep(_local_38, AnimationEnum.ANIM_STATIQUE));
                            seq.start();
                        };
                    };
                    return (true);
                case (msg is ExchangeMountTakenFromPaddockMessage):
                    _local_39 = (msg as ExchangeMountTakenFromPaddockMessage);
                    _local_40 = I18n.getUiText("ui.mount.takenFromPaddock", [_local_39.name, (((("[" + _local_39.worldX) + ",") + _local_39.worldY) + "]"), _local_39.ownername]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_40, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is MountReleasedMessage):
                    _local_41 = (msg as MountReleasedMessage);
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountReleased, _local_41.mountId);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function get inventoryWeight():uint
        {
            return (this._inventoryWeight);
        }

        public function get inventoryMaxWeight():uint
        {
            return (this._inventoryMaxWeight);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

