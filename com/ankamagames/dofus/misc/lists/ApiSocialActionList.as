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
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.TaxCollectorHireRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.GameRolePlayTaxCollectorFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.CharacterReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ChatReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.PlayerStatusUpdateRequestAction;


   public class ApiSocialActionList extends Object
   {
         

      public function ApiSocialActionList() {
         super();
      }

      public static const OpenSocial:DofusApiAction = new DofusApiAction("OpenSocial",OpenSocialAction);

      public static const FriendsListRequest:DofusApiAction = new DofusApiAction("FriendsListRequest",FriendsListRequestAction);

      public static const EnemiesListRequest:DofusApiAction = new DofusApiAction("EnemiesListRequest",EnemiesListRequestAction);

      public static const SpouseRequest:DofusApiAction = new DofusApiAction("SpouseRequest",SpouseRequestAction);

      public static const AddFriend:DofusApiAction = new DofusApiAction("AddFriend",AddFriendAction);

      public static const AddEnemy:DofusApiAction = new DofusApiAction("AddEnemy",AddEnemyAction);

      public static const RemoveFriend:DofusApiAction = new DofusApiAction("RemoveFriend",RemoveFriendAction);

      public static const RemoveEnemy:DofusApiAction = new DofusApiAction("RemoveEnemy",RemoveEnemyAction);

      public static const AddIgnored:DofusApiAction = new DofusApiAction("AddIgnored",AddIgnoredAction);

      public static const RemoveIgnored:DofusApiAction = new DofusApiAction("RemoveIgnored",RemoveIgnoredAction);

      public static const JoinFriend:DofusApiAction = new DofusApiAction("JoinFriend",JoinFriendAction);

      public static const JoinSpouse:DofusApiAction = new DofusApiAction("JoinSpouse",JoinSpouseAction);

      public static const FriendSpouseFollow:DofusApiAction = new DofusApiAction("FriendSpouseFollow",FriendSpouseFollowAction);

      public static const FriendWarningSet:DofusApiAction = new DofusApiAction("FriendWarningSet",FriendWarningSetAction);

      public static const MemberWarningSet:DofusApiAction = new DofusApiAction("MemberWarningSet",MemberWarningSetAction);

      public static const FriendOrGuildMemberLevelUpWarningSet:DofusApiAction = new DofusApiAction("FriendOrGuildMemberLevelUpWarningSet",FriendOrGuildMemberLevelUpWarningSetAction);

      public static const FriendGuildSetWarnOnAchievementComplete:DofusApiAction = new DofusApiAction("FriendGuildSetWarnOnAchievementComplete",FriendGuildSetWarnOnAchievementCompleteAction);

      public static const GuildGetInformations:DofusApiAction = new DofusApiAction("GuildGetInformations",GuildGetInformationsAction);

      public static const GuildCreationValid:DofusApiAction = new DofusApiAction("GuildCreationValid",GuildCreationValidAction);

      public static const GuildModificationValid:DofusApiAction = new DofusApiAction("GuildModificationValid",GuildModificationValidAction);

      public static const GuildModificationNameValid:DofusApiAction = new DofusApiAction("GuildModificationNameValid",GuildModificationNameValidAction);

      public static const GuildModificationEmblemValid:DofusApiAction = new DofusApiAction("GuildModificationEmblemValid",GuildModificationEmblemValidAction);

      public static const GuildInvitation:DofusApiAction = new DofusApiAction("GuildInvitation",GuildInvitationAction);

      public static const GuildInvitationByName:DofusApiAction = new DofusApiAction("GuildInvitationByName",GuildInvitationByNameAction);

      public static const GuildInvitationAnswer:DofusApiAction = new DofusApiAction("GuildInvitationAnswer",GuildInvitationAnswerAction);

      public static const GuildKickRequest:DofusApiAction = new DofusApiAction("GuildKickRequest",GuildKickRequestAction);

      public static const GuildChangeMemberParameters:DofusApiAction = new DofusApiAction("GuildChangeMemberParameters",GuildChangeMemberParametersAction);

      public static const GuildSpellUpgradeRequest:DofusApiAction = new DofusApiAction("GuildSpellUpgradeRequest",GuildSpellUpgradeRequestAction);

      public static const GuildCharacsUpgradeRequest:DofusApiAction = new DofusApiAction("GuildCharacsUpgradeRequest",GuildCharacsUpgradeRequestAction);

      public static const GuildFarmTeleportRequest:DofusApiAction = new DofusApiAction("GuildFarmTeleportRequest",GuildFarmTeleportRequestAction);

      public static const GuildHouseTeleportRequest:DofusApiAction = new DofusApiAction("GuildHouseTeleportRequest",GuildHouseTeleportRequestAction);

      public static const GuildFightJoinRequest:DofusApiAction = new DofusApiAction("GuildFightJoinRequest",GuildFightJoinRequestAction);

      public static const GuildFightTakePlaceRequest:DofusApiAction = new DofusApiAction("GuildFightTakePlaceRequest",GuildFightTakePlaceRequestAction);

      public static const GuildFightLeaveRequest:DofusApiAction = new DofusApiAction("GuildFightLeaveRequest",GuildFightLeaveRequestAction);

      public static const TaxCollectorHireRequest:DofusApiAction = new DofusApiAction("TaxCollectorHireRequest",TaxCollectorHireRequestAction);

      public static const GameRolePlayTaxCollectorFightRequest:DofusApiAction = new DofusApiAction("GameRolePlayTaxCollectorFightRequest",GameRolePlayTaxCollectorFightRequestAction);

      public static const CharacterReportRequest:DofusApiAction = new DofusApiAction("CharacterReport",CharacterReportAction);

      public static const ChatReportRequest:DofusApiAction = new DofusApiAction("ChatReport",ChatReportAction);

      public static const PlayerStatusUpdateRequest:DofusApiAction = new DofusApiAction("PlayerStatusUpdateRequest",PlayerStatusUpdateRequestAction);


   }

}