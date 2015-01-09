package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteListMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteAddMessage;
    import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
    import com.ankamagames.dofus.datacenter.communication.Emoticon;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteRemoveMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMassiveMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayErrorMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.LifePointsRegenBeginMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.LifePointsRegenEndMessage;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.RoleplayHookList;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.dofus.Constants;
    import com.ankamagames.dofus.logic.common.managers.NotificationManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.common.managers.AccountManager;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.tiphon.types.TiphonUtility;
    import flash.utils.setInterval;
    import com.ankamagames.dofus.misc.lists.HookList;
    import flash.utils.clearInterval;
    import com.ankamagames.jerakine.messages.Message;

    public class EmoticonFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmoticonFrame));

        private var _emotes:Array;
        private var _emotesList:Array;
        private var _interval:Number;
        private var _bEmoteOn:Boolean = false;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get emotes():Array
        {
            this._emotes.sort(Array.NUMERIC);
            return (this._emotes);
        }

        public function get emotesList():Array
        {
            this._emotesList.sortOn("order", Array.NUMERIC);
            return (this._emotesList);
        }

        private function get socialFrame():SocialFrame
        {
            return ((Kernel.getWorker().getFrame(SocialFrame) as SocialFrame));
        }

        private function get roleplayEntitiesFrame():RoleplayEntitiesFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame));
        }

        private function get roleplayMovementFrame():RoleplayMovementFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame));
        }

        public function pushed():Boolean
        {
            this._emotes = new Array();
            this._emotesList = new Array();
            return (true);
        }

        public function isKnownEmote(id:int):Boolean
        {
            return (!((this._emotes.indexOf(id) == -1)));
        }

        public function process(msg:Message):Boolean
        {
            var shortcut:ShortcutWrapper;
            var _local_3:EmoteListMessage;
            var _local_4:uint;
            var _local_5:EmoteAddMessage;
            var _local_6:EmoteWrapper;
            var _local_7:Emoticon;
            var _local_8:EmoteWrapper;
            var _local_9:String;
            var _local_10:EmoteRemoveMessage;
            var _local_11:String;
            var _local_12:EmotePlayRequestAction;
            var _local_13:Emoticon;
            var _local_14:EmoteWrapper;
            var _local_15:EmotePlayRequestMessage;
            var _local_16:IEntity;
            var _local_17:EmotePlayMessage;
            var _local_18:GameContextActorInformations;
            var _local_19:EmotePlayMassiveMessage;
            var _local_20:EmotePlayErrorMessage;
            var _local_21:String;
            var _local_22:LifePointsRegenBeginMessage;
            var _local_23:LifePointsRegenEndMessage;
            var id:*;
            var emoteW:EmoteWrapper;
            var i:*;
            var eamsgNid:uint;
            var ire:int;
            var ire2:int;
            var _local_30:Emoticon;
            var _local_31:TiphonEntityLook;
            var _local_32:String;
            var _local_33:Boolean;
            var _local_34:Boolean;
            var _local_35:*;
            var mEntityInfo:GameContextActorInformations;
            var _local_37:TiphonEntityLook;
            var _local_38:String;
            var _local_39:Boolean;
            var _local_40:Boolean;
            var regenText:String;
            switch (true)
            {
                case (msg is EmoteListMessage):
                    _local_3 = (msg as EmoteListMessage);
                    this._emotes = new Array();
                    this._emotesList.splice(0, this._emotesList.length);
                    _local_4 = 0;
                    for each (id in _local_3.emoteIds)
                    {
                        this._emotes.push(id);
                        emoteW = EmoteWrapper.create(id, _local_4);
                        this._emotesList.push(emoteW);
                        _local_4++;
                    };
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (shortcut in InventoryManager.getInstance().shortcutBarItems)
                    {
                        if (((shortcut) && ((shortcut.type == 4))))
                        {
                            if (this._emotes.indexOf(shortcut.id) != -1)
                            {
                                shortcut.active = true;
                            }
                            else
                            {
                                shortcut.active = false;
                            };
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                    return (true);
                case (msg is EmoteAddMessage):
                    _local_5 = (msg as EmoteAddMessage);
                    for (i in this._emotes)
                    {
                        if (this._emotes[i] == _local_5.emoteId)
                        {
                            return (true);
                        };
                    };
                    for each (_local_6 in this._emotesList)
                    {
                        if (_local_6.id == _local_5.emoteId)
                        {
                            return (true);
                        };
                    };
                    _local_7 = Emoticon.getEmoticonById(_local_5.emoteId);
                    if (!(_local_7))
                    {
                        return (true);
                    };
                    this._emotes.push(_local_5.emoteId);
                    _local_8 = EmoteWrapper.create(_local_5.emoteId, this._emotes.length);
                    this._emotesList.push(_local_8);
                    if (!(StoreDataManager.getInstance().getData(Constants.DATASTORE_COMPUTER_OPTIONS, ("learnEmote" + _local_5.emoteId))))
                    {
                        StoreDataManager.getInstance().setData(Constants.DATASTORE_COMPUTER_OPTIONS, ("learnEmote" + _local_5.emoteId), true);
                        eamsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.emotes"), I18n.getUiText("ui.common.emoteAdded", [_local_7.name]), NotificationTypeEnum.TUTORIAL, ("new_emote_" + _local_5.emoteId));
                        NotificationManager.getInstance().addButtonToNotification(eamsgNid, I18n.getUiText("ui.common.details"), "OpenSmileys", [1, true], true, 130);
                        NotificationManager.getInstance().sendNotification(eamsgNid);
                    };
                    _local_9 = I18n.getUiText("ui.common.emoteAdded", [Emoticon.getEmoticonById(_local_5.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_9, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (shortcut in InventoryManager.getInstance().shortcutBarItems)
                    {
                        if (((((shortcut) && ((shortcut.type == 4)))) && ((shortcut.id == _local_5.emoteId))))
                        {
                            shortcut.active = true;
                            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                        };
                    };
                    return (true);
                case (msg is EmoteRemoveMessage):
                    _local_10 = (msg as EmoteRemoveMessage);
                    ire = 0;
                    while (ire < this._emotes.length)
                    {
                        if (this._emotes[ire] == _local_10.emoteId)
                        {
                            this._emotes[ire] = null;
                            this._emotes.splice(ire, 1);
                            break;
                        };
                        ire++;
                    };
                    ire2 = 0;
                    while (ire2 < this._emotesList.length)
                    {
                        if (this._emotesList[ire2].id == _local_10.emoteId)
                        {
                            this._emotesList[ire2] = null;
                            this._emotesList.splice(ire2, 1);
                            break;
                        };
                        ire2++;
                    };
                    _local_11 = I18n.getUiText("ui.common.emoteRemoved", [Emoticon.getEmoticonById(_local_10.emoteId).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_11, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
                    for each (shortcut in InventoryManager.getInstance().shortcutBarItems)
                    {
                        if (((((shortcut) && ((shortcut.type == 4)))) && ((shortcut.id == _local_10.emoteId))))
                        {
                            shortcut.active = false;
                            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                        };
                    };
                    return (true);
                case (msg is EmotePlayRequestAction):
                    _local_12 = (msg as EmotePlayRequestAction);
                    _local_13 = Emoticon.getEmoticonById(_local_12.emoteId);
                    if (!(_local_13))
                    {
                        return (true);
                    };
                    _local_14 = EmoteWrapper.getEmoteWrapperById(_local_13.id);
                    if (((!(_local_14)) || (((_local_14) && ((_local_14.timer > 0))))))
                    {
                        return (true);
                    };
                    EmoteWrapper.getEmoteWrapperById(_local_13.id).timerToStart = _local_13.cooldown;
                    _local_15 = new EmotePlayRequestMessage();
                    _local_15.initEmotePlayRequestMessage(_local_12.emoteId);
                    _local_16 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if (!(_local_16))
                    {
                        return (true);
                    };
                    if ((_local_16 as IMovable).isMoving)
                    {
                        this.roleplayMovementFrame.setFollowingMessage(_local_15);
                        (_local_16 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_local_15);
                    };
                    return (true);
                case (msg is EmotePlayMessage):
                    _local_17 = (msg as EmotePlayMessage);
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return (true);
                    };
                    delete this.roleplayEntitiesFrame.lastStaticAnimations[_local_17.actorId];
                    _local_18 = this.roleplayEntitiesFrame.getEntityInfos(_local_17.actorId);
                    AccountManager.getInstance().setAccountFromId(_local_17.actorId, _local_17.accountId);
                    if ((((_local_18 is GameRolePlayCharacterInformations)) && (this.socialFrame.isIgnored(GameRolePlayCharacterInformations(_local_18).name, _local_17.accountId))))
                    {
                        return (true);
                    };
                    if (_local_17.emoteId == 0)
                    {
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_local_18, AnimationEnum.ANIM_STATIQUE));
                    }
                    else
                    {
                        if (!(_local_18))
                        {
                            return (true);
                        };
                        _local_30 = Emoticon.getEmoticonById(_local_17.emoteId);
                        if (!(_local_30))
                        {
                            _log.error((("ERREUR : Le client n'a pas de données pour l'emote [" + _local_17.emoteId) + "]."));
                            return (true);
                        };
                        _local_31 = EntityLookAdapter.fromNetwork(_local_18.look);
                        _local_32 = _local_30.getAnimName(TiphonUtility.getLookWithoutMount(_local_31));
                        _local_33 = _local_30.persistancy;
                        _local_34 = _local_30.eight_directions;
                        this.roleplayEntitiesFrame.currentEmoticon = _local_17.emoteId;
                        this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_local_18, _local_32, _local_17.emoteStartTime, !(_local_33), _local_34));
                    };
                    return (true);
                case (msg is EmotePlayMassiveMessage):
                    _local_19 = (msg as EmotePlayMassiveMessage);
                    this._bEmoteOn = true;
                    if (this.roleplayEntitiesFrame == null)
                    {
                        return (true);
                    };
                    for each (_local_35 in _local_19.actorIds)
                    {
                        mEntityInfo = this.roleplayEntitiesFrame.getEntityInfos(_local_35);
                        if (_local_19.emoteId == 0)
                        {
                            this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(mEntityInfo, AnimationEnum.ANIM_STATIQUE));
                        }
                        else
                        {
                            _local_37 = EntityLookAdapter.fromNetwork(mEntityInfo.look);
                            _local_38 = Emoticon.getEmoticonById(_local_19.emoteId).getAnimName(TiphonUtility.getLookWithoutMount(_local_37));
                            _local_39 = Emoticon.getEmoticonById(_local_19.emoteId).persistancy;
                            _local_40 = Emoticon.getEmoticonById(_local_19.emoteId).eight_directions;
                            this.roleplayEntitiesFrame.currentEmoticon = _local_19.emoteId;
                            this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(mEntityInfo, _local_38, _local_19.emoteStartTime, !(_local_39), _local_40));
                        };
                    };
                    return (true);
                case (msg is EmotePlayErrorMessage):
                    _local_20 = (msg as EmotePlayErrorMessage);
                    _local_21 = I18n.getUiText("ui.common.cantUseEmote");
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_21, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is LifePointsRegenBeginMessage):
                    _local_22 = (msg as LifePointsRegenBeginMessage);
                    this._interval = setInterval(this.interval, (_local_22.regenRate * 100));
                    KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin, null);
                    return (true);
                case (msg is LifePointsRegenEndMessage):
                    _local_23 = (msg as LifePointsRegenEndMessage);
                    if (this._bEmoteOn)
                    {
                        if (_local_23.lifePointsGained != 0)
                        {
                            regenText = I18n.getUiText("ui.common.emoteRestoreLife", [_local_23.lifePointsGained]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, regenText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        };
                        this._bEmoteOn = false;
                    };
                    clearInterval(this._interval);
                    PlayedCharacterManager.getInstance().characteristics.lifePoints = _local_23.lifePoints;
                    PlayedCharacterManager.getInstance().characteristics.maxLifePoints = _local_23.maxLifePoints;
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            if (this._interval)
            {
                clearInterval(this._interval);
            };
            return (true);
        }

        public function interval():void
        {
            if (((PlayedCharacterManager.getInstance()) && (PlayedCharacterManager.getInstance().characteristics)))
            {
                PlayedCharacterManager.getInstance().characteristics.lifePoints = (PlayedCharacterManager.getInstance().characteristics.lifePoints + 1);
                if (PlayedCharacterManager.getInstance().characteristics.lifePoints >= PlayedCharacterManager.getInstance().characteristics.maxLifePoints)
                {
                    clearInterval(this._interval);
                    PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.maxLifePoints;
                };
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList, true);
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

