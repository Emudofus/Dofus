package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
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
    import com.ankamagames.dofus.network.messages.game.chat.report.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.party.*;
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

        public function pushed() : Boolean
        {
            this._friendsList = new Array();
            this._enemiesList = new Array();
            this._ignoredList = new Array();
            this._guildDialogFrame = new GuildDialogFrame();
            ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
            ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:GuildMembershipMessage = null;
            var _loc_3:FriendsListMessage = null;
            var _loc_4:FriendsListWithSpouseMessage = null;
            var _loc_5:SpouseWrapper = null;
            var _loc_6:IgnoredListMessage = null;
            var _loc_7:OpenSocialAction = null;
            var _loc_8:FriendsListRequestAction = null;
            var _loc_9:EnemiesListRequestAction = null;
            var _loc_10:SpouseRequestAction = null;
            var _loc_11:AddFriendAction = null;
            var _loc_12:FriendAddedMessage = null;
            var _loc_13:FriendWrapper = null;
            var _loc_14:FriendAddFailureMessage = null;
            var _loc_15:String = null;
            var _loc_16:AddEnemyAction = null;
            var _loc_17:IgnoredAddedMessage = null;
            var _loc_18:IgnoredAddFailureMessage = null;
            var _loc_19:String = null;
            var _loc_20:RemoveFriendAction = null;
            var _loc_21:FriendDeleteRequestMessage = null;
            var _loc_22:FriendDeleteResultMessage = null;
            var _loc_23:String = null;
            var _loc_24:FriendUpdateMessage = null;
            var _loc_25:FriendWrapper = null;
            var _loc_26:RemoveEnemyAction = null;
            var _loc_27:IgnoredDeleteRequestMessage = null;
            var _loc_28:IgnoredDeleteResultMessage = null;
            var _loc_29:AddIgnoredAction = null;
            var _loc_30:RemoveIgnoredAction = null;
            var _loc_31:IgnoredDeleteRequestMessage = null;
            var _loc_32:JoinFriendAction = null;
            var _loc_33:FriendJoinRequestMessage = null;
            var _loc_34:JoinSpouseAction = null;
            var _loc_35:FriendSpouseFollowAction = null;
            var _loc_36:FriendSpouseFollowWithCompassRequestMessage = null;
            var _loc_37:FriendWarningSetAction = null;
            var _loc_38:FriendSetWarnOnConnectionMessage = null;
            var _loc_39:MemberWarningSetAction = null;
            var _loc_40:GuildMemberSetWarnOnConnectionMessage = null;
            var _loc_41:FriendOrGuildMemberLevelUpWarningSetAction = null;
            var _loc_42:FriendSetWarnOnLevelGainMessage = null;
            var _loc_43:SpouseStatusMessage = null;
            var _loc_44:FriendWarnOnConnectionStateMessage = null;
            var _loc_45:GuildMemberWarnOnConnectionStateMessage = null;
            var _loc_46:FriendWarnOnLevelGainStateMessage = null;
            var _loc_47:PartyFollowStatusUpdateMessage = null;
            var _loc_48:GuildInformationsMembersMessage = null;
            var _loc_49:GuildHousesInformationMessage = null;
            var _loc_50:GuildCreationResultMessage = null;
            var _loc_51:String = null;
            var _loc_52:GuildInvitedMessage = null;
            var _loc_53:GuildInvitationStateRecruterMessage = null;
            var _loc_54:GuildInvitationStateRecrutedMessage = null;
            var _loc_55:GuildJoinedMessage = null;
            var _loc_56:String = null;
            var _loc_57:GuildUIOpenedMessage = null;
            var _loc_58:GuildInformationsGeneralMessage = null;
            var _loc_59:GuildInformationsMemberUpdateMessage = null;
            var _loc_60:GuildMember = null;
            var _loc_61:GuildMemberLeavingMessage = null;
            var _loc_62:uint = 0;
            var _loc_63:GuildInfosUpgradeMessage = null;
            var _loc_64:GuildFightPlayersHelpersJoinMessage = null;
            var _loc_65:GuildFightPlayersHelpersLeaveMessage = null;
            var _loc_66:GuildFightPlayersEnemiesListMessage = null;
            var _loc_67:GuildFightPlayersEnemyRemoveMessage = null;
            var _loc_68:TaxCollectorMovementMessage = null;
            var _loc_69:String = null;
            var _loc_70:String = null;
            var _loc_71:WorldPointWrapper = null;
            var _loc_72:String = null;
            var _loc_73:String = null;
            var _loc_74:String = null;
            var _loc_75:TaxCollectorAttackedMessage = null;
            var _loc_76:String = null;
            var _loc_77:String = null;
            var _loc_78:TaxCollectorAttackedResultMessage = null;
            var _loc_79:String = null;
            var _loc_80:String = null;
            var _loc_81:WorldPointWrapper = null;
            var _loc_82:int = 0;
            var _loc_83:int = 0;
            var _loc_84:TaxCollectorErrorMessage = null;
            var _loc_85:String = null;
            var _loc_86:TaxCollectorListMessage = null;
            var _loc_87:TaxCollectorMovementAddMessage = null;
            var _loc_88:Boolean = false;
            var _loc_89:TaxCollectorMovementRemoveMessage = null;
            var _loc_90:GuildInformationsPaddocksMessage = null;
            var _loc_91:GuildPaddockBoughtMessage = null;
            var _loc_92:GuildPaddockRemovedMessage = null;
            var _loc_93:TaxCollectorDialogQuestionExtendedMessage = null;
            var _loc_94:TaxCollectorDialogQuestionBasicMessage = null;
            var _loc_95:GuildWrapper = null;
            var _loc_96:ContactLookMessage = null;
            var _loc_97:GuildGetInformationsAction = null;
            var _loc_98:Boolean = false;
            var _loc_99:GuildInvitationAction = null;
            var _loc_100:GuildInvitationMessage = null;
            var _loc_101:GuildInvitationByNameAction = null;
            var _loc_102:GuildInvitationByNameMessage = null;
            var _loc_103:GuildKickRequestAction = null;
            var _loc_104:GuildKickRequestMessage = null;
            var _loc_105:GuildChangeMemberParametersAction = null;
            var _loc_106:Number = NaN;
            var _loc_107:GuildChangeMemberParametersMessage = null;
            var _loc_108:GuildSpellUpgradeRequestAction = null;
            var _loc_109:GuildSpellUpgradeRequestMessage = null;
            var _loc_110:GuildCharacsUpgradeRequestAction = null;
            var _loc_111:GuildCharacsUpgradeRequestMessage = null;
            var _loc_112:GuildFarmTeleportRequestAction = null;
            var _loc_113:GuildPaddockTeleportRequestMessage = null;
            var _loc_114:GuildHouseTeleportRequestAction = null;
            var _loc_115:GuildHouseTeleportRequestMessage = null;
            var _loc_116:GuildFightJoinRequestAction = null;
            var _loc_117:GuildFightJoinRequestMessage = null;
            var _loc_118:GuildFightTakePlaceRequestAction = null;
            var _loc_119:GuildFightTakePlaceRequestMessage = null;
            var _loc_120:GuildFightLeaveRequestAction = null;
            var _loc_121:GuildFightLeaveRequestMessage = null;
            var _loc_122:TaxCollectorHireRequestAction = null;
            var _loc_123:TaxCollectorFireRequestAction = null;
            var _loc_124:TaxCollectorFireRequestMessage = null;
            var _loc_125:CharacterReportAction = null;
            var _loc_126:CharacterReportMessage = null;
            var _loc_127:ChatReportAction = null;
            var _loc_128:ChatMessageReportMessage = null;
            var _loc_129:ChatFrame = null;
            var _loc_130:uint = 0;
            var _loc_131:FriendInformations = null;
            var _loc_132:FriendWrapper = null;
            var _loc_133:FriendOnlineInformations = null;
            var _loc_134:FriendInformations = null;
            var _loc_135:FriendWrapper = null;
            var _loc_136:* = undefined;
            var _loc_137:EnemyWrapper = null;
            var _loc_138:IgnoredOnlineInformations = null;
            var _loc_139:FriendAddRequestMessage = null;
            var _loc_140:IgnoredAddRequestMessage = null;
            var _loc_141:EnemyWrapper = null;
            var _loc_142:* = undefined;
            var _loc_143:* = undefined;
            var _loc_144:* = undefined;
            var _loc_145:* = undefined;
            var _loc_146:* = undefined;
            var _loc_147:* = undefined;
            var _loc_148:IgnoredAddRequestMessage = null;
            var _loc_149:GuildMember = null;
            var _loc_150:HouseInformationsForGuild = null;
            var _loc_151:GuildHouseWrapper = null;
            var _loc_152:int = 0;
            var _loc_153:int = 0;
            var _loc_154:GuildMember = null;
            var _loc_155:String = null;
            var _loc_156:CharacterMinimalPlusLookInformations = null;
            var _loc_157:GuildGetInformationsMessage = null;
            var _loc_158:TaxCollectorWrapper = null;
            var _loc_159:TaxCollectorInFightWrapper = null;
            var _loc_160:TaxCollectorFightersWrapper = null;
            var _loc_161:TaxCollectorHireRequestMessage = null;
            var _loc_162:GuildHouseUpdateInformationMessage = null;
            var _loc_163:Boolean = false;
            var _loc_164:GuildHouseWrapper = null;
            var _loc_165:GuildHouseWrapper = null;
            var _loc_166:GuildHouseRemoveMessage = null;
            var _loc_167:Boolean = false;
            var _loc_168:int = 0;
            switch(true)
            {
                case param1 is GuildMembershipMessage:
                {
                    _loc_2 = param1 as GuildMembershipMessage;
                    if (this._guild != null)
                    {
                        this._guild.update(_loc_2.guildInfo.guildId, _loc_2.guildInfo.guildName, _loc_2.guildInfo.guildEmblem, _loc_2.memberRights);
                    }
                    else
                    {
                        this._guild = GuildWrapper.create(_loc_2.guildInfo.guildId, _loc_2.guildInfo.guildName, _loc_2.guildInfo.guildEmblem, _loc_2.memberRights);
                    }
                    this._hasGuild = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembership);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, true);
                    return true;
                }
                case param1 is FriendsListMessage && getQualifiedClassName(param1) == getQualifiedClassName(FriendsListMessage):
                {
                    _loc_3 = param1 as FriendsListMessage;
                    this._friendsList = new Array();
                    for each (_loc_131 in _loc_3.friendsList)
                    {
                        
                        if (_loc_131 is FriendOnlineInformations)
                        {
                            _loc_133 = _loc_131 as FriendOnlineInformations;
                            AccountManager.getInstance().setAccount(_loc_133.playerName, _loc_133.accountId, _loc_133.accountName);
                            ChatAutocompleteNameManager.getInstance().addEntry((_loc_131 as FriendOnlineInformations).playerName, 2);
                        }
                        _loc_132 = new FriendWrapper(_loc_131);
                        this._friendsList.push(_loc_132);
                    }
                    if (this._spouse)
                    {
                        this._spouse = null;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    return true;
                }
                case param1 is FriendsListWithSpouseMessage:
                {
                    this._friendsList = new Array();
                    _loc_4 = param1 as FriendsListWithSpouseMessage;
                    _loc_5 = new SpouseWrapper(_loc_4.spouse);
                    this._spouse = _loc_5;
                    for each (_loc_134 in _loc_4.friendsList)
                    {
                        
                        if (_loc_134 is FriendOnlineInformations)
                        {
                            ChatAutocompleteNameManager.getInstance().addEntry((_loc_134 as FriendOnlineInformations).playerName, 2);
                        }
                        _loc_135 = new FriendWrapper(_loc_134);
                        this._friendsList.push(_loc_135);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
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
                            _loc_138 = _loc_131 as IgnoredOnlineInformations;
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
                case param1 is SpouseRequestAction:
                {
                    _loc_10 = param1 as SpouseRequestAction;
                    ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
                    return true;
                }
                case param1 is AddFriendAction:
                {
                    _loc_11 = param1 as AddFriendAction;
                    if (_loc_11.name.length < 2 || _loc_11.name.length > 20)
                    {
                        _loc_15 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_15, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else if (_loc_11.name != PlayedCharacterManager.getInstance().infos.name)
                    {
                        _loc_139 = new FriendAddRequestMessage();
                        _loc_139.initFriendAddRequestMessage(_loc_11.name);
                        ConnectionsHandler.getConnection().send(_loc_139);
                    }
                    else
                    {
                        _loc_15 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_15, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is FriendAddedMessage:
                {
                    _loc_12 = param1 as FriendAddedMessage;
                    if (_loc_12.friendAdded is FriendOnlineInformations)
                    {
                        _loc_133 = _loc_12.friendAdded as FriendOnlineInformations;
                        AccountManager.getInstance().setAccount(_loc_133.playerName, _loc_133.accountId, _loc_133.accountName);
                        ChatAutocompleteNameManager.getInstance().addEntry((_loc_12.friendAdded as FriendInformations).accountName, 2);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendAdded, true);
                    _loc_13 = new FriendWrapper(_loc_12.friendAdded);
                    this._friendsList.push(_loc_13);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    return true;
                }
                case param1 is FriendAddFailureMessage:
                {
                    _loc_14 = param1 as FriendAddFailureMessage;
                    switch(_loc_14.reason)
                    {
                        case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                        {
                            _loc_15 = I18n.getUiText("ui.common.unknowReason");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                        {
                            _loc_15 = I18n.getUiText("ui.social.friend.addFailureListFull");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                        {
                            _loc_15 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                        {
                            _loc_15 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                        {
                            _loc_15 = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_15, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is AddEnemyAction:
                {
                    _loc_16 = param1 as AddEnemyAction;
                    if (_loc_16.name.length < 2 || _loc_16.name.length > 20)
                    {
                        _loc_15 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_15, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else if (_loc_16.name != PlayedCharacterManager.getInstance().infos.name)
                    {
                        _loc_140 = new IgnoredAddRequestMessage();
                        _loc_140.initIgnoredAddRequestMessage(_loc_16.name);
                        ConnectionsHandler.getConnection().send(_loc_140);
                    }
                    else
                    {
                        _loc_15 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_15, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is IgnoredAddedMessage:
                {
                    _loc_17 = param1 as IgnoredAddedMessage;
                    if (_loc_17.ignoreAdded is IgnoredOnlineInformations)
                    {
                        _loc_138 = _loc_17.ignoreAdded as IgnoredOnlineInformations;
                        AccountManager.getInstance().setAccount(_loc_138.playerName, _loc_138.accountId, _loc_138.accountName);
                    }
                    if (!_loc_17.session)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemyAdded, true);
                        _loc_141 = new EnemyWrapper(_loc_17.ignoreAdded);
                        this._enemiesList.push(_loc_141);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                    }
                    else
                    {
                        for each (_loc_142 in this._ignoredList)
                        {
                            
                            if (_loc_142.name == _loc_17.ignoreAdded.accountName)
                            {
                                return true;
                            }
                        }
                        this._ignoredList.push(new IgnoredWrapper(_loc_17.ignoreAdded.accountName, _loc_17.ignoreAdded.accountId));
                        KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredAdded);
                    }
                    return true;
                }
                case param1 is IgnoredAddFailureMessage:
                {
                    _loc_18 = param1 as IgnoredAddFailureMessage;
                    switch(_loc_18.reason)
                    {
                        case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                        {
                            _loc_19 = I18n.getUiText("ui.common.unknowReason");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                        {
                            _loc_19 = I18n.getUiText("ui.social.friend.addFailureListFull");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                        {
                            _loc_19 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                        {
                            _loc_19 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            break;
                        }
                        case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                        {
                            _loc_19 = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_19, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is RemoveFriendAction:
                {
                    _loc_20 = param1 as RemoveFriendAction;
                    _loc_21 = new FriendDeleteRequestMessage();
                    _loc_21.initFriendDeleteRequestMessage(_loc_20.name);
                    ConnectionsHandler.getConnection().send(_loc_21);
                    return true;
                }
                case param1 is FriendDeleteResultMessage:
                {
                    _loc_22 = param1 as FriendDeleteResultMessage;
                    _loc_23 = I18n.getUiText("ui.social.friend.delete");
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendRemoved, _loc_22.success);
                    if (_loc_22.success)
                    {
                        for (_loc_143 in this._friendsList)
                        {
                            
                            if (this._friendsList[_loc_143].name == _loc_22.name)
                            {
                                this._friendsList.splice(_loc_143, 1);
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_23, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is FriendUpdateMessage:
                {
                    _loc_24 = param1 as FriendUpdateMessage;
                    _loc_25 = new FriendWrapper(_loc_24.friendUpdated);
                    for each (_loc_144 in this._friendsList)
                    {
                        
                        if (_loc_144.name == _loc_25.name)
                        {
                            _loc_144 = _loc_25;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
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
                        _loc_15 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_15, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
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
                        _loc_15 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_15, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
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
                case param1 is SpouseStatusMessage:
                {
                    _loc_43 = param1 as SpouseStatusMessage;
                    this._hasSpouse = _loc_43.hasSpouse;
                    if (!this._hasSpouse)
                    {
                        this._spouse = null;
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
                    return true;
                }
                case param1 is FriendWarnOnConnectionStateMessage:
                {
                    _loc_44 = param1 as FriendWarnOnConnectionStateMessage;
                    this._warnOnFrienConnec = _loc_44.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendWarningState, _loc_44.enable);
                    return true;
                }
                case param1 is GuildMemberWarnOnConnectionStateMessage:
                {
                    _loc_45 = param1 as GuildMemberWarnOnConnectionStateMessage;
                    this._warnOnMemberConnec = _loc_45.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.MemberWarningState, _loc_45.enable);
                    return true;
                }
                case param1 is FriendWarnOnLevelGainStateMessage:
                {
                    _loc_46 = param1 as FriendWarnOnLevelGainStateMessage;
                    this._warnWhenFriendOrGuildMemberLvlUp = _loc_46.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendOrGuildMemberLevelUpWarningState, _loc_46.enable);
                    return true;
                }
                case param1 is PartyFollowStatusUpdateMessage:
                {
                    _loc_47 = param1 as PartyFollowStatusUpdateMessage;
                    if (_loc_47.success)
                    {
                        if (_loc_47.followedId == 0)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_PARTY + "_" + PlayedCharacterManager.getInstance().followingPlayerId);
                            PlayedCharacterManager.getInstance().followingPlayerId = -1;
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().followingPlayerId = _loc_47.followedId;
                        }
                    }
                    return true;
                }
                case param1 is GuildInformationsMembersMessage:
                {
                    _loc_48 = param1 as GuildInformationsMembersMessage;
                    for each (_loc_149 in _loc_48.members)
                    {
                        
                        ChatAutocompleteNameManager.getInstance().addEntry(_loc_149.name, 2);
                    }
                    this._guildMembers = _loc_48.members;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    return true;
                }
                case param1 is GuildHousesInformationMessage:
                {
                    _loc_49 = param1 as GuildHousesInformationMessage;
                    this._guildHouses = new Vector.<GuildHouseWrapper>;
                    for each (_loc_150 in _loc_49.housesInformations)
                    {
                        
                        _loc_151 = GuildHouseWrapper.create(_loc_150);
                        this._guildHouses.push(_loc_151);
                    }
                    this._guildHousesList = true;
                    this._guildHousesListUpdate = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                    return true;
                }
                case param1 is GuildCreationStartedMessage:
                {
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted);
                    return true;
                }
                case param1 is GuildCreationResultMessage:
                {
                    _loc_50 = param1 as GuildCreationResultMessage;
                    switch(_loc_50.result)
                    {
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_ALREADY_IN_GUILD:
                        {
                            _loc_51 = I18n.getUiText("ui.guild.alreadyInGuild");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_CANCEL:
                        {
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                        {
                            _loc_51 = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_LEAVE:
                        {
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_NAME_ALREADY_EXISTS:
                        {
                            _loc_51 = I18n.getUiText("ui.guild.AlreadyUseName");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_NAME_INVALID:
                        {
                            _loc_51 = I18n.getUiText("ui.guild.invalidName");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_ERROR_REQUIREMENT_UNMET:
                        {
                            _loc_51 = I18n.getUiText("ui.guild.requirementUnmet");
                            break;
                        }
                        case GuildCreationResultEnum.GUILD_CREATE_OK:
                        {
                            this._hasGuild = true;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_51)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_51, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationResult, _loc_50.result);
                    return true;
                }
                case param1 is GuildInvitedMessage:
                {
                    _loc_52 = param1 as GuildInvitedMessage;
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvited, _loc_52.guildInfo.guildName, _loc_52.recruterId, _loc_52.recruterName);
                    return true;
                }
                case param1 is GuildInvitationStateRecruterMessage:
                {
                    _loc_53 = param1 as GuildInvitationStateRecruterMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruter, _loc_53.invitationState, _loc_53.recrutedName);
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    return true;
                }
                case param1 is GuildInvitationStateRecrutedMessage:
                {
                    _loc_54 = param1 as GuildInvitationStateRecrutedMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruted, _loc_54.invitationState);
                    return true;
                }
                case param1 is GuildJoinedMessage:
                {
                    _loc_55 = param1 as GuildJoinedMessage;
                    this._hasGuild = true;
                    this._guild = GuildWrapper.create(_loc_55.guildInfo.guildId, _loc_55.guildInfo.guildName, _loc_55.guildInfo.guildEmblem, _loc_55.memberRights);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildJoined, _loc_55.guildInfo.guildEmblem, _loc_55.guildInfo.guildName, _loc_55.memberRights);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, true);
                    _loc_56 = I18n.getUiText("ui.guild.JoinGuildMessage", [_loc_55.guildInfo.guildName]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_56, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is GuildUIOpenedMessage:
                {
                    _loc_57 = param1 as GuildUIOpenedMessage;
                    if (this._guild != null)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildUIOpened, _loc_57.type);
                    }
                    return true;
                }
                case param1 is GuildInformationsGeneralMessage:
                {
                    _loc_58 = param1 as GuildInformationsGeneralMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsGeneral, _loc_58.enabled, _loc_58.expLevelFloor, _loc_58.experience, _loc_58.expNextLevelFloor, _loc_58.level, _loc_58.abandonnedPaddock);
                    this._guild.level = _loc_58.level;
                    this._guild.experience = _loc_58.experience;
                    this._guild.expLevelFloor = _loc_58.expLevelFloor;
                    this._guild.expNextLevelFloor = _loc_58.expNextLevelFloor;
                    return true;
                }
                case param1 is GuildInformationsMemberUpdateMessage:
                {
                    _loc_59 = param1 as GuildInformationsMemberUpdateMessage;
                    if (this._guildMembers != null)
                    {
                        _loc_152 = this._guildMembers.length;
                        _loc_153 = 0;
                        while (_loc_153 < _loc_152)
                        {
                            
                            _loc_60 = this._guildMembers[_loc_153];
                            if (_loc_60.id == _loc_59.member.id)
                            {
                                this._guildMembers[_loc_153] = _loc_59.member;
                                if (_loc_60.id == PlayedCharacterManager.getInstance().id)
                                {
                                    this.guild.memberRightsNumber = _loc_59.member.rights;
                                }
                                break;
                            }
                            _loc_153++;
                        }
                    }
                    else
                    {
                        this._guildMembers = new Vector.<GuildMember>;
                        _loc_60 = _loc_59.member;
                        this._guildMembers.push(_loc_60);
                        if (_loc_60.id == PlayedCharacterManager.getInstance().id)
                        {
                            this.guild.memberRightsNumber = _loc_60.rights;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate, _loc_59.member);
                    return true;
                }
                case param1 is GuildMemberLeavingMessage:
                {
                    _loc_61 = param1 as GuildMemberLeavingMessage;
                    _loc_62 = 0;
                    for each (_loc_154 in this._guildMembers)
                    {
                        
                        if (_loc_61.memberId == _loc_154.id)
                        {
                            this._guildMembers.splice(_loc_62, 1);
                        }
                        _loc_62 = _loc_62 + 1;
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMemberLeaving, _loc_61.kicked, _loc_61.memberId);
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
                    _loc_63 = param1 as GuildInfosUpgradeMessage;
                    TaxCollectorsManager.getInstance().updateGuild(_loc_63.maxTaxCollectorsCount, _loc_63.taxCollectorsCount, _loc_63.taxCollectorLifePoints, _loc_63.taxCollectorDamagesBonuses, _loc_63.taxCollectorPods, _loc_63.taxCollectorProspecting, _loc_63.taxCollectorWisdom);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInfosUpgrade, _loc_63.boostPoints, _loc_63.maxTaxCollectorsCount, _loc_63.spellId, _loc_63.spellLevel, _loc_63.taxCollectorDamagesBonuses, _loc_63.taxCollectorLifePoints, _loc_63.taxCollectorPods, _loc_63.taxCollectorProspecting, _loc_63.taxCollectorsCount, _loc_63.taxCollectorWisdom);
                    return true;
                }
                case param1 is GuildFightPlayersHelpersJoinMessage:
                {
                    _loc_64 = param1 as GuildFightPlayersHelpersJoinMessage;
                    TaxCollectorsManager.getInstance().addFighter(_loc_64.fightId, _loc_64.playerInfo, true);
                    return true;
                }
                case param1 is GuildFightPlayersHelpersLeaveMessage:
                {
                    _loc_65 = param1 as GuildFightPlayersHelpersLeaveMessage;
                    if (this._autoLeaveHelpers)
                    {
                        _loc_155 = I18n.getUiText("ui.social.guild.autoFightLeave");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_155, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    TaxCollectorsManager.getInstance().removeFighter(_loc_65.fightId, _loc_65.playerId, true);
                    return true;
                }
                case param1 is GuildFightPlayersEnemiesListMessage:
                {
                    _loc_66 = param1 as GuildFightPlayersEnemiesListMessage;
                    for each (_loc_156 in _loc_66.playerInfo)
                    {
                        
                        TaxCollectorsManager.getInstance().addFighter(_loc_66.fightId, _loc_156, false, false);
                    }
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, _loc_66.fightId);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorUpdate, _loc_66.fightId);
                    return true;
                }
                case param1 is GuildFightPlayersEnemyRemoveMessage:
                {
                    _loc_67 = param1 as GuildFightPlayersEnemyRemoveMessage;
                    TaxCollectorsManager.getInstance().removeFighter(_loc_67.fightId, _loc_67.playerId, false);
                    return true;
                }
                case param1 is TaxCollectorMovementMessage:
                {
                    _loc_68 = param1 as TaxCollectorMovementMessage;
                    _loc_70 = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_68.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_68.basicInfos.lastNameId).name;
                    _loc_71 = new WorldPointWrapper(_loc_68.basicInfos.mapId, true, _loc_68.basicInfos.worldX, _loc_68.basicInfos.worldY);
                    _loc_72 = String(_loc_71.outdoorX);
                    _loc_73 = String(_loc_71.outdoorY);
                    _loc_74 = _loc_72 + "," + _loc_73;
                    switch(_loc_68.hireOrFire)
                    {
                        case true:
                        {
                            _loc_69 = I18n.getUiText("ui.social.TaxCollectorAdded", [_loc_70, _loc_74, _loc_68.playerName]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_69, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                            break;
                        }
                        case false:
                        {
                            _loc_69 = I18n.getUiText("ui.social.TaxCollectorRemoved", [_loc_70, _loc_74, _loc_68.playerName]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_69, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
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
                    _loc_75 = param1 as TaxCollectorAttackedMessage;
                    _loc_76 = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_75.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_75.lastNameId).name;
                    _loc_77 = I18n.getUiText("ui.social.TaxCollectorAttacked", [_loc_76, _loc_75.worldX + "," + _loc_75.worldY]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, "{hook,OpenSocial,1,2::" + _loc_77 + "}", ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is TaxCollectorAttackedResultMessage:
                {
                    _loc_78 = param1 as TaxCollectorAttackedResultMessage;
                    _loc_80 = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_78.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_78.basicInfos.lastNameId).name;
                    _loc_81 = new WorldPointWrapper(_loc_78.basicInfos.mapId, true, _loc_78.basicInfos.worldX, _loc_78.basicInfos.worldY);
                    _loc_82 = _loc_81.outdoorX;
                    _loc_83 = _loc_81.outdoorY;
                    if (_loc_78.deadOrAlive)
                    {
                        _loc_79 = I18n.getUiText("ui.social.TaxCollectorDied", [_loc_80, _loc_82 + "," + _loc_83]);
                    }
                    else
                    {
                        _loc_79 = I18n.getUiText("ui.social.TaxCollectorSurvived", [_loc_80, _loc_82 + "," + _loc_83]);
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_79, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is TaxCollectorErrorMessage:
                {
                    _loc_84 = param1 as TaxCollectorErrorMessage;
                    _loc_85 = "";
                    switch(_loc_84.reason)
                    {
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ALREADY_ONE:
                        {
                            _loc_85 = I18n.getUiText("ui.social.alreadyTaxCollectorOnMap");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_HERE:
                        {
                            _loc_85 = I18n.getUiText("ui.social.cantHireTaxCollecotrHere");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_YET:
                        {
                            _loc_85 = I18n.getUiText("ui.social.cantHireTaxcollectorTooTired");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ERROR_UNKNOWN:
                        {
                            _loc_85 = I18n.getUiText("ui.social.unknownErrorTaxCollector");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_MAX_REACHED:
                        {
                            _loc_85 = I18n.getUiText("ui.social.cantHireMaxTaxCollector");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NO_RIGHTS:
                        {
                            _loc_85 = I18n.getUiText("ui.social.taxCollectorNoRights");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_ENOUGH_KAMAS:
                        {
                            _loc_85 = I18n.getUiText("ui.social.notEnougthRichToHireTaxCollector");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_FOUND:
                        {
                            _loc_85 = I18n.getUiText("ui.social.taxCollectorNotFound");
                            break;
                        }
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_OWNED:
                        {
                            _loc_85 = I18n.getUiText("ui.social.notYourTaxcollector");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_85, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is TaxCollectorListMessage:
                {
                    _loc_86 = param1 as TaxCollectorListMessage;
                    TaxCollectorsManager.getInstance().taxCollectorHireCost = _loc_86.taxCollectorHireCost;
                    TaxCollectorsManager.getInstance().maxTaxCollectorsCount = _loc_86.nbcollectorMax;
                    TaxCollectorsManager.getInstance().setTaxCollectors(_loc_86.informations);
                    TaxCollectorsManager.getInstance().setTaxCollectorsFighters(_loc_86.fightersInformations);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorListUpdate);
                    return true;
                }
                case param1 is TaxCollectorMovementAddMessage:
                {
                    _loc_87 = param1 as TaxCollectorMovementAddMessage;
                    _loc_88 = TaxCollectorsManager.getInstance().addTaxCollector(_loc_87.informations);
                    if (_loc_88 || TaxCollectorsManager.getInstance().taxCollectors[_loc_87.informations.uniqueId].state != 1)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorUpdate, _loc_87.informations.uniqueId);
                    }
                    if (_loc_88)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorAdd, _loc_87.informations);
                    }
                    return true;
                }
                case param1 is TaxCollectorMovementRemoveMessage:
                {
                    _loc_89 = param1 as TaxCollectorMovementRemoveMessage;
                    delete TaxCollectorsManager.getInstance().taxCollectors[_loc_89.collectorId];
                    delete TaxCollectorsManager.getInstance().taxCollectorsFighters[_loc_89.collectorId];
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorRemoved, _loc_89.collectorId);
                    return true;
                }
                case param1 is GuildInformationsPaddocksMessage:
                {
                    _loc_90 = param1 as GuildInformationsPaddocksMessage;
                    this._guildPaddocksMax = _loc_90.nbPaddockMax;
                    this._guildPaddocks = _loc_90.paddocksInformations;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsFarms);
                    return true;
                }
                case param1 is GuildPaddockBoughtMessage:
                {
                    _loc_91 = param1 as GuildPaddockBoughtMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockAdd, _loc_91.paddockInfo);
                    return true;
                }
                case param1 is GuildPaddockRemovedMessage:
                {
                    _loc_92 = param1 as GuildPaddockRemovedMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockRemoved, _loc_92.paddockId);
                    return true;
                }
                case param1 is TaxCollectorDialogQuestionExtendedMessage:
                {
                    _loc_93 = param1 as TaxCollectorDialogQuestionExtendedMessage;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionExtended, _loc_93.guildInfo.guildName, _loc_93.maxPods, _loc_93.prospecting, _loc_93.wisdom, _loc_93.taxCollectorsCount, _loc_93.taxCollectorAttack, _loc_93.kamas, _loc_93.experience, _loc_93.pods, _loc_93.itemsValue);
                    return true;
                }
                case param1 is TaxCollectorDialogQuestionBasicMessage:
                {
                    _loc_94 = param1 as TaxCollectorDialogQuestionBasicMessage;
                    _loc_95 = GuildWrapper.create(0, _loc_94.guildInfo.guildName, null, 0);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionBasic, _loc_95.guildName);
                    return true;
                }
                case param1 is ContactLookMessage:
                {
                    _loc_96 = param1 as ContactLookMessage;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, _loc_96.playerId, _loc_96.playerName, EntityLookAdapter.fromNetwork(_loc_96.look));
                    return true;
                }
                case param1 is GuildGetInformationsAction:
                {
                    _loc_97 = param1 as GuildGetInformationsAction;
                    _loc_98 = true;
                    switch(_loc_97.infoType)
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
                                _loc_98 = false;
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
                    if (_loc_98)
                    {
                        _loc_157 = new GuildGetInformationsMessage();
                        _loc_157.initGuildGetInformationsMessage(_loc_97.infoType);
                        ConnectionsHandler.getConnection().send(_loc_157);
                    }
                    return true;
                }
                case param1 is GuildInvitationAction:
                {
                    _loc_99 = param1 as GuildInvitationAction;
                    _loc_100 = new GuildInvitationMessage();
                    _loc_100.initGuildInvitationMessage(_loc_99.targetId);
                    ConnectionsHandler.getConnection().send(_loc_100);
                    return true;
                }
                case param1 is GuildInvitationByNameAction:
                {
                    _loc_101 = param1 as GuildInvitationByNameAction;
                    _loc_102 = new GuildInvitationByNameMessage();
                    _loc_102.initGuildInvitationByNameMessage(_loc_101.target);
                    ConnectionsHandler.getConnection().send(_loc_102);
                    return true;
                }
                case param1 is GuildKickRequestAction:
                {
                    _loc_103 = param1 as GuildKickRequestAction;
                    _loc_104 = new GuildKickRequestMessage();
                    _loc_104.initGuildKickRequestMessage(_loc_103.targetId);
                    ConnectionsHandler.getConnection().send(_loc_104);
                    return true;
                }
                case param1 is GuildChangeMemberParametersAction:
                {
                    _loc_105 = param1 as GuildChangeMemberParametersAction;
                    _loc_106 = GuildWrapper.getRightsNumber(_loc_105.rights);
                    _loc_107 = new GuildChangeMemberParametersMessage();
                    _loc_107.initGuildChangeMemberParametersMessage(_loc_105.memberId, _loc_105.rank, _loc_105.experienceGivenPercent, _loc_106);
                    ConnectionsHandler.getConnection().send(_loc_107);
                    return true;
                }
                case param1 is GuildSpellUpgradeRequestAction:
                {
                    _loc_108 = param1 as GuildSpellUpgradeRequestAction;
                    _loc_109 = new GuildSpellUpgradeRequestMessage();
                    _loc_109.initGuildSpellUpgradeRequestMessage(_loc_108.spellId);
                    ConnectionsHandler.getConnection().send(_loc_109);
                    return true;
                }
                case param1 is GuildCharacsUpgradeRequestAction:
                {
                    _loc_110 = param1 as GuildCharacsUpgradeRequestAction;
                    _loc_111 = new GuildCharacsUpgradeRequestMessage();
                    _loc_111.initGuildCharacsUpgradeRequestMessage(_loc_110.charaTypeTarget);
                    ConnectionsHandler.getConnection().send(_loc_111);
                    return true;
                }
                case param1 is GuildFarmTeleportRequestAction:
                {
                    _loc_112 = param1 as GuildFarmTeleportRequestAction;
                    _loc_113 = new GuildPaddockTeleportRequestMessage();
                    _loc_113.initGuildPaddockTeleportRequestMessage(_loc_112.farmId);
                    ConnectionsHandler.getConnection().send(_loc_113);
                    return true;
                }
                case param1 is GuildHouseTeleportRequestAction:
                {
                    _loc_114 = param1 as GuildHouseTeleportRequestAction;
                    _loc_115 = new GuildHouseTeleportRequestMessage();
                    _loc_115.initGuildHouseTeleportRequestMessage(_loc_114.houseId);
                    ConnectionsHandler.getConnection().send(_loc_115);
                    return true;
                }
                case param1 is GuildFightJoinRequestAction:
                {
                    _loc_116 = param1 as GuildFightJoinRequestAction;
                    _loc_117 = new GuildFightJoinRequestMessage();
                    _loc_117.initGuildFightJoinRequestMessage(_loc_116.taxCollectorId);
                    ConnectionsHandler.getConnection().send(_loc_117);
                    return true;
                }
                case param1 is GuildFightTakePlaceRequestAction:
                {
                    _loc_118 = param1 as GuildFightTakePlaceRequestAction;
                    _loc_119 = new GuildFightTakePlaceRequestMessage();
                    _loc_119.initGuildFightTakePlaceRequestMessage(_loc_118.taxCollectorId, _loc_118.replacedCharacterId);
                    ConnectionsHandler.getConnection().send(_loc_119);
                    return true;
                }
                case param1 is GuildFightLeaveRequestAction:
                {
                    _loc_120 = param1 as GuildFightLeaveRequestAction;
                    this._autoLeaveHelpers = false;
                    if (_loc_120.warning)
                    {
                        for each (_loc_158 in TaxCollectorsManager.getInstance().taxCollectors)
                        {
                            
                            if (_loc_158.state == 1)
                            {
                                _loc_159 = TaxCollectorsManager.getInstance().taxCollectorsFighters[_loc_158.uniqueId];
                                for each (_loc_160 in _loc_159.allyCharactersInformations)
                                {
                                    
                                    if (_loc_160.playerCharactersInformations.id == _loc_120.characterId)
                                    {
                                        this._autoLeaveHelpers = true;
                                        _loc_121 = new GuildFightLeaveRequestMessage();
                                        _loc_121.initGuildFightLeaveRequestMessage(_loc_158.uniqueId, _loc_120.characterId);
                                        ConnectionsHandler.getConnection().send(_loc_121);
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        _loc_121 = new GuildFightLeaveRequestMessage();
                        _loc_121.initGuildFightLeaveRequestMessage(_loc_120.taxCollectorId, _loc_120.characterId);
                        ConnectionsHandler.getConnection().send(_loc_121);
                    }
                    return true;
                }
                case param1 is TaxCollectorHireRequestAction:
                {
                    _loc_122 = param1 as TaxCollectorHireRequestAction;
                    if (TaxCollectorsManager.getInstance().taxCollectorHireCost <= PlayedCharacterManager.getInstance().characteristics.kamas)
                    {
                        _loc_161 = new TaxCollectorHireRequestMessage();
                        _loc_161.initTaxCollectorHireRequestMessage();
                        ConnectionsHandler.getConnection().send(_loc_161);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.popup.not_enough_rich"), ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is TaxCollectorFireRequestAction:
                {
                    _loc_123 = param1 as TaxCollectorFireRequestAction;
                    _loc_124 = new TaxCollectorFireRequestMessage();
                    _loc_124.initTaxCollectorFireRequestMessage(_loc_123.taxCollectorId);
                    ConnectionsHandler.getConnection().send(_loc_124);
                    return true;
                }
                case param1 is GuildHouseUpdateInformationMessage:
                {
                    if (this._guildHousesList)
                    {
                        _loc_162 = param1 as GuildHouseUpdateInformationMessage;
                        _loc_163 = false;
                        for each (_loc_164 in this._guildHouses)
                        {
                            
                            if (_loc_164.houseId == _loc_162.housesInformations.houseId)
                            {
                                _loc_164.update(_loc_162.housesInformations);
                                _loc_163 = true;
                            }
                            KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                        }
                        if (!_loc_163)
                        {
                            _loc_165 = GuildHouseWrapper.create(_loc_162.housesInformations);
                            this._guildHouses.push(_loc_165);
                            KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseAdd, _loc_165);
                        }
                        this._guildHousesListUpdate = true;
                    }
                    return true;
                }
                case param1 is GuildHouseRemoveMessage:
                {
                    if (this._guildHousesList)
                    {
                        _loc_166 = param1 as GuildHouseRemoveMessage;
                        _loc_167 = false;
                        _loc_168 = 0;
                        while (_loc_168 < this._guildHouses.length)
                        {
                            
                            if (this._guildHouses[_loc_168].houseId == _loc_166.houseId)
                            {
                                this._guildHouses.splice(_loc_168, 1);
                                break;
                            }
                            _loc_168++;
                        }
                        this._guildHousesListUpdate = true;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseRemoved, _loc_166.houseId);
                    }
                    return true;
                }
                case param1 is CharacterReportAction:
                {
                    _loc_125 = param1 as CharacterReportAction;
                    _loc_126 = new CharacterReportMessage();
                    _loc_126.initCharacterReportMessage(_loc_125.reportedId, _loc_125.reason);
                    ConnectionsHandler.getConnection().send(_loc_126);
                    return true;
                }
                case param1 is ChatReportAction:
                {
                    _loc_127 = param1 as ChatReportAction;
                    _loc_128 = new ChatMessageReportMessage();
                    _loc_129 = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
                    _loc_130 = _loc_129.getTimestampServerByRealTimestamp(_loc_127.timestamp);
                    _loc_128.initChatMessageReportMessage(_loc_127.name, _loc_127.message, _loc_130, _loc_127.channel, _loc_127.fingerprint, _loc_127.reason);
                    ConnectionsHandler.getConnection().send(_loc_128);
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
            var _loc_4:IgnoredWrapper = null;
            var _loc_3:* = AccountManager.getInstance().getAccountName(param1);
            for each (_loc_4 in this._ignoredList)
            {
                
                if (param2 != 0 && _loc_4.id == param2 || _loc_3 && _loc_4.name.toLowerCase() == _loc_3.toLowerCase())
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function isFriend(param1:String) : Boolean
        {
            var _loc_4:FriendWrapper = null;
            var _loc_2:* = this._friendsList.length;
            var _loc_3:int = 0;
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
            var _loc_4:EnemyWrapper = null;
            var _loc_2:* = this._enemiesList.length;
            var _loc_3:int = 0;
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
