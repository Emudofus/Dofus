package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildHouseWrapper;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
    import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.messages.game.friend.FriendsGetListMessage;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredGetListMessage;
    import com.ankamagames.dofus.network.messages.game.friend.SpouseGetInformationsMessage;
    import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
    import com.ankamagames.dofus.network.messages.game.guild.GuildMembershipMessage;
    import com.ankamagames.dofus.network.messages.game.friend.FriendsListMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.SpouseRequestAction;
    import com.ankamagames.dofus.network.messages.game.friend.SpouseInformationsMessage;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredListMessage;
    import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
    import com.ankamagames.dofus.logic.game.common.actions.social.FriendsListRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.social.EnemiesListRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.social.AddFriendAction;
    import com.ankamagames.dofus.network.messages.game.friend.FriendAddedMessage;
    import com.ankamagames.dofus.internalDatacenter.people.FriendWrapper;
    import com.ankamagames.dofus.network.messages.game.friend.FriendAddFailureMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.AddEnemyAction;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddedMessage;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddFailureMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.RemoveFriendAction;
    import com.ankamagames.dofus.network.messages.game.friend.FriendDeleteRequestMessage;
    import com.ankamagames.dofus.network.messages.game.friend.FriendDeleteResultMessage;
    import com.ankamagames.dofus.network.messages.game.friend.FriendUpdateMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.RemoveEnemyAction;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredDeleteRequestMessage;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredDeleteResultMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
    import com.ankamagames.dofus.logic.game.common.actions.social.RemoveIgnoredAction;
    import com.ankamagames.dofus.logic.game.common.actions.social.JoinFriendAction;
    import com.ankamagames.dofus.network.messages.game.friend.FriendJoinRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.JoinSpouseAction;
    import com.ankamagames.dofus.logic.game.common.actions.social.FriendSpouseFollowAction;
    import com.ankamagames.dofus.network.messages.game.friend.FriendSpouseFollowWithCompassRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.FriendWarningSetAction;
    import com.ankamagames.dofus.network.messages.game.friend.FriendSetWarnOnConnectionMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.MemberWarningSetAction;
    import com.ankamagames.dofus.network.messages.game.friend.GuildMemberSetWarnOnConnectionMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.FriendOrGuildMemberLevelUpWarningSetAction;
    import com.ankamagames.dofus.network.messages.game.friend.FriendSetWarnOnLevelGainMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.FriendGuildSetWarnOnAchievementCompleteAction;
    import com.ankamagames.dofus.network.messages.game.achievement.FriendGuildSetWarnOnAchievementCompleteMessage;
    import com.ankamagames.dofus.network.messages.game.friend.SpouseStatusMessage;
    import com.ankamagames.dofus.network.messages.game.chat.smiley.MoodSmileyUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.friend.FriendWarnOnConnectionStateMessage;
    import com.ankamagames.dofus.network.messages.game.friend.GuildMemberWarnOnConnectionStateMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildMemberOnlineStatusMessage;
    import com.ankamagames.dofus.network.messages.game.friend.FriendWarnOnLevelGainStateMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.FriendGuildWarnOnAchievementCompleteStateMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsMembersMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildHousesInformationMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildModificationStartedMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildCreationResultMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInvitedMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationStateRecruterMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationStateRecrutedMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildJoinedMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsGeneralMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsMemberUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildMemberLeavingMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInfosUpgradeMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersHelpersJoinMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersHelpersLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersEnemiesListMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersEnemyRemoveMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorMovementMessage;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorAttackedMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorAttackedResultMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorErrorMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorListMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorMovementAddMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorMovementRemoveMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorStateUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsPaddocksMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockBoughtMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockRemovedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.AllianceTaxCollectorDialogQuestionExtendedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionExtendedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionBasicMessage;
    import com.ankamagames.dofus.network.messages.game.social.ContactLookMessage;
    import com.ankamagames.dofus.network.messages.game.social.ContactLookErrorMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationByNameAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationByNameMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildKickRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildKickRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildChangeMemberParametersMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSpellUpgradeRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildSpellUpgradeRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCharacsUpgradeRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildCharacsUpgradeRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFarmTeleportRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockTeleportRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildHouseTeleportRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildHouseTeleportRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightJoinRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightTakePlaceRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightTakePlaceRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightLeaveRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightLeaveRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFactsRequestAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildFactsRequestMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildFactsMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildFactsErrorMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.CharacterReportAction;
    import com.ankamagames.dofus.network.messages.game.report.CharacterReportMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.ChatReportAction;
    import com.ankamagames.dofus.network.messages.game.chat.report.ChatMessageReportMessage;
    import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
    import com.ankamagames.dofus.logic.game.common.actions.social.PlayerStatusUpdateRequestAction;
    import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
    import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.ContactLookRequestByIdAction;
    import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
    import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
    import com.ankamagames.dofus.internalDatacenter.people.EnemyWrapper;
    import d2network.IgnoredOnlineInformations;
    import com.ankamagames.dofus.network.messages.game.friend.FriendAddRequestMessage;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddRequestMessage;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.network.messages.game.guild.GuildGetInformationsMessage;
    import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
    import com.ankamagames.dofus.network.messages.game.guild.GuildHouseUpdateInformationMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildHouseRemoveMessage;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInAllianceFactsMessage;
    import com.ankamagames.dofus.network.messages.game.social.ContactLookRequestByIdMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import com.ankamagames.dofus.logic.common.managers.AccountManager;
    import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.enums.ListAddFailureEnum;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.internalDatacenter.people.IgnoredWrapper;
    import com.ankamagames.dofus.network.enums.PlayerStateEnum;
    import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
    import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.network.messages.game.friend.FriendSpouseJoinRequestMessage;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import com.ankamagames.dofus.network.messages.game.guild.GuildCreationStartedMessage;
    import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.network.enums.SocialGroupInvitationStateEnum;
    import com.ankamagames.dofus.network.messages.game.guild.GuildLeftMessage;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.logic.common.managers.NotificationManager;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import com.ankamagames.dofus.network.enums.TaxCollectorErrorReasonEnum;
    import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
    import com.ankamagames.dofus.misc.lists.CraftHookList;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
    import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class SocialFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialFrame));
        private static var _instance:SocialFrame;

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
        private var _allGuilds:Dictionary;
        private var _socialDatFrame:SocialDataFrame;

        public function SocialFrame()
        {
            this._guildHouses = new Vector.<GuildHouseWrapper>();
            this._guildPaddocks = new Vector.<PaddockContentInformations>();
            this._allGuilds = new Dictionary(true);
            super();
        }

        public static function getInstance():SocialFrame
        {
            return (_instance);
        }


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get friendsList():Array
        {
            return (this._friendsList);
        }

        public function get enemiesList():Array
        {
            return (this._enemiesList);
        }

        public function get ignoredList():Array
        {
            return (this._ignoredList);
        }

        public function get spouse():SpouseWrapper
        {
            return (this._spouse);
        }

        public function get hasGuild():Boolean
        {
            return (this._hasGuild);
        }

        public function get hasSpouse():Boolean
        {
            return (this._hasSpouse);
        }

        public function get guild():GuildWrapper
        {
            return (this._guild);
        }

        public function get guildmembers():Vector.<GuildMember>
        {
            return (this._guildMembers);
        }

        public function get guildHouses():Vector.<GuildHouseWrapper>
        {
            return (this._guildHouses);
        }

        public function get guildPaddocks():Vector.<PaddockContentInformations>
        {
            return (this._guildPaddocks);
        }

        public function get maxGuildPaddocks():int
        {
            return (this._guildPaddocksMax);
        }

        public function get warnFriendConnec():Boolean
        {
            return (this._warnOnFrienConnec);
        }

        public function get warnMemberConnec():Boolean
        {
            return (this._warnOnMemberConnec);
        }

        public function get warnWhenFriendOrGuildMemberLvlUp():Boolean
        {
            return (this._warnWhenFriendOrGuildMemberLvlUp);
        }

        public function get warnWhenFriendOrGuildMemberAchieve():Boolean
        {
            return (this._warnWhenFriendOrGuildMemberAchieve);
        }

        public function get guildHousesUpdateNeeded():Boolean
        {
            return (this._guildHousesListUpdate);
        }

        public function getGuildById(id:int):GuildFactSheetWrapper
        {
            return (this._allGuilds[id]);
        }

        public function updateGuildById(id:int, guild:GuildFactSheetWrapper):void
        {
            this._allGuilds[id] = guild;
        }

        public function pushed():Boolean
        {
            _instance = this;
            this._enemiesList = new Array();
            this._ignoredList = new Array();
            this._socialDatFrame = new SocialDataFrame();
            this._guildDialogFrame = new GuildDialogFrame();
            Kernel.getWorker().addFrame(this._socialDatFrame);
            ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
            ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
            ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
            return (true);
        }

        public function pulled():Boolean
        {
            _instance = null;
            TaxCollectorsManager.getInstance().destroy();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GuildMembershipMessage;
            var _local_3:FriendsListMessage;
            var _local_4:SpouseRequestAction;
            var _local_5:SpouseInformationsMessage;
            var _local_6:IgnoredListMessage;
            var _local_7:OpenSocialAction;
            var _local_8:FriendsListRequestAction;
            var _local_9:EnemiesListRequestAction;
            var _local_10:AddFriendAction;
            var _local_11:FriendAddedMessage;
            var _local_12:FriendWrapper;
            var _local_13:FriendAddFailureMessage;
            var _local_14:String;
            var _local_15:AddEnemyAction;
            var _local_16:IgnoredAddedMessage;
            var _local_17:IgnoredAddFailureMessage;
            var _local_18:String;
            var _local_19:RemoveFriendAction;
            var _local_20:FriendDeleteRequestMessage;
            var _local_21:FriendDeleteResultMessage;
            var _local_22:String;
            var _local_23:FriendUpdateMessage;
            var _local_24:FriendWrapper;
            var _local_25:Boolean;
            var _local_26:RemoveEnemyAction;
            var _local_27:IgnoredDeleteRequestMessage;
            var _local_28:IgnoredDeleteResultMessage;
            var _local_29:AddIgnoredAction;
            var _local_30:RemoveIgnoredAction;
            var _local_31:IgnoredDeleteRequestMessage;
            var _local_32:JoinFriendAction;
            var _local_33:FriendJoinRequestMessage;
            var _local_34:JoinSpouseAction;
            var _local_35:FriendSpouseFollowAction;
            var _local_36:FriendSpouseFollowWithCompassRequestMessage;
            var _local_37:FriendWarningSetAction;
            var _local_38:FriendSetWarnOnConnectionMessage;
            var _local_39:MemberWarningSetAction;
            var _local_40:GuildMemberSetWarnOnConnectionMessage;
            var _local_41:FriendOrGuildMemberLevelUpWarningSetAction;
            var _local_42:FriendSetWarnOnLevelGainMessage;
            var _local_43:FriendGuildSetWarnOnAchievementCompleteAction;
            var _local_44:FriendGuildSetWarnOnAchievementCompleteMessage;
            var _local_45:SpouseStatusMessage;
            var _local_46:MoodSmileyUpdateMessage;
            var _local_47:FriendWarnOnConnectionStateMessage;
            var _local_48:GuildMemberWarnOnConnectionStateMessage;
            var _local_49:GuildMemberOnlineStatusMessage;
            var _local_50:FriendWarnOnLevelGainStateMessage;
            var _local_51:FriendGuildWarnOnAchievementCompleteStateMessage;
            var _local_52:GuildInformationsMembersMessage;
            var _local_53:GuildHousesInformationMessage;
            var _local_54:GuildModificationStartedMessage;
            var _local_55:GuildCreationResultMessage;
            var _local_56:String;
            var _local_57:GuildInvitedMessage;
            var _local_58:GuildInvitationStateRecruterMessage;
            var _local_59:GuildInvitationStateRecrutedMessage;
            var _local_60:GuildJoinedMessage;
            var _local_61:String;
            var _local_62:GuildInformationsGeneralMessage;
            var _local_63:GuildInformationsMemberUpdateMessage;
            var _local_64:GuildMember;
            var _local_65:GuildMemberLeavingMessage;
            var _local_66:uint;
            var _local_67:GuildInfosUpgradeMessage;
            var _local_68:GuildFightPlayersHelpersJoinMessage;
            var _local_69:GuildFightPlayersHelpersLeaveMessage;
            var _local_70:GuildFightPlayersEnemiesListMessage;
            var _local_71:GuildFightPlayersEnemyRemoveMessage;
            var _local_72:TaxCollectorMovementMessage;
            var _local_73:String;
            var _local_74:String;
            var _local_75:WorldPointWrapper;
            var _local_76:String;
            var _local_77:String;
            var _local_78:String;
            var _local_79:TaxCollectorAttackedMessage;
            var _local_80:int;
            var _local_81:int;
            var _local_82:String;
            var _local_83:String;
            var _local_84:TaxCollectorAttackedResultMessage;
            var _local_85:String;
            var _local_86:String;
            var _local_87:String;
            var _local_88:WorldPointWrapper;
            var _local_89:int;
            var _local_90:int;
            var _local_91:TaxCollectorErrorMessage;
            var _local_92:String;
            var _local_93:TaxCollectorListMessage;
            var _local_94:TaxCollectorMovementAddMessage;
            var _local_95:int;
            var _local_96:Boolean;
            var _local_97:int;
            var _local_98:TaxCollectorMovementRemoveMessage;
            var _local_99:TaxCollectorStateUpdateMessage;
            var _local_100:GuildInformationsPaddocksMessage;
            var _local_101:GuildPaddockBoughtMessage;
            var _local_102:GuildPaddockRemovedMessage;
            var _local_103:AllianceTaxCollectorDialogQuestionExtendedMessage;
            var _local_104:TaxCollectorDialogQuestionExtendedMessage;
            var _local_105:TaxCollectorDialogQuestionBasicMessage;
            var _local_106:GuildWrapper;
            var _local_107:ContactLookMessage;
            var _local_108:ContactLookErrorMessage;
            var _local_109:GuildGetInformationsAction;
            var _local_110:Boolean;
            var _local_111:GuildInvitationAction;
            var _local_112:GuildInvitationMessage;
            var _local_113:GuildInvitationByNameAction;
            var _local_114:GuildInvitationByNameMessage;
            var _local_115:GuildKickRequestAction;
            var _local_116:GuildKickRequestMessage;
            var _local_117:GuildChangeMemberParametersAction;
            var _local_118:Number;
            var _local_119:GuildChangeMemberParametersMessage;
            var _local_120:GuildSpellUpgradeRequestAction;
            var _local_121:GuildSpellUpgradeRequestMessage;
            var _local_122:GuildCharacsUpgradeRequestAction;
            var _local_123:GuildCharacsUpgradeRequestMessage;
            var _local_124:GuildFarmTeleportRequestAction;
            var _local_125:GuildPaddockTeleportRequestMessage;
            var _local_126:GuildHouseTeleportRequestAction;
            var _local_127:GuildHouseTeleportRequestMessage;
            var _local_128:GuildFightJoinRequestAction;
            var _local_129:GuildFightJoinRequestMessage;
            var _local_130:GuildFightTakePlaceRequestAction;
            var _local_131:GuildFightTakePlaceRequestMessage;
            var _local_132:GuildFightLeaveRequestAction;
            var _local_133:GuildFightLeaveRequestMessage;
            var _local_134:GuildFactsRequestAction;
            var _local_135:GuildFactsRequestMessage;
            var _local_136:GuildFactsMessage;
            var _local_137:GuildFactSheetWrapper;
            var _local_138:uint;
            var _local_139:String;
            var _local_140:String;
            var _local_141:GuildFactsErrorMessage;
            var _local_142:CharacterReportAction;
            var _local_143:CharacterReportMessage;
            var _local_144:ChatReportAction;
            var _local_145:ChatMessageReportMessage;
            var _local_146:ChatFrame;
            var _local_147:uint;
            var _local_148:PlayerStatusUpdateMessage;
            var _local_149:PlayerStatusUpdateRequestAction;
            var _local_150:PlayerStatus;
            var _local_151:PlayerStatusUpdateRequestMessage;
            var _local_152:ContactLookRequestByIdAction;
            var f:FriendInformations;
            var fw:FriendWrapper;
            var foi:FriendOnlineInformations;
            var i:*;
            var ew:EnemyWrapper;
            var ioi:IgnoredOnlineInformations;
            var farmsg:FriendAddRequestMessage;
            var iarmsg:IgnoredAddRequestMessage;
            var enemyToAdd:EnemyWrapper;
            var _local_162:*;
            var fd:*;
            var frd:*;
            var ed:*;
            var il:*;
            var ignoredAdd:*;
            var iar2msg:IgnoredAddRequestMessage;
            var memberm:GuildMember;
            var nm:int;
            var imood:int;
            var frdmood:FriendWrapper;
            var memberName:String;
            var gm:GuildMember;
            var friend:Boolean;
            var fr:FriendWrapper;
            var mb:GuildMember;
            var houseInformation:HouseInformationsForGuild;
            var ghw:GuildHouseWrapper;
            var nmu:int;
            var k:int;
            var guildMember:GuildMember;
            var text:String;
            var enemy:CharacterMinimalPlusLookInformations;
            var _local_185:String;
            var _local_186:String;
            var suba:SubArea;
            var nid:uint;
            var ggimsg:GuildGetInformationsMessage;
            var tc2:TaxCollectorWrapper;
            var tcInFight:SocialEntityInFightWrapper;
            var defender:SocialFightersWrapper;
            var ghuimsg:GuildHouseUpdateInformationMessage;
            var toUpdate:Boolean;
            var house1:GuildHouseWrapper;
            var ghw1:GuildHouseWrapper;
            var ghrmsg:GuildHouseRemoveMessage;
            var moveGuildHouse:Boolean;
            var iGHR:int;
            var giafmsg:GuildInAllianceFactsMessage;
            var members:GuildMember;
            var snm:int;
            var istatus:int;
            var frdstatus:FriendWrapper;
            var _local_205:ContactLookRequestByIdMessage;
            switch (true)
            {
                case (msg is GuildMembershipMessage):
                    _local_2 = (msg as GuildMembershipMessage);
                    if (this._guild != null)
                    {
                        this._guild.update(_local_2.guildInfo.guildId, _local_2.guildInfo.guildName, _local_2.guildInfo.guildEmblem, _local_2.memberRights, _local_2.enabled);
                    }
                    else
                    {
                        this._guild = GuildWrapper.create(_local_2.guildInfo.guildId, _local_2.guildInfo.guildName, _local_2.guildInfo.guildEmblem, _local_2.memberRights, _local_2.enabled);
                    };
                    this._hasGuild = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, true);
                    return (true);
                case (msg is FriendsListMessage):
                    _local_3 = (msg as FriendsListMessage);
                    this._friendsList = new Array();
                    for each (f in _local_3.friendsList)
                    {
                        if ((f is FriendOnlineInformations))
                        {
                            foi = (f as FriendOnlineInformations);
                            AccountManager.getInstance().setAccount(foi.playerName, foi.accountId, foi.accountName);
                            ChatAutocompleteNameManager.getInstance().addEntry((f as FriendOnlineInformations).playerName, 2);
                        };
                        fw = new FriendWrapper(f);
                        this._friendsList.push(fw);
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    return (true);
                case (msg is SpouseRequestAction):
                    _local_4 = (msg as SpouseRequestAction);
                    ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
                    return (true);
                case (msg is SpouseInformationsMessage):
                    _local_5 = (msg as SpouseInformationsMessage);
                    this._spouse = new SpouseWrapper(_local_5.spouse);
                    this._hasSpouse = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
                    return (true);
                case (msg is IgnoredListMessage):
                    this._enemiesList = new Array();
                    _local_6 = (msg as IgnoredListMessage);
                    for each (i in _local_6.ignoredList)
                    {
                        if ((i is IgnoredOnlineInformations))
                        {
                            ioi = (f as IgnoredOnlineInformations);
                            AccountManager.getInstance().setAccount(ioi.playerName, ioi.accountId, ioi.accountName);
                        };
                        ew = new EnemyWrapper(i);
                        this._enemiesList.push(ew);
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                    return (true);
                case (msg is OpenSocialAction):
                    _local_7 = (msg as OpenSocialAction);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, _local_7.name);
                    return (true);
                case (msg is FriendsListRequestAction):
                    _local_8 = (msg as FriendsListRequestAction);
                    ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
                    return (true);
                case (msg is EnemiesListRequestAction):
                    _local_9 = (msg as EnemiesListRequestAction);
                    ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
                    return (true);
                case (msg is AddFriendAction):
                    _local_10 = (msg as AddFriendAction);
                    if ((((_local_10.name.length < 2)) || ((_local_10.name.length > 20))))
                    {
                        _local_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else
                    {
                        if (_local_10.name != PlayedCharacterManager.getInstance().infos.name)
                        {
                            farmsg = new FriendAddRequestMessage();
                            farmsg.initFriendAddRequestMessage(_local_10.name);
                            ConnectionsHandler.getConnection().send(farmsg);
                        }
                        else
                        {
                            _local_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                        };
                    };
                    return (true);
                case (msg is FriendAddedMessage):
                    _local_11 = (msg as FriendAddedMessage);
                    if ((_local_11.friendAdded is FriendOnlineInformations))
                    {
                        foi = (_local_11.friendAdded as FriendOnlineInformations);
                        AccountManager.getInstance().setAccount(foi.playerName, foi.accountId, foi.accountName);
                        ChatAutocompleteNameManager.getInstance().addEntry((_local_11.friendAdded as FriendInformations).accountName, 2);
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendAdded, true);
                    _local_12 = new FriendWrapper(_local_11.friendAdded);
                    this._friendsList.push(_local_12);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    return (true);
                case (msg is FriendAddFailureMessage):
                    _local_13 = (msg as FriendAddFailureMessage);
                    switch (_local_13.reason)
                    {
                        case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                            _local_14 = I18n.getUiText("ui.common.unknowReason");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                            _local_14 = I18n.getUiText("ui.social.friend.addFailureListFull");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                            _local_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                            _local_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                            _local_14 = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is AddEnemyAction):
                    _local_15 = (msg as AddEnemyAction);
                    if ((((_local_15.name.length < ProtocolConstantsEnum.MIN_PLAYER_NAME_LEN)) || ((_local_15.name.length > ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN))))
                    {
                        _local_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else
                    {
                        if (_local_15.name != PlayedCharacterManager.getInstance().infos.name)
                        {
                            iarmsg = new IgnoredAddRequestMessage();
                            iarmsg.initIgnoredAddRequestMessage(_local_15.name);
                            ConnectionsHandler.getConnection().send(iarmsg);
                        }
                        else
                        {
                            _local_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                        };
                    };
                    return (true);
                case (msg is IgnoredAddedMessage):
                    _local_16 = (msg as IgnoredAddedMessage);
                    if ((_local_16.ignoreAdded is IgnoredOnlineInformations))
                    {
                        ioi = (_local_16.ignoreAdded as IgnoredOnlineInformations);
                        AccountManager.getInstance().setAccount(ioi.playerName, ioi.accountId, ioi.accountName);
                    };
                    if (!(_local_16.session))
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemyAdded, true);
                        enemyToAdd = new EnemyWrapper(_local_16.ignoreAdded);
                        this._enemiesList.push(enemyToAdd);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                    }
                    else
                    {
                        for each (_local_162 in this._ignoredList)
                        {
                            if (_local_162.name == _local_16.ignoreAdded.accountName)
                            {
                                return (true);
                            };
                        };
                        this._ignoredList.push(new IgnoredWrapper(_local_16.ignoreAdded.accountName, _local_16.ignoreAdded.accountId));
                        KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredAdded);
                    };
                    return (true);
                case (msg is IgnoredAddFailureMessage):
                    _local_17 = (msg as IgnoredAddFailureMessage);
                    switch (_local_17.reason)
                    {
                        case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                            _local_18 = I18n.getUiText("ui.common.unknowReason");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                            _local_18 = I18n.getUiText("ui.social.friend.addFailureListFull");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                            _local_18 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                            _local_18 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            break;
                        case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                            _local_18 = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_18, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is RemoveFriendAction):
                    _local_19 = (msg as RemoveFriendAction);
                    _local_20 = new FriendDeleteRequestMessage();
                    _local_20.initFriendDeleteRequestMessage(_local_19.accountId);
                    ConnectionsHandler.getConnection().send(_local_20);
                    return (true);
                case (msg is FriendDeleteResultMessage):
                    _local_21 = (msg as FriendDeleteResultMessage);
                    _local_22 = I18n.getUiText("ui.social.friend.delete");
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendRemoved, _local_21.success);
                    if (_local_21.success)
                    {
                        for (fd in this._friendsList)
                        {
                            if (this._friendsList[fd].name == _local_21.name)
                            {
                                this._friendsList.splice(fd, 1);
                            };
                        };
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_22, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is FriendUpdateMessage):
                    _local_23 = (msg as FriendUpdateMessage);
                    _local_24 = new FriendWrapper(_local_23.friendUpdated);
                    for each (frd in this._friendsList)
                    {
                        if (frd.name == _local_24.name)
                        {
                            frd = _local_24;
                            break;
                        };
                    };
                    _local_25 = (((_local_24.state == PlayerStateEnum.GAME_TYPE_ROLEPLAY)) || ((_local_24.state == PlayerStateEnum.GAME_TYPE_FIGHT)));
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                    if (((((((((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.FRIEND_CONNECTION)))) && (this._warnOnFrienConnec))) && (_local_24.online))) && (!(_local_25))))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.FRIEND_CONNECTION, [_local_24.name, _local_24.playerName, _local_24.playerId]);
                    };
                    return (true);
                case (msg is RemoveEnemyAction):
                    _local_26 = (msg as RemoveEnemyAction);
                    _local_27 = new IgnoredDeleteRequestMessage();
                    _local_27.initIgnoredDeleteRequestMessage(_local_26.accountId);
                    ConnectionsHandler.getConnection().send(_local_27);
                    return (true);
                case (msg is IgnoredDeleteResultMessage):
                    _local_28 = (msg as IgnoredDeleteResultMessage);
                    if (!(_local_28.session))
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemyRemoved, _local_28.success);
                        if (_local_28.success)
                        {
                            for (ed in this._enemiesList)
                            {
                                if (this._enemiesList[ed].name == _local_28.name)
                                {
                                    this._enemiesList.splice(ed, 1);
                                };
                            };
                        };
                        KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                    }
                    else
                    {
                        if (_local_28.success)
                        {
                            for (il in this._ignoredList)
                            {
                                if (this._ignoredList[il].name == _local_28.name)
                                {
                                    this._ignoredList.splice(il, 1);
                                };
                            };
                            KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredRemoved);
                        };
                    };
                    return (true);
                case (msg is AddIgnoredAction):
                    _local_29 = (msg as AddIgnoredAction);
                    if ((((_local_29.name.length < ProtocolConstantsEnum.MIN_PLAYER_NAME_LEN)) || ((_local_29.name.length > ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN))))
                    {
                        _local_14 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    else
                    {
                        if (_local_29.name != PlayedCharacterManager.getInstance().infos.name)
                        {
                            for each (ignoredAdd in this._ignoredList)
                            {
                                if (ignoredAdd.playerName == _local_29.name)
                                {
                                    return (true);
                                };
                            };
                            iar2msg = new IgnoredAddRequestMessage();
                            iar2msg.initIgnoredAddRequestMessage(_local_29.name, true);
                            ConnectionsHandler.getConnection().send(iar2msg);
                        }
                        else
                        {
                            _local_14 = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                        };
                    };
                    return (true);
                case (msg is RemoveIgnoredAction):
                    _local_30 = (msg as RemoveIgnoredAction);
                    _local_31 = new IgnoredDeleteRequestMessage();
                    _local_31.initIgnoredDeleteRequestMessage(_local_30.accountId, true);
                    ConnectionsHandler.getConnection().send(_local_31);
                    return (true);
                case (msg is JoinFriendAction):
                    _local_32 = (msg as JoinFriendAction);
                    _local_33 = new FriendJoinRequestMessage();
                    _local_33.initFriendJoinRequestMessage(_local_32.name);
                    ConnectionsHandler.getConnection().send(_local_33);
                    return (true);
                case (msg is JoinSpouseAction):
                    _local_34 = (msg as JoinSpouseAction);
                    ConnectionsHandler.getConnection().send(new FriendSpouseJoinRequestMessage());
                    return (true);
                case (msg is FriendSpouseFollowAction):
                    _local_35 = (msg as FriendSpouseFollowAction);
                    _local_36 = new FriendSpouseFollowWithCompassRequestMessage();
                    _local_36.initFriendSpouseFollowWithCompassRequestMessage(_local_35.enable);
                    ConnectionsHandler.getConnection().send(_local_36);
                    return (true);
                case (msg is FriendWarningSetAction):
                    _local_37 = (msg as FriendWarningSetAction);
                    this._warnOnFrienConnec = _local_37.enable;
                    _local_38 = new FriendSetWarnOnConnectionMessage();
                    _local_38.initFriendSetWarnOnConnectionMessage(_local_37.enable);
                    ConnectionsHandler.getConnection().send(_local_38);
                    return (true);
                case (msg is MemberWarningSetAction):
                    _local_39 = (msg as MemberWarningSetAction);
                    this._warnOnMemberConnec = _local_39.enable;
                    _local_40 = new GuildMemberSetWarnOnConnectionMessage();
                    _local_40.initGuildMemberSetWarnOnConnectionMessage(_local_39.enable);
                    ConnectionsHandler.getConnection().send(_local_40);
                    return (true);
                case (msg is FriendOrGuildMemberLevelUpWarningSetAction):
                    _local_41 = (msg as FriendOrGuildMemberLevelUpWarningSetAction);
                    this._warnWhenFriendOrGuildMemberLvlUp = _local_41.enable;
                    _local_42 = new FriendSetWarnOnLevelGainMessage();
                    _local_42.initFriendSetWarnOnLevelGainMessage(_local_41.enable);
                    ConnectionsHandler.getConnection().send(_local_42);
                    return (true);
                case (msg is FriendGuildSetWarnOnAchievementCompleteAction):
                    _local_43 = (msg as FriendGuildSetWarnOnAchievementCompleteAction);
                    this._warnWhenFriendOrGuildMemberAchieve = _local_43.enable;
                    _local_44 = new FriendGuildSetWarnOnAchievementCompleteMessage();
                    _local_44.initFriendGuildSetWarnOnAchievementCompleteMessage(_local_43.enable);
                    ConnectionsHandler.getConnection().send(_local_44);
                    return (true);
                case (msg is SpouseStatusMessage):
                    _local_45 = (msg as SpouseStatusMessage);
                    this._hasSpouse = _local_45.hasSpouse;
                    if (!(this._hasSpouse))
                    {
                        this._spouse = null;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, false);
                        KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ("flag_srv" + CompassTypeEnum.COMPASS_TYPE_SPOUSE), -1);
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
                    return (true);
                case (msg is MoodSmileyUpdateMessage):
                    _local_46 = (msg as MoodSmileyUpdateMessage);
                    if (this._guildMembers != null)
                    {
                        nm = this._guildMembers.length;
                        imood = 0;
                        while (imood < nm)
                        {
                            if (this._guildMembers[imood].id == _local_46.playerId)
                            {
                                this._guildMembers[imood].moodSmileyId = _local_46.smileyId;
                                memberm = this._guildMembers[imood];
                                KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate, memberm);
                                break;
                            };
                            imood++;
                        };
                    };
                    if (this._friendsList != null)
                    {
                        for each (frdmood in this._friendsList)
                        {
                            if (frdmood.accountId == _local_46.accountId)
                            {
                                frdmood.moodSmileyId = _local_46.smileyId;
                                KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                                break;
                            };
                        };
                    };
                    return (true);
                case (msg is FriendWarnOnConnectionStateMessage):
                    _local_47 = (msg as FriendWarnOnConnectionStateMessage);
                    this._warnOnFrienConnec = _local_47.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendWarningState, _local_47.enable);
                    return (true);
                case (msg is GuildMemberWarnOnConnectionStateMessage):
                    _local_48 = (msg as GuildMemberWarnOnConnectionStateMessage);
                    this._warnOnMemberConnec = _local_48.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.MemberWarningState, _local_48.enable);
                    return (true);
                case (msg is GuildMemberOnlineStatusMessage):
                    if (!(this._friendsList))
                    {
                        return (true);
                    };
                    _local_49 = (msg as GuildMemberOnlineStatusMessage);
                    if (((((((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.MEMBER_CONNECTION)))) && (this._warnOnMemberConnec))) && (_local_49.online)))
                    {
                        for each (gm in this._guildMembers)
                        {
                            if (gm.id == _local_49.memberId)
                            {
                                memberName = gm.name;
                                break;
                            };
                        };
                        friend = false;
                        for each (fr in this._friendsList)
                        {
                            if (fr.name == memberName)
                            {
                                friend = true;
                                break;
                            };
                        };
                        if (!(((friend) && (!(ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.FRIEND_CONNECTION))))))
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.MEMBER_CONNECTION, [memberName, _local_49.memberId]);
                        };
                    };
                    return (true);
                case (msg is FriendWarnOnLevelGainStateMessage):
                    _local_50 = (msg as FriendWarnOnLevelGainStateMessage);
                    this._warnWhenFriendOrGuildMemberLvlUp = _local_50.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendOrGuildMemberLevelUpWarningState, _local_50.enable);
                    return (true);
                case (msg is FriendGuildWarnOnAchievementCompleteStateMessage):
                    _local_51 = (msg as FriendGuildWarnOnAchievementCompleteStateMessage);
                    this._warnWhenFriendOrGuildMemberAchieve = _local_51.enable;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.FriendGuildWarnOnAchievementCompleteState, _local_51.enable);
                    return (true);
                case (msg is GuildInformationsMembersMessage):
                    _local_52 = (msg as GuildInformationsMembersMessage);
                    for each (mb in _local_52.members)
                    {
                        ChatAutocompleteNameManager.getInstance().addEntry(mb.name, 2);
                    };
                    this._guildMembers = _local_52.members;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    return (true);
                case (msg is GuildHousesInformationMessage):
                    _local_53 = (msg as GuildHousesInformationMessage);
                    this._guildHouses = new Vector.<GuildHouseWrapper>();
                    for each (houseInformation in _local_53.housesInformations)
                    {
                        ghw = GuildHouseWrapper.create(houseInformation);
                        this._guildHouses.push(ghw);
                    };
                    this._guildHousesList = true;
                    this._guildHousesListUpdate = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                    return (true);
                case (msg is GuildCreationStartedMessage):
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted, false, false);
                    return (true);
                case (msg is GuildModificationStartedMessage):
                    _local_54 = (msg as GuildModificationStartedMessage);
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted, _local_54.canChangeName, _local_54.canChangeEmblem);
                    return (true);
                case (msg is GuildCreationResultMessage):
                    _local_55 = (msg as GuildCreationResultMessage);
                    switch (_local_55.result)
                    {
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_ALREADY_IN_GROUP:
                            _local_56 = I18n.getUiText("ui.guild.alreadyInGuild");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                            _local_56 = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                            _local_56 = I18n.getUiText("ui.guild.AlreadyUseName");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                            _local_56 = I18n.getUiText("ui.guild.invalidName");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                            _local_56 = I18n.getUiText("ui.guild.requirementUnmet");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                            Kernel.getWorker().removeFrame(this._guildDialogFrame);
                            this._hasGuild = true;
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_UNKNOWN:
                            _local_56 = I18n.getUiText("ui.common.unknownFail");
                            break;
                    };
                    if (_local_56)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_56, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationResult, _local_55.result);
                    return (true);
                case (msg is GuildInvitedMessage):
                    _local_57 = (msg as GuildInvitedMessage);
                    Kernel.getWorker().addFrame(this._guildDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvited, _local_57.guildInfo.guildName, _local_57.recruterId, _local_57.recruterName);
                    return (true);
                case (msg is GuildInvitationStateRecruterMessage):
                    _local_58 = (msg as GuildInvitationStateRecruterMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruter, _local_58.invitationState, _local_58.recrutedName);
                    if ((((_local_58.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED)) || ((_local_58.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK))))
                    {
                        Kernel.getWorker().removeFrame(this._guildDialogFrame);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._guildDialogFrame);
                    };
                    return (true);
                case (msg is GuildInvitationStateRecrutedMessage):
                    _local_59 = (msg as GuildInvitationStateRecrutedMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruted, _local_59.invitationState);
                    if ((((_local_59.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED)) || ((_local_59.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK))))
                    {
                        Kernel.getWorker().removeFrame(this._guildDialogFrame);
                    };
                    return (true);
                case (msg is GuildJoinedMessage):
                    _local_60 = (msg as GuildJoinedMessage);
                    this._hasGuild = true;
                    this._guild = GuildWrapper.create(_local_60.guildInfo.guildId, _local_60.guildInfo.guildName, _local_60.guildInfo.guildEmblem, _local_60.memberRights, _local_60.enabled);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, true);
                    _local_61 = I18n.getUiText("ui.guild.JoinGuildMessage", [_local_60.guildInfo.guildName]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_61, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is GuildInformationsGeneralMessage):
                    _local_62 = (msg as GuildInformationsGeneralMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsGeneral, _local_62.enabled, _local_62.expLevelFloor, _local_62.experience, _local_62.expNextLevelFloor, _local_62.level, _local_62.creationDate, _local_62.abandonnedPaddock, _local_62.nbConnectedMembers, _local_62.nbTotalMembers);
                    this._guild.level = _local_62.level;
                    this._guild.experience = _local_62.experience;
                    this._guild.expLevelFloor = _local_62.expLevelFloor;
                    this._guild.expNextLevelFloor = _local_62.expNextLevelFloor;
                    this._guild.creationDate = _local_62.creationDate;
                    this._guild.nbMembers = _local_62.nbTotalMembers;
                    this._guild.nbConnectedMembers = _local_62.nbConnectedMembers;
                    return (true);
                case (msg is GuildInformationsMemberUpdateMessage):
                    _local_63 = (msg as GuildInformationsMemberUpdateMessage);
                    if (this._guildMembers != null)
                    {
                        nmu = this._guildMembers.length;
                        k = 0;
                        while (k < nmu)
                        {
                            _local_64 = this._guildMembers[k];
                            if (_local_64.id == _local_63.member.id)
                            {
                                this._guildMembers[k] = _local_63.member;
                                if (_local_64.id == PlayedCharacterManager.getInstance().id)
                                {
                                    this.guild.memberRightsNumber = _local_63.member.rights;
                                };
                                break;
                            };
                            k++;
                        };
                    }
                    else
                    {
                        this._guildMembers = new Vector.<GuildMember>();
                        _local_64 = _local_63.member;
                        this._guildMembers.push(_local_64);
                        if (_local_64.id == PlayedCharacterManager.getInstance().id)
                        {
                            this.guild.memberRightsNumber = _local_64.rights;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate, _local_63.member);
                    return (true);
                case (msg is GuildMemberLeavingMessage):
                    _local_65 = (msg as GuildMemberLeavingMessage);
                    _local_66 = 0;
                    for each (guildMember in this._guildMembers)
                    {
                        if (_local_65.memberId == guildMember.id)
                        {
                            this._guildMembers.splice(_local_66, 1);
                        };
                        _local_66++;
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers, this._guildMembers);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMemberLeaving, _local_65.kicked, _local_65.memberId);
                    return (true);
                case (msg is GuildLeftMessage):
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildLeft);
                    this._hasGuild = false;
                    this._guild = null;
                    this._guildHousesList = false;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated, false);
                    return (true);
                case (msg is GuildInfosUpgradeMessage):
                    _local_67 = (msg as GuildInfosUpgradeMessage);
                    TaxCollectorsManager.getInstance().updateGuild(_local_67.maxTaxCollectorsCount, _local_67.taxCollectorsCount, _local_67.taxCollectorLifePoints, _local_67.taxCollectorDamagesBonuses, _local_67.taxCollectorPods, _local_67.taxCollectorProspecting, _local_67.taxCollectorWisdom);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInfosUpgrade, _local_67.boostPoints, _local_67.maxTaxCollectorsCount, _local_67.spellId, _local_67.spellLevel, _local_67.taxCollectorDamagesBonuses, _local_67.taxCollectorLifePoints, _local_67.taxCollectorPods, _local_67.taxCollectorProspecting, _local_67.taxCollectorsCount, _local_67.taxCollectorWisdom);
                    return (true);
                case (msg is GuildFightPlayersHelpersJoinMessage):
                    _local_68 = (msg as GuildFightPlayersHelpersJoinMessage);
                    TaxCollectorsManager.getInstance().addFighter(0, _local_68.fightId, _local_68.playerInfo, true);
                    return (true);
                case (msg is GuildFightPlayersHelpersLeaveMessage):
                    _local_69 = (msg as GuildFightPlayersHelpersLeaveMessage);
                    if (this._autoLeaveHelpers)
                    {
                        text = I18n.getUiText("ui.social.guild.autoFightLeave");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    TaxCollectorsManager.getInstance().removeFighter(0, _local_69.fightId, _local_69.playerId, true);
                    return (true);
                case (msg is GuildFightPlayersEnemiesListMessage):
                    _local_70 = (msg as GuildFightPlayersEnemiesListMessage);
                    for each (enemy in _local_70.playerInfo)
                    {
                        TaxCollectorsManager.getInstance().addFighter(0, _local_70.fightId, enemy, false, false);
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, 0, _local_70.fightId);
                    return (true);
                case (msg is GuildFightPlayersEnemyRemoveMessage):
                    _local_71 = (msg as GuildFightPlayersEnemyRemoveMessage);
                    TaxCollectorsManager.getInstance().removeFighter(0, _local_71.fightId, _local_71.playerId, false);
                    return (true);
                case (msg is TaxCollectorMovementMessage):
                    _local_72 = (msg as TaxCollectorMovementMessage);
                    _local_74 = ((TaxCollectorFirstname.getTaxCollectorFirstnameById(_local_72.basicInfos.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(_local_72.basicInfos.lastNameId).name);
                    _local_75 = new WorldPointWrapper(_local_72.basicInfos.mapId, true, _local_72.basicInfos.worldX, _local_72.basicInfos.worldY);
                    _local_76 = String(_local_75.outdoorX);
                    _local_77 = String(_local_75.outdoorY);
                    _local_78 = ((_local_76 + ",") + _local_77);
                    switch (_local_72.hireOrFire)
                    {
                        case true:
                            _local_73 = I18n.getUiText("ui.social.TaxCollectorAdded", [_local_74, _local_78, _local_72.playerName]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_73, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                            break;
                        case false:
                            _local_73 = I18n.getUiText("ui.social.TaxCollectorRemoved", [_local_74, _local_78, _local_72.playerName]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_73, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                            break;
                    };
                    return (true);
                case (msg is TaxCollectorAttackedMessage):
                    _local_79 = (msg as TaxCollectorAttackedMessage);
                    _local_80 = _local_79.worldX;
                    _local_81 = _local_79.worldY;
                    _local_82 = ((TaxCollectorFirstname.getTaxCollectorFirstnameById(_local_79.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(_local_79.lastNameId).name);
                    if (((!(_local_79.guild)) || ((_local_79.guild.guildId == this._guild.guildId))))
                    {
                        _local_83 = I18n.getUiText("ui.social.TaxCollectorAttacked", [_local_82, ((_local_80 + ",") + _local_81)]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, (("{openSocial,1,2::" + _local_83) + "}"), ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                    }
                    else
                    {
                        _local_185 = _local_79.guild.guildName;
                        _local_186 = SubArea.getSubAreaById(_local_79.subAreaId).name;
                        _local_83 = I18n.getUiText("ui.guild.taxCollectorAttacked", [_local_185, _local_186, ((_local_80 + ",") + _local_81)]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, (((("{openSocial,2,2,0," + _local_79.mapId) + "::") + _local_83) + "}"), ChatActivableChannelsEnum.CHANNEL_ALLIANCE, TimeManager.getInstance().getTimestamp());
                    };
                    if (((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK))))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK, [_local_82, _local_80, _local_81]);
                    };
                    if (((this._guild.alliance) && (OptionManager.getOptionManager("dofus")["warnOnGuildItemAgression"])))
                    {
                        suba = SubArea.getSubAreaById(_local_79.subAreaId);
                        nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.taxCollectorAttackedTitle"), I18n.getUiText("ui.guild.taxCollectorAttacked", [_local_79.guild.guildName, suba.name, ((_local_80 + ",") + _local_81)]), NotificationTypeEnum.INVITATION, "TaxCollectorAttacked");
                        NotificationManager.getInstance().addButtonToNotification(nid, I18n.getUiText("ui.common.join"), "OpenSocial", [2, 2, [0, _local_79.mapId]], true, 200, 0, "hook");
                        NotificationManager.getInstance().sendNotification(nid);
                    };
                    return (true);
                case (msg is TaxCollectorAttackedResultMessage):
                    _local_84 = (msg as TaxCollectorAttackedResultMessage);
                    _local_86 = ((TaxCollectorFirstname.getTaxCollectorFirstnameById(_local_84.basicInfos.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(_local_84.basicInfos.lastNameId).name);
                    _local_87 = _local_84.guild.guildName;
                    if (_local_87 == "#NONAME#")
                    {
                        _local_87 = I18n.getUiText("ui.guild.noName");
                    };
                    _local_88 = new WorldPointWrapper(_local_84.basicInfos.mapId, true, _local_84.basicInfos.worldX, _local_84.basicInfos.worldY);
                    _local_89 = _local_88.outdoorX;
                    _local_90 = _local_88.outdoorY;
                    if (((!(_local_84.guild)) || ((_local_84.guild.guildId == this._guild.guildId))))
                    {
                        if (_local_84.deadOrAlive)
                        {
                            _local_85 = I18n.getUiText("ui.social.TaxCollectorDied", [_local_86, ((_local_89 + ",") + _local_90)]);
                        }
                        else
                        {
                            _local_85 = I18n.getUiText("ui.social.TaxCollectorSurvived", [_local_86, ((_local_89 + ",") + _local_90)]);
                        };
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_85, ChatActivableChannelsEnum.CHANNEL_GUILD, TimeManager.getInstance().getTimestamp());
                    }
                    else
                    {
                        if (_local_84.deadOrAlive)
                        {
                            _local_85 = I18n.getUiText("ui.alliance.taxCollectorDied", [_local_87, ((_local_89 + ",") + _local_90)]);
                        }
                        else
                        {
                            _local_85 = I18n.getUiText("ui.alliance.taxCollectorSurvived", [_local_87, ((_local_89 + ",") + _local_90)]);
                        };
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_85, ChatActivableChannelsEnum.CHANNEL_ALLIANCE, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is TaxCollectorErrorMessage):
                    _local_91 = (msg as TaxCollectorErrorMessage);
                    _local_92 = "";
                    switch (_local_91.reason)
                    {
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ALREADY_ONE:
                            _local_92 = I18n.getUiText("ui.social.alreadyTaxCollectorOnMap");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_HERE:
                            _local_92 = I18n.getUiText("ui.social.cantHireTaxCollecotrHere");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_YET:
                            _local_92 = I18n.getUiText("ui.social.cantHireTaxcollectorTooTired");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ERROR_UNKNOWN:
                            _local_92 = I18n.getUiText("ui.social.unknownErrorTaxCollector");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_MAX_REACHED:
                            _local_92 = I18n.getUiText("ui.social.cantHireMaxTaxCollector");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NO_RIGHTS:
                            _local_92 = I18n.getUiText("ui.social.taxCollectorNoRights");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_ENOUGH_KAMAS:
                            _local_92 = I18n.getUiText("ui.social.notEnougthRichToHireTaxCollector");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_FOUND:
                            _local_92 = I18n.getUiText("ui.social.taxCollectorNotFound");
                            break;
                        case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_OWNED:
                            _local_92 = I18n.getUiText("ui.social.notYourTaxcollector");
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_92, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is TaxCollectorListMessage):
                    _local_93 = (msg as TaxCollectorListMessage);
                    TaxCollectorsManager.getInstance().maxTaxCollectorsCount = _local_93.nbcollectorMax;
                    TaxCollectorsManager.getInstance().setTaxCollectors(_local_93.informations);
                    TaxCollectorsManager.getInstance().setTaxCollectorsFighters(_local_93.fightersInformations);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorListUpdate);
                    return (true);
                case (msg is TaxCollectorMovementAddMessage):
                    _local_94 = (msg as TaxCollectorMovementAddMessage);
                    _local_95 = -1;
                    if (TaxCollectorsManager.getInstance().taxCollectors[_local_94.informations.uniqueId])
                    {
                        _local_95 = TaxCollectorsManager.getInstance().taxCollectors[_local_94.informations.uniqueId].state;
                    };
                    _local_96 = TaxCollectorsManager.getInstance().addTaxCollector(_local_94.informations);
                    _local_97 = TaxCollectorsManager.getInstance().taxCollectors[_local_94.informations.uniqueId].state;
                    if (((_local_96) || (!((_local_97 == _local_95)))))
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorUpdate, _local_94.informations.uniqueId);
                    };
                    if (_local_96)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorAdd, TaxCollectorsManager.getInstance().taxCollectors[_local_94.informations.uniqueId]);
                    };
                    return (true);
                case (msg is TaxCollectorMovementRemoveMessage):
                    _local_98 = (msg as TaxCollectorMovementRemoveMessage);
                    delete TaxCollectorsManager.getInstance().taxCollectors[_local_98.collectorId];
                    delete TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[_local_98.collectorId];
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorRemoved, _local_98.collectorId);
                    return (true);
                case (msg is TaxCollectorStateUpdateMessage):
                    _local_99 = (msg as TaxCollectorStateUpdateMessage);
                    if (TaxCollectorsManager.getInstance().taxCollectors[_local_99.uniqueId])
                    {
                        TaxCollectorsManager.getInstance().taxCollectors[_local_99.uniqueId].state = _local_99.state;
                    };
                    if (TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[_local_99.uniqueId])
                    {
                        if (_local_99.state != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                        {
                            delete TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[_local_99.uniqueId];
                            KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceTaxCollectorRemoved, _local_99.uniqueId);
                        };
                    };
                    return (true);
                case (msg is GuildInformationsPaddocksMessage):
                    _local_100 = (msg as GuildInformationsPaddocksMessage);
                    this._guildPaddocksMax = _local_100.nbPaddockMax;
                    this._guildPaddocks = _local_100.paddocksInformations;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsFarms);
                    return (true);
                case (msg is GuildPaddockBoughtMessage):
                    _local_101 = (msg as GuildPaddockBoughtMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockAdd, _local_101.paddockInfo);
                    return (true);
                case (msg is GuildPaddockRemovedMessage):
                    _local_102 = (msg as GuildPaddockRemovedMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockRemoved, _local_102.paddockId);
                    return (true);
                case (msg is AllianceTaxCollectorDialogQuestionExtendedMessage):
                    _local_103 = (msg as AllianceTaxCollectorDialogQuestionExtendedMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceTaxCollectorDialogQuestionExtended, _local_103.guildInfo.guildName, _local_103.maxPods, _local_103.prospecting, _local_103.wisdom, _local_103.taxCollectorsCount, _local_103.taxCollectorAttack, _local_103.kamas, _local_103.experience, _local_103.pods, _local_103.itemsValue, _local_103.alliance);
                    return (true);
                case (msg is TaxCollectorDialogQuestionExtendedMessage):
                    _local_104 = (msg as TaxCollectorDialogQuestionExtendedMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionExtended, _local_104.guildInfo.guildName, _local_104.maxPods, _local_104.prospecting, _local_104.wisdom, _local_104.taxCollectorsCount, _local_104.taxCollectorAttack, _local_104.kamas, _local_104.experience, _local_104.pods, _local_104.itemsValue);
                    return (true);
                case (msg is TaxCollectorDialogQuestionBasicMessage):
                    _local_105 = (msg as TaxCollectorDialogQuestionBasicMessage);
                    _local_106 = GuildWrapper.create(0, _local_105.guildInfo.guildName, null, 0, true);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionBasic, _local_106.guildName);
                    return (true);
                case (msg is ContactLookMessage):
                    _local_107 = (msg as ContactLookMessage);
                    if (_local_107.requestId == 0)
                    {
                        KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, _local_107.playerId, _local_107.playerName, EntityLookAdapter.fromNetwork(_local_107.look));
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ContactLook, _local_107.playerId, _local_107.playerName, EntityLookAdapter.fromNetwork(_local_107.look));
                    };
                    return (true);
                case (msg is ContactLookErrorMessage):
                    _local_108 = (msg as ContactLookErrorMessage);
                    return (true);
                case (msg is GuildGetInformationsAction):
                    _local_109 = (msg as GuildGetInformationsAction);
                    _local_110 = true;
                    switch (_local_109.infoType)
                    {
                        case GuildInformationsTypeEnum.INFO_MEMBERS:
                            break;
                        case GuildInformationsTypeEnum.INFO_HOUSES:
                            if (this._guildHousesList)
                            {
                                _local_110 = false;
                                if (this._guildHousesListUpdate)
                                {
                                    this._guildHousesListUpdate = false;
                                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                                };
                            };
                            break;
                    };
                    if (_local_110)
                    {
                        ggimsg = new GuildGetInformationsMessage();
                        ggimsg.initGuildGetInformationsMessage(_local_109.infoType);
                        ConnectionsHandler.getConnection().send(ggimsg);
                    };
                    return (true);
                case (msg is GuildInvitationAction):
                    _local_111 = (msg as GuildInvitationAction);
                    _local_112 = new GuildInvitationMessage();
                    _local_112.initGuildInvitationMessage(_local_111.targetId);
                    ConnectionsHandler.getConnection().send(_local_112);
                    return (true);
                case (msg is GuildInvitationByNameAction):
                    _local_113 = (msg as GuildInvitationByNameAction);
                    _local_114 = new GuildInvitationByNameMessage();
                    _local_114.initGuildInvitationByNameMessage(_local_113.target);
                    ConnectionsHandler.getConnection().send(_local_114);
                    return (true);
                case (msg is GuildKickRequestAction):
                    _local_115 = (msg as GuildKickRequestAction);
                    _local_116 = new GuildKickRequestMessage();
                    _local_116.initGuildKickRequestMessage(_local_115.targetId);
                    ConnectionsHandler.getConnection().send(_local_116);
                    return (true);
                case (msg is GuildChangeMemberParametersAction):
                    _local_117 = (msg as GuildChangeMemberParametersAction);
                    _local_118 = GuildWrapper.getRightsNumber(_local_117.rights);
                    _local_119 = new GuildChangeMemberParametersMessage();
                    _local_119.initGuildChangeMemberParametersMessage(_local_117.memberId, _local_117.rank, _local_117.experienceGivenPercent, _local_118);
                    ConnectionsHandler.getConnection().send(_local_119);
                    return (true);
                case (msg is GuildSpellUpgradeRequestAction):
                    _local_120 = (msg as GuildSpellUpgradeRequestAction);
                    _local_121 = new GuildSpellUpgradeRequestMessage();
                    _local_121.initGuildSpellUpgradeRequestMessage(_local_120.spellId);
                    ConnectionsHandler.getConnection().send(_local_121);
                    return (true);
                case (msg is GuildCharacsUpgradeRequestAction):
                    _local_122 = (msg as GuildCharacsUpgradeRequestAction);
                    _local_123 = new GuildCharacsUpgradeRequestMessage();
                    _local_123.initGuildCharacsUpgradeRequestMessage(_local_122.charaTypeTarget);
                    ConnectionsHandler.getConnection().send(_local_123);
                    return (true);
                case (msg is GuildFarmTeleportRequestAction):
                    _local_124 = (msg as GuildFarmTeleportRequestAction);
                    _local_125 = new GuildPaddockTeleportRequestMessage();
                    _local_125.initGuildPaddockTeleportRequestMessage(_local_124.farmId);
                    ConnectionsHandler.getConnection().send(_local_125);
                    return (true);
                case (msg is GuildHouseTeleportRequestAction):
                    _local_126 = (msg as GuildHouseTeleportRequestAction);
                    _local_127 = new GuildHouseTeleportRequestMessage();
                    _local_127.initGuildHouseTeleportRequestMessage(_local_126.houseId);
                    ConnectionsHandler.getConnection().send(_local_127);
                    return (true);
                case (msg is GuildFightJoinRequestAction):
                    _local_128 = (msg as GuildFightJoinRequestAction);
                    _local_129 = new GuildFightJoinRequestMessage();
                    _local_129.initGuildFightJoinRequestMessage(_local_128.taxCollectorId);
                    ConnectionsHandler.getConnection().send(_local_129);
                    return (true);
                case (msg is GuildFightTakePlaceRequestAction):
                    _local_130 = (msg as GuildFightTakePlaceRequestAction);
                    _local_131 = new GuildFightTakePlaceRequestMessage();
                    _local_131.initGuildFightTakePlaceRequestMessage(_local_130.taxCollectorId, _local_130.replacedCharacterId);
                    ConnectionsHandler.getConnection().send(_local_131);
                    return (true);
                case (msg is GuildFightLeaveRequestAction):
                    _local_132 = (msg as GuildFightLeaveRequestAction);
                    this._autoLeaveHelpers = false;
                    if (_local_132.warning)
                    {
                        for each (tc2 in TaxCollectorsManager.getInstance().taxCollectors)
                        {
                            if (tc2.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                            {
                                tcInFight = TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[tc2.uniqueId];
                                for each (defender in tcInFight.allyCharactersInformations)
                                {
                                    if (defender.playerCharactersInformations.id == _local_132.characterId)
                                    {
                                        this._autoLeaveHelpers = true;
                                        _local_133 = new GuildFightLeaveRequestMessage();
                                        _local_133.initGuildFightLeaveRequestMessage(tc2.uniqueId, _local_132.characterId);
                                        ConnectionsHandler.getConnection().send(_local_133);
                                    };
                                };
                            };
                        };
                    }
                    else
                    {
                        _local_133 = new GuildFightLeaveRequestMessage();
                        _local_133.initGuildFightLeaveRequestMessage(_local_132.taxCollectorId, _local_132.characterId);
                        ConnectionsHandler.getConnection().send(_local_133);
                    };
                    return (true);
                case (msg is GuildHouseUpdateInformationMessage):
                    if (this._guildHousesList)
                    {
                        ghuimsg = (msg as GuildHouseUpdateInformationMessage);
                        toUpdate = false;
                        for each (house1 in this._guildHouses)
                        {
                            if (house1.houseId == ghuimsg.housesInformations.houseId)
                            {
                                house1.update(ghuimsg.housesInformations);
                                toUpdate = true;
                            };
                            KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                        };
                        if (!(toUpdate))
                        {
                            ghw1 = GuildHouseWrapper.create(ghuimsg.housesInformations);
                            this._guildHouses.push(ghw1);
                            KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseAdd, ghw1);
                        };
                        this._guildHousesListUpdate = true;
                    };
                    return (true);
                case (msg is GuildHouseRemoveMessage):
                    if (this._guildHousesList)
                    {
                        ghrmsg = (msg as GuildHouseRemoveMessage);
                        moveGuildHouse = false;
                        iGHR = 0;
                        while (iGHR < this._guildHouses.length)
                        {
                            if (this._guildHouses[iGHR].houseId == ghrmsg.houseId)
                            {
                                this._guildHouses.splice(iGHR, 1);
                                break;
                            };
                            iGHR++;
                        };
                        this._guildHousesListUpdate = true;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseRemoved, ghrmsg.houseId);
                    };
                    return (true);
                case (msg is GuildFactsRequestAction):
                    _local_134 = (msg as GuildFactsRequestAction);
                    _local_135 = new GuildFactsRequestMessage();
                    _local_135.initGuildFactsRequestMessage(_local_134.guildId);
                    ConnectionsHandler.getConnection().send(_local_135);
                    return (true);
                case (msg is GuildFactsMessage):
                    _local_136 = (msg as GuildFactsMessage);
                    _local_137 = this._allGuilds[_local_136.infos.guildId];
                    _local_138 = 0;
                    _local_139 = "";
                    _local_140 = "";
                    if ((msg is GuildInAllianceFactsMessage))
                    {
                        giafmsg = (msg as GuildInAllianceFactsMessage);
                        _local_138 = giafmsg.allianceInfos.allianceId;
                        _local_139 = giafmsg.allianceInfos.allianceName;
                        _local_140 = giafmsg.allianceInfos.allianceTag;
                    };
                    if (_local_137)
                    {
                        _local_137.update(_local_136.infos.guildId, _local_136.infos.guildName, _local_136.infos.guildEmblem, _local_136.infos.leaderId, _local_137.leaderName, _local_136.infos.guildLevel, _local_136.infos.nbMembers, _local_136.creationDate, _local_136.members, _local_137.nbConnectedMembers, _local_136.nbTaxCollectors, _local_137.lastActivity, _local_136.enabled, _local_138, _local_139, _local_140, _local_137.allianceLeader);
                    }
                    else
                    {
                        _local_137 = GuildFactSheetWrapper.create(_local_136.infos.guildId, _local_136.infos.guildName, _local_136.infos.guildEmblem, _local_136.infos.leaderId, "", _local_136.infos.guildLevel, _local_136.infos.nbMembers, _local_136.creationDate, _local_136.members, 0, _local_136.nbTaxCollectors, 0, _local_136.enabled, _local_138, _local_139, _local_140);
                        this._allGuilds[_local_136.infos.guildId] = _local_137;
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.OpenOneGuild, _local_137);
                    return (true);
                case (msg is GuildFactsErrorMessage):
                    _local_141 = (msg as GuildFactsErrorMessage);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.guild.doesntExistAnymore"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is CharacterReportAction):
                    _local_142 = (msg as CharacterReportAction);
                    _local_143 = new CharacterReportMessage();
                    _local_143.initCharacterReportMessage(_local_142.reportedId, _local_142.reason);
                    ConnectionsHandler.getConnection().send(_local_143);
                    return (true);
                case (msg is ChatReportAction):
                    _local_144 = (msg as ChatReportAction);
                    _local_145 = new ChatMessageReportMessage();
                    _local_146 = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
                    _local_147 = _local_146.getTimestampServerByRealTimestamp(_local_144.timestamp);
                    _local_145.initChatMessageReportMessage(_local_144.name, _local_144.message, _local_147, _local_144.channel, _local_144.fingerprint, _local_144.reason);
                    ConnectionsHandler.getConnection().send(_local_145);
                    return (true);
                case (msg is PlayerStatusUpdateMessage):
                    _local_148 = (msg as PlayerStatusUpdateMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.PlayerStatusUpdate, _local_148.accountId, _local_148.playerId, _local_148.status.statusId);
                    if (this._guildMembers != null)
                    {
                        snm = this._guildMembers.length;
                        istatus = 0;
                        while (istatus < snm)
                        {
                            if (this._guildMembers[istatus].id == _local_148.playerId)
                            {
                                this._guildMembers[istatus].status = _local_148.status;
                                members = this._guildMembers[istatus];
                                KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate, members);
                                break;
                            };
                            istatus++;
                        };
                    };
                    if (this._friendsList != null)
                    {
                        for each (frdstatus in this._friendsList)
                        {
                            if (frdstatus.accountId == _local_148.accountId)
                            {
                                frdstatus.statusId = _local_148.status.statusId;
                                if ((_local_148.status is PlayerStatusExtended))
                                {
                                    frdstatus.awayMessage = PlayerStatusExtended(_local_148.status).message;
                                };
                                KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                                break;
                            };
                        };
                    };
                    return (false);
                case (msg is PlayerStatusUpdateRequestAction):
                    _local_149 = (msg as PlayerStatusUpdateRequestAction);
                    if (_local_149.message)
                    {
                        _local_150 = new PlayerStatusExtended();
                        PlayerStatusExtended(_local_150).initPlayerStatusExtended(_local_149.status, _local_149.message);
                    }
                    else
                    {
                        _local_150 = new PlayerStatus();
                        _local_150.initPlayerStatus(_local_149.status);
                    };
                    _local_151 = new PlayerStatusUpdateRequestMessage();
                    _local_151.initPlayerStatusUpdateRequestMessage(_local_150);
                    ConnectionsHandler.getConnection().send(_local_151);
                    return (true);
                case (msg is ContactLookRequestByIdAction):
                    _local_152 = (msg as ContactLookRequestByIdAction);
                    if (_local_152.entityId == PlayedCharacterManager.getInstance().id)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ContactLook, PlayedCharacterManager.getInstance().id, PlayedCharacterManager.getInstance().infos.name, EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
                    }
                    else
                    {
                        _local_205 = new ContactLookRequestByIdMessage();
                        _local_205.initContactLookRequestByIdMessage(1, _local_152.contactType, _local_152.entityId);
                        ConnectionsHandler.getConnection().send(_local_205);
                    };
                    return (true);
            };
            return (false);
        }

        public function isIgnored(name:String, accountId:int=0):Boolean
        {
            var loser:IgnoredWrapper;
            var accountName:String = AccountManager.getInstance().getAccountName(name);
            for each (loser in this._ignoredList)
            {
                if (((((!((accountId == 0))) && ((loser.accountId == accountId)))) || (((accountName) && ((loser.name.toLowerCase() == accountName.toLowerCase()))))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function isFriend(playerName:String):Boolean
        {
            var fw:FriendWrapper;
            var n:int = this._friendsList.length;
            var i:int;
            while (i < n)
            {
                fw = this._friendsList[i];
                if (fw.playerName == playerName)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function isEnemy(playerName:String):Boolean
        {
            var ew:EnemyWrapper;
            var n:int = this._enemiesList.length;
            var i:int;
            while (i < n)
            {
                ew = this._enemiesList[i];
                if (ew.playerName == playerName)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

