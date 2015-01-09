package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.logic.game.common.actions.OpenSmileysAction;
    import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
    import com.ankamagames.dofus.logic.game.common.actions.OpenTeamSearchAction;
    import com.ankamagames.dofus.logic.game.common.actions.OpenArenaAction;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
    import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
    import com.ankamagames.dofus.network.messages.game.script.CinematicMessage;
    import com.ankamagames.dofus.network.messages.game.context.display.DisplayNumericalValueMessage;
    import flash.utils.Timer;
    import com.ankamagames.dofus.logic.connection.messages.DelayedSystemMessageDisplayMessage;
    import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
    import com.ankamagames.dofus.network.messages.game.ui.ClientUIOpenedByObjectMessage;
    import com.ankamagames.dofus.network.messages.game.ui.ClientUIOpenedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.EntityTalkMessage;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
    import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionLimitationMessage;
    import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionZoneMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionStateUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionToggleMessage;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.misc.lists.TriggerHookList;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
    import com.ankamagames.dofus.logic.game.common.actions.OpenMountAction;
    import com.ankamagames.dofus.logic.game.common.actions.OpenMainMenuAction;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.logic.game.common.actions.OpenStatsAction;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.entities.interfaces.IAnimated;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.dofus.network.enums.NumericalValueTypeEnum;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
    import com.ankamagames.dofus.misc.lists.CustomUiHookList;
    import com.ankamagames.dofus.network.enums.TextInformationTypeEnum;
    import com.ankamagames.dofus.datacenter.communication.InfoMessage;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.network.enums.SubscriptionRequiredEnum;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.network.enums.FightOptionsEnum;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.fight.actions.ToggleWitnessForbiddenAction;
    import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockPartyAction;
    import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockFightAction;
    import com.ankamagames.dofus.logic.game.fight.actions.ToggleHelpWantedAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.network.messages.game.context.display.DisplayNumericalValueWithAgeBonusMessage;
    import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
    import flash.text.TextFormat;
    import com.ankamagames.dofus.misc.utils.ParamsDecoder;

    public class CommonUiFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonUiFrame));

        private var _dnvmsgs:Dictionary;


        public function get priority():int
        {
            return (0);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:OpenSmileysAction;
            var _local_3:OpenBookAction;
            var _local_4:OpenTeamSearchAction;
            var _local_5:OpenArenaAction;
            var _local_6:IEntity;
            var _local_7:OpenMapAction;
            var _local_8:Boolean;
            var _local_9:OpenInventoryAction;
            var _local_10:CinematicMessage;
            var _local_11:DisplayNumericalValueMessage;
            var _local_12:IEntity;
            var _local_13:uint;
            var _local_14:Timer;
            var _local_15:DelayedSystemMessageDisplayMessage;
            var _local_16:SystemMessageDisplayMessage;
            var _local_17:ClientUIOpenedByObjectMessage;
            var _local_18:ClientUIOpenedMessage;
            var _local_19:EntityTalkMessage;
            var _local_20:IDisplayable;
            var _local_21:String;
            var _local_22:uint;
            var _local_23:Array;
            var _local_24:uint;
            var _local_25:Array;
            var _local_26:ChatBubble;
            var _local_27:SubscriptionLimitationMessage;
            var _local_28:String;
            var _local_29:SubscriptionZoneMessage;
            var _local_30:GameFightOptionStateUpdateMessage;
            var _local_31:uint;
            var _local_32:GameFightOptionToggleMessage;
            var _local_33:uint;
            var _local_34:GameFightOptionToggleMessage;
            var _local_35:uint;
            var _local_36:GameFightOptionToggleMessage;
            var _local_37:uint;
            var _local_38:GameFightOptionToggleMessage;
            var _local_39:RoleplayInteractivesFrame;
            var dsmdmsg2:DelayedSystemMessageDisplayMessage;
            var prm:*;
            switch (true)
            {
                case (msg is OpenSmileysAction):
                    _local_2 = (msg as OpenSmileysAction);
                    KernelEventsManager.getInstance().processCallback(HookList.SmileysStart, _local_2.type, _local_2.forceOpen);
                    return (true);
                case (msg is OpenBookAction):
                    _local_3 = (msg as OpenBookAction);
                    KernelEventsManager.getInstance().processCallback(HookList.OpenBook, _local_3.value, _local_3.param);
                    return (true);
                case (msg is OpenTeamSearchAction):
                    _local_4 = (msg as OpenTeamSearchAction);
                    KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenTeamSearch);
                    return (true);
                case (msg is OpenArenaAction):
                    _local_5 = (msg as OpenArenaAction);
                    KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenArena);
                    return (true);
                case (msg is OpenMapAction):
                    _local_6 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if (!(_local_6))
                    {
                        return (true);
                    };
                    TooltipManager.hideAll();
                    _local_7 = (msg as OpenMapAction);
                    _local_8 = OptionManager.getOptionManager("dofus")["lastMapUiWasPocket"];
                    if (!(_local_7.ignoreSetting))
                    {
                        _local_7.pocket = _local_8;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMap, _local_7.ignoreSetting, _local_7.pocket, _local_7.conquest);
                    return (true);
                case (msg is OpenInventoryAction):
                    _local_9 = (msg as OpenInventoryAction);
                    KernelEventsManager.getInstance().processCallback(HookList.OpenInventory, _local_9.behavior);
                    return (true);
                case (msg is CloseInventoryAction):
                    KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
                    return (true);
                case (msg is OpenMountAction):
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMount);
                    return (true);
                case (msg is OpenMainMenuAction):
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
                    return (true);
                case (msg is OpenStatsAction):
                    KernelEventsManager.getInstance().processCallback(HookList.OpenStats, InventoryManager.getInstance().inventory.getView("equipment").content);
                    return (true);
                case (msg is CinematicMessage):
                    _local_10 = (msg as CinematicMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.Cinematic, _local_10.cinematicId);
                    return (true);
                case (msg is DisplayNumericalValueMessage):
                    _local_11 = (msg as DisplayNumericalValueMessage);
                    _local_12 = DofusEntities.getEntity(_local_11.entityId);
                    _local_13 = 0;
                    switch (_local_11.type)
                    {
                        case NumericalValueTypeEnum.NUMERICAL_VALUE_COLLECT:
                            _local_13 = 7615756;
                            _local_39 = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
                            if (((((_local_39) && (_local_12))) && (!(((_local_12 as IAnimated).getAnimation() == AnimationEnum.ANIM_STATIQUE)))))
                            {
                                _local_14 = _local_39.getInteractiveActionTimer(_local_12);
                            };
                            break;
                        default:
                            _log.warn(("DisplayNumericalValueMessage with unsupported type : " + _local_11.type));
                            return (false);
                    };
                    if (((_local_14) && (_local_14.running)))
                    {
                        this._dnvmsgs[_local_14] = _local_11;
                        _local_14.addEventListener(TimerEvent.TIMER, this.onAnimEnd);
                    }
                    else
                    {
                        this.displayNumericalValue(_local_12, _local_11, _local_13);
                    };
                    return (true);
                case (msg is DelayedSystemMessageDisplayMessage):
                    _local_15 = (msg as DelayedSystemMessageDisplayMessage);
                    this.systemMessageDisplay(_local_15);
                    return (true);
                case (msg is SystemMessageDisplayMessage):
                    _local_16 = (msg as SystemMessageDisplayMessage);
                    if (_local_16.hangUp)
                    {
                        dsmdmsg2 = new DelayedSystemMessageDisplayMessage();
                        dsmdmsg2.initDelayedSystemMessageDisplayMessage(_local_16.hangUp, _local_16.msgId, _local_16.parameters);
                        DisconnectionHandlerFrame.messagesAfterReset.push(dsmdmsg2);
                    };
                    this.systemMessageDisplay(_local_16);
                    return (true);
                case (msg is ClientUIOpenedByObjectMessage):
                    _local_17 = (msg as ClientUIOpenedByObjectMessage);
                    KernelEventsManager.getInstance().processCallback(CustomUiHookList.ClientUIOpened, _local_17.type, _local_17.uid);
                    return (true);
                case (msg is ClientUIOpenedMessage):
                    _local_18 = (msg as ClientUIOpenedMessage);
                    KernelEventsManager.getInstance().processCallback(CustomUiHookList.ClientUIOpened, _local_18.type, 0);
                    return (true);
                case (msg is EntityTalkMessage):
                    _local_19 = (msg as EntityTalkMessage);
                    _local_20 = (DofusEntities.getEntity(_local_19.entityId) as IDisplayable);
                    _local_23 = new Array();
                    _local_24 = TextInformationTypeEnum.TEXT_ENTITY_TALK;
                    if (_local_20 == null)
                    {
                        return (true);
                    };
                    _local_25 = new Array();
                    for each (prm in _local_19.parameters)
                    {
                        _local_25.push(prm);
                    };
                    if (InfoMessage.getInfoMessageById(((_local_24 * 10000) + _local_19.textId)))
                    {
                        _local_22 = InfoMessage.getInfoMessageById(((_local_24 * 10000) + _local_19.textId)).textId;
                        if (_local_25 != null)
                        {
                            if (((_local_25[0]) && (!((_local_25[0].indexOf("~") == -1)))))
                            {
                                _local_23 = _local_25[0].split("~");
                            }
                            else
                            {
                                _local_23 = _local_25;
                            };
                        };
                    }
                    else
                    {
                        _log.error((("Texte " + ((_local_24 * 10000) + _local_19.textId)) + " not found."));
                        _local_21 = ("" + _local_19.textId);
                    };
                    if (!(_local_21))
                    {
                        _local_21 = I18n.getText(_local_22, _local_23);
                    };
                    _local_26 = new ChatBubble(_local_21);
                    TooltipManager.show(_local_26, _local_20.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, ("entityMsg" + _local_19.entityId), LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOPRIGHT, 0, true, null, null);
                    return (true);
                case (msg is SubscriptionLimitationMessage):
                    _local_27 = (msg as SubscriptionLimitationMessage);
                    _log.error(("SubscriptionLimitationMessage reason " + _local_27.reason));
                    _local_28 = "";
                    switch (_local_27.reason)
                    {
                        case SubscriptionRequiredEnum.LIMIT_ON_JOB_XP:
                            _local_28 = I18n.getUiText("ui.payzone.limitJobXp");
                            break;
                        case SubscriptionRequiredEnum.LIMIT_ON_JOB_USE:
                            _local_28 = I18n.getUiText("ui.payzone.limitJobXp");
                            break;
                        case SubscriptionRequiredEnum.LIMIT_ON_MAP:
                            _local_28 = I18n.getUiText("ui.payzone.limit");
                            break;
                        case SubscriptionRequiredEnum.LIMIT_ON_ITEM:
                            _local_28 = I18n.getUiText("ui.payzone.limitItem");
                            break;
                        case SubscriptionRequiredEnum.LIMIT_ON_VENDOR:
                            _local_28 = I18n.getUiText("ui.payzone.limitVendor");
                            break;
                        case SubscriptionRequiredEnum.LIMITED_TO_SUBSCRIBER:
                        default:
                            _local_28 = I18n.getUiText("ui.payzone.limit");
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_28, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(HookList.NonSubscriberPopup);
                    return (true);
                case (msg is SubscriptionZoneMessage):
                    _local_29 = (msg as SubscriptionZoneMessage);
                    _log.error(("SubscriptionZoneMessage active " + _local_29.active));
                    KernelEventsManager.getInstance().processCallback(HookList.SubscriptionZone, _local_29.active);
                    return (true);
                case (msg is GameFightOptionStateUpdateMessage):
                    _local_30 = (msg as GameFightOptionStateUpdateMessage);
                    switch (_local_30.option)
                    {
                        case FightOptionsEnum.FIGHT_OPTION_SET_SECRET:
                            KernelEventsManager.getInstance().processCallback(HookList.OptionWitnessForbidden, _local_30.state);
                            break;
                        case FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY:
                            if (Kernel.getWorker().getFrame(FightContextFrame))
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty, _local_30.state);
                            };
                            break;
                        case FightOptionsEnum.FIGHT_OPTION_SET_CLOSED:
                            if (PlayedCharacterManager.getInstance().teamId == _local_30.teamId)
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.OptionLockFight, _local_30.state);
                            };
                            break;
                        case FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP:
                            KernelEventsManager.getInstance().processCallback(HookList.OptionHelpWanted, _local_30.state);
                            break;
                    };
                    if (Kernel.getWorker().getFrame(RoleplayEntitiesFrame))
                    {
                        return (false);
                    };
                    return (true);
                case (msg is ToggleWitnessForbiddenAction):
                    _local_31 = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
                    _local_32 = new GameFightOptionToggleMessage();
                    _local_32.initGameFightOptionToggleMessage(_local_31);
                    ConnectionsHandler.getConnection().send(_local_32);
                    return (true);
                case (msg is ToggleLockPartyAction):
                    _local_33 = FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY;
                    _local_34 = new GameFightOptionToggleMessage();
                    _local_34.initGameFightOptionToggleMessage(_local_33);
                    ConnectionsHandler.getConnection().send(_local_34);
                    return (true);
                case (msg is ToggleLockFightAction):
                    _local_35 = FightOptionsEnum.FIGHT_OPTION_SET_CLOSED;
                    _local_36 = new GameFightOptionToggleMessage();
                    _local_36.initGameFightOptionToggleMessage(_local_35);
                    ConnectionsHandler.getConnection().send(_local_36);
                    return (true);
                case (msg is ToggleHelpWantedAction):
                    _local_37 = FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP;
                    _local_38 = new GameFightOptionToggleMessage();
                    _local_38.initGameFightOptionToggleMessage(_local_37);
                    ConnectionsHandler.getConnection().send(_local_38);
                    return (true);
            };
            return (false);
        }

        public function pushed():Boolean
        {
            this._dnvmsgs = new Dictionary(true);
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        private function onAnimEnd(pTimerEvent:TimerEvent):void
        {
            pTimerEvent.currentTarget.removeEventListener(TimerEvent.TIMER, this.onAnimEnd);
            var dnvmsg:DisplayNumericalValueMessage = this._dnvmsgs[pTimerEvent.currentTarget];
            this.displayNumericalValue(DofusEntities.getEntity(dnvmsg.entityId), dnvmsg, 7615756, 1, 1500);
            delete this._dnvmsgs[pTimerEvent.currentTarget];
        }

        private function displayNumericalValue(pEntity:IEntity, pMsg:DisplayNumericalValueMessage, pColor:uint, pScrollSpeed:Number=1, pScrollDuration:uint=2500):void
        {
            this.displayValue(pEntity, pMsg.value.toString(), pColor, pScrollSpeed, pScrollDuration);
            var dnvwabmsg:DisplayNumericalValueWithAgeBonusMessage = (pMsg as DisplayNumericalValueWithAgeBonusMessage);
            if (dnvwabmsg)
            {
                this.displayValue(pEntity, dnvwabmsg.valueOfBonus.toString(), 0xFF5500, pScrollSpeed, pScrollDuration);
            };
        }

        private function displayValue(pEntity:IEntity, pValue:String, pColor:uint, pScrollSpeed:Number, pScrollDuration:uint):void
        {
            if (!(pEntity))
            {
                return;
            };
            CharacteristicContextualManager.getInstance().addStatContextual(pValue, pEntity, new TextFormat("Verdana", 24, pColor, true), 1, pScrollSpeed, pScrollDuration);
        }

        private function systemMessageDisplay(msg:SystemMessageDisplayMessage):void
        {
            var i:*;
            var msgContent:String;
            var message:InfoMessage;
            var textId:uint;
            var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            var a:Array = new Array();
            for each (i in msg.parameters)
            {
                a.push(i);
            };
            message = InfoMessage.getInfoMessageById((40000 + msg.msgId));
            if (message)
            {
                textId = message.textId;
                msgContent = I18n.getText(textId);
                if (msgContent)
                {
                    msgContent = ParamsDecoder.applyParams(msgContent, a);
                };
            }
            else
            {
                _log.error((("Information message " + (40000 + msg.msgId)) + " cannot be found."));
                msgContent = (("Information message " + (40000 + msg.msgId)) + " cannot be found.");
            };
            commonMod.openPopup(I18n.getUiText("ui.popup.warning"), msgContent, [I18n.getUiText("ui.common.ok")], null, null, null, null, false, true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

