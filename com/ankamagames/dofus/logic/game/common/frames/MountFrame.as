package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.mount.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.common.types.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.mount.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.types.game.mount.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import flash.utils.*;

    public class MountFrame extends Object implements Frame
    {
        private var _mountDialogFrame:MountDialogFrame;
        private var _mountXpRatio:uint;
        private var _stableList:Array;
        private var _paddockList:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MountFrame));
        public static const MAX_XP_RATIO:uint = 90;

        public function MountFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return 0;
        }// end function

        public function get mountXpRatio() : uint
        {
            return this._mountXpRatio;
        }// end function

        public function get stableList() : Array
        {
            return this._stableList;
        }// end function

        public function get paddockList() : Array
        {
            return this._paddockList;
        }// end function

        public function pushed() : Boolean
        {
            this._mountDialogFrame = new MountDialogFrame();
            return true;
        }// end function

        public function initializeMountLists(param1:Vector.<MountClientData>, param2:Vector.<MountClientData>) : void
        {
            var _loc_3:* = null;
            this._stableList = new Array();
            if (param1)
            {
                for each (_loc_3 in param1)
                {
                    
                    this._stableList.push(MountData.makeMountData(_loc_3, true, this._mountXpRatio));
                }
            }
            this._paddockList = new Array();
            if (param2)
            {
                for each (_loc_3 in param2)
                {
                    
                    this._paddockList.push(MountData.makeMountData(_loc_3, true, this._mountXpRatio));
                }
            }
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
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = NaN;
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
            var _loc_28:* = false;
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
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = null;
            var _loc_43:* = null;
            var _loc_44:* = 0;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = null;
            var _loc_49:* = null;
            switch(true)
            {
                case param1 is MountInformationInPaddockRequestAction:
                {
                    _loc_2 = param1 as MountInformationInPaddockRequestAction;
                    _loc_3 = new MountInformationInPaddockRequestMessage();
                    _loc_3.initMountInformationInPaddockRequestMessage(_loc_2.mountId);
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is MountToggleRidingRequestAction:
                {
                    _loc_4 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IMovable;
                    if (_loc_4 && !_loc_4.isMoving)
                    {
                        _loc_42 = new MountToggleRidingRequestMessage();
                        _loc_42.initMountToggleRidingRequestMessage();
                        ConnectionsHandler.getConnection().send(_loc_42);
                    }
                    return true;
                }
                case param1 is MountFeedRequestAction:
                {
                    _loc_5 = param1 as MountFeedRequestAction;
                    if (Kernel.getWorker().getFrame(FightBattleFrame) == null)
                    {
                        _loc_43 = new MountFeedRequestMessage();
                        _loc_43.initMountFeedRequestMessage(_loc_5.mountId, _loc_5.mountLocation, _loc_5.mountFoodUid, _loc_5.quantity);
                        ConnectionsHandler.getConnection().send(_loc_43);
                    }
                    return true;
                }
                case param1 is MountReleaseRequestAction:
                {
                    _loc_6 = new MountReleaseRequestMessage();
                    _loc_6.initMountReleaseRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_6);
                    return true;
                }
                case param1 is MountSterilizeRequestAction:
                {
                    _loc_7 = new MountSterilizeRequestMessage();
                    _loc_7.initMountSterilizeRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is MountRenameRequestAction:
                {
                    _loc_8 = param1 as MountRenameRequestAction;
                    _loc_9 = new MountRenameRequestMessage();
                    _loc_9.initMountRenameRequestMessage(_loc_8.newName ? (_loc_8.newName) : (""), _loc_8.mountId);
                    ConnectionsHandler.getConnection().send(_loc_9);
                    return true;
                }
                case param1 is MountSetXpRatioRequestAction:
                {
                    _loc_10 = param1 as MountSetXpRatioRequestAction;
                    _loc_11 = new MountSetXpRatioRequestMessage();
                    _loc_11.initMountSetXpRatioRequestMessage(_loc_10.xpRatio > MAX_XP_RATIO ? (MAX_XP_RATIO) : (_loc_10.xpRatio));
                    ConnectionsHandler.getConnection().send(_loc_11);
                    return true;
                }
                case param1 is MountInfoRequestAction:
                {
                    _loc_12 = param1 as MountInfoRequestAction;
                    _loc_13 = new MountInformationRequestMessage();
                    _loc_13.initMountInformationRequestMessage(_loc_12.mountId, _loc_12.time);
                    ConnectionsHandler.getConnection().send(_loc_13);
                    return true;
                }
                case param1 is ExchangeRequestOnMountStockAction:
                {
                    _loc_14 = new ExchangeRequestOnMountStockMessage();
                    _loc_14.initExchangeRequestOnMountStockMessage();
                    ConnectionsHandler.getConnection().send(_loc_14);
                    return true;
                }
                case param1 is MountSterilizedMessage:
                {
                    _loc_17 = MountSterilizedMessage(param1).mountId;
                    _loc_15 = MountData.getMountFromCache(_loc_17);
                    if (_loc_15)
                    {
                        _loc_15.reproductionCount = -1;
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountSterilized, _loc_17);
                    return true;
                }
                case param1 is MountRenamedMessage:
                {
                    _loc_16 = param1 as MountRenamedMessage;
                    _loc_17 = _loc_16.mountId;
                    _loc_18 = _loc_16.name;
                    _loc_15 = MountData.getMountFromCache(_loc_17);
                    if (_loc_15)
                    {
                        _loc_15.name = _loc_18;
                    }
                    if (this._mountDialogFrame.inStable)
                    {
                        KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountRenamed, _loc_17, _loc_18);
                    return true;
                }
                case param1 is ExchangeHandleMountStableAction:
                {
                    _loc_19 = param1 as ExchangeHandleMountStableAction;
                    _loc_20 = new ExchangeHandleMountStableMessage();
                    _loc_20.initExchangeHandleMountStableMessage(_loc_19.actionType, _loc_19.rideId);
                    ConnectionsHandler.getConnection().send(_loc_20);
                    return true;
                }
                case param1 is ExchangeMountStableBornAddMessage:
                {
                    _loc_21 = param1 as ExchangeMountStableBornAddMessage;
                    _loc_22 = MountData.makeMountData(_loc_21.mountDescription, true, this._mountXpRatio);
                    _loc_22.borning = true;
                    if (this._stableList)
                    {
                        this._stableList.push(_loc_22);
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    return true;
                }
                case param1 is ExchangeMountStableAddMessage:
                {
                    _loc_23 = param1 as ExchangeMountStableAddMessage;
                    if (this._stableList)
                    {
                        this._stableList.push(MountData.makeMountData(_loc_23.mountDescription, true, this._mountXpRatio));
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    return true;
                }
                case param1 is ExchangeMountStableRemoveMessage:
                {
                    _loc_24 = param1 as ExchangeMountStableRemoveMessage;
                    _loc_44 = 0;
                    while (_loc_44 < this._stableList.length)
                    {
                        
                        if (this._stableList[_loc_44].id == _loc_24.mountId)
                        {
                            this._stableList.splice(_loc_44, 1);
                            break;
                        }
                        _loc_44++;
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, this._stableList, null, null);
                    return true;
                }
                case param1 is ExchangeMountPaddockAddMessage:
                {
                    _loc_25 = param1 as ExchangeMountPaddockAddMessage;
                    this._paddockList.push(MountData.makeMountData(_loc_25.mountDescription, true, this._mountXpRatio));
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, null, this._paddockList, null);
                    return true;
                }
                case param1 is ExchangeMountPaddockRemoveMessage:
                {
                    _loc_26 = param1 as ExchangeMountPaddockRemoveMessage;
                    _loc_44 = 0;
                    while (_loc_44 < this._paddockList.length)
                    {
                        
                        if (this._paddockList[_loc_44].id == _loc_26.mountId)
                        {
                            this._paddockList.splice(_loc_44, 1);
                            break;
                        }
                        _loc_44++;
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, null, this._paddockList, null);
                    return true;
                }
                case param1 is MountXpRatioMessage:
                {
                    this._mountXpRatio = MountXpRatioMessage(param1).ratio;
                    _loc_15 = PlayedCharacterManager.getInstance().mount;
                    if (_loc_15)
                    {
                        _loc_15.xpRatio = this._mountXpRatio;
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountXpRatio, this._mountXpRatio);
                    return true;
                }
                case param1 is MountDataMessage:
                {
                    _loc_27 = param1 as MountDataMessage;
                    if (this._mountDialogFrame.inStable)
                    {
                        KernelEventsManager.getInstance().processCallback(MountHookList.CertificateMountData, MountData.makeMountData(_loc_27.mountData, false, this.mountXpRatio));
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(MountHookList.PaddockedMountData, MountData.makeMountData(_loc_27.mountData, false, this.mountXpRatio));
                    }
                    return true;
                }
                case param1 is MountRidingMessage:
                {
                    _loc_28 = MountRidingMessage(param1).isRiding;
                    _loc_29 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
                    if (_loc_29)
                    {
                        _loc_29.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    }
                    PlayedCharacterManager.getInstance().isRidding = _loc_28;
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding, _loc_28);
                    return true;
                }
                case param1 is MountEquipedErrorMessage:
                {
                    _loc_30 = MountEquipedErrorMessage(param1);
                    switch(_loc_30.errorType)
                    {
                        case MountEquipedErrorEnum.UNSET:
                        {
                            _loc_31 = "UNSET";
                            break;
                        }
                        case MountEquipedErrorEnum.SET:
                        {
                            _loc_31 = "SET";
                            break;
                        }
                        case MountEquipedErrorEnum.RIDING:
                        {
                            _loc_31 = "RIDING";
                            KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding, false);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountEquipedError, _loc_31);
                    return true;
                }
                case param1 is ExchangeWeightMessage:
                {
                    _loc_32 = param1 as ExchangeWeightMessage;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeWeight, _loc_32.currentWeight, _loc_32.maxWeight);
                    return true;
                }
                case param1 is ExchangeStartOkMountMessage:
                {
                    _loc_33 = param1 as ExchangeStartOkMountMessage;
                    TooltipManager.hideAll();
                    this.initializeMountLists(_loc_33.stabledMountsDescription, _loc_33.paddockedMountsDescription);
                    Kernel.getWorker().addFrame(this._mountDialogFrame);
                    return true;
                }
                case param1 is MountSetMessage:
                {
                    PlayedCharacterManager.getInstance().mount = MountData.makeMountData(MountSetMessage(param1).mountData, false, this.mountXpRatio);
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountSet);
                    return true;
                }
                case param1 is MountUnSetMessage:
                {
                    PlayedCharacterManager.getInstance().mount = null;
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountUnSet);
                    return true;
                }
                case param1 is ExchangeStartOkMountWithOutPaddockMessage:
                {
                    _loc_34 = param1 as ExchangeStartOkMountWithOutPaddockMessage;
                    this.initializeMountLists(_loc_34.stabledMountsDescription, null);
                    Kernel.getWorker().addFrame(this._mountDialogFrame);
                    return true;
                }
                case param1 is UpdateMountBoostMessage:
                {
                    _loc_35 = param1 as UpdateMountBoostMessage;
                    _loc_36 = null;
                    for each (_loc_45 in this._paddockList)
                    {
                        
                        if (_loc_45.id == _loc_35.rideId)
                        {
                            _loc_36 = _loc_45;
                            break;
                        }
                    }
                    if (!_loc_36)
                    {
                        _log.error("Can\'t find " + _loc_35.rideId + " ride ID for update mount boost");
                        return true;
                    }
                    for each (_loc_46 in _loc_35.boostToUpdateList)
                    {
                        
                        if (_loc_46 is UpdateMountIntBoost)
                        {
                            _loc_47 = _loc_46 as UpdateMountIntBoost;
                            switch(_loc_47.type)
                            {
                                case UpdatableMountBoostEnum.ENERGY:
                                {
                                    _loc_36.energy = _loc_47.value;
                                    break;
                                }
                                case UpdatableMountBoostEnum.LOVE:
                                {
                                    _loc_36.love = _loc_47.value;
                                    break;
                                }
                                case UpdatableMountBoostEnum.MATURITY:
                                {
                                    _loc_36.maturity = _loc_47.value;
                                    break;
                                }
                                case UpdatableMountBoostEnum.SERENITY:
                                {
                                    _loc_36.serenity = _loc_47.value;
                                    break;
                                }
                                case UpdatableMountBoostEnum.STAMINA:
                                {
                                    _loc_36.stamina = _loc_47.value;
                                    break;
                                }
                                case UpdatableMountBoostEnum.TIREDNESS:
                                {
                                    _loc_36.boostLimiter = _loc_47.value;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate, null, this._paddockList, null);
                    return true;
                }
                case param1 is MountEmoteIconUsedOkMessage:
                {
                    _loc_37 = param1 as MountEmoteIconUsedOkMessage;
                    _loc_38 = DofusEntities.getEntity(_loc_37.mountId) as TiphonSprite;
                    if (_loc_38)
                    {
                        _loc_48 = null;
                        switch(_loc_37.reactionType)
                        {
                            case 1:
                            {
                                _loc_48 = "AnimEmoteRest_Statique";
                                break;
                            }
                            case 2:
                            {
                                _loc_48 = "AnimAttaque0";
                                break;
                            }
                            case 3:
                            {
                                _loc_48 = "AnimEmoteCaresse";
                                break;
                            }
                            case 4:
                            {
                                _loc_48 = "AnimEmoteReproductionF";
                                break;
                            }
                            case 5:
                            {
                                _loc_48 = "AnimEmoteReproductionM";
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        if (_loc_48)
                        {
                            _loc_49 = new SerialSequencer();
                            _loc_49.addStep(new PlayAnimationStep(_loc_38, _loc_48, false));
                            _loc_49.addStep(new SetAnimationStep(_loc_38, AnimationEnum.ANIM_STATIQUE));
                            _loc_49.start();
                        }
                    }
                    return true;
                }
                case param1 is ExchangeMountTakenFromPaddockMessage:
                {
                    _loc_39 = param1 as ExchangeMountTakenFromPaddockMessage;
                    _loc_40 = I18n.getUiText("ui.mount.takenFromPaddock", [_loc_39.name, "[" + _loc_39.worldX + "," + _loc_39.worldY + "]", _loc_39.ownername]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_40, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is MountReleasedMessage:
                {
                    _loc_41 = param1 as MountReleasedMessage;
                    KernelEventsManager.getInstance().processCallback(MountHookList.MountReleased, _loc_41.mountId);
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
            return true;
        }// end function

    }
}
