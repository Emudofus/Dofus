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
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.friend.FriendsGetListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredGetListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.SpouseGetInformationsMessage;
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
   import com.ankamagames.dofus.network.messages.game.guild.GuildUIOpenedMessage;
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
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsPaddocksMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockBoughtMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionExtendedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionBasicMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookMessage;
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
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.TaxCollectorHireRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.CharacterReportAction;
   import com.ankamagames.dofus.network.messages.game.report.CharacterReportMessage;
   import com.ankamagames.dofus.logic.game.common.actions.social.ChatReportAction;
   import com.ankamagames.dofus.network.messages.game.chat.report.ChatMessageReportMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
   import com.ankamagames.dofus.logic.game.common.actions.social.PlayerStatusUpdateRequestAction;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateRequestMessage;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
   import com.ankamagames.dofus.internalDatacenter.people.EnemyWrapper;
   import d2network.IgnoredOnlineInformations;
   import com.ankamagames.dofus.network.messages.game.friend.FriendAddRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddRequestMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.messages.game.guild.GuildGetInformationsMessage;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorFightersWrapper;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorHireRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildHouseUpdateInformationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildHouseRemoveMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import com.ankamagames.dofus.internalDatacenter.people.IgnoredWrapper;


   public class SocialFrame extends Object implements Frame
   {
         

      public function SocialFrame() {
         this._guildHouses=new Vector.<GuildHouseWrapper>();
         this._guildPaddocks=new Vector.<PaddockContentInformations>();
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialFrame));

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

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function get friendsList() : Array {
         return this._friendsList;
      }

      public function get enemiesList() : Array {
         return this._enemiesList;
      }

      public function get ignoredList() : Array {
         return this._ignoredList;
      }

      public function get spouse() : SpouseWrapper {
         return this._spouse;
      }

      public function get hasGuild() : Boolean {
         return this._hasGuild;
      }

      public function get hasSpouse() : Boolean {
         return this._hasSpouse;
      }

      public function get guild() : GuildWrapper {
         return this._guild;
      }

      public function get guildmembers() : Vector.<GuildMember> {
         return this._guildMembers;
      }

      public function get guildHouses() : Vector.<GuildHouseWrapper> {
         return this._guildHouses;
      }

      public function get guildPaddocks() : Vector.<PaddockContentInformations> {
         return this._guildPaddocks;
      }

      public function get maxGuildPaddocks() : int {
         return this._guildPaddocksMax;
      }

      public function get warnFriendConnec() : Boolean {
         return this._warnOnFrienConnec;
      }

      public function get warnMemberConnec() : Boolean {
         return this._warnOnMemberConnec;
      }

      public function get warnWhenFriendOrGuildMemberLvlUp() : Boolean {
         return this._warnWhenFriendOrGuildMemberLvlUp;
      }

      public function get warnWhenFriendOrGuildMemberAchieve() : Boolean {
         return this._warnWhenFriendOrGuildMemberAchieve;
      }

      public function pushed() : Boolean {
         this._enemiesList=new Array();
         this._ignoredList=new Array();
         this._guildDialogFrame=new GuildDialogFrame();
         ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
         ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
         ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
         return true;
      }

      public function process(msg:Message) : Boolean {
         var gmmsg:GuildMembershipMessage = null;
         var flmsg:FriendsListMessage = null;
         var sra:SpouseRequestAction = null;
         var simsg:SpouseInformationsMessage = null;
         var ilmsg:IgnoredListMessage = null;
         var osa:OpenSocialAction = null;
         var flra:FriendsListRequestAction = null;
         var elra:EnemiesListRequestAction = null;
         var afa:AddFriendAction = null;
         var famsg:FriendAddedMessage = null;
         var friendToAdd:FriendWrapper = null;
         var fafmsg:FriendAddFailureMessage = null;
         var reason:String = null;
         var aea:AddEnemyAction = null;
         var iamsg:IgnoredAddedMessage = null;
         var iafmsg:IgnoredAddFailureMessage = null;
         var reason2:String = null;
         var rfa:RemoveFriendAction = null;
         var fdrqmsg:FriendDeleteRequestMessage = null;
         var fdrmsg:FriendDeleteResultMessage = null;
         var output:String = null;
         var fumsg:FriendUpdateMessage = null;
         var friendToUpdate:FriendWrapper = null;
         var friendAlreadyInGame:* = false;
         var rea:RemoveEnemyAction = null;
         var idrqmsg:IgnoredDeleteRequestMessage = null;
         var idrmsg:IgnoredDeleteResultMessage = null;
         var aia:AddIgnoredAction = null;
         var ria:RemoveIgnoredAction = null;
         var idrq2msg:IgnoredDeleteRequestMessage = null;
         var jfa:JoinFriendAction = null;
         var fjrmsg:FriendJoinRequestMessage = null;
         var jsa:JoinSpouseAction = null;
         var fsfa:FriendSpouseFollowAction = null;
         var fsfwcmsg:FriendSpouseFollowWithCompassRequestMessage = null;
         var fwsa:FriendWarningSetAction = null;
         var fsocmsg:FriendSetWarnOnConnectionMessage = null;
         var mwsa:MemberWarningSetAction = null;
         var gmswocmsg:GuildMemberSetWarnOnConnectionMessage = null;
         var fogmwsa:FriendOrGuildMemberLevelUpWarningSetAction = null;
         var fswolgmsg:FriendSetWarnOnLevelGainMessage = null;
         var fgswoaca:FriendGuildSetWarnOnAchievementCompleteAction = null;
         var fgswoacmsg:FriendGuildSetWarnOnAchievementCompleteMessage = null;
         var ssmsg:SpouseStatusMessage = null;
         var msumsg:MoodSmileyUpdateMessage = null;
         var fwocsmsg:FriendWarnOnConnectionStateMessage = null;
         var gmwocsmsg:GuildMemberWarnOnConnectionStateMessage = null;
         var gmosm:GuildMemberOnlineStatusMessage = null;
         var fwolgsmsg:FriendWarnOnLevelGainStateMessage = null;
         var fgwoacsmsg:FriendGuildWarnOnAchievementCompleteStateMessage = null;
         var gimmsg:GuildInformationsMembersMessage = null;
         var ghimsg:GuildHousesInformationMessage = null;
         var gmsmsg:GuildModificationStartedMessage = null;
         var gcrmsg:GuildCreationResultMessage = null;
         var errorMessage:String = null;
         var gimsg:GuildInvitedMessage = null;
         var gisrermsg:GuildInvitationStateRecruterMessage = null;
         var gisredmsg:GuildInvitationStateRecrutedMessage = null;
         var gjmsg:GuildJoinedMessage = null;
         var joinMessage:String = null;
         var guiomsg:GuildUIOpenedMessage = null;
         var gigmsg:GuildInformationsGeneralMessage = null;
         var gimumsg:GuildInformationsMemberUpdateMessage = null;
         var member:GuildMember = null;
         var gmlmsg:GuildMemberLeavingMessage = null;
         var comptgm:uint = 0;
         var gipmsg:GuildInfosUpgradeMessage = null;
         var gfphjmsg:GuildFightPlayersHelpersJoinMessage = null;
         var gfphlmsg:GuildFightPlayersHelpersLeaveMessage = null;
         var gfpelmsg:GuildFightPlayersEnemiesListMessage = null;
         var gfpermsg:GuildFightPlayersEnemyRemoveMessage = null;
         var tcmmsg:TaxCollectorMovementMessage = null;
         var infoText:String = null;
         var taxCollectorName:String = null;
         var point:WorldPointWrapper = null;
         var positionX:String = null;
         var positionY:String = null;
         var worldPoint:String = null;
         var tcamsg:TaxCollectorAttackedMessage = null;
         var taxCollectorN:String = null;
         var sentenceToDisplatch:String = null;
         var tcarmsg:TaxCollectorAttackedResultMessage = null;
         var sentenceToDisplatchResultAttack:String = null;
         var taxCName:String = null;
         var pointAttacked:WorldPointWrapper = null;
         var worldPosX:* = 0;
         var worldPosY:* = 0;
         var tcemsg:TaxCollectorErrorMessage = null;
         var errorTaxCollectorMessage:String = null;
         var tclmamsg:TaxCollectorListMessage = null;
         var tcmamsg:TaxCollectorMovementAddMessage = null;
         var newTC:* = false;
         var tcmrmsg:TaxCollectorMovementRemoveMessage = null;
         var gifmsg:GuildInformationsPaddocksMessage = null;
         var gpbmsg:GuildPaddockBoughtMessage = null;
         var gprmsg:GuildPaddockRemovedMessage = null;
         var tcdqemsg:TaxCollectorDialogQuestionExtendedMessage = null;
         var tcdqbmsg:TaxCollectorDialogQuestionBasicMessage = null;
         var guildw:GuildWrapper = null;
         var clmsg:ContactLookMessage = null;
         var ggia:GuildGetInformationsAction = null;
         var askInformation:* = false;
         var gia:GuildInvitationAction = null;
         var ginvitationmsg:GuildInvitationMessage = null;
         var gibna:GuildInvitationByNameAction = null;
         var gibnmsg:GuildInvitationByNameMessage = null;
         var gkra:GuildKickRequestAction = null;
         var gkrmsg:GuildKickRequestMessage = null;
         var gcmpa:GuildChangeMemberParametersAction = null;
         var newRights:* = NaN;
         var gcmpmsg:GuildChangeMemberParametersMessage = null;
         var gsura:GuildSpellUpgradeRequestAction = null;
         var gsurmsg:GuildSpellUpgradeRequestMessage = null;
         var gcura:GuildCharacsUpgradeRequestAction = null;
         var gcurmsg:GuildCharacsUpgradeRequestMessage = null;
         var gftra:GuildFarmTeleportRequestAction = null;
         var gftrmsg:GuildPaddockTeleportRequestMessage = null;
         var ghtra:GuildHouseTeleportRequestAction = null;
         var ghtrmsg:GuildHouseTeleportRequestMessage = null;
         var gfjra:GuildFightJoinRequestAction = null;
         var gfjrmsg:GuildFightJoinRequestMessage = null;
         var gftpra:GuildFightTakePlaceRequestAction = null;
         var gftprmsg:GuildFightTakePlaceRequestMessage = null;
         var gflra:GuildFightLeaveRequestAction = null;
         var gflrmsg:GuildFightLeaveRequestMessage = null;
         var tchra:TaxCollectorHireRequestAction = null;
         var cra:CharacterReportAction = null;
         var crm:CharacterReportMessage = null;
         var chra:ChatReportAction = null;
         var cmr:ChatMessageReportMessage = null;
         var chatFrame:ChatFrame = null;
         var timeStamp:uint = 0;
         var psum:PlayerStatusUpdateMessage = null;
         var psura:PlayerStatusUpdateRequestAction = null;
         var status:PlayerStatus = null;
         var psurmsg:PlayerStatusUpdateRequestMessage = null;
         var f:FriendInformations = null;
         var fw:FriendWrapper = null;
         var foi:FriendOnlineInformations = null;
         var _loc141_:* = undefined;
         var _loc142_:EnemyWrapper = null;
         var _loc143_:IgnoredOnlineInformations = null;
         var _loc144_:FriendAddRequestMessage = null;
         var _loc145_:IgnoredAddRequestMessage = null;
         var _loc146_:EnemyWrapper = null;
         var _loc147_:* = undefined;
         var _loc148_:* = undefined;
         var _loc149_:* = undefined;
         var _loc150_:* = undefined;
         var _loc151_:* = undefined;
         var _loc152_:* = undefined;
         var _loc153_:IgnoredAddRequestMessage = null;
         var _loc154_:GuildMember = null;
         var _loc155_:* = 0;
         var _loc156_:* = 0;
         var _loc157_:FriendWrapper = null;
         var _loc158_:String = null;
         var _loc159_:GuildMember = null;
         var _loc160_:* = false;
         var _loc161_:FriendWrapper = null;
         var _loc162_:GuildMember = null;
         var _loc163_:HouseInformationsForGuild = null;
         var _loc164_:GuildHouseWrapper = null;
         var _loc165_:* = 0;
         var _loc166_:* = 0;
         var _loc167_:GuildMember = null;
         var _loc168_:String = null;
         var _loc169_:CharacterMinimalPlusLookInformations = null;
         var _loc170_:GuildGetInformationsMessage = null;
         var _loc171_:TaxCollectorWrapper = null;
         var _loc172_:TaxCollectorInFightWrapper = null;
         var _loc173_:TaxCollectorFightersWrapper = null;
         var _loc174_:TaxCollectorHireRequestMessage = null;
         var _loc175_:GuildHouseUpdateInformationMessage = null;
         var _loc176_:* = false;
         var _loc177_:GuildHouseWrapper = null;
         var _loc178_:GuildHouseWrapper = null;
         var _loc179_:GuildHouseRemoveMessage = null;
         var _loc180_:* = false;
         var _loc181_:* = 0;
         var _loc182_:GuildMember = null;
         var _loc183_:* = 0;
         var _loc184_:* = 0;
         var _loc185_:FriendWrapper = null;
         gmmsg=msg as GuildMembershipMessage;
         if(this._guild!=null)
         {
            this._guild.update(gmmsg.guildInfo.guildId,gmmsg.guildInfo.guildName,gmmsg.guildInfo.guildEmblem,gmmsg.memberRights,gmmsg.enabled);
         }
         else
         {
            this._guild=GuildWrapper.create(gmmsg.guildInfo.guildId,gmmsg.guildInfo.guildName,gmmsg.guildInfo.guildEmblem,gmmsg.memberRights,gmmsg.enabled);
         }
         this._hasGuild=true;
         KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembership);
         KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,true);
         return true;
      }

      public function pulled() : Boolean {
         TaxCollectorsManager.getInstance().destroy();
         return true;
      }

      public function isIgnored(name:String, accountId:int=0) : Boolean {
         var loser:IgnoredWrapper = null;
         var accountName:String = AccountManager.getInstance().getAccountName(name);
         for each (loser in this._ignoredList)
         {
            if((!(accountId==0))&&(loser.accountId==accountId)||(accountName)&&(loser.name.toLowerCase()==accountName.toLowerCase()))
            {
               return true;
            }
         }
         return false;
      }

      public function isFriend(playerName:String) : Boolean {
         var fw:FriendWrapper = null;
         var n:int = this._friendsList.length;
         var i:int = 0;
         while(i<n)
         {
            fw=this._friendsList[i];
            if(fw.playerName==playerName)
            {
               return true;
            }
            i++;
         }
         return false;
      }

      public function isEnemy(playerName:String) : Boolean {
         var ew:EnemyWrapper = null;
         var n:int = this._enemiesList.length;
         var i:int = 0;
         while(i<n)
         {
            ew=this._enemiesList[i];
            if(ew.playerName==playerName)
            {
               return true;
            }
            i++;
         }
         return false;
      }
   }

}