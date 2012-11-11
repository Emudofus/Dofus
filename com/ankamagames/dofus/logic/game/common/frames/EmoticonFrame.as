package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
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

    public class EmoticonFrame extends Object implements Frame
    {
        private var _emotes:Array;
        private var _emotesList:Array;
        private var _interval:Number;
        private var _bEmoteOn:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmoticonFrame));

        public function EmoticonFrame()
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
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
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
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = undefined;
            var _loc_22:* = null;
            var _loc_23:* = undefined;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = false;
            var _loc_30:* = false;
            var _loc_31:* = undefined;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = false;
            var _loc_36:* = false;
            var _loc_37:* = null;
            switch(true)
            {
                case param1 is EmoteListMessage:
                {
                    _loc_3 = param1 as EmoteListMessage;
                    this._emotes = new Array();
                    this._emotesList.splice(0, this._emotesList.length);
                    _loc_4 = 0;
                    for each (_loc_21 in _loc_3.emoteIds)
                    {
                        
                        this._emotes.push(_loc_21);
                        _loc_22 = EmoteWrapper.create(_loc_21, _loc_4);
                        this._emotesList.push(_loc_22);
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
                    for (_loc_23 in this._emotes)
                    {
                        
                        if (this._emotes[_loc_23] == _loc_5.emoteId)
                        {
                            return true;
                        }
                    }
                    this._emotes.push(_loc_5.emoteId);
                    _loc_6 = EmoteWrapper.create(_loc_5.emoteId, this._emotes.length);
                    this._emotesList.push(_loc_6);
                    _loc_7 = I18n.getUiText("ui.common.emoteAdded", [Emoticon.getEmoticonById(_loc_5.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_7, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
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
                    _loc_8 = param1 as EmoteRemoveMessage;
                    _loc_24 = 0;
                    while (_loc_24 < this._emotes.length)
                    {
                        
                        if (this._emotes[_loc_24] == _loc_8.emoteId)
                        {
                            this._emotes[_loc_24] = null;
                            this._emotes.splice(_loc_24, 1);
                            break;
                        }
                        _loc_24++;
                    }
                    _loc_25 = 0;
                    while (_loc_25 < this._emotesList.length)
                    {
                        
                        if (this._emotesList[_loc_25].id == _loc_8.emoteId)
                        {
                            this._emotesList[_loc_25] = null;
                            this._emotesList.splice(_loc_25, 1);
                            break;
                        }
                        _loc_25++;
                    }
                    _loc_9 = I18n.getUiText("ui.common.emoteRemoved", [Emoticon.getEmoticonById(_loc_8.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_9, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (_loc_2 in InventoryManager.getInstance().shortcutBarItems)
                    {
                        
                        if (_loc_2 && _loc_2.type == 4 && _loc_2.id == _loc_8.emoteId)
                        {
                            _loc_2.active = false;
                            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                        }
                    }
                    return true;
                }
                case param1 is EmotePlayRequestAction:
                {
                    _loc_10 = param1 as EmotePlayRequestAction;
                    _loc_11 = Emoticon.getEmoticonById(_loc_10.emoteId);
                    if (PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
                    {
                        return true;
                    }
                    if (EmoteWrapper.getEmoteWrapperById(_loc_11.id).timer > 0)
                    {
                        return true;
                    }
                    EmoteWrapper.getEmoteWrapperById(_loc_11.id).timerToStart = _loc_11.cooldown;
                    _loc_12 = new EmotePlayRequestMessage();
                    _loc_12.initEmotePlayRequestMessage(_loc_10.emoteId);
                    _loc_13 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if (!_loc_13)
                    {
                        return true;
                    }
                    if ((_loc_13 as IMovable).isMoving)
                    {
                        this.roleplayMovementFrame.setFollowingMessage(_loc_12);
                        (_loc_13 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_12);
                    }
                    return true;
                }
                case param1 is EmotePlayMessage:
                {
                    _loc_14 = param1 as EmotePlayMessage;
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return true;
                    }
                    _loc_15 = this.roleplayEntitiesFrame.getEntityInfos(_loc_14.actorId);
                    AccountManager.getInstance().setAccountFromId(_loc_14.actorId, _loc_14.accountId);
                    if (_loc_15 is GameRolePlayCharacterInformations && this.socialFrame.isIgnored(GameRolePlayCharacterInformations(_loc_15).name, _loc_14.accountId))
                    {
                        return true;
                    }
                    if (_loc_14.emoteId == 0)
                    {
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_15, AnimationEnum.ANIM_STATIQUE));
                    }
                    else
                    {
                        if (!_loc_15)
                        {
                            return true;
                        }
                        _loc_26 = Emoticon.getEmoticonById(_loc_14.emoteId);
                        if (!_loc_26)
                        {
                            _log.error("ERREUR : Le client n\'a pas de données pour l\'emote [" + _loc_14.emoteId + "].");
                            return true;
                        }
                        _loc_27 = EntityLookAdapter.fromNetwork(_loc_15.look);
                        _loc_28 = _loc_26.getAnimName(TiphonUtility.getLookWithoutMount(_loc_27));
                        _loc_29 = _loc_26.persistancy;
                        _loc_30 = _loc_26.eight_directions;
                        this.roleplayEntitiesFrame.currentEmoticon = _loc_14.emoteId;
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_15, _loc_28, _loc_14.emoteStartTime, !_loc_29, _loc_30));
                    }
                    return true;
                }
                case param1 is EmotePlayMassiveMessage:
                {
                    _loc_16 = param1 as EmotePlayMassiveMessage;
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return true;
                    }
                    for each (_loc_31 in _loc_16.actorIds)
                    {
                        
                        _loc_32 = this.roleplayEntitiesFrame.getEntityInfos(_loc_31);
                        if (_loc_16.emoteId == 0)
                        {
                            this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_32, AnimationEnum.ANIM_STATIQUE));
                            continue;
                        }
                        _loc_33 = EntityLookAdapter.fromNetwork(_loc_32.look);
                        _loc_34 = Emoticon.getEmoticonById(_loc_16.emoteId).getAnimName(TiphonUtility.getLookWithoutMount(_loc_33));
                        _loc_35 = Emoticon.getEmoticonById(_loc_16.emoteId).persistancy;
                        _loc_36 = Emoticon.getEmoticonById(_loc_16.emoteId).eight_directions;
                        this.roleplayEntitiesFrame.currentEmoticon = _loc_16.emoteId;
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_32, _loc_34, _loc_16.emoteStartTime, !_loc_35, _loc_36));
                    }
                    return true;
                }
                case param1 is EmotePlayErrorMessage:
                {
                    _loc_17 = param1 as EmotePlayErrorMessage;
                    _loc_18 = I18n.getUiText("ui.common.cantUseEmote");
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_18, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is LifePointsRegenBeginMessage:
                {
                    _loc_19 = param1 as LifePointsRegenBeginMessage;
                    this._interval = setInterval(this.interval, _loc_19.regenRate * 100);
                    KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin, null);
                    return true;
                }
                case param1 is LifePointsRegenEndMessage:
                {
                    _loc_20 = param1 as LifePointsRegenEndMessage;
                    if (this._bEmoteOn)
                    {
                        if (_loc_20.lifePointsGained != 0)
                        {
                            _loc_37 = I18n.getUiText("ui.common.emoteRestoreLife", [_loc_20.lifePointsGained]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_37, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        }
                        this._bEmoteOn = false;
                    }
                    clearInterval(this._interval);
                    PlayedCharacterManager.getInstance().characteristics.lifePoints = _loc_20.lifePoints;
                    PlayedCharacterManager.getInstance().characteristics.maxLifePoints = _loc_20.maxLifePoints;
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
