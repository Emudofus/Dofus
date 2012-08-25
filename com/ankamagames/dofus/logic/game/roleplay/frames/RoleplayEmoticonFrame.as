package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.character.stats.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class RoleplayEmoticonFrame extends Object implements Frame
    {
        private var _emotes:Array;
        private var _emotesList:Array;
        private var _interval:Number;
        private var _bEmoteOn:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayEmoticonFrame));

        public function RoleplayEmoticonFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get emotes() : Array
        {
            this._emotes.sort(Array.NUMERIC);
            return this._emotes;
        }// end function

        public function get emotesList() : Array
        {
            this._emotesList.sortOn("order", Array.NUMERIC);
            return this._emotesList;
        }// end function

        private function get socialFrame() : SocialFrame
        {
            return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
        }// end function

        private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
        }// end function

        private function get roleplayMovementFrame() : RoleplayMovementFrame
        {
            return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
        }// end function

        public function pushed() : Boolean
        {
            this._emotes = new Array();
            this._emotesList = new Array();
            return true;
        }// end function

        public function isKnownEmote(param1:int) : Boolean
        {
            return this._emotes.indexOf(param1) != -1;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:ShortcutWrapper = null;
            var _loc_3:EmoteListMessage = null;
            var _loc_4:uint = 0;
            var _loc_5:EmoteAddMessage = null;
            var _loc_6:EmoteWrapper = null;
            var _loc_7:Emoticon = null;
            var _loc_8:uint = 0;
            var _loc_9:String = null;
            var _loc_10:EmoteRemoveMessage = null;
            var _loc_11:String = null;
            var _loc_12:EmotePlayRequestAction = null;
            var _loc_13:Emoticon = null;
            var _loc_14:EmotePlayRequestMessage = null;
            var _loc_15:IEntity = null;
            var _loc_16:EmotePlayMessage = null;
            var _loc_17:GameContextActorInformations = null;
            var _loc_18:EmotePlayMassiveMessage = null;
            var _loc_19:EmotePlayErrorMessage = null;
            var _loc_20:String = null;
            var _loc_21:LifePointsRegenBeginMessage = null;
            var _loc_22:LifePointsRegenEndMessage = null;
            var _loc_23:* = undefined;
            var _loc_24:EmoteWrapper = null;
            var _loc_25:* = undefined;
            var _loc_26:int = 0;
            var _loc_27:int = 0;
            var _loc_28:Emoticon = null;
            var _loc_29:TiphonEntityLook = null;
            var _loc_30:String = null;
            var _loc_31:Boolean = false;
            var _loc_32:Boolean = false;
            var _loc_33:* = undefined;
            var _loc_34:GameContextActorInformations = null;
            var _loc_35:TiphonEntityLook = null;
            var _loc_36:String = null;
            var _loc_37:Boolean = false;
            var _loc_38:Boolean = false;
            var _loc_39:String = null;
            switch(true)
            {
                case param1 is EmoteListMessage:
                {
                    _loc_3 = param1 as EmoteListMessage;
                    this._emotes = new Array();
                    _loc_4 = 0;
                    for each (_loc_23 in _loc_3.emoteIds)
                    {
                        
                        this._emotes.push(_loc_23);
                        _loc_24 = EmoteWrapper.create(_loc_23, _loc_4);
                        this._emotesList.push(_loc_24);
                        _loc_4 = _loc_4 + 1;
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (_loc_2 in InventoryManager.getInstance().shortcutBarItems)
                    {
                        
                        if (_loc_2 && _loc_2.type == 4)
                        {
                            if (this._emotes.indexOf(_loc_2.id) != -1)
                            {
                                _loc_2.active = true;
                                continue;
                            }
                            _loc_2.active = false;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                    return true;
                }
                case param1 is EmoteAddMessage:
                {
                    _loc_5 = param1 as EmoteAddMessage;
                    for (_loc_25 in this._emotes)
                    {
                        
                        if (this._emotes[_loc_25] == _loc_5.emoteId)
                        {
                            return true;
                        }
                    }
                    this._emotes.push(_loc_5.emoteId);
                    _loc_6 = EmoteWrapper.create(_loc_5.emoteId, this._emotes.length);
                    this._emotesList.push(_loc_6);
                    _loc_7 = Emoticon.getEmoticonById(_loc_5.emoteId);
                    _loc_8 = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.emotes"), I18n.getUiText("ui.common.emoteAdded", [_loc_7.name]), NotificationTypeEnum.TUTORIAL, "new_emote_" + _loc_5.emoteId);
                    NotificationManager.getInstance().addButtonToNotification(_loc_8, I18n.getUiText("ui.common.details"), "OpenSmileys", [1, true], true, 130);
                    NotificationManager.getInstance().sendNotification(_loc_8);
                    _loc_9 = I18n.getUiText("ui.common.emoteAdded", [Emoticon.getEmoticonById(_loc_5.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_9, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (_loc_2 in InventoryManager.getInstance().shortcutBarItems)
                    {
                        
                        if (_loc_2 && _loc_2.type == 4 && _loc_2.id == _loc_5.emoteId)
                        {
                            _loc_2.active = true;
                            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                        }
                    }
                    return true;
                }
                case param1 is EmoteRemoveMessage:
                {
                    _loc_10 = param1 as EmoteRemoveMessage;
                    _loc_26 = 0;
                    while (_loc_26 < this._emotes.length)
                    {
                        
                        if (this._emotes[_loc_26] == _loc_10.emoteId)
                        {
                            this._emotes[_loc_26] = null;
                            this._emotes.splice(_loc_26, 1);
                            break;
                        }
                        _loc_26++;
                    }
                    _loc_27 = 0;
                    while (_loc_27 < this._emotesList.length)
                    {
                        
                        if (this._emotesList[_loc_27].id == _loc_10.emoteId)
                        {
                            this._emotesList[_loc_27] = null;
                            this._emotesList.splice(_loc_27, 1);
                            break;
                        }
                        _loc_27++;
                    }
                    _loc_11 = I18n.getUiText("ui.common.emoteRemoved", [Emoticon.getEmoticonById(_loc_10.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_11, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (_loc_2 in InventoryManager.getInstance().shortcutBarItems)
                    {
                        
                        if (_loc_2 && _loc_2.type == 4 && _loc_2.id == _loc_10.emoteId)
                        {
                            _loc_2.active = false;
                            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                        }
                    }
                    return true;
                }
                case param1 is EmotePlayRequestAction:
                {
                    _loc_12 = param1 as EmotePlayRequestAction;
                    _loc_13 = Emoticon.getEmoticonById(_loc_12.emoteId);
                    if (PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
                    {
                        return true;
                    }
                    if (EmoteWrapper.getEmoteWrapperById(_loc_13.id).timer > 0)
                    {
                        return true;
                    }
                    EmoteWrapper.getEmoteWrapperById(_loc_13.id).timerToStart = _loc_13.cooldown;
                    _loc_14 = new EmotePlayRequestMessage();
                    _loc_14.initEmotePlayRequestMessage(_loc_12.emoteId);
                    _loc_15 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if (!_loc_15)
                    {
                        return true;
                    }
                    if ((_loc_15 as IMovable).isMoving)
                    {
                        this.roleplayMovementFrame.setFollowingMessage(_loc_14);
                        (_loc_15 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_14);
                    }
                    return true;
                }
                case param1 is EmotePlayMessage:
                {
                    _loc_16 = param1 as EmotePlayMessage;
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return true;
                    }
                    _loc_17 = this.roleplayEntitiesFrame.getEntityInfos(_loc_16.actorId);
                    AccountManager.getInstance().setAccountFromId(_loc_16.actorId, _loc_16.accountId);
                    if (_loc_17 is GameRolePlayCharacterInformations && this.socialFrame.isIgnored(GameRolePlayCharacterInformations(_loc_17).name, _loc_16.accountId))
                    {
                        return true;
                    }
                    if (_loc_16.emoteId == 0)
                    {
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_17, AnimationEnum.ANIM_STATIQUE));
                    }
                    else
                    {
                        if (!_loc_17)
                        {
                            return true;
                        }
                        _loc_28 = Emoticon.getEmoticonById(_loc_16.emoteId);
                        if (!_loc_28)
                        {
                            _log.error("ERREUR : Le client n\'a pas de données pour l\'emote [" + _loc_16.emoteId + "].");
                            return true;
                        }
                        _loc_29 = EntityLookAdapter.fromNetwork(_loc_17.look);
                        _loc_30 = _loc_28.getAnimName(TiphonUtility.getLookWithoutMount(_loc_29));
                        _loc_31 = _loc_28.persistancy;
                        _loc_32 = _loc_28.eight_directions;
                        this.roleplayEntitiesFrame.currentEmoticon = _loc_16.emoteId;
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_17, _loc_30, _loc_16.emoteStartTime, !_loc_31, _loc_32));
                    }
                    return true;
                }
                case param1 is EmotePlayMassiveMessage:
                {
                    _loc_18 = param1 as EmotePlayMassiveMessage;
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return true;
                    }
                    for each (_loc_33 in _loc_18.actorIds)
                    {
                        
                        _loc_34 = this.roleplayEntitiesFrame.getEntityInfos(_loc_33);
                        if (_loc_18.emoteId == 0)
                        {
                            this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_34, AnimationEnum.ANIM_STATIQUE));
                            continue;
                        }
                        _loc_35 = EntityLookAdapter.fromNetwork(_loc_34.look);
                        _loc_36 = Emoticon.getEmoticonById(_loc_18.emoteId).getAnimName(TiphonUtility.getLookWithoutMount(_loc_35));
                        _loc_37 = Emoticon.getEmoticonById(_loc_18.emoteId).persistancy;
                        _loc_38 = Emoticon.getEmoticonById(_loc_18.emoteId).eight_directions;
                        this.roleplayEntitiesFrame.currentEmoticon = _loc_18.emoteId;
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_34, _loc_36, _loc_18.emoteStartTime, !_loc_37, _loc_38));
                    }
                    return true;
                }
                case param1 is EmotePlayErrorMessage:
                {
                    _loc_19 = param1 as EmotePlayErrorMessage;
                    _loc_20 = I18n.getUiText("ui.common.cantUseEmote");
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_20, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is LifePointsRegenBeginMessage:
                {
                    _loc_21 = param1 as LifePointsRegenBeginMessage;
                    this._interval = setInterval(this.interval, _loc_21.regenRate * 100);
                    KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin, null);
                    return true;
                }
                case param1 is LifePointsRegenEndMessage:
                {
                    _loc_22 = param1 as LifePointsRegenEndMessage;
                    if (this._bEmoteOn)
                    {
                        if (_loc_22.lifePointsGained != 0)
                        {
                            _loc_39 = I18n.getUiText("ui.common.emoteRestoreLife", [_loc_22.lifePointsGained]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_39, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        }
                        this._bEmoteOn = false;
                    }
                    clearInterval(this._interval);
                    PlayedCharacterManager.getInstance().characteristics.lifePoints = _loc_22.lifePoints;
                    PlayedCharacterManager.getInstance().characteristics.maxLifePoints = _loc_22.maxLifePoints;
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
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
            if (this._interval)
            {
                clearInterval(this._interval);
            }
            return true;
        }// end function

        public function interval() : void
        {
            if (PlayedCharacterManager.getInstance())
            {
                (PlayedCharacterManager.getInstance().characteristics.lifePoints + 1);
                if (PlayedCharacterManager.getInstance().characteristics.lifePoints >= PlayedCharacterManager.getInstance().characteristics.maxLifePoints)
                {
                    clearInterval(this._interval);
                    PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.maxLifePoints;
                }
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList, true);
            }
            return;
        }// end function

    }
}
