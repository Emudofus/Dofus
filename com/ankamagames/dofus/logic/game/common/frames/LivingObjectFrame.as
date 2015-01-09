package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectDissociateAction;
    import com.ankamagames.dofus.network.messages.game.inventory.items.LivingObjectDissociateMessage;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectFeedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectChangeSkinRequestAction;
    import com.ankamagames.dofus.network.messages.game.inventory.items.LivingObjectChangeSkinRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectModifiedMessage;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectFeedAndAssociateRequestAction;
    import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectFeedAndAssociateRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectPreviewMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectErrorMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectAssociatedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectEraseRequestAction;
    import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectEraseRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.WrapperObjectErrorMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.WrapperObjectAssociatedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.WrapperObjectDissociateRequestAction;
    import com.ankamagames.dofus.network.messages.game.inventory.items.WrapperObjectDissociateRequestMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.LivingObjectHookList;
    import com.ankamagames.dofus.network.enums.ObjectErrorEnum;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.jerakine.messages.Message;

    public class LivingObjectFrame implements Frame 
    {

        private static const ACTION_TOSKIN:uint = 1;
        private static const ACTION_TOFEED:uint = 2;
        private static const ACTION_TODISSOCIATE:uint = 3;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LivingObjectFrame));

        private var livingObjectUID:uint = 0;
        private var action:uint = 0;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:LivingObjectDissociateAction;
            var _local_3:LivingObjectDissociateMessage;
            var _local_4:LivingObjectFeedAction;
            var _local_5:ObjectFeedMessage;
            var _local_6:LivingObjectChangeSkinRequestAction;
            var _local_7:LivingObjectChangeSkinRequestMessage;
            var _local_8:ObjectModifiedMessage;
            var _local_9:ItemWrapper;
            var _local_10:MimicryObjectFeedAndAssociateRequestAction;
            var _local_11:MimicryObjectFeedAndAssociateRequestMessage;
            var _local_12:MimicryObjectPreviewMessage;
            var _local_13:ItemWrapper;
            var _local_14:MimicryObjectErrorMessage;
            var _local_15:MimicryObjectAssociatedMessage;
            var _local_16:ItemWrapper;
            var _local_17:MimicryObjectEraseRequestAction;
            var _local_18:MimicryObjectEraseRequestMessage;
            var _local_19:WrapperObjectErrorMessage;
            var _local_20:WrapperObjectAssociatedMessage;
            var _local_21:ItemWrapper;
            var _local_22:WrapperObjectDissociateRequestAction;
            var _local_23:WrapperObjectDissociateRequestMessage;
            var mimicryErrorText:String;
            var wrapperErrorText:String;
            switch (true)
            {
                case (msg is LivingObjectDissociateAction):
                    _local_2 = (msg as LivingObjectDissociateAction);
                    _local_3 = new LivingObjectDissociateMessage();
                    _local_3.initLivingObjectDissociateMessage(_local_2.livingUID, _local_2.livingPosition);
                    this.livingObjectUID = _local_2.livingUID;
                    this.action = ACTION_TODISSOCIATE;
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is LivingObjectFeedAction):
                    _local_4 = (msg as LivingObjectFeedAction);
                    _local_5 = new ObjectFeedMessage();
                    _local_5.initObjectFeedMessage(_local_4.objectUID, _local_4.foodUID, _local_4.foodQuantity);
                    this.livingObjectUID = _local_4.objectUID;
                    this.action = ACTION_TOFEED;
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is LivingObjectChangeSkinRequestAction):
                    _local_6 = (msg as LivingObjectChangeSkinRequestAction);
                    _local_7 = new LivingObjectChangeSkinRequestMessage();
                    _local_7.initLivingObjectChangeSkinRequestMessage(_local_6.livingUID, _local_6.livingPosition, _local_6.skinId);
                    this.livingObjectUID = _local_6.livingUID;
                    this.action = ACTION_TOSKIN;
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is ObjectModifiedMessage):
                    _local_8 = (msg as ObjectModifiedMessage);
                    _local_9 = ItemWrapper.create(_local_8.object.position, _local_8.object.objectUID, _local_8.object.objectGID, _local_8.object.quantity, _local_8.object.effects, false);
                    if (!(_local_9))
                    {
                        return (false);
                    };
                    if (_local_9.isObjectWrapped)
                    {
                        _local_9.update(_local_8.object.position, _local_8.object.objectUID, _local_8.object.objectGID, _local_8.object.quantity, _local_8.object.effects);
                    };
                    if (this.livingObjectUID == _local_8.object.objectUID)
                    {
                        _local_9.update(_local_8.object.position, _local_8.object.objectUID, _local_8.object.objectGID, _local_8.object.quantity, _local_8.object.effects);
                        switch (this.action)
                        {
                            case ACTION_TOFEED:
                                KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectFeed, _local_9);
                                break;
                            case ACTION_TODISSOCIATE:
                                KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectDissociate, _local_9);
                                break;
                            case ACTION_TOSKIN:
                            default:
                                KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectUpdate, _local_9);
                        };
                    }
                    else
                    {
                        if (_local_9.livingObjectId != 0)
                        {
                            KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectAssociate, _local_9);
                        };
                    };
                    this.livingObjectUID = 0;
                    return (false);
                case (msg is MimicryObjectFeedAndAssociateRequestAction):
                    _local_10 = (msg as MimicryObjectFeedAndAssociateRequestAction);
                    _local_11 = new MimicryObjectFeedAndAssociateRequestMessage();
                    _local_11.initMimicryObjectFeedAndAssociateRequestMessage(_local_10.mimicryUID, _local_10.symbiotePos, _local_10.hostUID, _local_10.hostPos, _local_10.foodUID, _local_10.foodPos, _local_10.preview);
                    ConnectionsHandler.getConnection().send(_local_11);
                    return (true);
                case (msg is MimicryObjectPreviewMessage):
                    _local_12 = (msg as MimicryObjectPreviewMessage);
                    _local_13 = ItemWrapper.create(_local_12.result.position, _local_12.result.objectUID, _local_12.result.objectGID, _local_12.result.quantity, _local_12.result.effects, false);
                    if (!(_local_13))
                    {
                        return (false);
                    };
                    KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectPreview, _local_13, "");
                    return (true);
                case (msg is MimicryObjectErrorMessage):
                    _local_14 = (msg as MimicryObjectErrorMessage);
                    if (_local_14.reason == ObjectErrorEnum.SYMBIOTIC_OBJECT_ERROR)
                    {
                        switch (_local_14.errorCode)
                        {
                            case -1:
                                mimicryErrorText = I18n.getUiText("ui.error.state");
                                break;
                            case -2:
                                mimicryErrorText = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                                break;
                            case -7:
                                mimicryErrorText = I18n.getUiText("ui.mimicry.error.foodType");
                                break;
                            case -8:
                                mimicryErrorText = I18n.getUiText("ui.mimicry.error.foodLevel");
                                break;
                            case -9:
                                mimicryErrorText = I18n.getUiText("ui.mimicry.error.noValidMimicry");
                                break;
                            case -10:
                                mimicryErrorText = I18n.getUiText("ui.mimicry.error.noValidHost");
                                break;
                            case -11:
                                mimicryErrorText = I18n.getUiText("ui.mimicry.error.noValidFood");
                                break;
                            case -16:
                                mimicryErrorText = I18n.getUiText("ui.mimicry.error.noMimicryAssociated");
                                break;
                            case -17:
                                mimicryErrorText = I18n.getUiText("ui.mimicry.error.sameSkin");
                                break;
                            case -3:
                            case -4:
                            case -5:
                            case -6:
                            case -12:
                            case -13:
                            case -14:
                            case -15:
                                mimicryErrorText = I18n.getUiText("ui.popup.impossible_action");
                                break;
                            default:
                                mimicryErrorText = I18n.getUiText("ui.common.unknownFail");
                        };
                        if (_local_14.preview)
                        {
                            KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectPreview, null, mimicryErrorText);
                        }
                        else
                        {
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, mimicryErrorText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        };
                    };
                    return (true);
                case (msg is MimicryObjectAssociatedMessage):
                    _local_15 = (msg as MimicryObjectAssociatedMessage);
                    _local_16 = InventoryManager.getInstance().inventory.getItem(_local_15.hostUID);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mimicry.success", [_local_16.name]), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectAssociated, _local_16);
                    return (true);
                case (msg is MimicryObjectEraseRequestAction):
                    _local_17 = (msg as MimicryObjectEraseRequestAction);
                    _local_18 = new MimicryObjectEraseRequestMessage();
                    _local_18.initMimicryObjectEraseRequestMessage(_local_17.hostUID, _local_17.hostPos);
                    ConnectionsHandler.getConnection().send(_local_18);
                    return (true);
                case (msg is WrapperObjectErrorMessage):
                    _local_19 = (msg as WrapperObjectErrorMessage);
                    if (_local_19.reason == ObjectErrorEnum.SYMBIOTIC_OBJECT_ERROR)
                    {
                        switch (_local_19.errorCode)
                        {
                            case -1:
                                wrapperErrorText = I18n.getUiText("ui.error.state");
                                break;
                            case -2:
                                wrapperErrorText = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                                break;
                            case -7:
                                wrapperErrorText = I18n.getUiText("ui.mimicry.error.foodType");
                                break;
                            case -8:
                                wrapperErrorText = I18n.getUiText("ui.mimicry.error.invalidWrapperObject");
                                break;
                            case -10:
                                wrapperErrorText = I18n.getUiText("ui.mimicry.error.noValidHost");
                                break;
                            case -16:
                                wrapperErrorText = I18n.getUiText("ui.mimicry.error.noWrapperAssociated");
                                break;
                            case -18:
                                wrapperErrorText = I18n.getUiText("ui.mimicry.error.noAssociationWithLivingObject");
                                break;
                            case -19:
                                wrapperErrorText = I18n.getUiText("ui.mimicry.error.alreadyWrapped");
                                break;
                            case -3:
                            case -4:
                            case -6:
                            case -12:
                            case -14:
                            case -15:
                                wrapperErrorText = I18n.getUiText("ui.popup.impossible_action");
                                break;
                            default:
                                wrapperErrorText = I18n.getUiText("ui.common.unknownFail");
                        };
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, wrapperErrorText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is WrapperObjectAssociatedMessage):
                    _local_20 = (msg as WrapperObjectAssociatedMessage);
                    _local_21 = InventoryManager.getInstance().inventory.getItem(_local_20.hostUID);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mimicry.success", [_local_21.name]), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is WrapperObjectDissociateRequestAction):
                    _local_22 = (msg as WrapperObjectDissociateRequestAction);
                    _local_23 = new WrapperObjectDissociateRequestMessage();
                    _local_23.initWrapperObjectDissociateRequestMessage(_local_22.hostUID, _local_22.hostPosition);
                    ConnectionsHandler.getConnection().send(_local_23);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

