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
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
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
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.events.*;
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
            var osa:OpenSmileysAction;
            var oba:OpenBookAction;
            var tsa:OpenTeamSearchAction;
            var oaa:OpenArenaAction;
            var playerEntity:IEntity;
            var oia:OpenInventoryAction;
            var dnvmsg:DisplayNumericalValueMessage;
            var entity:IEntity;
            var color:uint;
            var animTimer:Timer;
            var displayValue:Function;
            var dsmdmsg:DelayedSystemMessageDisplayMessage;
            var smdmsg:SystemMessageDisplayMessage;
            var etmsg:EntityTalkMessage;
            var speakerEntity:IDisplayable;
            var msgContent2:String;
            var textId2:uint;
            var params:Array;
            var type:uint;
            var param:Array;
            var bubble:ChatBubble;
            var slmsg:SubscriptionLimitationMessage;
            var text:String;
            var szmsg:SubscriptionZoneMessage;
            var apimsg:AtlasPointInformationsMessage;
            var gfosumsg:GameFightOptionStateUpdateMessage;
            var option:uint;
            var gfotmsg:GameFightOptionToggleMessage;
            var option2:uint;
            var gfotmsg2:GameFightOptionToggleMessage;
            var option3:uint;
            var gfotmsg3:GameFightOptionToggleMessage;
            var option4:uint;
            var gfotmsg4:GameFightOptionToggleMessage;
            var interactiveFrame:RoleplayInteractivesFrame;
            var dsmdmsg2:DelayedSystemMessageDisplayMessage;
            var prm:*;
            var pList:Array;
            var coord:MapCoordinatesExtended;
            var msg:* = param1;
            switch(true)
            {
                case msg is OpenSmileysAction:
                {
                    osa = msg as OpenSmileysAction;
                    KernelEventsManager.getInstance().processCallback(HookList.SmileysStart, osa.type, osa.forceOpen);
                    return true;
                }
                case msg is OpenBookAction:
                {
                    oba = msg as OpenBookAction;
                    KernelEventsManager.getInstance().processCallback(HookList.OpenBook, oba.value, oba.param);
                    return true;
                }
                case msg is OpenTeamSearchAction:
                {
                    tsa = msg as OpenTeamSearchAction;
                    KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenTeamSearch);
                    return true;
                }
                case msg is OpenArenaAction:
                {
                    oaa = msg as OpenArenaAction;
                    KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenArena);
                    return true;
                }
                case msg is OpenMapAction:
                {
                    playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if (!playerEntity)
                    {
                        return true;
                    }
                    TooltipManager.hideAll();
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMap, (msg as OpenMapAction).conquest);
                    if ((playerEntity as IMovable).isMoving)
                    {
                        (playerEntity as IMovable).stop();
                    }
                    return true;
                }
                case msg is OpenInventoryAction:
                {
                    oia = msg as OpenInventoryAction;
                    KernelEventsManager.getInstance().processCallback(HookList.OpenInventory, oia.behavior);
                    return true;
                }
                case msg is CloseInventoryAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
                    return true;
                }
                case msg is OpenMountAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMount);
                    return true;
                }
                case msg is OpenMainMenuAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
                    return true;
                }
                case msg is OpenStatsAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.OpenStats, InventoryManager.getInstance().inventory.getView("equipment").content);
                    return true;
                }
                case msg is DisplayNumericalValueMessage:
                {
                    dnvmsg = msg as DisplayNumericalValueMessage;
                    entity = DofusEntities.getEntity(dnvmsg.entityId);
                    color;
                    switch(dnvmsg.type)
                    {
                        case NumericalValueTypeEnum.NUMERICAL_VALUE_COLLECT:
                        {
                            color;
                            interactiveFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
                            if (interactiveFrame && (entity as IAnimated).getAnimation() != AnimationEnum.ANIM_STATIQUE)
                            {
                                animTimer = interactiveFrame.getInteractiveActionTimer(entity);
                            }
                            break;
                        }
                        default:
                        {
                            _log.warn("DisplayNumericalValueMessage with unsupported type : " + dnvmsg.type);
                            return false;
                            break;
                        }
                    }
                    displayValue = function () : void
            {
                if (animTimer)
                {
                    animTimer.removeEventListener(TimerEvent.TIMER, displayValue);
                }
                CharacteristicContextualManager.getInstance().addStatContextual(dnvmsg.value.toString(), entity, new TextFormat("Verdana", 24, color, true), 1);
                if (dnvmsg is DisplayNumericalValueWithAgeBonusMessage)
                {
                    CharacteristicContextualManager.getInstance().addStatContextual((dnvmsg as DisplayNumericalValueWithAgeBonusMessage).valueOfBonus.toString(), entity, new TextFormat("Verdana", 24, 16733440, true), 1);
                }
                return;
            }// end function
            ;
                    if (animTimer && animTimer.running)
                    {
                        animTimer.addEventListener(TimerEvent.TIMER, displayValue);
                    }
                    else
                    {
                        this.displayValue();
                    }
                    return true;
                }
                case msg is DelayedSystemMessageDisplayMessage:
                {
                    dsmdmsg = msg as DelayedSystemMessageDisplayMessage;
                    this.systemMessageDisplay(dsmdmsg);
                    return true;
                }
                case msg is SystemMessageDisplayMessage:
                {
                    smdmsg = msg as SystemMessageDisplayMessage;
                    if (smdmsg.hangUp)
                    {
                        dsmdmsg2 = new DelayedSystemMessageDisplayMessage();
                        dsmdmsg2.initDelayedSystemMessageDisplayMessage(smdmsg.hangUp, smdmsg.msgId, smdmsg.parameters);
                        DisconnectionHandlerFrame.messagesAfterReset.push(dsmdmsg2);
                    }
                    this.systemMessageDisplay(smdmsg);
                    return true;
                }
                case msg is EntityTalkMessage:
                {
                    etmsg = msg as EntityTalkMessage;
                    speakerEntity = DofusEntities.getEntity(etmsg.entityId) as IDisplayable;
                    params = new Array();
                    type = TextInformationTypeEnum.TEXT_ENTITY_TALK;
                    if (speakerEntity == null)
                    {
                        return true;
                    }
                    param = new Array();
                    var _loc_3:* = 0;
                    var _loc_4:* = etmsg.parameters;
                    while (_loc_4 in _loc_3)
                    {
                        
                        prm = _loc_4[_loc_3];
                        param.push(prm);
                    }
                    if (InfoMessage.getInfoMessageById(type * 10000 + etmsg.textId))
                    {
                        textId2 = InfoMessage.getInfoMessageById(type * 10000 + etmsg.textId).textId;
                        if (param != null)
                        {
                            if (param[0] && param[0].indexOf("~") != -1)
                            {
                                params = param[0].split("~");
                            }
                            else
                            {
                                params = param;
                            }
                        }
                    }
                    else
                    {
                        _log.error("Texte " + (type * 10000 + etmsg.textId) + " not found.");
                        msgContent2 = "" + etmsg.textId;
                    }
                    if (!msgContent2)
                    {
                        msgContent2 = I18n.getText(textId2, params);
                    }
                    bubble = new ChatBubble(msgContent2);
                    TooltipManager.show(bubble, speakerEntity.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "entityMsg" + etmsg.entityId, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOPRIGHT, 0, true, null, null);
                    return true;
                }
                case msg is SubscriptionLimitationMessage:
                {
                    slmsg = msg as SubscriptionLimitationMessage;
                    _log.error("SubscriptionLimitationMessage reason " + slmsg.reason);
                    text;
                    switch(slmsg.reason)
                    {
                        case SubscriptionRequiredEnum.LIMIT_ON_JOB_XP:
                        {
                            text = I18n.getUiText("ui.payzone.limitJobXp");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_JOB_USE:
                        {
                            text = I18n.getUiText("ui.payzone.limitJobXp");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_MAP:
                        {
                            text = I18n.getUiText("ui.payzone.limit");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_ITEM:
                        {
                            text = I18n.getUiText("ui.payzone.limitItem");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMIT_ON_VENDOR:
                        {
                            text = I18n.getUiText("ui.payzone.limitVendor");
                            break;
                        }
                        case SubscriptionRequiredEnum.LIMITED_TO_SUBSCRIBER:
                        {
                        }
                        default:
                        {
                            text = I18n.getUiText("ui.payzone.limit");
                            break;
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(HookList.NonSubscriberPopup);
                    return true;
                }
                case msg is SubscriptionZoneMessage:
                {
                    szmsg = msg as SubscriptionZoneMessage;
                    _log.error("SubscriptionZoneMessage active " + szmsg.active);
                    KernelEventsManager.getInstance().processCallback(HookList.SubscriptionZone, szmsg.active);
                    return true;
                }
                case msg is AtlasPointInformationsMessage:
                {
                    apimsg = AtlasPointInformationsMessage(msg);
                    if (apimsg.type.type == 3)
                    {
                        pList = new Array();
                        var _loc_3:* = 0;
                        var _loc_4:* = apimsg.type.coords;
                        while (_loc_4 in _loc_3)
                        {
                            
                            coord = _loc_4[_loc_3];
                            pList.push(coord.mapId);
                        }
                        FlagManager.getInstance().phoenixs = pList;
                        KernelEventsManager.getInstance().processCallback(HookList.phoenixUpdate);
                    }
                    return true;
                }
                case msg is GameFightOptionStateUpdateMessage:
                {
                    gfosumsg = msg as GameFightOptionStateUpdateMessage;
                    switch(gfosumsg.option)
                    {
                        case FightOptionsEnum.FIGHT_OPTION_SET_SECRET:
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.OptionWitnessForbidden, gfosumsg.state);
                            break;
                        }
                        case FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY:
                        {
                            if (Kernel.getWorker().getFrame(FightContextFrame))
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty, gfosumsg.state);
                            }
                            break;
                        }
                        case FightOptionsEnum.FIGHT_OPTION_SET_CLOSED:
                        {
                            if (PlayedCharacterManager.getInstance().teamId == gfosumsg.teamId)
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.OptionLockFight, gfosumsg.state);
                            }
                            break;
                        }
                        case FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP:
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.OptionHelpWanted, gfosumsg.state);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return false;
                }
                case msg is ToggleWitnessForbiddenAction:
                {
                    option = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
                    gfotmsg = new GameFightOptionToggleMessage();
                    gfotmsg.initGameFightOptionToggleMessage(option);
                    ConnectionsHandler.getConnection().send(gfotmsg);
                    return true;
                }
                case msg is ToggleLockPartyAction:
                {
                    option2 = FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY;
                    gfotmsg2 = new GameFightOptionToggleMessage();
                    gfotmsg2.initGameFightOptionToggleMessage(option2);
                    ConnectionsHandler.getConnection().send(gfotmsg2);
                    return true;
                }
                case msg is ToggleLockFightAction:
                {
                    option3 = FightOptionsEnum.FIGHT_OPTION_SET_CLOSED;
                    gfotmsg3 = new GameFightOptionToggleMessage();
                    gfotmsg3.initGameFightOptionToggleMessage(option3);
                    ConnectionsHandler.getConnection().send(gfotmsg3);
                    return true;
                }
                case msg is ToggleHelpWantedAction:
                {
                    option4 = FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP;
                    gfotmsg4 = new GameFightOptionToggleMessage();
                    gfotmsg4.initGameFightOptionToggleMessage(option4);
                    ConnectionsHandler.getConnection().send(gfotmsg4);
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
