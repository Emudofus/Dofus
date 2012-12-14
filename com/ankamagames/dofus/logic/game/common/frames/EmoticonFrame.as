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
            var _loc_21:* = null;
            var _loc_22:* = undefined;
            var _loc_23:* = null;
            var _loc_24:* = undefined;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = false;
            var _loc_31:* = false;
            var _loc_32:* = undefined;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = false;
            var _loc_37:* = false;
            var _loc_38:* = null;
            switch(true)
            {
                case param1 is EmoteListMessage:
                {
                    _loc_3 = param1 as EmoteListMessage;
                    this._emotes = new Array();
                    this._emotesList.splice(0, this._emotesList.length);
                    _loc_4 = 0;
                    for each (_loc_22 in _loc_3.emoteIds)
                    {
                        
                        this._emotes.push(_loc_22);
                        _loc_23 = EmoteWrapper.create(_loc_22, _loc_4);
                        this._emotesList.push(_loc_23);
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
                    for (_loc_24 in this._emotes)
                    {
                        
                        if (this._emotes[_loc_24] == _loc_5.emoteId)
                        {
                            return true;
                        }
                    }
                    _loc_6 = Emoticon.getEmoticonById(_loc_5.emoteId);
                    if (!_loc_6)
                    {
                        return true;
                    }
                    this._emotes.push(_loc_5.emoteId);
                    _loc_7 = EmoteWrapper.create(_loc_5.emoteId, this._emotes.length);
                    this._emotesList.push(_loc_7);
                    _loc_8 = I18n.getUiText("ui.common.emoteAdded", [Emoticon.getEmoticonById(_loc_5.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_8, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
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
                    _loc_9 = param1 as EmoteRemoveMessage;
                    _loc_25 = 0;
                    while (_loc_25 < this._emotes.length)
                    {
                        
                        if (this._emotes[_loc_25] == _loc_9.emoteId)
                        {
                            this._emotes[_loc_25] = null;
                            this._emotes.splice(_loc_25, 1);
                            break;
                        }
                        _loc_25++;
                    }
                    _loc_26 = 0;
                    while (_loc_26 < this._emotesList.length)
                    {
                        
                        if (this._emotesList[_loc_26].id == _loc_9.emoteId)
                        {
                            this._emotesList[_loc_26] = null;
                            this._emotesList.splice(_loc_26, 1);
                            break;
                        }
                        _loc_26++;
                    }
                    _loc_10 = I18n.getUiText("ui.common.emoteRemoved", [Emoticon.getEmoticonById(_loc_9.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_10, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (_loc_2 in InventoryManager.getInstance().shortcutBarItems)
                    {
                        
                        if (_loc_2 && _loc_2.type == 4 && _loc_2.id == _loc_9.emoteId)
                        {
                            _loc_2.active = false;
                            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                        }
                    }
                    return true;
                }
                case param1 is EmotePlayRequestAction:
                {
                    _loc_11 = param1 as EmotePlayRequestAction;
                    _loc_12 = Emoticon.getEmoticonById(_loc_11.emoteId);
                    if (PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
                    {
                        return true;
                    }
                    if (EmoteWrapper.getEmoteWrapperById(_loc_12.id).timer > 0)
                    {
                        return true;
                    }
                    EmoteWrapper.getEmoteWrapperById(_loc_12.id).timerToStart = _loc_12.cooldown;
                    _loc_13 = new EmotePlayRequestMessage();
                    _loc_13.initEmotePlayRequestMessage(_loc_11.emoteId);
                    _loc_14 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if (!_loc_14)
                    {
                        return true;
                    }
                    if ((_loc_14 as IMovable).isMoving)
                    {
                        this.roleplayMovementFrame.setFollowingMessage(_loc_13);
                        (_loc_14 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_13);
                    }
                    return true;
                }
                case param1 is EmotePlayMessage:
                {
                    _loc_15 = param1 as EmotePlayMessage;
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return true;
                    }
                    _loc_16 = this.roleplayEntitiesFrame.getEntityInfos(_loc_15.actorId);
                    AccountManager.getInstance().setAccountFromId(_loc_15.actorId, _loc_15.accountId);
                    if (_loc_16 is GameRolePlayCharacterInformations && this.socialFrame.isIgnored(GameRolePlayCharacterInformations(_loc_16).name, _loc_15.accountId))
                    {
                        return true;
                    }
                    if (_loc_15.emoteId == 0)
                    {
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_16, AnimationEnum.ANIM_STATIQUE));
                    }
                    else
                    {
                        if (!_loc_16)
                        {
                            return true;
                        }
                        _loc_27 = Emoticon.getEmoticonById(_loc_15.emoteId);
                        if (!_loc_27)
                        {
                            _log.error("ERREUR : Le client n\'a pas de données pour l\'emote [" + _loc_15.emoteId + "].");
                            return true;
                        }
                        _loc_28 = EntityLookAdapter.fromNetwork(_loc_16.look);
                        _loc_29 = _loc_27.getAnimName(TiphonUtility.getLookWithoutMount(_loc_28));
                        _loc_30 = _loc_27.persistancy;
                        _loc_31 = _loc_27.eight_directions;
                        this.roleplayEntitiesFrame.currentEmoticon = _loc_15.emoteId;
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_16, _loc_29, _loc_15.emoteStartTime, !_loc_30, _loc_31));
                    }
                    return true;
                }
                case param1 is EmotePlayMassiveMessage:
                {
                    _loc_17 = param1 as EmotePlayMassiveMessage;
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return true;
                    }
                    for each (_loc_32 in _loc_17.actorIds)
                    {
                        
                        _loc_33 = this.roleplayEntitiesFrame.getEntityInfos(_loc_32);
                        if (_loc_17.emoteId == 0)
                        {
                            this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_33, AnimationEnum.ANIM_STATIQUE));
                            continue;
                        }
                        _loc_34 = EntityLookAdapter.fromNetwork(_loc_33.look);
                        _loc_35 = Emoticon.getEmoticonById(_loc_17.emoteId).getAnimName(TiphonUtility.getLookWithoutMount(_loc_34));
                        _loc_36 = Emoticon.getEmoticonById(_loc_17.emoteId).persistancy;
                        _loc_37 = Emoticon.getEmoticonById(_loc_17.emoteId).eight_directions;
                        this.roleplayEntitiesFrame.currentEmoticon = _loc_17.emoteId;
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc_33, _loc_35, _loc_17.emoteStartTime, !_loc_36, _loc_37));
                    }
                    return true;
                }
                case param1 is EmotePlayErrorMessage:
                {
                    _loc_18 = param1 as EmotePlayErrorMessage;
                    _loc_19 = I18n.getUiText("ui.common.cantUseEmote");
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_19, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is LifePointsRegenBeginMessage:
                {
                    _loc_20 = param1 as LifePointsRegenBeginMessage;
                    this._interval = setInterval(this.interval, _loc_20.regenRate * 100);
                    KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin, null);
                    return true;
                }
                case param1 is LifePointsRegenEndMessage:
                {
                    _loc_21 = param1 as LifePointsRegenEndMessage;
                    if (this._bEmoteOn)
                    {
                        if (_loc_21.lifePointsGained != 0)
                        {
                            _loc_38 = I18n.getUiText("ui.common.emoteRestoreLife", [_loc_21.lifePointsGained]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_38, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        }
                        this._bEmoteOn = false;
                    }
                    clearInterval(this._interval);
                    PlayedCharacterManager.getInstance().characteristics.lifePoints = _loc_21.lifePoints;
                    PlayedCharacterManager.getInstance().characteristics.maxLifePoints = _loc_21.maxLifePoints;
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
