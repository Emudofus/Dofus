package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildHouseWrapper;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.friend.FriendsGetListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredGetListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.SpouseGetInformationsMessage;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import com.ankamagames.jerakine.messages.Message;
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
   import com.ankamagames.dofus.logic.game.common.actions.social.WarnOnHardcoreDeathAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.death.WarnOnPermaDeathMessage;
   import com.ankamagames.dofus.network.messages.game.friend.SpouseStatusMessage;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.MoodSmileyUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendWarnOnConnectionStateMessage;
   import com.ankamagames.dofus.network.messages.game.friend.GuildMemberWarnOnConnectionStateMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMemberOnlineStatusMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendWarnOnLevelGainStateMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.FriendGuildWarnOnAchievementCompleteStateMessage;
   import com.ankamagames.dofus.network.messages.game.friend.WarnOnPermaDeathStateMessage;
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
   import com.ankamagames.dofus.network.messages.game.guild.tax.TopTaxCollectorListMessage;
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
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.network.messages.game.guild.GuildGetInformationsMessage;
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
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.game.friend.FriendSpouseJoinRequestMessage;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupInvitationStateEnum;
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
   import com.ankamagames.dofus.network.messages.game.guild.GuildCreationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildLeftMessage;
   
   public class SocialFrame extends Object implements Frame
   {
      
      public function SocialFrame()
      {
         this._guildHouses = new Vector.<GuildHouseWrapper>();
         this._guildPaddocks = new Vector.<PaddockContentInformations>();
         this._allGuilds = new Dictionary(true);
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialFrame));
      
      private static var _instance:SocialFrame;
      
      public static function getInstance() : SocialFrame
      {
         return _instance;
      }
      
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
      
      private var _warnOnHardcoreDeath:Boolean;
      
      private var _autoLeaveHelpers:Boolean;
      
      private var _allGuilds:Dictionary;
      
      private var _socialDatFrame:SocialDataFrame;
      
      private var _dungeonTopTaxCollectors:Vector.<TaxCollectorInformations>;
      
      private var _topTaxCollectors:Vector.<TaxCollectorInformations>;
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get friendsList() : Array
      {
         return this._friendsList;
      }
      
      public function get enemiesList() : Array
      {
         return this._enemiesList;
      }
      
      public function get ignoredList() : Array
      {
         return this._ignoredList;
      }
      
      public function get spouse() : SpouseWrapper
      {
         return this._spouse;
      }
      
      public function get hasGuild() : Boolean
      {
         return this._hasGuild;
      }
      
      public function get hasSpouse() : Boolean
      {
         return this._hasSpouse;
      }
      
      public function get guild() : GuildWrapper
      {
         return this._guild;
      }
      
      public function get guildmembers() : Vector.<GuildMember>
      {
         return this._guildMembers;
      }
      
      public function get guildHouses() : Vector.<GuildHouseWrapper>
      {
         return this._guildHouses;
      }
      
      public function get guildPaddocks() : Vector.<PaddockContentInformations>
      {
         return this._guildPaddocks;
      }
      
      public function get maxGuildPaddocks() : int
      {
         return this._guildPaddocksMax;
      }
      
      public function get warnFriendConnec() : Boolean
      {
         return this._warnOnFrienConnec;
      }
      
      public function get warnMemberConnec() : Boolean
      {
         return this._warnOnMemberConnec;
      }
      
      public function get warnWhenFriendOrGuildMemberLvlUp() : Boolean
      {
         return this._warnWhenFriendOrGuildMemberLvlUp;
      }
      
      public function get warnWhenFriendOrGuildMemberAchieve() : Boolean
      {
         return this._warnWhenFriendOrGuildMemberAchieve;
      }
      
      public function get warnOnHardcoreDeath() : Boolean
      {
         return this._warnOnHardcoreDeath;
      }
      
      public function get guildHousesUpdateNeeded() : Boolean
      {
         return this._guildHousesListUpdate;
      }
      
      public function getGuildById(param1:int) : GuildFactSheetWrapper
      {
         return this._allGuilds[param1];
      }
      
      public function updateGuildById(param1:int, param2:GuildFactSheetWrapper) : void
      {
         this._allGuilds[param1] = param2;
      }
      
      public function pushed() : Boolean
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
         return true;
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         TaxCollectorsManager.getInstance().destroy();
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:GuildMembershipMessage = null;
         var _loc3_:FriendsListMessage = null;
         var _loc4_:SpouseRequestAction = null;
         var _loc5_:SpouseInformationsMessage = null;
         var _loc6_:IgnoredListMessage = null;
         var _loc7_:OpenSocialAction = null;
         var _loc8_:FriendsListRequestAction = null;
         var _loc9_:EnemiesListRequestAction = null;
         var _loc10_:AddFriendAction = null;
         var _loc11_:FriendAddedMessage = null;
         var _loc12_:FriendWrapper = null;
         var _loc13_:FriendAddFailureMessage = null;
         var _loc14_:String = null;
         var _loc15_:AddEnemyAction = null;
         var _loc16_:IgnoredAddedMessage = null;
         var _loc17_:IgnoredAddFailureMessage = null;
         var _loc18_:String = null;
         var _loc19_:RemoveFriendAction = null;
         var _loc20_:FriendDeleteRequestMessage = null;
         var _loc21_:FriendDeleteResultMessage = null;
         var _loc22_:String = null;
         var _loc23_:FriendUpdateMessage = null;
         var _loc24_:FriendWrapper = null;
         var _loc25_:* = false;
         var _loc26_:RemoveEnemyAction = null;
         var _loc27_:IgnoredDeleteRequestMessage = null;
         var _loc28_:IgnoredDeleteResultMessage = null;
         var _loc29_:AddIgnoredAction = null;
         var _loc30_:RemoveIgnoredAction = null;
         var _loc31_:IgnoredDeleteRequestMessage = null;
         var _loc32_:JoinFriendAction = null;
         var _loc33_:FriendJoinRequestMessage = null;
         var _loc34_:JoinSpouseAction = null;
         var _loc35_:FriendSpouseFollowAction = null;
         var _loc36_:FriendSpouseFollowWithCompassRequestMessage = null;
         var _loc37_:FriendWarningSetAction = null;
         var _loc38_:FriendSetWarnOnConnectionMessage = null;
         var _loc39_:MemberWarningSetAction = null;
         var _loc40_:GuildMemberSetWarnOnConnectionMessage = null;
         var _loc41_:FriendOrGuildMemberLevelUpWarningSetAction = null;
         var _loc42_:FriendSetWarnOnLevelGainMessage = null;
         var _loc43_:FriendGuildSetWarnOnAchievementCompleteAction = null;
         var _loc44_:FriendGuildSetWarnOnAchievementCompleteMessage = null;
         var _loc45_:WarnOnHardcoreDeathAction = null;
         var _loc46_:WarnOnPermaDeathMessage = null;
         var _loc47_:SpouseStatusMessage = null;
         var _loc48_:MoodSmileyUpdateMessage = null;
         var _loc49_:FriendWarnOnConnectionStateMessage = null;
         var _loc50_:GuildMemberWarnOnConnectionStateMessage = null;
         var _loc51_:GuildMemberOnlineStatusMessage = null;
         var _loc52_:FriendWarnOnLevelGainStateMessage = null;
         var _loc53_:FriendGuildWarnOnAchievementCompleteStateMessage = null;
         var _loc54_:WarnOnPermaDeathStateMessage = null;
         var _loc55_:GuildInformationsMembersMessage = null;
         var _loc56_:GuildHousesInformationMessage = null;
         var _loc57_:GuildModificationStartedMessage = null;
         var _loc58_:GuildCreationResultMessage = null;
         var _loc59_:String = null;
         var _loc60_:GuildInvitedMessage = null;
         var _loc61_:GuildInvitationStateRecruterMessage = null;
         var _loc62_:GuildInvitationStateRecrutedMessage = null;
         var _loc63_:GuildJoinedMessage = null;
         var _loc64_:String = null;
         var _loc65_:GuildInformationsGeneralMessage = null;
         var _loc66_:GuildInformationsMemberUpdateMessage = null;
         var _loc67_:GuildMember = null;
         var _loc68_:GuildMemberLeavingMessage = null;
         var _loc69_:uint = 0;
         var _loc70_:GuildInfosUpgradeMessage = null;
         var _loc71_:GuildFightPlayersHelpersJoinMessage = null;
         var _loc72_:GuildFightPlayersHelpersLeaveMessage = null;
         var _loc73_:GuildFightPlayersEnemiesListMessage = null;
         var _loc74_:GuildFightPlayersEnemyRemoveMessage = null;
         var _loc75_:TaxCollectorMovementMessage = null;
         var _loc76_:String = null;
         var _loc77_:String = null;
         var _loc78_:WorldPointWrapper = null;
         var _loc79_:String = null;
         var _loc80_:String = null;
         var _loc81_:String = null;
         var _loc82_:TaxCollectorAttackedMessage = null;
         var _loc83_:* = 0;
         var _loc84_:* = 0;
         var _loc85_:String = null;
         var _loc86_:String = null;
         var _loc87_:TaxCollectorAttackedResultMessage = null;
         var _loc88_:String = null;
         var _loc89_:String = null;
         var _loc90_:String = null;
         var _loc91_:WorldPointWrapper = null;
         var _loc92_:* = 0;
         var _loc93_:* = 0;
         var _loc94_:TaxCollectorErrorMessage = null;
         var _loc95_:String = null;
         var _loc96_:TaxCollectorListMessage = null;
         var _loc97_:TaxCollectorMovementAddMessage = null;
         var _loc98_:* = 0;
         var _loc99_:* = false;
         var _loc100_:* = 0;
         var _loc101_:TaxCollectorMovementRemoveMessage = null;
         var _loc102_:TaxCollectorStateUpdateMessage = null;
         var _loc103_:TopTaxCollectorListMessage = null;
         var _loc104_:GuildInformationsPaddocksMessage = null;
         var _loc105_:GuildPaddockBoughtMessage = null;
         var _loc106_:GuildPaddockRemovedMessage = null;
         var _loc107_:AllianceTaxCollectorDialogQuestionExtendedMessage = null;
         var _loc108_:TaxCollectorDialogQuestionExtendedMessage = null;
         var _loc109_:TaxCollectorDialogQuestionBasicMessage = null;
         var _loc110_:GuildWrapper = null;
         var _loc111_:ContactLookMessage = null;
         var _loc112_:ContactLookErrorMessage = null;
         var _loc113_:GuildGetInformationsAction = null;
         var _loc114_:* = false;
         var _loc115_:GuildInvitationAction = null;
         var _loc116_:GuildInvitationMessage = null;
         var _loc117_:GuildInvitationByNameAction = null;
         var _loc118_:GuildInvitationByNameMessage = null;
         var _loc119_:GuildKickRequestAction = null;
         var _loc120_:GuildKickRequestMessage = null;
         var _loc121_:GuildChangeMemberParametersAction = null;
         var _loc122_:* = NaN;
         var _loc123_:GuildChangeMemberParametersMessage = null;
         var _loc124_:GuildSpellUpgradeRequestAction = null;
         var _loc125_:GuildSpellUpgradeRequestMessage = null;
         var _loc126_:GuildCharacsUpgradeRequestAction = null;
         var _loc127_:GuildCharacsUpgradeRequestMessage = null;
         var _loc128_:GuildFarmTeleportRequestAction = null;
         var _loc129_:GuildPaddockTeleportRequestMessage = null;
         var _loc130_:GuildHouseTeleportRequestAction = null;
         var _loc131_:GuildHouseTeleportRequestMessage = null;
         var _loc132_:GuildFightJoinRequestAction = null;
         var _loc133_:GuildFightJoinRequestMessage = null;
         var _loc134_:GuildFightTakePlaceRequestAction = null;
         var _loc135_:GuildFightTakePlaceRequestMessage = null;
         var _loc136_:GuildFightLeaveRequestAction = null;
         var _loc137_:GuildFightLeaveRequestMessage = null;
         var _loc138_:GuildFactsRequestAction = null;
         var _loc139_:GuildFactsRequestMessage = null;
         var _loc140_:GuildFactsMessage = null;
         var _loc141_:GuildFactSheetWrapper = null;
         var _loc142_:uint = 0;
         var _loc143_:String = null;
         var _loc144_:String = null;
         var _loc145_:GuildFactsErrorMessage = null;
         var _loc146_:CharacterReportAction = null;
         var _loc147_:CharacterReportMessage = null;
         var _loc148_:ChatReportAction = null;
         var _loc149_:ChatMessageReportMessage = null;
         var _loc150_:ChatFrame = null;
         var _loc151_:uint = 0;
         var _loc152_:PlayerStatusUpdateMessage = null;
         var _loc153_:PlayerStatusUpdateRequestAction = null;
         var _loc154_:PlayerStatus = null;
         var _loc155_:PlayerStatusUpdateRequestMessage = null;
         var _loc156_:ContactLookRequestByIdAction = null;
         var _loc157_:FriendInformations = null;
         var _loc158_:FriendWrapper = null;
         var _loc159_:FriendOnlineInformations = null;
         var _loc160_:* = undefined;
         var _loc161_:EnemyWrapper = null;
         var _loc162_:IgnoredOnlineInformations = null;
         var _loc163_:FriendAddRequestMessage = null;
         var _loc164_:IgnoredAddRequestMessage = null;
         var _loc165_:EnemyWrapper = null;
         var _loc166_:* = undefined;
         var _loc167_:* = undefined;
         var _loc168_:* = undefined;
         var _loc169_:* = undefined;
         var _loc170_:* = undefined;
         var _loc171_:* = undefined;
         var _loc172_:IgnoredAddRequestMessage = null;
         var _loc173_:GuildMember = null;
         var _loc174_:* = 0;
         var _loc175_:* = 0;
         var _loc176_:FriendWrapper = null;
         var _loc177_:String = null;
         var _loc178_:GuildMember = null;
         var _loc179_:* = false;
         var _loc180_:FriendWrapper = null;
         var _loc181_:GuildMember = null;
         var _loc182_:HouseInformationsForGuild = null;
         var _loc183_:GuildHouseWrapper = null;
         var _loc184_:* = 0;
         var _loc185_:* = 0;
         var _loc186_:GuildMember = null;
         var _loc187_:String = null;
         var _loc188_:CharacterMinimalPlusLookInformations = null;
         var _loc189_:String = null;
         var _loc190_:String = null;
         var _loc191_:SubArea = null;
         var _loc192_:uint = 0;
         var _loc193_:TaxCollectorInformations = null;
         var _loc194_:Vector.<TaxCollectorWrapper> = null;
         var _loc195_:Vector.<TaxCollectorWrapper> = null;
         var _loc196_:GuildGetInformationsMessage = null;
         var _loc197_:TaxCollectorWrapper = null;
         var _loc198_:SocialEntityInFightWrapper = null;
         var _loc199_:SocialFightersWrapper = null;
         var _loc200_:GuildHouseUpdateInformationMessage = null;
         var _loc201_:* = false;
         var _loc202_:GuildHouseWrapper = null;
         var _loc203_:GuildHouseWrapper = null;
         var _loc204_:GuildHouseRemoveMessage = null;
         var _loc205_:* = false;
         var _loc206_:* = 0;
         var _loc207_:GuildInAllianceFactsMessage = null;
         var _loc208_:GuildMember = null;
         var _loc209_:* = 0;
         var _loc210_:* = 0;
         var _loc211_:FriendWrapper = null;
         var _loc212_:ContactLookRequestByIdMessage = null;
         switch(true)
         {
            case param1 is GuildMembershipMessage:
               _loc2_ = param1 as GuildMembershipMessage;
               if(this._guild != null)
               {
                  this._guild.update(_loc2_.guildInfo.guildId,_loc2_.guildInfo.guildName,_loc2_.guildInfo.guildEmblem,_loc2_.memberRights,_loc2_.enabled);
               }
               else
               {
                  this._guild = GuildWrapper.create(_loc2_.guildInfo.guildId,_loc2_.guildInfo.guildName,_loc2_.guildInfo.guildEmblem,_loc2_.memberRights,_loc2_.enabled);
               }
               this._hasGuild = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,true);
               return true;
            case param1 is FriendsListMessage:
               _loc3_ = param1 as FriendsListMessage;
               this._friendsList = new Array();
               for each(_loc157_ in _loc3_.friendsList)
               {
                  if(_loc157_ is FriendOnlineInformations)
                  {
                     _loc159_ = _loc157_ as FriendOnlineInformations;
                     AccountManager.getInstance().setAccount(_loc159_.playerName,_loc159_.accountId,_loc159_.accountName);
                     ChatAutocompleteNameManager.getInstance().addEntry((_loc157_ as FriendOnlineInformations).playerName,2);
                  }
                  _loc158_ = new FriendWrapper(_loc157_);
                  this._friendsList.push(_loc158_);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               return true;
            case param1 is SpouseRequestAction:
               _loc4_ = param1 as SpouseRequestAction;
               ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
               return true;
            case param1 is SpouseInformationsMessage:
               _loc5_ = param1 as SpouseInformationsMessage;
               this._spouse = new SpouseWrapper(_loc5_.spouse);
               this._hasSpouse = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
               return true;
            case param1 is IgnoredListMessage:
               this._enemiesList = new Array();
               _loc6_ = param1 as IgnoredListMessage;
               for each(_loc160_ in _loc6_.ignoredList)
               {
                  if(_loc160_ is IgnoredOnlineInformations)
                  {
                     _loc162_ = _loc157_ as IgnoredOnlineInformations;
                     AccountManager.getInstance().setAccount(_loc162_.playerName,_loc162_.accountId,_loc162_.accountName);
                  }
                  _loc161_ = new EnemyWrapper(_loc160_);
                  this._enemiesList.push(_loc161_);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
               return true;
            case param1 is OpenSocialAction:
               _loc7_ = param1 as OpenSocialAction;
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,_loc7_.name);
               return true;
            case param1 is FriendsListRequestAction:
               _loc8_ = param1 as FriendsListRequestAction;
               ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
               return true;
            case param1 is EnemiesListRequestAction:
               _loc9_ = param1 as EnemiesListRequestAction;
               ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
               return true;
            case param1 is AddFriendAction:
               _loc10_ = param1 as AddFriendAction;
               if(_loc10_.name.length < 2 || _loc10_.name.length > 20)
               {
                  _loc14_ = I18n.getUiText("ui.social.friend.addFailureNotFound");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               else if(_loc10_.name != PlayedCharacterManager.getInstance().infos.name)
               {
                  _loc163_ = new FriendAddRequestMessage();
                  _loc163_.initFriendAddRequestMessage(_loc10_.name);
                  ConnectionsHandler.getConnection().send(_loc163_);
               }
               else
               {
                  _loc14_ = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               
               return true;
            case param1 is FriendAddedMessage:
               _loc11_ = param1 as FriendAddedMessage;
               if(_loc11_.friendAdded is FriendOnlineInformations)
               {
                  _loc159_ = _loc11_.friendAdded as FriendOnlineInformations;
                  AccountManager.getInstance().setAccount(_loc159_.playerName,_loc159_.accountId,_loc159_.accountName);
                  ChatAutocompleteNameManager.getInstance().addEntry((_loc11_.friendAdded as FriendInformations).accountName,2);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendAdded,true);
               _loc12_ = new FriendWrapper(_loc11_.friendAdded);
               this._friendsList.push(_loc12_);
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               return true;
            case param1 is FriendAddFailureMessage:
               _loc13_ = param1 as FriendAddFailureMessage;
               switch(_loc13_.reason)
               {
                  case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                     _loc14_ = I18n.getUiText("ui.common.unknowReason");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                     _loc14_ = I18n.getUiText("ui.social.friend.addFailureListFull");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                     _loc14_ = I18n.getUiText("ui.social.friend.addFailureNotFound");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                     _loc14_ = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                     _loc14_ = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is AddEnemyAction:
               _loc15_ = param1 as AddEnemyAction;
               if(_loc15_.name.length < ProtocolConstantsEnum.MIN_PLAYER_NAME_LEN || _loc15_.name.length > ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN)
               {
                  _loc14_ = I18n.getUiText("ui.social.friend.addFailureNotFound");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               else if(_loc15_.name != PlayedCharacterManager.getInstance().infos.name)
               {
                  _loc164_ = new IgnoredAddRequestMessage();
                  _loc164_.initIgnoredAddRequestMessage(_loc15_.name);
                  ConnectionsHandler.getConnection().send(_loc164_);
               }
               else
               {
                  _loc14_ = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               
               return true;
            case param1 is IgnoredAddedMessage:
               _loc16_ = param1 as IgnoredAddedMessage;
               if(_loc16_.ignoreAdded is IgnoredOnlineInformations)
               {
                  _loc162_ = _loc16_.ignoreAdded as IgnoredOnlineInformations;
                  AccountManager.getInstance().setAccount(_loc162_.playerName,_loc162_.accountId,_loc162_.accountName);
               }
               if(!_loc16_.session)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.EnemyAdded,true);
                  _loc165_ = new EnemyWrapper(_loc16_.ignoreAdded);
                  this._enemiesList.push(_loc165_);
                  KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
               }
               else
               {
                  for each(_loc166_ in this._ignoredList)
                  {
                     if(_loc166_.name == _loc16_.ignoreAdded.accountName)
                     {
                        return true;
                     }
                  }
                  this._ignoredList.push(new IgnoredWrapper(_loc16_.ignoreAdded.accountName,_loc16_.ignoreAdded.accountId));
                  KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredAdded);
               }
               return true;
            case param1 is IgnoredAddFailureMessage:
               _loc17_ = param1 as IgnoredAddFailureMessage;
               switch(_loc17_.reason)
               {
                  case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
                     _loc18_ = I18n.getUiText("ui.common.unknowReason");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
                     _loc18_ = I18n.getUiText("ui.social.friend.addFailureListFull");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
                     _loc18_ = I18n.getUiText("ui.social.friend.addFailureNotFound");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
                     _loc18_ = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                     break;
                  case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
                     _loc18_ = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc18_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is RemoveFriendAction:
               _loc19_ = param1 as RemoveFriendAction;
               _loc20_ = new FriendDeleteRequestMessage();
               _loc20_.initFriendDeleteRequestMessage(_loc19_.accountId);
               ConnectionsHandler.getConnection().send(_loc20_);
               return true;
            case param1 is FriendDeleteResultMessage:
               _loc21_ = param1 as FriendDeleteResultMessage;
               _loc22_ = I18n.getUiText("ui.social.friend.delete");
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendRemoved,_loc21_.success);
               if(_loc21_.success)
               {
                  for(_loc167_ in this._friendsList)
                  {
                     if(this._friendsList[_loc167_].name == _loc21_.name)
                     {
                        this._friendsList.splice(_loc167_,1);
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc22_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case param1 is FriendUpdateMessage:
               _loc23_ = param1 as FriendUpdateMessage;
               _loc24_ = new FriendWrapper(_loc23_.friendUpdated);
               for each(_loc168_ in this._friendsList)
               {
                  if(_loc168_.name == _loc24_.name)
                  {
                     _loc168_ = _loc24_;
                     break;
                  }
               }
               _loc25_ = _loc24_.state == PlayerStateEnum.GAME_TYPE_ROLEPLAY || _loc24_.state == PlayerStateEnum.GAME_TYPE_FIGHT;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.FRIEND_CONNECTION)) && (this._warnOnFrienConnec) && (_loc24_.online) && !_loc25_)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.FRIEND_CONNECTION,[_loc24_.name,_loc24_.playerName,_loc24_.playerId]);
               }
               return true;
            case param1 is RemoveEnemyAction:
               _loc26_ = param1 as RemoveEnemyAction;
               _loc27_ = new IgnoredDeleteRequestMessage();
               _loc27_.initIgnoredDeleteRequestMessage(_loc26_.accountId);
               ConnectionsHandler.getConnection().send(_loc27_);
               return true;
            case param1 is IgnoredDeleteResultMessage:
               _loc28_ = param1 as IgnoredDeleteResultMessage;
               if(!_loc28_.session)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.EnemyRemoved,_loc28_.success);
                  if(_loc28_.success)
                  {
                     for(_loc169_ in this._enemiesList)
                     {
                        if(this._enemiesList[_loc169_].name == _loc28_.name)
                        {
                           this._enemiesList.splice(_loc169_,1);
                        }
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
               }
               else if(_loc28_.success)
               {
                  for(_loc170_ in this._ignoredList)
                  {
                     if(this._ignoredList[_loc170_].name == _loc28_.name)
                     {
                        this._ignoredList.splice(_loc170_,1);
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredRemoved);
               }
               
               return true;
            case param1 is AddIgnoredAction:
               _loc29_ = param1 as AddIgnoredAction;
               if(_loc29_.name.length < ProtocolConstantsEnum.MIN_PLAYER_NAME_LEN || _loc29_.name.length > ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN)
               {
                  _loc14_ = I18n.getUiText("ui.social.friend.addFailureNotFound");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               else if(_loc29_.name != PlayedCharacterManager.getInstance().infos.name)
               {
                  for each(_loc171_ in this._ignoredList)
                  {
                     if(_loc171_.playerName == _loc29_.name)
                     {
                        return true;
                     }
                  }
                  _loc172_ = new IgnoredAddRequestMessage();
                  _loc172_.initIgnoredAddRequestMessage(_loc29_.name,true);
                  ConnectionsHandler.getConnection().send(_loc172_);
               }
               else
               {
                  _loc14_ = I18n.getUiText("ui.social.friend.addFailureEgocentric");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               
               return true;
            case param1 is RemoveIgnoredAction:
               _loc30_ = param1 as RemoveIgnoredAction;
               _loc31_ = new IgnoredDeleteRequestMessage();
               _loc31_.initIgnoredDeleteRequestMessage(_loc30_.accountId,true);
               ConnectionsHandler.getConnection().send(_loc31_);
               return true;
            case param1 is JoinFriendAction:
               _loc32_ = param1 as JoinFriendAction;
               _loc33_ = new FriendJoinRequestMessage();
               _loc33_.initFriendJoinRequestMessage(_loc32_.name);
               ConnectionsHandler.getConnection().send(_loc33_);
               return true;
            case param1 is JoinSpouseAction:
               _loc34_ = param1 as JoinSpouseAction;
               ConnectionsHandler.getConnection().send(new FriendSpouseJoinRequestMessage());
               return true;
            case param1 is FriendSpouseFollowAction:
               _loc35_ = param1 as FriendSpouseFollowAction;
               _loc36_ = new FriendSpouseFollowWithCompassRequestMessage();
               _loc36_.initFriendSpouseFollowWithCompassRequestMessage(_loc35_.enable);
               ConnectionsHandler.getConnection().send(_loc36_);
               return true;
            case param1 is FriendWarningSetAction:
               _loc37_ = param1 as FriendWarningSetAction;
               this._warnOnFrienConnec = _loc37_.enable;
               _loc38_ = new FriendSetWarnOnConnectionMessage();
               _loc38_.initFriendSetWarnOnConnectionMessage(_loc37_.enable);
               ConnectionsHandler.getConnection().send(_loc38_);
               return true;
            case param1 is MemberWarningSetAction:
               _loc39_ = param1 as MemberWarningSetAction;
               this._warnOnMemberConnec = _loc39_.enable;
               _loc40_ = new GuildMemberSetWarnOnConnectionMessage();
               _loc40_.initGuildMemberSetWarnOnConnectionMessage(_loc39_.enable);
               ConnectionsHandler.getConnection().send(_loc40_);
               return true;
            case param1 is FriendOrGuildMemberLevelUpWarningSetAction:
               _loc41_ = param1 as FriendOrGuildMemberLevelUpWarningSetAction;
               this._warnWhenFriendOrGuildMemberLvlUp = _loc41_.enable;
               _loc42_ = new FriendSetWarnOnLevelGainMessage();
               _loc42_.initFriendSetWarnOnLevelGainMessage(_loc41_.enable);
               ConnectionsHandler.getConnection().send(_loc42_);
               return true;
            case param1 is FriendGuildSetWarnOnAchievementCompleteAction:
               _loc43_ = param1 as FriendGuildSetWarnOnAchievementCompleteAction;
               this._warnWhenFriendOrGuildMemberAchieve = _loc43_.enable;
               _loc44_ = new FriendGuildSetWarnOnAchievementCompleteMessage();
               _loc44_.initFriendGuildSetWarnOnAchievementCompleteMessage(_loc43_.enable);
               ConnectionsHandler.getConnection().send(_loc44_);
               return true;
            case param1 is WarnOnHardcoreDeathAction:
               _loc45_ = param1 as WarnOnHardcoreDeathAction;
               this._warnOnHardcoreDeath = _loc45_.enable;
               _loc46_ = new WarnOnPermaDeathMessage();
               _loc46_.initWarnOnPermaDeathMessage(_loc45_.enable);
               ConnectionsHandler.getConnection().send(_loc46_);
               return true;
            case param1 is SpouseStatusMessage:
               _loc47_ = param1 as SpouseStatusMessage;
               this._hasSpouse = _loc47_.hasSpouse;
               if(!this._hasSpouse)
               {
                  this._spouse = null;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated,false);
                  KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_SPOUSE,-1);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
               return true;
            case param1 is MoodSmileyUpdateMessage:
               _loc48_ = param1 as MoodSmileyUpdateMessage;
               if(this._guildMembers != null)
               {
                  _loc174_ = this._guildMembers.length;
                  _loc175_ = 0;
                  while(_loc175_ < _loc174_)
                  {
                     if(this._guildMembers[_loc175_].id == _loc48_.playerId)
                     {
                        this._guildMembers[_loc175_].moodSmileyId = _loc48_.smileyId;
                        _loc173_ = this._guildMembers[_loc175_];
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,_loc173_);
                        break;
                     }
                     _loc175_++;
                  }
               }
               if(this._friendsList != null)
               {
                  for each(_loc176_ in this._friendsList)
                  {
                     if(_loc176_.accountId == _loc48_.accountId)
                     {
                        _loc176_.moodSmileyId = _loc48_.smileyId;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        break;
                     }
                  }
               }
               return true;
            case param1 is FriendWarnOnConnectionStateMessage:
               _loc49_ = param1 as FriendWarnOnConnectionStateMessage;
               this._warnOnFrienConnec = _loc49_.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendWarningState,_loc49_.enable);
               return true;
            case param1 is GuildMemberWarnOnConnectionStateMessage:
               _loc50_ = param1 as GuildMemberWarnOnConnectionStateMessage;
               this._warnOnMemberConnec = _loc50_.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.MemberWarningState,_loc50_.enable);
               return true;
            case param1 is GuildMemberOnlineStatusMessage:
               if(!this._friendsList)
               {
                  return true;
               }
               _loc51_ = param1 as GuildMemberOnlineStatusMessage;
               if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.MEMBER_CONNECTION)) && (this._warnOnMemberConnec) && (_loc51_.online))
               {
                  for each(_loc178_ in this._guildMembers)
                  {
                     if(_loc178_.id == _loc51_.memberId)
                     {
                        _loc177_ = _loc178_.name;
                        break;
                     }
                  }
                  _loc179_ = false;
                  for each(_loc180_ in this._friendsList)
                  {
                     if(_loc180_.name == _loc177_)
                     {
                        _loc179_ = true;
                        break;
                     }
                  }
                  if(!((_loc179_) && !ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.FRIEND_CONNECTION)))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.MEMBER_CONNECTION,[_loc177_,_loc51_.memberId]);
                  }
               }
               return true;
            case param1 is FriendWarnOnLevelGainStateMessage:
               _loc52_ = param1 as FriendWarnOnLevelGainStateMessage;
               this._warnWhenFriendOrGuildMemberLvlUp = _loc52_.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendOrGuildMemberLevelUpWarningState,_loc52_.enable);
               return true;
            case param1 is FriendGuildWarnOnAchievementCompleteStateMessage:
               _loc53_ = param1 as FriendGuildWarnOnAchievementCompleteStateMessage;
               this._warnWhenFriendOrGuildMemberAchieve = _loc53_.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendGuildWarnOnAchievementCompleteState,_loc53_.enable);
               return true;
            case param1 is WarnOnPermaDeathStateMessage:
               _loc54_ = param1 as WarnOnPermaDeathStateMessage;
               this._warnOnHardcoreDeath = _loc54_.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.WarnOnHardcoreDeathState,_loc54_.enable);
               return true;
            case param1 is GuildInformationsMembersMessage:
               _loc55_ = param1 as GuildInformationsMembersMessage;
               for each(_loc181_ in _loc55_.members)
               {
                  ChatAutocompleteNameManager.getInstance().addEntry(_loc181_.name,2);
               }
               this._guildMembers = _loc55_.members;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               return true;
            case param1 is GuildHousesInformationMessage:
               _loc56_ = param1 as GuildHousesInformationMessage;
               this._guildHouses = new Vector.<GuildHouseWrapper>();
               for each(_loc182_ in _loc56_.housesInformations)
               {
                  _loc183_ = GuildHouseWrapper.create(_loc182_);
                  this._guildHouses.push(_loc183_);
               }
               this._guildHousesList = true;
               this._guildHousesListUpdate = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
               return true;
            case param1 is GuildCreationStartedMessage:
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted,false,false);
               return true;
            case param1 is GuildModificationStartedMessage:
               _loc57_ = param1 as GuildModificationStartedMessage;
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted,_loc57_.canChangeName,_loc57_.canChangeEmblem);
               return true;
            case param1 is GuildCreationResultMessage:
               _loc58_ = param1 as GuildCreationResultMessage;
               switch(_loc58_.result)
               {
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_ALREADY_IN_GROUP:
                     _loc59_ = I18n.getUiText("ui.guild.alreadyInGuild");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                     _loc59_ = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                     _loc59_ = I18n.getUiText("ui.guild.AlreadyUseName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                     _loc59_ = I18n.getUiText("ui.guild.invalidName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                     _loc59_ = I18n.getUiText("ui.guild.requirementUnmet");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                     Kernel.getWorker().removeFrame(this._guildDialogFrame);
                     this._hasGuild = true;
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_UNKNOWN:
                     _loc59_ = I18n.getUiText("ui.common.unknownFail");
                     break;
               }
               if(_loc59_)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc59_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationResult,_loc58_.result);
               return true;
            case param1 is GuildInvitedMessage:
               _loc60_ = param1 as GuildInvitedMessage;
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvited,_loc60_.guildInfo.guildName,_loc60_.recruterId,_loc60_.recruterName);
               return true;
            case param1 is GuildInvitationStateRecruterMessage:
               _loc61_ = param1 as GuildInvitationStateRecruterMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruter,_loc61_.invitationState,_loc61_.recrutedName);
               if(_loc61_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || _loc61_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._guildDialogFrame);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._guildDialogFrame);
               }
               return true;
            case param1 is GuildInvitationStateRecrutedMessage:
               _loc62_ = param1 as GuildInvitationStateRecrutedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruted,_loc62_.invitationState);
               if(_loc62_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || _loc62_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._guildDialogFrame);
               }
               return true;
            case param1 is GuildJoinedMessage:
               _loc63_ = param1 as GuildJoinedMessage;
               this._hasGuild = true;
               this._guild = GuildWrapper.create(_loc63_.guildInfo.guildId,_loc63_.guildInfo.guildName,_loc63_.guildInfo.guildEmblem,_loc63_.memberRights,_loc63_.enabled);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,true);
               _loc64_ = I18n.getUiText("ui.guild.JoinGuildMessage",[_loc63_.guildInfo.guildName]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc64_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is GuildInformationsGeneralMessage:
               _loc65_ = param1 as GuildInformationsGeneralMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsGeneral,_loc65_.enabled,_loc65_.expLevelFloor,_loc65_.experience,_loc65_.expNextLevelFloor,_loc65_.level,_loc65_.creationDate,_loc65_.abandonnedPaddock,_loc65_.nbConnectedMembers,_loc65_.nbTotalMembers);
               this._guild.level = _loc65_.level;
               this._guild.experience = _loc65_.experience;
               this._guild.expLevelFloor = _loc65_.expLevelFloor;
               this._guild.expNextLevelFloor = _loc65_.expNextLevelFloor;
               this._guild.creationDate = _loc65_.creationDate;
               this._guild.nbMembers = _loc65_.nbTotalMembers;
               this._guild.nbConnectedMembers = _loc65_.nbConnectedMembers;
               return true;
            case param1 is GuildInformationsMemberUpdateMessage:
               _loc66_ = param1 as GuildInformationsMemberUpdateMessage;
               if(this._guildMembers != null)
               {
                  _loc184_ = this._guildMembers.length;
                  _loc185_ = 0;
                  while(_loc185_ < _loc184_)
                  {
                     _loc67_ = this._guildMembers[_loc185_];
                     if(_loc67_.id == _loc66_.member.id)
                     {
                        this._guildMembers[_loc185_] = _loc66_.member;
                        if(_loc67_.id == PlayedCharacterManager.getInstance().id)
                        {
                           this.guild.memberRightsNumber = _loc66_.member.rights;
                        }
                        break;
                     }
                     _loc185_++;
                  }
               }
               else
               {
                  this._guildMembers = new Vector.<GuildMember>();
                  _loc67_ = _loc66_.member;
                  this._guildMembers.push(_loc67_);
                  if(_loc67_.id == PlayedCharacterManager.getInstance().id)
                  {
                     this.guild.memberRightsNumber = _loc67_.rights;
                  }
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,_loc66_.member);
               return true;
            case param1 is GuildMemberLeavingMessage:
               _loc68_ = param1 as GuildMemberLeavingMessage;
               _loc69_ = 0;
               for each(_loc186_ in this._guildMembers)
               {
                  if(_loc68_.memberId == _loc186_.id)
                  {
                     this._guildMembers.splice(_loc69_,1);
                  }
                  _loc69_++;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMemberLeaving,_loc68_.kicked,_loc68_.memberId);
               return true;
            case param1 is GuildLeftMessage:
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildLeft);
               this._hasGuild = false;
               this._guild = null;
               this._guildHousesList = false;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,false);
               return true;
            case param1 is GuildInfosUpgradeMessage:
               _loc70_ = param1 as GuildInfosUpgradeMessage;
               TaxCollectorsManager.getInstance().updateGuild(_loc70_.maxTaxCollectorsCount,_loc70_.taxCollectorsCount,_loc70_.taxCollectorLifePoints,_loc70_.taxCollectorDamagesBonuses,_loc70_.taxCollectorPods,_loc70_.taxCollectorProspecting,_loc70_.taxCollectorWisdom);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInfosUpgrade,_loc70_.boostPoints,_loc70_.maxTaxCollectorsCount,_loc70_.spellId,_loc70_.spellLevel,_loc70_.taxCollectorDamagesBonuses,_loc70_.taxCollectorLifePoints,_loc70_.taxCollectorPods,_loc70_.taxCollectorProspecting,_loc70_.taxCollectorsCount,_loc70_.taxCollectorWisdom);
               return true;
            case param1 is GuildFightPlayersHelpersJoinMessage:
               _loc71_ = param1 as GuildFightPlayersHelpersJoinMessage;
               TaxCollectorsManager.getInstance().addFighter(0,_loc71_.fightId,_loc71_.playerInfo,true);
               return true;
            case param1 is GuildFightPlayersHelpersLeaveMessage:
               _loc72_ = param1 as GuildFightPlayersHelpersLeaveMessage;
               if(this._autoLeaveHelpers)
               {
                  _loc187_ = I18n.getUiText("ui.social.guild.autoFightLeave");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc187_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               TaxCollectorsManager.getInstance().removeFighter(0,_loc72_.fightId,_loc72_.playerId,true);
               return true;
            case param1 is GuildFightPlayersEnemiesListMessage:
               _loc73_ = param1 as GuildFightPlayersEnemiesListMessage;
               for each(_loc188_ in _loc73_.playerInfo)
               {
                  TaxCollectorsManager.getInstance().addFighter(0,_loc73_.fightId,_loc188_,false,false);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,0,_loc73_.fightId);
               return true;
            case param1 is GuildFightPlayersEnemyRemoveMessage:
               _loc74_ = param1 as GuildFightPlayersEnemyRemoveMessage;
               TaxCollectorsManager.getInstance().removeFighter(0,_loc74_.fightId,_loc74_.playerId,false);
               return true;
            case param1 is TaxCollectorMovementMessage:
               _loc75_ = param1 as TaxCollectorMovementMessage;
               _loc77_ = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc75_.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc75_.basicInfos.lastNameId).name;
               _loc78_ = new WorldPointWrapper(_loc75_.basicInfos.mapId,true,_loc75_.basicInfos.worldX,_loc75_.basicInfos.worldY);
               _loc79_ = String(_loc78_.outdoorX);
               _loc80_ = String(_loc78_.outdoorY);
               _loc81_ = _loc79_ + "," + _loc80_;
               switch(_loc75_.hireOrFire)
               {
                  case true:
                     _loc76_ = I18n.getUiText("ui.social.TaxCollectorAdded",[_loc77_,_loc81_,_loc75_.playerName]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc76_,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
                     break;
                  case false:
                     _loc76_ = I18n.getUiText("ui.social.TaxCollectorRemoved",[_loc77_,_loc81_,_loc75_.playerName]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc76_,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
                     break;
               }
               return true;
            case param1 is TaxCollectorAttackedMessage:
               _loc82_ = param1 as TaxCollectorAttackedMessage;
               _loc83_ = _loc82_.worldX;
               _loc84_ = _loc82_.worldY;
               _loc85_ = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc82_.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc82_.lastNameId).name;
               if(!_loc82_.guild || _loc82_.guild.guildId == this._guild.guildId)
               {
                  _loc86_ = I18n.getUiText("ui.social.TaxCollectorAttacked",[_loc85_,_loc83_ + "," + _loc84_]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{openSocial,1,2::" + _loc86_ + "}",ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               else
               {
                  _loc189_ = _loc82_.guild.guildName;
                  _loc190_ = SubArea.getSubAreaById(_loc82_.subAreaId).name;
                  _loc86_ = I18n.getUiText("ui.guild.taxCollectorAttacked",[_loc189_,_loc190_,_loc83_ + "," + _loc84_]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{openSocial,2,2,0," + _loc82_.mapId + "::" + _loc86_ + "}",ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK)))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK,[_loc85_,_loc83_,_loc84_]);
               }
               if((this._guild.alliance) && (OptionManager.getOptionManager("dofus")["warnOnGuildItemAgression"]))
               {
                  _loc191_ = SubArea.getSubAreaById(_loc82_.subAreaId);
                  _loc192_ = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.taxCollectorAttackedTitle"),I18n.getUiText("ui.guild.taxCollectorAttacked",[_loc82_.guild.guildName,_loc191_.name,_loc83_ + "," + _loc84_]),NotificationTypeEnum.INVITATION,"TaxCollectorAttacked");
                  NotificationManager.getInstance().addButtonToNotification(_loc192_,I18n.getUiText("ui.common.join"),"OpenSocial",[2,2,[0,_loc82_.mapId]],true,200,0,"hook");
                  NotificationManager.getInstance().sendNotification(_loc192_);
               }
               return true;
            case param1 is TaxCollectorAttackedResultMessage:
               _loc87_ = param1 as TaxCollectorAttackedResultMessage;
               _loc89_ = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc87_.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc87_.basicInfos.lastNameId).name;
               _loc90_ = _loc87_.guild.guildName;
               if(_loc90_ == "#NONAME#")
               {
                  _loc90_ = I18n.getUiText("ui.guild.noName");
               }
               _loc91_ = new WorldPointWrapper(_loc87_.basicInfos.mapId,true,_loc87_.basicInfos.worldX,_loc87_.basicInfos.worldY);
               _loc92_ = _loc91_.outdoorX;
               _loc93_ = _loc91_.outdoorY;
               if(!_loc87_.guild || _loc87_.guild.guildId == this._guild.guildId)
               {
                  if(_loc87_.deadOrAlive)
                  {
                     _loc88_ = I18n.getUiText("ui.social.TaxCollectorDied",[_loc89_,_loc92_ + "," + _loc93_]);
                  }
                  else
                  {
                     _loc88_ = I18n.getUiText("ui.social.TaxCollectorSurvived",[_loc89_,_loc92_ + "," + _loc93_]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc88_,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               else
               {
                  if(_loc87_.deadOrAlive)
                  {
                     _loc88_ = I18n.getUiText("ui.alliance.taxCollectorDied",[_loc90_,_loc92_ + "," + _loc93_]);
                  }
                  else
                  {
                     _loc88_ = I18n.getUiText("ui.alliance.taxCollectorSurvived",[_loc90_,_loc92_ + "," + _loc93_]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc88_,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case param1 is TaxCollectorErrorMessage:
               _loc94_ = param1 as TaxCollectorErrorMessage;
               _loc95_ = "";
               switch(_loc94_.reason)
               {
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ALREADY_ONE:
                     _loc95_ = I18n.getUiText("ui.social.alreadyTaxCollectorOnMap");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_HERE:
                     _loc95_ = I18n.getUiText("ui.social.cantHireTaxCollecotrHere");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_YET:
                     _loc95_ = I18n.getUiText("ui.social.cantHireTaxcollectorTooTired");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ERROR_UNKNOWN:
                     _loc95_ = I18n.getUiText("ui.social.unknownErrorTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_MAX_REACHED:
                     _loc95_ = I18n.getUiText("ui.social.cantHireMaxTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NO_RIGHTS:
                     _loc95_ = I18n.getUiText("ui.social.taxCollectorNoRights");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_ENOUGH_KAMAS:
                     _loc95_ = I18n.getUiText("ui.social.notEnougthRichToHireTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_FOUND:
                     _loc95_ = I18n.getUiText("ui.social.taxCollectorNotFound");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_OWNED:
                     _loc95_ = I18n.getUiText("ui.social.notYourTaxcollector");
                     break;
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc95_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is TaxCollectorListMessage:
               _loc96_ = param1 as TaxCollectorListMessage;
               TaxCollectorsManager.getInstance().maxTaxCollectorsCount = _loc96_.nbcollectorMax;
               TaxCollectorsManager.getInstance().setTaxCollectors(_loc96_.informations);
               TaxCollectorsManager.getInstance().setTaxCollectorsFighters(_loc96_.fightersInformations);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorListUpdate);
               return true;
            case param1 is TaxCollectorMovementAddMessage:
               _loc97_ = param1 as TaxCollectorMovementAddMessage;
               _loc98_ = -1;
               if(TaxCollectorsManager.getInstance().taxCollectors[_loc97_.informations.uniqueId])
               {
                  _loc98_ = TaxCollectorsManager.getInstance().taxCollectors[_loc97_.informations.uniqueId].state;
               }
               _loc99_ = TaxCollectorsManager.getInstance().addTaxCollector(_loc97_.informations);
               _loc100_ = TaxCollectorsManager.getInstance().taxCollectors[_loc97_.informations.uniqueId].state;
               if((_loc99_) || !(_loc100_ == _loc98_))
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorUpdate,_loc97_.informations.uniqueId);
               }
               if(_loc99_)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorAdd,TaxCollectorsManager.getInstance().taxCollectors[_loc97_.informations.uniqueId]);
               }
               return true;
            case param1 is TaxCollectorMovementRemoveMessage:
               _loc101_ = param1 as TaxCollectorMovementRemoveMessage;
               delete TaxCollectorsManager.getInstance().taxCollectors[_loc101_.collectorId];
               true;
               delete TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[_loc101_.collectorId];
               true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorRemoved,_loc101_.collectorId);
               return true;
            case param1 is TaxCollectorStateUpdateMessage:
               _loc102_ = param1 as TaxCollectorStateUpdateMessage;
               if(TaxCollectorsManager.getInstance().taxCollectors[_loc102_.uniqueId])
               {
                  TaxCollectorsManager.getInstance().taxCollectors[_loc102_.uniqueId].state = _loc102_.state;
               }
               if(TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[_loc102_.uniqueId])
               {
                  if(_loc102_.state != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                  {
                     delete TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[_loc102_.uniqueId];
                     true;
                     KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceTaxCollectorRemoved,_loc102_.uniqueId);
                  }
               }
               return true;
            case param1 is TopTaxCollectorListMessage:
               _loc103_ = param1 as TopTaxCollectorListMessage;
               if(_loc103_.isDungeon)
               {
                  this._dungeonTopTaxCollectors = _loc103_.informations;
               }
               else
               {
                  this._topTaxCollectors = _loc103_.informations;
               }
               if((this._dungeonTopTaxCollectors) && (this._topTaxCollectors))
               {
                  _loc194_ = new Vector.<TaxCollectorWrapper>(0);
                  _loc195_ = new Vector.<TaxCollectorWrapper>(0);
                  for each(_loc193_ in this._dungeonTopTaxCollectors)
                  {
                     _loc194_.push(TaxCollectorWrapper.create(_loc193_));
                  }
                  for each(_loc193_ in this._topTaxCollectors)
                  {
                     _loc195_.push(TaxCollectorWrapper.create(_loc193_));
                  }
                  KernelEventsManager.getInstance().processCallback(SocialHookList.ShowTopTaxCollectors,_loc194_,_loc195_);
                  this._dungeonTopTaxCollectors = null;
                  this._topTaxCollectors = null;
               }
               return true;
            case param1 is GuildInformationsPaddocksMessage:
               _loc104_ = param1 as GuildInformationsPaddocksMessage;
               this._guildPaddocksMax = _loc104_.nbPaddockMax;
               this._guildPaddocks = _loc104_.paddocksInformations;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsFarms);
               return true;
            case param1 is GuildPaddockBoughtMessage:
               _loc105_ = param1 as GuildPaddockBoughtMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockAdd,_loc105_.paddockInfo);
               return true;
            case param1 is GuildPaddockRemovedMessage:
               _loc106_ = param1 as GuildPaddockRemovedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockRemoved,_loc106_.paddockId);
               return true;
            case param1 is AllianceTaxCollectorDialogQuestionExtendedMessage:
               _loc107_ = param1 as AllianceTaxCollectorDialogQuestionExtendedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceTaxCollectorDialogQuestionExtended,_loc107_.guildInfo.guildName,_loc107_.maxPods,_loc107_.prospecting,_loc107_.wisdom,_loc107_.taxCollectorsCount,_loc107_.taxCollectorAttack,_loc107_.kamas,_loc107_.experience,_loc107_.pods,_loc107_.itemsValue,_loc107_.alliance);
               return true;
            case param1 is TaxCollectorDialogQuestionExtendedMessage:
               _loc108_ = param1 as TaxCollectorDialogQuestionExtendedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionExtended,_loc108_.guildInfo.guildName,_loc108_.maxPods,_loc108_.prospecting,_loc108_.wisdom,_loc108_.taxCollectorsCount,_loc108_.taxCollectorAttack,_loc108_.kamas,_loc108_.experience,_loc108_.pods,_loc108_.itemsValue);
               return true;
            case param1 is TaxCollectorDialogQuestionBasicMessage:
               _loc109_ = param1 as TaxCollectorDialogQuestionBasicMessage;
               _loc110_ = GuildWrapper.create(0,_loc109_.guildInfo.guildName,null,0,true);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionBasic,_loc110_.guildName);
               return true;
            case param1 is ContactLookMessage:
               _loc111_ = param1 as ContactLookMessage;
               if(_loc111_.requestId == 0)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,_loc111_.playerId,_loc111_.playerName,EntityLookAdapter.fromNetwork(_loc111_.look));
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ContactLook,_loc111_.playerId,_loc111_.playerName,EntityLookAdapter.fromNetwork(_loc111_.look));
               }
               return true;
            case param1 is ContactLookErrorMessage:
               _loc112_ = param1 as ContactLookErrorMessage;
               return true;
            case param1 is GuildGetInformationsAction:
               _loc113_ = param1 as GuildGetInformationsAction;
               _loc114_ = true;
               switch(_loc113_.infoType)
               {
                  case GuildInformationsTypeEnum.INFO_MEMBERS:
                     break;
                  case GuildInformationsTypeEnum.INFO_HOUSES:
                     if(this._guildHousesList)
                     {
                        _loc114_ = false;
                        if(this._guildHousesListUpdate)
                        {
                           this._guildHousesListUpdate = false;
                           KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                        }
                     }
                     break;
               }
               if(_loc114_)
               {
                  _loc196_ = new GuildGetInformationsMessage();
                  _loc196_.initGuildGetInformationsMessage(_loc113_.infoType);
                  ConnectionsHandler.getConnection().send(_loc196_);
               }
               return true;
            case param1 is GuildInvitationAction:
               _loc115_ = param1 as GuildInvitationAction;
               _loc116_ = new GuildInvitationMessage();
               _loc116_.initGuildInvitationMessage(_loc115_.targetId);
               ConnectionsHandler.getConnection().send(_loc116_);
               return true;
            case param1 is GuildInvitationByNameAction:
               _loc117_ = param1 as GuildInvitationByNameAction;
               _loc118_ = new GuildInvitationByNameMessage();
               _loc118_.initGuildInvitationByNameMessage(_loc117_.target);
               ConnectionsHandler.getConnection().send(_loc118_);
               return true;
            case param1 is GuildKickRequestAction:
               _loc119_ = param1 as GuildKickRequestAction;
               _loc120_ = new GuildKickRequestMessage();
               _loc120_.initGuildKickRequestMessage(_loc119_.targetId);
               ConnectionsHandler.getConnection().send(_loc120_);
               return true;
            case param1 is GuildChangeMemberParametersAction:
               _loc121_ = param1 as GuildChangeMemberParametersAction;
               _loc122_ = GuildWrapper.getRightsNumber(_loc121_.rights);
               _loc123_ = new GuildChangeMemberParametersMessage();
               _loc123_.initGuildChangeMemberParametersMessage(_loc121_.memberId,_loc121_.rank,_loc121_.experienceGivenPercent,_loc122_);
               ConnectionsHandler.getConnection().send(_loc123_);
               return true;
            case param1 is GuildSpellUpgradeRequestAction:
               _loc124_ = param1 as GuildSpellUpgradeRequestAction;
               _loc125_ = new GuildSpellUpgradeRequestMessage();
               _loc125_.initGuildSpellUpgradeRequestMessage(_loc124_.spellId);
               ConnectionsHandler.getConnection().send(_loc125_);
               return true;
            case param1 is GuildCharacsUpgradeRequestAction:
               _loc126_ = param1 as GuildCharacsUpgradeRequestAction;
               _loc127_ = new GuildCharacsUpgradeRequestMessage();
               _loc127_.initGuildCharacsUpgradeRequestMessage(_loc126_.charaTypeTarget);
               ConnectionsHandler.getConnection().send(_loc127_);
               return true;
            case param1 is GuildFarmTeleportRequestAction:
               _loc128_ = param1 as GuildFarmTeleportRequestAction;
               _loc129_ = new GuildPaddockTeleportRequestMessage();
               _loc129_.initGuildPaddockTeleportRequestMessage(_loc128_.farmId);
               ConnectionsHandler.getConnection().send(_loc129_);
               return true;
            case param1 is GuildHouseTeleportRequestAction:
               _loc130_ = param1 as GuildHouseTeleportRequestAction;
               _loc131_ = new GuildHouseTeleportRequestMessage();
               _loc131_.initGuildHouseTeleportRequestMessage(_loc130_.houseId);
               ConnectionsHandler.getConnection().send(_loc131_);
               return true;
            case param1 is GuildFightJoinRequestAction:
               _loc132_ = param1 as GuildFightJoinRequestAction;
               _loc133_ = new GuildFightJoinRequestMessage();
               _loc133_.initGuildFightJoinRequestMessage(_loc132_.taxCollectorId);
               ConnectionsHandler.getConnection().send(_loc133_);
               return true;
            case param1 is GuildFightTakePlaceRequestAction:
               _loc134_ = param1 as GuildFightTakePlaceRequestAction;
               _loc135_ = new GuildFightTakePlaceRequestMessage();
               _loc135_.initGuildFightTakePlaceRequestMessage(_loc134_.taxCollectorId,_loc134_.replacedCharacterId);
               ConnectionsHandler.getConnection().send(_loc135_);
               return true;
            case param1 is GuildFightLeaveRequestAction:
               _loc136_ = param1 as GuildFightLeaveRequestAction;
               this._autoLeaveHelpers = false;
               if(_loc136_.warning)
               {
                  for each(_loc197_ in TaxCollectorsManager.getInstance().taxCollectors)
                  {
                     if(_loc197_.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                     {
                        _loc198_ = TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[_loc197_.uniqueId];
                        for each(_loc199_ in _loc198_.allyCharactersInformations)
                        {
                           if(_loc199_.playerCharactersInformations.id == _loc136_.characterId)
                           {
                              this._autoLeaveHelpers = true;
                              _loc137_ = new GuildFightLeaveRequestMessage();
                              _loc137_.initGuildFightLeaveRequestMessage(_loc197_.uniqueId,_loc136_.characterId);
                              ConnectionsHandler.getConnection().send(_loc137_);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc137_ = new GuildFightLeaveRequestMessage();
                  _loc137_.initGuildFightLeaveRequestMessage(_loc136_.taxCollectorId,_loc136_.characterId);
                  ConnectionsHandler.getConnection().send(_loc137_);
               }
               return true;
            case param1 is GuildHouseUpdateInformationMessage:
               if(this._guildHousesList)
               {
                  _loc200_ = param1 as GuildHouseUpdateInformationMessage;
                  _loc201_ = false;
                  for each(_loc202_ in this._guildHouses)
                  {
                     if(_loc202_.houseId == _loc200_.housesInformations.houseId)
                     {
                        _loc202_.update(_loc200_.housesInformations);
                        _loc201_ = true;
                     }
                     KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                  }
                  if(!_loc201_)
                  {
                     _loc203_ = GuildHouseWrapper.create(_loc200_.housesInformations);
                     this._guildHouses.push(_loc203_);
                     KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseAdd,_loc203_);
                  }
                  this._guildHousesListUpdate = true;
               }
               return true;
            case param1 is GuildHouseRemoveMessage:
               if(this._guildHousesList)
               {
                  _loc204_ = param1 as GuildHouseRemoveMessage;
                  _loc205_ = false;
                  _loc206_ = 0;
                  while(_loc206_ < this._guildHouses.length)
                  {
                     if(this._guildHouses[_loc206_].houseId == _loc204_.houseId)
                     {
                        this._guildHouses.splice(_loc206_,1);
                        break;
                     }
                     _loc206_++;
                  }
                  this._guildHousesListUpdate = true;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseRemoved,_loc204_.houseId);
               }
               return true;
            case param1 is GuildFactsRequestAction:
               _loc138_ = param1 as GuildFactsRequestAction;
               _loc139_ = new GuildFactsRequestMessage();
               _loc139_.initGuildFactsRequestMessage(_loc138_.guildId);
               ConnectionsHandler.getConnection().send(_loc139_);
               return true;
            case param1 is GuildFactsMessage:
               _loc140_ = param1 as GuildFactsMessage;
               _loc141_ = this._allGuilds[_loc140_.infos.guildId];
               _loc142_ = 0;
               _loc143_ = "";
               _loc144_ = "";
               if(param1 is GuildInAllianceFactsMessage)
               {
                  _loc207_ = param1 as GuildInAllianceFactsMessage;
                  _loc142_ = _loc207_.allianceInfos.allianceId;
                  _loc143_ = _loc207_.allianceInfos.allianceName;
                  _loc144_ = _loc207_.allianceInfos.allianceTag;
               }
               if(_loc141_)
               {
                  _loc141_.update(_loc140_.infos.guildId,_loc140_.infos.guildName,_loc140_.infos.guildEmblem,_loc140_.infos.leaderId,_loc141_.leaderName,_loc140_.infos.guildLevel,_loc140_.infos.nbMembers,_loc140_.creationDate,_loc140_.members,_loc141_.nbConnectedMembers,_loc140_.nbTaxCollectors,_loc141_.lastActivity,_loc140_.enabled,_loc142_,_loc143_,_loc144_,_loc141_.allianceLeader);
               }
               else
               {
                  _loc141_ = GuildFactSheetWrapper.create(_loc140_.infos.guildId,_loc140_.infos.guildName,_loc140_.infos.guildEmblem,_loc140_.infos.leaderId,"",_loc140_.infos.guildLevel,_loc140_.infos.nbMembers,_loc140_.creationDate,_loc140_.members,0,_loc140_.nbTaxCollectors,0,_loc140_.enabled,_loc142_,_loc143_,_loc144_);
                  this._allGuilds[_loc140_.infos.guildId] = _loc141_;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenOneGuild,_loc141_);
               return true;
            case param1 is GuildFactsErrorMessage:
               _loc145_ = param1 as GuildFactsErrorMessage;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.guild.doesntExistAnymore"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is CharacterReportAction:
               _loc146_ = param1 as CharacterReportAction;
               _loc147_ = new CharacterReportMessage();
               _loc147_.initCharacterReportMessage(_loc146_.reportedId,_loc146_.reason);
               ConnectionsHandler.getConnection().send(_loc147_);
               return true;
            case param1 is ChatReportAction:
               _loc148_ = param1 as ChatReportAction;
               _loc149_ = new ChatMessageReportMessage();
               _loc150_ = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
               _loc151_ = _loc150_.getTimestampServerByRealTimestamp(_loc148_.timestamp);
               _loc149_.initChatMessageReportMessage(_loc148_.name,_loc148_.message,_loc151_,_loc148_.channel,_loc148_.fingerprint,_loc148_.reason);
               ConnectionsHandler.getConnection().send(_loc149_);
               return true;
            case param1 is PlayerStatusUpdateMessage:
               _loc152_ = param1 as PlayerStatusUpdateMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.PlayerStatusUpdate,_loc152_.accountId,_loc152_.playerId,_loc152_.status.statusId);
               if(this._guildMembers != null)
               {
                  _loc209_ = this._guildMembers.length;
                  _loc210_ = 0;
                  while(_loc210_ < _loc209_)
                  {
                     if(this._guildMembers[_loc210_].id == _loc152_.playerId)
                     {
                        this._guildMembers[_loc210_].status = _loc152_.status;
                        _loc208_ = this._guildMembers[_loc210_];
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,_loc208_);
                        break;
                     }
                     _loc210_++;
                  }
               }
               if(this._friendsList != null)
               {
                  for each(_loc211_ in this._friendsList)
                  {
                     if(_loc211_.accountId == _loc152_.accountId)
                     {
                        _loc211_.statusId = _loc152_.status.statusId;
                        if(_loc152_.status is PlayerStatusExtended)
                        {
                           _loc211_.awayMessage = PlayerStatusExtended(_loc152_.status).message;
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        break;
                     }
                  }
               }
               return false;
            case param1 is PlayerStatusUpdateRequestAction:
               _loc153_ = param1 as PlayerStatusUpdateRequestAction;
               if(_loc153_.message)
               {
                  _loc154_ = new PlayerStatusExtended();
                  PlayerStatusExtended(_loc154_).initPlayerStatusExtended(_loc153_.status,_loc153_.message);
               }
               else
               {
                  _loc154_ = new PlayerStatus();
                  _loc154_.initPlayerStatus(_loc153_.status);
               }
               _loc155_ = new PlayerStatusUpdateRequestMessage();
               _loc155_.initPlayerStatusUpdateRequestMessage(_loc154_);
               ConnectionsHandler.getConnection().send(_loc155_);
               return true;
            case param1 is ContactLookRequestByIdAction:
               _loc156_ = param1 as ContactLookRequestByIdAction;
               if(_loc156_.entityId == PlayedCharacterManager.getInstance().id)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ContactLook,PlayedCharacterManager.getInstance().id,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  _loc212_ = new ContactLookRequestByIdMessage();
                  _loc212_.initContactLookRequestByIdMessage(1,_loc156_.contactType,_loc156_.entityId);
                  ConnectionsHandler.getConnection().send(_loc212_);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function isIgnored(param1:String, param2:int = 0) : Boolean
      {
         var _loc4_:IgnoredWrapper = null;
         var _loc3_:String = AccountManager.getInstance().getAccountName(param1);
         for each(_loc4_ in this._ignoredList)
         {
            if(!(param2 == 0) && _loc4_.accountId == param2 || (_loc3_) && (_loc4_.name.toLowerCase() == _loc3_.toLowerCase()))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isFriend(param1:String) : Boolean
      {
         var _loc4_:FriendWrapper = null;
         var _loc2_:int = this._friendsList.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._friendsList[_loc3_];
            if(_loc4_.playerName == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function isEnemy(param1:String) : Boolean
      {
         var _loc4_:EnemyWrapper = null;
         var _loc2_:int = this._enemiesList.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._enemiesList[_loc3_];
            if(_loc4_.playerName == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}
