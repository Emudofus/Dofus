package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class SocialHookList extends Object
   {
      
      public function SocialHookList() {
         super();
      }
      
      public static const OpenSocial:Hook = new Hook("OpenSocial",false);
      
      public static const OpenOneGuild:Hook = new Hook("OpenOneGuild",false);
      
      public static const OpenOneAlliance:Hook = new Hook("OpenOneAlliance",false);
      
      public static const FriendsListUpdated:Hook = new Hook("FriendsListUpdated",false);
      
      public static const EnemiesListUpdated:Hook = new Hook("EnemiesListUpdated",false);
      
      public static const SpouseUpdated:Hook = new Hook("SpouseUpdated",false);
      
      public static const FriendAdded:Hook = new Hook("FriendAdded",false);
      
      public static const FriendRemoved:Hook = new Hook("FriendRemoved",false);
      
      public static const EnemyAdded:Hook = new Hook("EnemyAdded",false);
      
      public static const EnemyRemoved:Hook = new Hook("EnemyRemoved",false);
      
      public static const IgnoredAdded:Hook = new Hook("IgnoredAdded",false);
      
      public static const IgnoredRemoved:Hook = new Hook("IgnoredRemoved",false);
      
      public static const FriendWarningState:Hook = new Hook("FriendWarningState",false);
      
      public static const MemberWarningState:Hook = new Hook("MemberWarningState",false);
      
      public static const FriendOrGuildMemberLevelUpWarningState:Hook = new Hook("FriendOrGuildMemberLevelUpWarningState",false);
      
      public static const FriendGuildWarnOnAchievementCompleteState:Hook = new Hook("FriendGuildWarnOnAchievementCompleteState",false);
      
      public static const SpouseFollowStatusUpdated:Hook = new Hook("SpouseFollowStatusUpdated",false);
      
      public static const GuildInformationsMembers:Hook = new Hook("GuildInformationsMembers",false);
      
      public static const GuildMembershipUpdated:Hook = new Hook("GuildMembershipUpdated",false);
      
      public static const GuildCreationStarted:Hook = new Hook("GuildCreationStarted",false);
      
      public static const GuildCreationResult:Hook = new Hook("GuildCreationResult",false);
      
      public static const GuildInvited:Hook = new Hook("GuildInvited",false);
      
      public static const GuildInvitationStateRecruter:Hook = new Hook("GuildInvitationStateRecruter",false);
      
      public static const GuildInvitationStateRecruted:Hook = new Hook("GuildInvitationStateRecruted",false);
      
      public static const GuildInformationsGeneral:Hook = new Hook("GuildInformationsGeneral",false);
      
      public static const GuildInformationsMemberUpdate:Hook = new Hook("GuildInformationsMemberUpdate",false);
      
      public static const GuildMemberLeaving:Hook = new Hook("GuildMemberLeaving",false);
      
      public static const GuildLeft:Hook = new Hook("GuildLeft",false);
      
      public static const GuildInfosUpgrade:Hook = new Hook("GuildInfosUpgrade",false);
      
      public static const GuildFightEnnemiesListUpdate:Hook = new Hook("GuildFightEnnemiesListUpdate",false);
      
      public static const GuildFightAlliesListUpdate:Hook = new Hook("GuildFightAlliesListUpdate",false);
      
      public static const GuildHousesInformation:Hook = new Hook("GuildHousesInformation",false);
      
      public static const GuildHousesUpdate:Hook = new Hook("GuildHousesUpdate",false);
      
      public static const TaxCollectorMovement:Hook = new Hook("TaxCollectorMovement",false);
      
      public static const AlliancePrismDialogQuestion:Hook = new Hook("AlliancePrismDialogQuestion",false);
      
      public static const TaxCollectorDialogQuestionExtended:Hook = new Hook("TaxCollectorDialogQuestionExtended",false);
      
      public static const AllianceTaxCollectorDialogQuestionExtended:Hook = new Hook("AllianceTaxCollectorDialogQuestionExtended",false);
      
      public static const TaxCollectorDialogQuestionBasic:Hook = new Hook("TaxCollectorDialogQuestionBasic",false);
      
      public static const TaxCollectorAttackedResult:Hook = new Hook("TaxCollectorAttackedResult",false);
      
      public static const TaxCollectorError:Hook = new Hook("TaxCollectorError",false);
      
      public static const TaxCollectorListUpdate:Hook = new Hook("TaxCollectorListUpdate",false);
      
      public static const TaxCollectorUpdate:Hook = new Hook("TaxCollectorUpdate",false);
      
      public static const TaxCollectorMovementAdd:Hook = new Hook("TaxCollectorMovementAdd",false);
      
      public static const TaxCollectorMovementRemove:Hook = new Hook("TaxCollectorMovementRemove",false);
      
      public static const GuildInformationsFarms:Hook = new Hook("GuildInformationsFarms",false);
      
      public static const GuildPaddockAdd:Hook = new Hook("GuildPaddockAdd",false);
      
      public static const GuildPaddockRemoved:Hook = new Hook("GuildPaddockRemoved",false);
      
      public static const GuildHouseAdd:Hook = new Hook("GuildHouseAdd",false);
      
      public static const GuildHouseRemoved:Hook = new Hook("GuildHouseRemoved",false);
      
      public static const GuildTaxCollectorAdd:Hook = new Hook("GuildTaxCollectorAdd",false);
      
      public static const GuildTaxCollectorRemoved:Hook = new Hook("GuildTaxCollectorRemoved",false);
      
      public static const AllianceTaxCollectorRemoved:Hook = new Hook("AllianceTaxCollectorRemoved",false);
      
      public static const GuildList:Hook = new Hook("GuildList",false);
      
      public static const AllianceMembershipUpdated:Hook = new Hook("AllianceMembershipUpdated",false);
      
      public static const AllianceCreationStarted:Hook = new Hook("AllianceCreationStarted",false);
      
      public static const AllianceCreationResult:Hook = new Hook("AllianceCreationResult",false);
      
      public static const AllianceInvited:Hook = new Hook("AllianceInvited",false);
      
      public static const AllianceInvitationStateRecruter:Hook = new Hook("AllianceInvitationStateRecruter",false);
      
      public static const AllianceInvitationStateRecruted:Hook = new Hook("AllianceInvitationStateRecruted",false);
      
      public static const AllianceJoined:Hook = new Hook("AllianceJoined",false);
      
      public static const AllianceGuildLeaving:Hook = new Hook("AllianceGuildLeaving",false);
      
      public static const AllianceLeft:Hook = new Hook("AllianceLeft",false);
      
      public static const AllianceUpdateInformations:Hook = new Hook("AllianceUpdateInformations",false);
      
      public static const AllianceList:Hook = new Hook("AllianceList",false);
      
      public static const ContactLookById:Hook = new Hook("ContactLookById",false);
      
      public static const AttackPlayer:Hook = new Hook("AttackPlayer",false);
      
      public static const DishonourChanged:Hook = new Hook("DishonourChanged",false);
      
      public static const PlayerStatusUpdate:Hook = new Hook("PlayerStatusUpdate",false);
      
      public static const NewAwayMessage:Hook = new Hook("NewAwayMessage",false);
   }
}
