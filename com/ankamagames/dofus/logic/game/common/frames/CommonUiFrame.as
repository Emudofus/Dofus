package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.connection.messages.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.atlas.*;
    import com.ankamagames.dofus.network.messages.game.context.display.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
    import com.ankamagames.dofus.network.messages.game.subscriber.*;
    import com.ankamagames.dofus.network.messages.server.basic.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.types.characteristicContextual.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.text.*;
    import flash.utils.*;

    public class CommonUiFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonUiFrame));

        public function CommonUiFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return 0;
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
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = 0;
            var _loc_26:* = null;
            var _loc_27:* = 0;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = null;
            var _loc_31:* = 0;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = undefined;
            var _loc_35:* = null;
            var _loc_36:* = null;
            switch(true)
            {
                case param1 is OpenSmileysAction:
                {
                    _loc_2 = param1 as OpenSmileysAction;
                    KernelEventsManager.getInstance().processCallback(HookList.SmileysStart, _loc_2.type, _loc_2.forceOpen);
                    return true;
                }
                case param1 is OpenBookAction:
                {
                    _loc_3 = param1 as OpenBookAction;
                    KernelEventsManager.getInstance().processCallback(HookList.OpenBook, _loc_3.value, _loc_3.param);
                    return true;
                }
                case param1 is OpenTeamSearchAction:
                {
                    _loc_4 = param1 as OpenTeamSearchAction;
                    KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenTeamSearch);
                    return true;
                }
                case param1 is OpenArenaAction:
                {
                    _loc_5 = param1 as OpenArenaAction;
                    KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenArena);
                    return true;
                }
                case param1 is OpenMapAction:
                {
                    _loc_6 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if (!_loc_6)
                    {
                        return true;
                    }
                    TooltipManager.hideAll();
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMap, (param1 as OpenMapAction).conquest);
                    if ((_loc_6 as IMovable).isMoving)
                    {
                        (_loc_6 as IMovable).stop();
                    }
                    return true;
                }
                case param1 is OpenInventoryAction:
                {
                    _loc_7 = param1 as OpenInventoryAction;
                    KernelEventsManager.getInstance().processCallback(HookList.OpenInventory, _loc_7.behavior);
                    return true;
                }
                case param1 is CloseInventoryAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
                    return true;
                }
                case param1 is OpenMountAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMount);
                    return true;
                }
                case param1 is OpenMainMenuAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
                    return true;
                }
                case param1 is OpenStatsAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.OpenStats, InventoryManager.getInstance().inventory.getView("equipment").content);
                    return true;
                }
                case param1 is DisplayNumericalValueMessage:
                {
                    _loc_8 = param1 as DisplayNumericalValueMessage;
                    _loc_9 = 0;
                    switch(_loc_8.type)
                    {
                        case NumericalValueTypeEnum.NUMERICAL_VALUE_COLLECT:
                        {
                            _loc_9 = 7615756;
                            break;
                        }
                        default:
                        {
                            _log.warn("DisplayNumericalValueMessage with unsupported type : " + _loc_8.type);
                            return false;
                            break;
                        }
                    }
                    CharacteristicContextualManager.getInstance().addStatContextual("" + _loc_8.value, DofusEntities.getEntity(_loc_8.entityId), new TextFormat("Verdana", 24, _loc_9, true), 1);
                    return true;
                }
                case param1 is DelayedSystemMessageDisplayMessage:
                {
                    _loc_10 = param1 as DelayedSystemMessageDisplayMessage;
                    this.systemMessageDisplay(_loc_10);
                    return true;
                }
                case param1 is SystemMessageDisplayMessage:
                {
                    _loc_11 = param1 as SystemMessageDisplayMessage;
                    if (_loc_11.hangUp)
                    {
                        _loc_33 = new DelayedSystemMessageDisplayMessage();
                        _loc_33.initDelayedSystemMessageDisplayMessage(_loc_11.hangUp, _loc_11.msgId, _loc_11.parameters);
                        DisconnectionHandlerFrame.messagesAfterReset.push(_loc_33);
                    }
                    this.systemMessageDisplay(_loc_11);
                    return true;
                }
                case param1 is EntityTalkMessage:
                {
                    _loc_12 = param1 as EntityTalkMessage;
                    _loc_13 = DofusEntities.getEntity(_loc_12.entityId) as IDisplayable;
                    _loc_16 = new Array();
                    _loc_17 = TextInformationTypeEnum.TEXT_ENTITY_TALK;
                    if (_loc_13 == null)
                    {
                        return true;
                    }
                    _loc_18 = new Array();
                    for each (_loc_34 in _loc_12.parameters)
                    {
                        
                        _loc_18.push(_loc_34);
                    }
                    if (InfoMessage.getInfoMessageById(_loc_17 * 10000 + _loc_12.textId))
                    {
                        _loc_15 = InfoMessage.getInfoMessageById(_loc_17 * 10000 + _loc_12.textId).textId;
                        if (_loc_18 != null)
                        {
                            if (_loc_18[0] && _loc_18[0].indexOf("~") != -1)
                            {
                                _loc_16 = _loc_18[0].split("~");
                            }
                            else
                            {
                                _loc_16 = _loc_18;
                            }
                        }
                    }
                    else
                    {
                        _log.error("Texte " + (_loc_17 * 10000 + _loc_12.textId) + " not found.");
                        _loc_14 = "" + _loc_12.textId;
                    }
                    if (!_loc_14)
                    {
                        _loc_14 = I18n.getText(_loc_15, _loc_16);
                    }
                    _loc_19 = new ChatBubble(_loc_14);
                    TooltipManager.show(_loc_19, _loc_13.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "entityMsg" + _loc_12.entityId, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOPRIGHT, 0, true, null, null);
                    return true;
                }
                case param1 is SubscriptionLimitationMessage:
                {
                    _loc_20 = param1 as SubscriptionLimitationMessage;
                    _log.error("SubscriptionLimitationMessage reason " + _loc_20.reason);
                    _loc_21 = "";
                    switch(_loc_20.reason)
                    {
                        case SubscriptionRequiredEnum.LIMIT_ON_JOB_XP:
                        {
                            _loc_21 = I18n.getUiText("ui.payzone.limitJobXp");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_JOB_USE:
                        {
                            _loc_21 = I18n.getUiText("ui.payzone.limitJobXp");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_MAP:
                        {
                            _loc_21 = I18n.getUiText("ui.payzone.limit");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_ITEM:
                        {
                            _loc_21 = I18n.getUiText("ui.payzone.limitItem");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_VENDOR:
                        {
                            _loc_21 = I18n.getUiText("ui.payzone.limitVendor");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMITED_TO_SUBSCRIBER:
                        {
                        }
                        default:
                        {
                            _loc_21 = I18n.getUiText("ui.payzone.limit");
                            break;
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_21, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(HookList.NonSubscriberPopup);
                    return true;
                }
                case param1 is SubscriptionZoneMessage:
                {
                    _loc_22 = param1 as SubscriptionZoneMessage;
                    _log.error("SubscriptionZoneMessage active " + _loc_22.active);
                    KernelEventsManager.getInstance().processCallback(HookList.SubscriptionZone, _loc_22.active);
                    return true;
                }
                case param1 is AtlasPointInformationsMessage:
                {
                    _loc_23 = AtlasPointInformationsMessage(param1);
                    if (_loc_23.type.type == 3)
                    {
                        _loc_35 = new Array();
                        for each (_loc_36 in _loc_23.type.coords)
                        {
                            
                            _loc_35.push(_loc_36.mapId);
                        }
                        FlagManager.getInstance().phoenixs = _loc_35;
                        KernelEventsManager.getInstance().processCallback(HookList.phoenixUpdate);
                    }
                    return true;
                }
                case param1 is GameFightOptionStateUpdateMessage:
                {
                    _loc_24 = param1 as GameFightOptionStateUpdateMessage;
                    switch(_loc_24.option)
                    {
                        case FightOptionsEnum.FIGHT_OPTION_SET_SECRET:
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.OptionWitnessForbidden, _loc_24.state);
                            break;
                        }
                        case FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY:
                        {
                            if (Kernel.getWorker().getFrame(FightContextFrame))
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty, _loc_24.state);
                            }
                            break;
                        }
                        case FightOptionsEnum.FIGHT_OPTION_SET_CLOSED:
                        {
                            if (PlayedCharacterManager.getInstance().teamId == _loc_24.teamId)
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.OptionLockFight, _loc_24.state);
                            }
                            break;
                        }
                        case FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP:
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.OptionHelpWanted, _loc_24.state);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return false;
                }
                case param1 is ToggleWitnessForbiddenAction:
                {
                    _loc_25 = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
                    _loc_26 = new GameFightOptionToggleMessage();
                    _loc_26.initGameFightOptionToggleMessage(_loc_25);
                    ConnectionsHandler.getConnection().send(_loc_26);
                    return true;
                }
                case param1 is ToggleLockPartyAction:
                {
                    _loc_27 = FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY;
                    _loc_28 = new GameFightOptionToggleMessage();
                    _loc_28.initGameFightOptionToggleMessage(_loc_27);
                    ConnectionsHandler.getConnection().send(_loc_28);
                    return true;
                }
                case param1 is ToggleLockFightAction:
                {
                    _loc_29 = FightOptionsEnum.FIGHT_OPTION_SET_CLOSED;
                    _loc_30 = new GameFightOptionToggleMessage();
                    _loc_30.initGameFightOptionToggleMessage(_loc_29);
                    ConnectionsHandler.getConnection().send(_loc_30);
                    return true;
                }
                case param1 is ToggleHelpWantedAction:
                {
                    _loc_31 = FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP;
                    _loc_32 = new GameFightOptionToggleMessage();
                    _loc_32.initGameFightOptionToggleMessage(_loc_31);
                    ConnectionsHandler.getConnection().send(_loc_32);
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
            return true;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        private function systemMessageDisplay(param1:SystemMessageDisplayMessage) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            var _loc_3:* = new Array();
            for each (_loc_4 in param1.parameters)
            {
                
                _loc_3.push(_loc_4);
            }
            _loc_6 = InfoMessage.getInfoMessageById(40000 + param1.msgId);
            if (_loc_6)
            {
                _loc_7 = _loc_6.textId;
                _loc_5 = I18n.getText(_loc_7);
                if (_loc_5)
                {
                    _loc_5 = ParamsDecoder.applyParams(_loc_5, _loc_3);
                }
            }
            else
            {
                _log.error("Information message " + (40000 + param1.msgId) + " cannot be found.");
                _loc_5 = "Information message " + (40000 + param1.msgId) + " cannot be found.";
            }
            _loc_2.openPopup(I18n.getUiText("ui.popup.warning"), _loc_5, [I18n.getUiText("ui.common.ok")]);
            return;
        }// end function

    }
}
