package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.EnemiesListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.SpouseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinSpouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendSpouseFollowAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.MemberWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendOrGuildMemberLevelUpWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendGuildSetWarnOnAchievementCompleteAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationNameValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationByNameAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSpellUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCharacsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFarmTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildHouseTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightTakePlaceRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.GameRolePlayTaxCollectorFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationNameAndTagValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInsiderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceChangeGuildRightsAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.CharacterReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ChatReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.PlayerStatusUpdateRequestAction;
   
   public class ApiSocialActionList extends Object
   {
      
      public function ApiSocialActionList() {
         super();
      }
      
      public static const OpenSocial:DofusApiAction;
      
      public static const FriendsListRequest:DofusApiAction;
      
      public static const EnemiesListRequest:DofusApiAction;
      
      public static const SpouseRequest:DofusApiAction;
      
      public static const AddFriend:DofusApiAction;
      
      public static const AddEnemy:DofusApiAction;
      
      public static const RemoveFriend:DofusApiAction;
      
      public static const RemoveEnemy:DofusApiAction;
      
      public static const AddIgnored:DofusApiAction;
      
      public static const RemoveIgnored:DofusApiAction;
      
      public static const JoinFriend:DofusApiAction;
      
      public static const JoinSpouse:DofusApiAction;
      
      public static const FriendSpouseFollow:DofusApiAction;
      
      public static const FriendWarningSet:DofusApiAction;
      
      public static const MemberWarningSet:DofusApiAction;
      
      public static const FriendOrGuildMemberLevelUpWarningSet:DofusApiAction;
      
      public static const FriendGuildSetWarnOnAchievementComplete:DofusApiAction;
      
      public static const GuildGetInformations:DofusApiAction;
      
      public static const GuildCreationValid:DofusApiAction;
      
      public static const GuildModificationValid:DofusApiAction;
      
      public static const GuildModificationNameValid:DofusApiAction;
      
      public static const GuildModificationEmblemValid:DofusApiAction;
      
      public static const GuildInvitation:DofusApiAction;
      
      public static const GuildInvitationByName:DofusApiAction;
      
      public static const GuildInvitationAnswer:DofusApiAction;
      
      public static const GuildKickRequest:DofusApiAction;
      
      public static const GuildChangeMemberParameters:DofusApiAction;
      
      public static const GuildSpellUpgradeRequest:DofusApiAction;
      
      public static const GuildCharacsUpgradeRequest:DofusApiAction;
      
      public static const GuildFarmTeleportRequest:DofusApiAction;
      
      public static const GuildHouseTeleportRequest:DofusApiAction;
      
      public static const GuildFightJoinRequest:DofusApiAction;
      
      public static const GuildFightTakePlaceRequest:DofusApiAction;
      
      public static const GuildFightLeaveRequest:DofusApiAction;
      
      public static const GameRolePlayTaxCollectorFightRequest:DofusApiAction;
      
      public static const GuildFactsRequest:DofusApiAction;
      
      public static const GuildListRequest:DofusApiAction;
      
      public static const AllianceCreationValid:DofusApiAction;
      
      public static const AllianceModificationValid:DofusApiAction;
      
      public static const AllianceModificationNameAndTagValid:DofusApiAction;
      
      public static const AllianceModificationEmblemValid:DofusApiAction;
      
      public static const AllianceInvitation:DofusApiAction;
      
      public static const AllianceInvitationAnswer:DofusApiAction;
      
      public static const AllianceKickRequest:DofusApiAction;
      
      public static const AllianceFactsRequest:DofusApiAction;
      
      public static const AllianceListRequest:DofusApiAction;
      
      public static const AllianceInsiderInfoRequest:DofusApiAction;
      
      public static const AllianceChangeGuildRights:DofusApiAction;
      
      public static const CharacterReport:DofusApiAction;
      
      public static const ChatReport:DofusApiAction;
      
      public static const PlayerStatusUpdateRequest:DofusApiAction;
   }
}
