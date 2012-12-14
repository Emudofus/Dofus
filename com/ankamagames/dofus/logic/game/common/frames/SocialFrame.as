package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.externalnotification.*;
    import com.ankamagames.dofus.externalnotification.enums.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.internalDatacenter.people.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.guild.*;
    import com.ankamagames.dofus.logic.game.common.actions.social.*;
    import com.ankamagames.dofus.logic.game.common.actions.taxCollector.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.achievement.*;
    import com.ankamagames.dofus.network.messages.game.chat.report.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
    import com.ankamagames.dofus.network.messages.game.friend.*;
    import com.ankamagames.dofus.network.messages.game.guild.*;
    import com.ankamagames.dofus.network.messages.game.guild.tax.*;
    import com.ankamagames.dofus.network.messages.game.report.*;
    import com.ankamagames.dofus.network.messages.game.social.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.system.*;
    import d2network.*;
    import flash.utils.*;

    public class SocialFrame extends Object implements Frame
    {
        private var _guildDialogFrame:GuildDialogFrame;
        private var _friendsList:Array;
        private var _enemiesList:Array;
        private var _ignoredList:Array;
        private var _spouse:SpouseWrapper;
        private var _hasGuild:Boolean = false;
        private var _hasSpouse:Boolean = false;
        private var _guild:GuildWrapper;
        private var _guildMembers:Vector.<GuildMember>;
        private var _guildHouses:Vector.<GuildHouseWrapper>;
        private var _guildHousesList:Boolean = false;
        private var _guildHousesListUpdate:Boolean = false;
        private var _guildPaddocks:Vector.<PaddockContentInformations>;
        private var _guildPaddocksMax:int = 1;
        private var _upGuildEmblem:EmblemWrapper;
        private var _backGuildEmblem:EmblemWrapper;
        private var _warnOnFrienConnec:Boolean;
        private var _warnOnMemberConnec:Boolean;
        private var _warnWhenFriendOrGuildMemberLvlUp:Boolean;
        private var _warnWhenFriendOrGuildMemberAchieve:Boolean;
        private var _autoLeaveHelpers:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialFrame));

        public function SocialFrame()
        {
            this._guildHouses = new Vector.<GuildHouseWrapper>;
            this._guildPaddocks = new Vector.<PaddockContentInformations>;
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get friendsList() : Array
        {
            return this._friendsList;
        }// end function

        public function get enemiesList() : Array
        {
            return this._enemiesList;
        }// end function

        public function get ignoredList() : Array
        {
            return this._ignoredList;
        }// end function

        public function get spouse() : SpouseWrapper
        {
            return this._spouse;
        }// end function

        public function get hasGuild() : Boolean
        {
            return this._hasGuild;
        }// end function

        public function get hasSpouse() : Boolean
        {
            return this._hasSpouse;
        }// end function

        public function get guild() : GuildWrapper
        {
            return this._guild;
        }// end function

        public function get guildmembers() : Vector.<GuildMember>
        {
            return this._guildMembers;
        }// end function

        public function get guildHouses() : Vector.<GuildHouseWrapper>
        {
            return this._guildHouses;
        }// end function

        public function get guildPaddocks() : Vector.<PaddockContentInformations>
        {
            return this._guildPaddocks;
        }// end function

        public function get maxGuildPaddocks() : int
        {
            return this._guildPaddocksMax;
        }// end function

        public function get warnFriendConnec() : Boolean
        {
            return this._warnOnFrienConnec;
        }// end function

        public function get warnMemberConnec() : Boolean
        {
            return this._warnOnMemberConnec;
        }// end function

        public function get warnWhenFriendOrGuildMemberLvlUp() : Boolean
        {
            return this._warnWhenFriendOrGuildMemberLvlUp;
        }// end function

        public function get warnWhenFriendOrGuildMemberAchieve() : Boolean
        {
            return this._warnWhenFriendOrGuildMemberAchieve;
        }// end function

        public function pushed() : Boolean
        {
            this._enemiesList = new Array();
            this._ignoredList = new Array();
            this._guildDialogFrame = new GuildDialogFrame();
            ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
            ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
            ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
            return true;
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
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = false;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
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
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = null;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = null;
            var _loc_52:* = null;
            var _loc_53:* = null;
            var _loc_54:* = null;
            var _loc_55:* = null;
            var _loc_56:* = null;
            var _loc_57:* = null;
            var _loc_58:* = null;
            var _loc_59:* = null;
            var _loc_60:* = null;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = null;
            var _loc_64:* = null;
            var _loc_65:* = null;
            var _loc_66:* = 0;
            var _loc_67:* = null;
            var _loc_68:* = null;
            var _loc_69:* = null;
            var _loc_70:* = null;
            var _loc_71:* = null;
            var _loc_72:* = null;
            var _loc_73:* = null;
            var _loc_74:* = null;
            var _loc_75:* = null;
            var _loc_76:* = null;
            var _loc_77:* = null;
            var _loc_78:* = null;
            var _loc_79:* = null;
            var _loc_80:* = null;
            var _loc_81:* = null;
            var _loc_82:* = null;
            var _loc_83:* = null;
            var _loc_84:* = null;
            var _loc_85:* = null;
            var _loc_86:* = 0;
            var _loc_87:* = 0;
            var _loc_88:* = null;
            var _loc_89:* = null;
            var _loc_90:* = null;
            var _loc_91:* = null;
            var _loc_92:* = false;
            var _loc_93:* = null;
            var _loc_94:* = null;
            var _loc_95:* = null;
            var _loc_96:* = null;
            var _loc_97:* = null;
            var _loc_98:* = null;
            var _loc_99:* = null;
            var _loc_100:* = null;
            var _loc_101:* = null;
            var _loc_102:* = false;
            var _loc_103:* = null;
            var _loc_104:* = null;
            var _loc_105:* = null;
            var _loc_106:* = null;
            var _loc_107:* = null;
            var _loc_108:* = null;
            var _loc_109:* = null;
            var _loc_110:* = NaN;
            var _loc_111:* = null;
            var _loc_112:* = null;
            var _loc_113:* = null;
            var _loc_114:* = null;
            var _loc_115:* = null;
            var _loc_116:* = null;
            var _loc_117:* = null;
            var _loc_118:* = null;
            var _loc_119:* = null;
            var _loc_120:* = null;
            var _loc_121:* = null;
            var _loc_122:* = null;
            var _loc_123:* = null;
            var _loc_124:* = null;
            var _loc_125:* = null;
            var _loc_126:* = null;
            var _loc_127:* = null;
            var _loc_128:* = null;
            var _loc_129:* = null;
            var _loc_130:* = null;
            var _loc_131:* = null;
            var _loc_132:* = 0;
            var _loc_133:* = null;
            var _loc_134:* = null;
            var _loc_135:* = null;
            var _loc_136:* = undefined;
            var _loc_137:* = null;
            var _loc_138:* = null;
            var _loc_139:* = null;
            var _loc_140:* = null;
            var _loc_141:* = null;
            var _loc_142:* = undefined;
            var _loc_143:* = undefined;
            var _loc_144:* = undefined;
            var _loc_145:* = undefined;
            var _loc_146:* = undefined;
            var _loc_147:* = undefined;
            var _loc_148:* = null;
            var _loc_149:* = null;
            var _loc_150:* = null;
            var _loc_151:* = false;
            var _loc_152:* = null;
            var _loc_153:* = null;
            var _loc_154:* = null;
            var _loc_155:* = null;
            var _loc_156:* = 0;
            var _loc_157:* = 0;
            var _loc_158:* = null;
            var _loc_159:* = null;
            var _loc_160:* = null;
            var _loc_161:* = null;
            var _loc_162:* = null;
            var _loc_163:* = null;
            var _loc_164:* = null;
            var _loc_165:* = null;
            var _loc_166:* = null;
            var _loc_167:* = false;
            var _loc_168:* = null;
            var _loc_169:* = null;
            var _loc_170:* = null;
            var _loc_171:* = false;
            var _loc_172:* = 0;
            switch(true)
            {
                case param1 is GuildMembershipMessage:
                {
                    _loc_2 = param1 as GuildMembershipMessage;
                    if (this._guild != null)
                    {
                        this._guild.update(_loc_2.guildInfo.guildId, _loc_2.guildInfo.guildName, _loc_2.guildInfo.guildEmblem, _loc_2.memberRights, _loc_2.enabled);
                    }
                    else
                    {
                        this._guild = GuildWrapper.create(_loc_2.guildInfo.guildId, _loc_2.guildInfo.guildName, _loc_2.guildInfo.guildEmblem, _loc_2.memberRights, _loc_2.enabled);
                    }
                    this._hasGuild = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembership);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, true);
                    return true;
                }
                case param1 is FriendsListMessage:
                {
                    _loc_3 = param1 as FriendsListMessage;
                    this._friendsList = new Array();
                    for each (_loc_133 in _loc_3.friendsList)
                    {
                        
                        if (_loc_133 is FriendOnlineInformations)
                        {
                            _loc_135 = _loc_133 as FriendOnlineInformations;
                            AccountManager.getInstance().setAccount(_loc_135.playerName, _loc_135.accountId, _loc_135.accountName);
                            ChatAutocompleteNameManager.getInstance().addEntry((_loc_133 as FriendOnlineInformations).playerName, 2);
                        }
                        _loc_134 = new FriendWrapper(_loc_133);
                        this._friendsList.push(_loc_134);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    return true;
                }
                case param1 is SpouseRequestAction:
                {
                    _loc_4 = param1 as SpouseRequestAction;
                    ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
                    return true;
                }
                case param1 is SpouseInformationsMessage:
                {
                    _loc_5 = param1 as SpouseInformationsMessage;
                    this._spouse = new SpouseWrapper(_loc_5.spouse);
                    this._hasSpouse = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
                    return true;
                }
                case param1 is IgnoredListMessage:
                {
                    this._enemiesList = new Array();
                    _loc_6 = param1 as IgnoredListMessage;
                    for each (_loc_136 in _loc_6.ignoredList)
                    {
                        
                        if (_loc_136 is IgnoredOnlineInformations)
                        {
                            _loc_138 = _loc_133 as IgnoredOnlineInformations;
                            AccountManager.getInstance().setAccount(_loc_138.playerName, _loc_138.accountId, _loc_138.accountName);
                        }
                        _loc_137 = new EnemyWrapper(_loc_136);
                        this._enemiesList.push(_loc_137);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                    return true;
                }
                case param1 is OpenSocialAction:
                {
                    _loc_7 = param1 as OpenSocialAction;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, _loc_7.name);
                    return true;
                }
                case param1 is FriendsListRequestAction:
                {
                    _loc_8 = param1 as FriendsListRequestAction;
                    ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
                    return true;
                }
                case param1 is EnemiesListRequestAction:
                {
                    _loc_9 = param1 as EnemiesListRequestAction;
                    ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
                    return true;
                }
                case param1 is AddFriendAction:
                {
                    _loc_10 = param1 as AddFriendAction;
                    if (_loc_10.name.length < 2 || _loc_10.name.length > 20)
                    {
                        _loc_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else if (_loc_10.name != PlayedCharacterManager.getInstance().infos.name)
                    {
                        _loc_139 = new FriendAddRequestMessage();
                        _loc_139.initFriendAddRequestMessage(_loc_10.name);
                        ConnectionsHandler.getConnection().send(_loc_139);
                    }
                    else
                    {
                        _loc_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is FriendAddedMessage:
                {
                    _loc_11 = param1 as FriendAddedMessage;
                    if (_loc_11.friendAdded is FriendOnlineInformations)
                    {
                        _loc_135 = _loc_11.friendAdded as FriendOnlineInformations;
                        AccountManager.getInstance().setAccount(_loc_135.playerName, _loc_135.accountId, _loc_135.accountName);
                        ChatAutocompleteNameManager.getInstance().addEntry((_loc_11.friendAdded as FriendInformations).accountName, 2);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendAdded, true);
                    _loc_12 = new FriendWrapper(_loc_11.friendAdded);
                    this._friendsList.push(_loc_12);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    return true;
                }
                case param1 is FriendAddFailureMessage:
                {
                    _loc_13 = param1 as FriendAddFailureMessage;
                    switch(_loc_13.reason)
                    {
                        case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                        {
                            _loc_14 = I18n.getUiText("ui.common.unknowReason");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                        {
                            _loc_14 = I18n.getUiText("ui.social.friend.addFailureListFull");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                        {
                            _loc_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                        {
                            _loc_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                        {
                            _loc_14 = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is AddEnemyAction:
                {
                    _loc_15 = param1 as AddEnemyAction;
                    if (_loc_15.name.length < 2 || _loc_15.name.length > 20)
                    {
                        _loc_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else if (_loc_15.name != PlayedCharacterManager.getInstance().infos.name)
                    {
                        _loc_140 = new IgnoredAddRequestMessage();
                        _loc_140.initIgnoredAddRequestMessage(_loc_15.name);
                        ConnectionsHandler.getConnection().send(_loc_140);
                    }
                    else
                    {
                        _loc_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is IgnoredAddedMessage:
                {
                    _loc_16 = param1 as IgnoredAddedMessage;
                    if (_loc_16.ignoreAdded is IgnoredOnlineInformations)
                    {
                        _loc_138 = _loc_16.ignoreAdded as IgnoredOnlineInformations;
                        AccountManager.getInstance().setAccount(_loc_138.playerName, _loc_138.accountId, _loc_138.accountName);
                    }
                    if (!_loc_16.session)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemyAdded, true);
                        _loc_141 = new EnemyWrapper(_loc_16.ignoreAdded);
                        this._enemiesList.push(_loc_141);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                    }
                    else
                    {
                        for each (_loc_142 in this._ignoredList)
                        {
                            
                            if (_loc_142.name == _loc_16.ignoreAdded.accountName)
                            {
                                return true;
                            }
                        }
                        this._ignoredList.push(new IgnoredWrapper(_loc_16.ignoreAdded.accountName, _loc_16.ignoreAdded.accountId));
                        KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredAdded);
                    }
                    return true;
                }
                case param1 is IgnoredAddFailureMessage:
                {
                    _loc_17 = param1 as IgnoredAddFailureMessage;
                    switch(_loc_17.reason)
                    {
                        case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                        {
                            _loc_18 = I18n.getUiText("ui.common.unknowReason");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                        {
                            _loc_18 = I18n.getUiText("ui.social.friend.addFailureListFull");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                        {
                            _loc_18 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                        {
                            _loc_18 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                        {
                            _loc_18 = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_18, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is RemoveFriendAction:
                {
                    _loc_19 = param1 as RemoveFriendAction;
                    _loc_20 = new FriendDeleteRequestMessage();
                    _loc_20.initFriendDeleteRequestMessage(_loc_19.name);
                    ConnectionsHandler.getConnection().send(_loc_20);
                    return true;
                }
                case param1 is FriendDeleteResultMessage:
                {
                    _loc_21 = param1 as FriendDeleteResultMessage;
                    _loc_22 = I18n.getUiText("ui.social.friend.delete");
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendRemoved, _loc_21.success);
                    if (_loc_21.success)
                    {
                        for (_loc_143 in this._friendsList)
                        {
                            
                            if (this._friendsList[_loc_143].name == _loc_21.name)
                            {
                                this._friendsList.splice(_loc_143, 1);
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_22, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is FriendUpdateMessage:
                {
                    _loc_23 = param1 as FriendUpdateMessage;
                    _loc_24 = new FriendWrapper(_loc_23.friendUpdated);
                    for each (_loc_144 in this._friendsList)
                    {
                        
                        if (_loc_144.name == _loc_24.name)
                        {
                            _loc_144 = _loc_24;
                            break;
                        }
                    }
                    _loc_25 = _loc_24.state == PlayerStateEnum.GAME_TYPE_ROLEPLAY || _loc_24.state == PlayerStateEnum.GAME_TYPE_FIGHT;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    if (AirScanner.hasAir() && ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.FRIEND_CONNECTION) && this._warnOnFrienConnec && _loc_24.online && !_loc_25)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.FRIEND_CONNECTION, [_loc_24.name, _loc_24.playerName]);
                    }
                    return true;
                }
                case param1 is RemoveEnemyAction:
                {
                    _loc_26 = param1 as RemoveEnemyAction;
                    _loc_27 = new IgnoredDeleteRequestMessage();
                    _loc_27.initIgnoredDeleteRequestMessage(_loc_26.name);
                    ConnectionsHandler.getConnection().send(_loc_27);
                    return true;
                }
                case param1 is IgnoredDeleteResultMessage:
                {
                    _loc_28 = param1 as IgnoredDeleteResultMessage;
                    if (!_loc_28.session)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemyRemoved, _loc_28.success);
                        if (_loc_28.success)
                        {
                            for (_loc_145 in this._enemiesList)
                            {
                                
                                if (this._enemiesList[_loc_145].name == _loc_28.name)
                                {
                                    this._enemiesList.splice(_loc_145, 1);
                                }
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                    }
                    else if (_loc_28.success)
                    {
                        for (_loc_146 in this._ignoredList)
                        {
                            
                            if (this._ignoredList[_loc_146].name == _loc_28.name)
                            {
                                this._ignoredList.splice(_loc_146, 1);
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredRemoved);
                    }
                    return true;
                }
                case param1 is AddIgnoredAction:
                {
                    _loc_29 = param1 as AddIgnoredAction;
                    if (_loc_29.name.length < 2 || _loc_29.name.length > 20)
                    {
                        _loc_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else if (_loc_29.name != PlayedCharacterManager.getInstance().infos.name)
                    {
                        for each (_loc_147 in this._ignoredList)
                        {
                            
                            _log.debug(" " + _loc_147.playerName + " == " + _loc_29.name);
                            if (_loc_147.playerName == _loc_29.name)
                            {
                                return true;
                            }
                        }
                        _loc_148 = new IgnoredAddRequestMessage();
                        _loc_148.initIgnoredAddRequestMessage(_loc_29.name, true);
                        ConnectionsHandler.getConnection().send(_loc_148);
                    }
                    else
                    {
                        _loc_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is RemoveIgnoredAction:
                {
                    _loc_30 = param1 as RemoveIgnoredAction;
                    _loc_31 = new IgnoredDeleteRequestMessage();
                    _loc_31.initIgnoredDeleteRequestMessage(_loc_30.name, true);
                    ConnectionsHandler.getConnection().send(_loc_31);
                    return true;
                }
                case param1 is JoinFriendAction:
                {
                    _loc_32 = param1 as JoinFriendAction;
                    _loc_33 = new FriendJoinRequestMessage();
                    _loc_33.initFriendJoinRequestMessage(_loc_32.name);
                    ConnectionsHandler.getConnection().send(_loc_33);
                    return true;
                }
                case param1 is JoinSpouseAction:
                {
                    _loc_34 = param1 as JoinSpouseAction;
                    ConnectionsHandler.getConnection().send(new FriendSpouseJoinRequestMessage());
                    return true;
                }
                case param1 is FriendSpouseFollowAction:
                {
                    _loc_35 = param1 as FriendSpouseFollowAction;
                    _loc_36 = new FriendSpouseFollowWithCompassRequestMessage();
                    _loc_36.initFriendSpouseFollowWithCompassRequestMessage(_loc_35.enable);
                    ConnectionsHandler.getConnection().send(_loc_36);
                    return true;
                }
                case param1 is FriendWarningSetAction:
                {
                    _loc_37 = param1 as FriendWarningSetAction;
                    this._warnOnFrienConnec = _loc_37.enable;
                    _loc_38 = new FriendSetWarnOnConnectionMessage();
                    _loc_38.initFriendSetWarnOnConnectionMessage(_loc_37.enable);
                    ConnectionsHandler.getConnection().send(_loc_38);
                    return true;
                }
                case param1 is MemberWarningSetAction:
                {
                    _loc_39 = param1 as MemberWarningSetAction;
                    this._warnOnMemberConnec = _loc_39.enable;
                    _loc_40 = new GuildMemberSetWarnOnConnectionMessage();
                    _loc_40.initGuildMemberSetWarnOnConnectionMessage(_loc_39.enable);
                    ConnectionsHandler.getConnection().send(_loc_40);
                    return true;
                }
                case param1 is FriendOrGuildMemberLevelUpWarningSetAction:
                {
                    _loc_41 = param1 as FriendOrGuildMemberLevelUpWarningSetAction;
                    this._warnWhenFriendOrGuildMemberLvlUp = _loc_41.enable;
                    _loc_42 = new FriendSetWarnOnLevelGainMessage();
                    _loc_42.initFriendSetWarnOnLevelGainMessage(_loc_41.enable);
                    ConnectionsHandler.getConnection().send(_loc_42);
                    return true;
                }
                case param1 is FriendGuildSetWarnOnAchievementCompleteAction:
                {
                    _loc_43 = param1 as FriendGuildSetWarnOnAchievementCompleteAction;
                    this._warnWhenFriendOrGuildMemberAchieve = _loc_43.enable;
                    _loc_44 = new FriendGuildSetWarnOnAchievementCompleteMessage();
                    _loc_44.initFriendGuildSetWarnOnAchievementCompleteMessage(_loc_43.enable);
                    ConnectionsHandler.getConnection().send(_loc_44);
                    return true;
                }
                case param1 is SpouseStatusMessage:
                {
                    _loc_45 = param1 as SpouseStatusMessage;
                    this._hasSpouse = _loc_45.hasSpouse;
                    if (!this._hasSpouse)
                    {
                        this._spouse = null;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, false);
                        KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_SPOUSE);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
                    return true;
                }
                case param1 is FriendWarnOnConnectionStateMessage:
                {
                    _loc_46 = param1 as FriendWarnOnConnectionStateMessage;
                    this._warnOnFrienConnec = _loc_46.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendWarningState, _loc_46.enable);
                    return true;
                }
                case param1 is GuildMemberWarnOnConnectionStateMessage:
                {
                    _loc_47 = param1 as GuildMemberWarnOnConnectionStateMessage;
                    this._warnOnMemberConnec = _loc_47.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.MemberWarningState, _loc_47.enable);
                    return true;
                }
                case param1 is GuildMemberOnlineStatusMessage:
                {
                    if (!this._friendsList)
                    {
                        return true;
                    }
                    _loc_48 = param1 as GuildMemberOnlineStatusMessage;
                    if (AirScanner.hasAir() && ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.MEMBER_CONNECTION) && this._warnOnMemberConnec && _loc_48.online)
                    {
                        for each (_loc_150 in this._guildMembers)
                        {
                            
                            if (_loc_150.id == _loc_48.memberId)
                            {
                                _loc_149 = _loc_150.name;
                                break;
                            }
                        }
                        _loc_151 = false;
                        for each (_loc_152 in this._friendsList)
                        {
                            
                            if (_loc_152.name == _loc_149)
                            {
                                _loc_151 = true;
                                break;
                            }
                        }
                        if (!(_loc_151 && !ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.FRIEND_CONNECTION)))
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.MEMBER_CONNECTION, [_loc_149]);
                        }
                    }
                    return true;
                }
                case param1 is FriendWarnOnLevelGainStateMessage:
                {
                    _loc_49 = param1 as FriendWarnOnLevelGainStateMessage;
                    this._warnWhenFriendOrGuildMemberLvlUp = _loc_49.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendOrGuildMemberLevelUpWarningState, _loc_49.enable);
                    return true;
                }
                case param1 is FriendGuildWarnOnAchievementCompleteStateMessage:
                {
                    _loc_50 = param1 as FriendGuildWarnOnAchievementCompleteStateMessage;
                    this._warnWhenFriendOrGuildMemberAchieve = _loc_50.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendGuildWarnOnAchievementCompleteState, _loc_50.enable);
                    return true;
                }
                case param1 is GuildInformationsMembersMessage:
                {
                    _loc_51 = param1 as GuildInformationsMembersMessage;
                    for each (_loc_153 in _loc_51.members)
                    {
                        
                        ChatAutocompleteNameManager.getInstance().addEntry(_loc_153.name, 2);
                    }
                    this._guildMembers = _loc_51.members;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    return true;
                }
                case param1 is GuildHousesInformationMessage:
                {
                    _loc_52 = param1 as GuildHousesInformationMessage;
                    this._guildHouses = new Vector.<GuildHouseWrapper>;
                    for each (_loc_154 in _loc_52.housesInformations)
                    {
                        
                        _loc_155 = GuildHouseWrapper.create(_loc_154);
                        this._guildHouses.push(_loc_155);
                    }
                    this._guildHousesList = true;
                    this._guildHousesListUpdate = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                    return true;
                }
                case param1 is GuildCreationStartedMessage:
                {
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted, false, false);
                    return true;
                }
                case param1 is GuildModificationStartedMessage:
                {
                    _loc_53 = param1 as GuildModificationStartedMessage;
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted, _loc_53.canChangeName, _loc_53.canChangeEmblem);
                    return true;
                }
                case param1 is GuildCreationResultMessage:
                {
                    _loc_54 = param1 as GuildCreationResultMessage;
                    switch(_loc_54.result)
                    {
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_ALREADY_IN_GUILD:
                        {
                            _loc_55 = I18n.getUiText("ui.guild.alreadyInGuild");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_CANCEL:
                        {
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                        {
                            _loc_55 = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_LEAVE:
                        {
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_NAME_ALREADY_EXISTS:
                        {
                            _loc_55 = I18n.getUiText("ui.guild.AlreadyUseName");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_NAME_INVALID:
                        {
                            _loc_55 = I18n.getUiText("ui.guild.invalidName");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_REQUIREMENT_UNMET:
                        {
                            _loc_55 = I18n.getUiText("ui.guild.requirementUnmet");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_OK:
                        {
                            Kernel.getWorker().removeFrame(this._guildDialogFrame);
                            this._hasGuild = true;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_55)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_55, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationResult, _loc_54.result);
                    return true;
                }
                case param1 is GuildInvitedMessage:
                {
                    _loc_56 = param1 as GuildInvitedMessage;
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvited, _loc_56.guildInfo.guildName, _loc_56.recruterId, _loc_56.recruterName);
                    return true;
                }
                case param1 is GuildInvitationStateRecruterMessage:
                {
                    _loc_57 = param1 as GuildInvitationStateRecruterMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruter, _loc_57.invitationState, _loc_57.recrutedName);
                    if (_loc_57.invitationState == 2 || _loc_57.invitationState == 3)
                    {
                        Kernel.getWorker().removeFrame(this._guildDialogFrame);
                    }
                    return true;
                }
                case param1 is GuildInvitationStateRecrutedMessage:
                {
                    _loc_58 = param1 as GuildInvitationStateRecrutedMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruted, _loc_58.invitationState);
                    return true;
                }
                case param1 is GuildJoinedMessage:
                {
                    _loc_59 = param1 as GuildJoinedMessage;
                    this._hasGuild = true;
                    this._guild = GuildWrapper.create(_loc_59.guildInfo.guildId, _loc_59.guildInfo.guildName, _loc_59.guildInfo.guildEmblem, _loc_59.memberRights, _loc_59.enabled);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildJoined, _loc_59.guildInfo.guildEmblem, _loc_59.guildInfo.guildName, _loc_59.memberRights);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, true);
                    _loc_60 = I18n.getUiText("ui.guild.JoinGuildMessage", [_loc_59.guildInfo.guildName]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_60, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is GuildUIOpenedMessage:
                {
                    _loc_61 = param1 as GuildUIOpenedMessage;
                    if (this._guild != null)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildUIOpened, _loc_61.type);
                    }
                    return true;
                }
                case param1 is GuildInformationsGeneralMessage:
                {
                    _loc_62 = param1 as GuildInformationsGeneralMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsGeneral, _loc_62.enabled, _loc_62.expLevelFloor, _loc_62.experience, _loc_62.expNextLevelFloor, _loc_62.level, _loc_62.creationDate, _loc_62.abandonnedPaddock);
                    this._guild.level = _loc_62.level;
                    this._guild.experience = _loc_62.experience;
                    this._guild.expLevelFloor = _loc_62.expLevelFloor;
                    this._guild.expNextLevelFloor = _loc_62.expNextLevelFloor;
                    this._guild.creationDate = _loc_62.creationDate;
                    return true;
                }
                case param1 is GuildInformationsMemberUpdateMessage:
                {
                    _loc_63 = param1 as GuildInformationsMemberUpdateMessage;
                    if (this._guildMembers != null)
                    {
                        _loc_156 = this._guildMembers.length;
                        _loc_157 = 0;
                        while (_loc_157 < _loc_156)
                        {
                            
                            _loc_64 = this._guildMembers[_loc_157];
                            if (_loc_64.id == _loc_63.member.id)
                            {
                                this._guildMembers[_loc_157] = _loc_63.member;
                                if (_loc_64.id == PlayedCharacterManager.getInstance().id)
                                {
                                    this.guild.memberRightsNumber = _loc_63.member.rights;
                                }
                                break;
                            }
                            _loc_157++;
                        }
                    }
                    else
                    {
                        this._guildMembers = new Vector.<GuildMember>;
                        _loc_64 = _loc_63.member;
                        this._guildMembers.push(_loc_64);
                        if (_loc_64.id == PlayedCharacterManager.getInstance().id)
                        {
                            this.guild.memberRightsNumber = _loc_64.rights;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate, _loc_63.member);
                    return true;
                }
                case param1 is GuildMemberLeavingMessage:
                {
                    _loc_65 = param1 as GuildMemberLeavingMessage;
                    _loc_66 = 0;
                    for each (_loc_158 in this._guildMembers)
                    {
                        
                        if (_loc_65.memberId == _loc_158.id)
                        {
                            this._guildMembers.splice(_loc_66, 1);
                        }
                        _loc_66 = _loc_66 + 1;
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMemberLeaving, _loc_65.kicked, _loc_65.memberId);
                    return true;
                }
                case param1 is GuildLeftMessage:
                {
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildLeft);
                    this._hasGuild = false;
                    this._guild = null;
                    this._guildHousesList = false;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, false);
                    return true;
                }
                case param1 is GuildInfosUpgradeMessage:
                {
                    _loc_67 = param1 as GuildInfosUpgradeMessage;
                    TaxCollectorsManager.getInstance().updateGuild(_loc_67.maxTaxCollectorsCount, _loc_67.taxCollectorsCount, _loc_67.taxCollectorLifePoints, _loc_67.taxCollectorDamagesBonuses, _loc_67.taxCollectorPods, _loc_67.taxCollectorProspecting, _loc_67.taxCollectorWisdom);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInfosUpgrade, _loc_67.boostPoints, _loc_67.maxTaxCollectorsCount, _loc_67.spellId, _loc_67.spellLevel, _loc_67.taxCollectorDamagesBonuses, _loc_67.taxCollectorLifePoints, _loc_67.taxCollectorPods, _loc_67.taxCollectorProspecting, _loc_67.taxCollectorsCount, _loc_67.taxCollectorWisdom);
                    return true;
                }
                case param1 is GuildFightPlayersHelpersJoinMessage:
                {
                    _loc_68 = param1 as GuildFightPlayersHelpersJoinMessage;
                    TaxCollectorsManager.getInstance().addFighter(_loc_68.fightId, _loc_68.playerInfo, true);
                    return true;
                }
                case param1 is GuildFightPlayersHelpersLeaveMessage:
                {
                    _loc_69 = param1 as GuildFightPlayersHelpersLeaveMessage;
                    if (this._autoLeaveHelpers)
                    {
                        _loc_159 = I18n.getUiText("ui.social.guild.autoFightLeave");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_159, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    TaxCollectorsManager.getInstance().removeFighter(_loc_69.fightId, _loc_69.playerId, true);
                    return true;
                }
                case param1 is GuildFightPlayersEnemiesListMessage:
                {
                    _loc_70 = param1 as GuildFightPlayersEnemiesListMessage;
                    for each (_loc_160 in _loc_70.playerInfo)
                    {
                        
                        TaxCollectorsManager.getInstance().addFighter(_loc_70.fightId, _loc_160, false, false);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, _loc_70.fightId);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorUpdate, _loc_70.fightId);
                    return true;
                }
                case param1 is GuildFightPlayersEnemyRemoveMessage:
                {
                    _loc_71 = param1 as GuildFightPlayersEnemyRemoveMessage;
                    TaxCollectorsManager.getInstance().removeFighter(_loc_71.fightId, _loc_71.playerId, false);
                    return true;
                }
                case param1 is TaxCollectorMovementMessage:
                {
                    _loc_72 = param1 as TaxCollectorMovementMessage;
                    _loc_74 = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_72.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_72.basicInfos.lastNameId).name;
                    _loc_75 = new WorldPointWrapper(_loc_72.basicInfos.mapId, true, _loc_72.basicInfos.worldX, _loc_72.basicInfos.worldY);
                    _loc_76 = String(_loc_75.outdoorX);
                    _loc_77 = String(_loc_75.outdoorY);
                    _loc_78 = _loc_76 + "," + _loc_77;
                    switch(_loc_72.hireOrFire)
                    {
                        case true:
                        {
                            _loc_73 = I18n.getUiText("ui.social.TaxCollectorAdded", [_loc_74, _loc_78, _loc_72.playerName]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_73, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                            break;
                        }
                        case false:
                        {
                            _loc_73 = I18n.getUiText("ui.social.TaxCollectorRemoved", [_loc_74, _loc_78, _loc_72.playerName]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_73, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is TaxCollectorAttackedMessage:
                {
                    _loc_79 = param1 as TaxCollectorAttackedMessage;
                    _loc_80 = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_79.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_79.lastNameId).name;
                    _loc_81 = I18n.getUiText("ui.social.TaxCollectorAttacked", [_loc_80, _loc_79.worldX + "," + _loc_79.worldY]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, "{openSocial,1,2::" + _loc_81 + "}", ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                    if (AirScanner.hasAir() && ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK, [_loc_80, _loc_79.worldX, _loc_79.worldY]);
                    }
                    return true;
                }
                case param1 is TaxCollectorAttackedResultMessage:
                {
                    _loc_82 = param1 as TaxCollectorAttackedResultMessage;
                    _loc_84 = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_82.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_82.basicInfos.lastNameId).name;
                    _loc_85 = new WorldPointWrapper(_loc_82.basicInfos.mapId, true, _loc_82.basicInfos.worldX, _loc_82.basicInfos.worldY);
                    _loc_86 = _loc_85.outdoorX;
                    _loc_87 = _loc_85.outdoorY;
                    if (_loc_82.deadOrAlive)
                    {
                        _loc_83 = I18n.getUiText("ui.social.TaxCollectorDied", [_loc_84, _loc_86 + "," + _loc_87]);
                    }
                    else
                    {
                        _loc_83 = I18n.getUiText("ui.social.TaxCollectorSurvived", [_loc_84, _loc_86 + "," + _loc_87]);
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_83, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is TaxCollectorErrorMessage:
                {
                    _loc_88 = param1 as TaxCollectorErrorMessage;
                    _loc_89 = "";
                    switch(_loc_88.reason)
                    {
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ALREADY_ONE:
                        {
                            _loc_89 = I18n.getUiText("ui.social.alreadyTaxCollectorOnMap");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_HERE:
                        {
                            _loc_89 = I18n.getUiText("ui.social.cantHireTaxCollecotrHere");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_YET:
                        {
                            _loc_89 = I18n.getUiText("ui.social.cantHireTaxcollectorTooTired");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ERROR_UNKNOWN:
                        {
                            _loc_89 = I18n.getUiText("ui.social.unknownErrorTaxCollector");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_MAX_REACHED:
                        {
                            _loc_89 = I18n.getUiText("ui.social.cantHireMaxTaxCollector");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NO_RIGHTS:
                        {
                            _loc_89 = I18n.getUiText("ui.social.taxCollectorNoRights");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_ENOUGH_KAMAS:
                        {
                            _loc_89 = I18n.getUiText("ui.social.notEnougthRichToHireTaxCollector");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_FOUND:
                        {
                            _loc_89 = I18n.getUiText("ui.social.taxCollectorNotFound");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_OWNED:
                        {
                            _loc_89 = I18n.getUiText("ui.social.notYourTaxcollector");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_89, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is TaxCollectorListMessage:
                {
                    _loc_90 = param1 as TaxCollectorListMessage;
                    TaxCollectorsManager.getInstance().taxCollectorHireCost = _loc_90.taxCollectorHireCost;
                    TaxCollectorsManager.getInstance().maxTaxCollectorsCount = _loc_90.nbcollectorMax;
                    TaxCollectorsManager.getInstance().setTaxCollectors(_loc_90.informations);
                    TaxCollectorsManager.getInstance().setTaxCollectorsFighters(_loc_90.fightersInformations);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorListUpdate);
                    return true;
                }
                case param1 is TaxCollectorMovementAddMessage:
                {
                    _loc_91 = param1 as TaxCollectorMovementAddMessage;
                    _loc_92 = TaxCollectorsManager.getInstance().addTaxCollector(_loc_91.informations);
                    if (_loc_92 || TaxCollectorsManager.getInstance().taxCollectors[_loc_91.informations.uniqueId].state != 1)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorUpdate, _loc_91.informations.uniqueId);
                    }
                    if (_loc_92)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorAdd, _loc_91.informations);
                    }
                    return true;
                }
                case param1 is TaxCollectorMovementRemoveMessage:
                {
                    _loc_93 = param1 as TaxCollectorMovementRemoveMessage;
                    delete TaxCollectorsManager.getInstance().taxCollectors[_loc_93.collectorId];
                    delete TaxCollectorsManager.getInstance().taxCollectorsFighters[_loc_93.collectorId];
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorRemoved, _loc_93.collectorId);
                    return true;
                }
                case param1 is GuildInformationsPaddocksMessage:
                {
                    _loc_94 = param1 as GuildInformationsPaddocksMessage;
                    this._guildPaddocksMax = _loc_94.nbPaddockMax;
                    this._guildPaddocks = _loc_94.paddocksInformations;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsFarms);
                    return true;
                }
                case param1 is GuildPaddockBoughtMessage:
                {
                    _loc_95 = param1 as GuildPaddockBoughtMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockAdd, _loc_95.paddockInfo);
                    return true;
                }
                case param1 is GuildPaddockRemovedMessage:
                {
                    _loc_96 = param1 as GuildPaddockRemovedMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockRemoved, _loc_96.paddockId);
                    return true;
                }
                case param1 is TaxCollectorDialogQuestionExtendedMessage:
                {
                    _loc_97 = param1 as TaxCollectorDialogQuestionExtendedMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionExtended, _loc_97.guildInfo.guildName, _loc_97.maxPods, _loc_97.prospecting, _loc_97.wisdom, _loc_97.taxCollectorsCount, _loc_97.taxCollectorAttack, _loc_97.kamas, _loc_97.experience, _loc_97.pods, _loc_97.itemsValue);
                    return true;
                }
                case param1 is TaxCollectorDialogQuestionBasicMessage:
                {
                    _loc_98 = param1 as TaxCollectorDialogQuestionBasicMessage;
                    _loc_99 = GuildWrapper.create(0, _loc_98.guildInfo.guildName, null, 0, true);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionBasic, _loc_99.guildName);
                    return true;
                }
                case param1 is ContactLookMessage:
                {
                    _loc_100 = param1 as ContactLookMessage;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, _loc_100.playerId, _loc_100.playerName, EntityLookAdapter.fromNetwork(_loc_100.look));
                    return true;
                }
                case param1 is GuildGetInformationsAction:
                {
                    _loc_101 = param1 as GuildGetInformationsAction;
                    _loc_102 = true;
                    switch(_loc_101.infoType)
                    {
                        case GuildInformationsTypeEnum.INFO_MEMBERS:
                        {
                            break;
                        }
                        case GuildInformationsTypeEnum.INFO_TAX_COLLECTOR:
                        {
                            break;
                        }
                        case GuildInformationsTypeEnum.INFO_HOUSES:
                        {
                            if (this._guildHousesList)
                            {
                                _loc_102 = false;
                                if (this._guildHousesListUpdate)
                                {
                                    this._guildHousesListUpdate = false;
                                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                                }
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_102)
                    {
                        _loc_161 = new GuildGetInformationsMessage();
                        _loc_161.initGuildGetInformationsMessage(_loc_101.infoType);
                        ConnectionsHandler.getConnection().send(_loc_161);
                    }
                    return true;
                }
                case param1 is GuildInvitationAction:
                {
                    _loc_103 = param1 as GuildInvitationAction;
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    _loc_104 = new GuildInvitationMessage();
                    _loc_104.initGuildInvitationMessage(_loc_103.targetId);
                    ConnectionsHandler.getConnection().send(_loc_104);
                    return true;
                }
                case param1 is GuildInvitationByNameAction:
                {
                    _loc_105 = param1 as GuildInvitationByNameAction;
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    _loc_106 = new GuildInvitationByNameMessage();
                    _loc_106.initGuildInvitationByNameMessage(_loc_105.target);
                    ConnectionsHandler.getConnection().send(_loc_106);
                    return true;
                }
                case param1 is GuildKickRequestAction:
                {
                    _loc_107 = param1 as GuildKickRequestAction;
                    _loc_108 = new GuildKickRequestMessage();
                    _loc_108.initGuildKickRequestMessage(_loc_107.targetId);
                    ConnectionsHandler.getConnection().send(_loc_108);
                    return true;
                }
                case param1 is GuildChangeMemberParametersAction:
                {
                    _loc_109 = param1 as GuildChangeMemberParametersAction;
                    _loc_110 = GuildWrapper.getRightsNumber(_loc_109.rights);
                    _loc_111 = new GuildChangeMemberParametersMessage();
                    _loc_111.initGuildChangeMemberParametersMessage(_loc_109.memberId, _loc_109.rank, _loc_109.experienceGivenPercent, _loc_110);
                    ConnectionsHandler.getConnection().send(_loc_111);
                    return true;
                }
                case param1 is GuildSpellUpgradeRequestAction:
                {
                    _loc_112 = param1 as GuildSpellUpgradeRequestAction;
                    _loc_113 = new GuildSpellUpgradeRequestMessage();
                    _loc_113.initGuildSpellUpgradeRequestMessage(_loc_112.spellId);
                    ConnectionsHandler.getConnection().send(_loc_113);
                    return true;
                }
                case param1 is GuildCharacsUpgradeRequestAction:
                {
                    _loc_114 = param1 as GuildCharacsUpgradeRequestAction;
                    _loc_115 = new GuildCharacsUpgradeRequestMessage();
                    _loc_115.initGuildCharacsUpgradeRequestMessage(_loc_114.charaTypeTarget);
                    ConnectionsHandler.getConnection().send(_loc_115);
                    return true;
                }
                case param1 is GuildFarmTeleportRequestAction:
                {
                    _loc_116 = param1 as GuildFarmTeleportRequestAction;
                    _loc_117 = new GuildPaddockTeleportRequestMessage();
                    _loc_117.initGuildPaddockTeleportRequestMessage(_loc_116.farmId);
                    ConnectionsHandler.getConnection().send(_loc_117);
                    return true;
                }
                case param1 is GuildHouseTeleportRequestAction:
                {
                    _loc_118 = param1 as GuildHouseTeleportRequestAction;
                    _loc_119 = new GuildHouseTeleportRequestMessage();
                    _loc_119.initGuildHouseTeleportRequestMessage(_loc_118.houseId);
                    ConnectionsHandler.getConnection().send(_loc_119);
                    return true;
                }
                case param1 is GuildFightJoinRequestAction:
                {
                    _loc_120 = param1 as GuildFightJoinRequestAction;
                    _loc_121 = new GuildFightJoinRequestMessage();
                    _loc_121.initGuildFightJoinRequestMessage(_loc_120.taxCollectorId);
                    ConnectionsHandler.getConnection().send(_loc_121);
                    return true;
                }
                case param1 is GuildFightTakePlaceRequestAction:
                {
                    _loc_122 = param1 as GuildFightTakePlaceRequestAction;
                    _loc_123 = new GuildFightTakePlaceRequestMessage();
                    _loc_123.initGuildFightTakePlaceRequestMessage(_loc_122.taxCollectorId, _loc_122.replacedCharacterId);
                    ConnectionsHandler.getConnection().send(_loc_123);
                    return true;
                }
                case param1 is GuildFightLeaveRequestAction:
                {
                    _loc_124 = param1 as GuildFightLeaveRequestAction;
                    this._autoLeaveHelpers = false;
                    if (_loc_124.warning)
                    {
                        for each (_loc_162 in TaxCollectorsManager.getInstance().taxCollectors)
                        {
                            
                            if (_loc_162.state == 1)
                            {
                                _loc_163 = TaxCollectorsManager.getInstance().taxCollectorsFighters[_loc_162.uniqueId];
                                for each (_loc_164 in _loc_163.allyCharactersInformations)
                                {
                                    
                                    if (_loc_164.playerCharactersInformations.id == _loc_124.characterId)
                                    {
                                        this._autoLeaveHelpers = true;
                                        _loc_125 = new GuildFightLeaveRequestMessage();
                                        _loc_125.initGuildFightLeaveRequestMessage(_loc_162.uniqueId, _loc_124.characterId);
                                        ConnectionsHandler.getConnection().send(_loc_125);
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        _loc_125 = new GuildFightLeaveRequestMessage();
                        _loc_125.initGuildFightLeaveRequestMessage(_loc_124.taxCollectorId, _loc_124.characterId);
                        ConnectionsHandler.getConnection().send(_loc_125);
                    }
                    return true;
                }
                case param1 is TaxCollectorHireRequestAction:
                {
                    _loc_126 = param1 as TaxCollectorHireRequestAction;
                    if (TaxCollectorsManager.getInstance().taxCollectorHireCost <= PlayedCharacterManager.getInstance().characteristics.kamas)
                    {
                        _loc_165 = new TaxCollectorHireRequestMessage();
                        _loc_165.initTaxCollectorHireRequestMessage();
                        ConnectionsHandler.getConnection().send(_loc_165);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.popup.not_enough_rich"), ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is GuildHouseUpdateInformationMessage:
                {
                    if (this._guildHousesList)
                    {
                        _loc_166 = param1 as GuildHouseUpdateInformationMessage;
                        _loc_167 = false;
                        for each (_loc_168 in this._guildHouses)
                        {
                            
                            if (_loc_168.houseId == _loc_166.housesInformations.houseId)
                            {
                                _loc_168.update(_loc_166.housesInformations);
                                _loc_167 = true;
                            }
                            KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                        }
                        if (!_loc_167)
                        {
                            _loc_169 = GuildHouseWrapper.create(_loc_166.housesInformations);
                            this._guildHouses.push(_loc_169);
                            KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseAdd, _loc_169);
                        }
                        this._guildHousesListUpdate = true;
                    }
                    return true;
                }
                case param1 is GuildHouseRemoveMessage:
                {
                    if (this._guildHousesList)
                    {
                        _loc_170 = param1 as GuildHouseRemoveMessage;
                        _loc_171 = false;
                        _loc_172 = 0;
                        while (_loc_172 < this._guildHouses.length)
                        {
                            
                            if (this._guildHouses[_loc_172].houseId == _loc_170.houseId)
                            {
                                this._guildHouses.splice(_loc_172, 1);
                                break;
                            }
                            _loc_172++;
                        }
                        this._guildHousesListUpdate = true;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseRemoved, _loc_170.houseId);
                    }
                    return true;
                }
                case param1 is CharacterReportAction:
                {
                    _loc_127 = param1 as CharacterReportAction;
                    _loc_128 = new CharacterReportMessage();
                    _loc_128.initCharacterReportMessage(_loc_127.reportedId, _loc_127.reason);
                    ConnectionsHandler.getConnection().send(_loc_128);
                    return true;
                }
                case param1 is ChatReportAction:
                {
                    _loc_129 = param1 as ChatReportAction;
                    _loc_130 = new ChatMessageReportMessage();
                    _loc_131 = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
                    _loc_132 = _loc_131.getTimestampServerByRealTimestamp(_loc_129.timestamp);
                    _loc_130.initChatMessageReportMessage(_loc_129.name, _loc_129.message, _loc_132, _loc_129.channel, _loc_129.fingerprint, _loc_129.reason);
                    ConnectionsHandler.getConnection().send(_loc_130);
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
            TaxCollectorsManager.getInstance().destroy();
            return true;
        }// end function

        public function isIgnored(param1:String, param2:int = 0) : Boolean
        {
            var _loc_3:* = AccountManager.getInstance().getAccountName(param1);
            return false;
        }// end function

        public function isFriend(param1:String) : Boolean
        {
            var _loc_4:* = null;
            var _loc_2:* = this._friendsList.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._friendsList[_loc_3];
                if (_loc_4.playerName == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function isEnemy(param1:String) : Boolean
        {
            var _loc_4:* = null;
            var _loc_2:* = this._enemiesList.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._enemiesList[_loc_3];
                if (_loc_4.playerName == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

    }
}
