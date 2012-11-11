package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.guild.*;
    import com.ankamagames.dofus.logic.game.common.actions.social.*;
    import com.ankamagames.dofus.logic.game.common.actions.taxCollector.*;
    import com.ankamagames.dofus.misc.utils.*;

    public class ApiSocialActionList extends Object
    {
        public static const OpenSocial:DofusApiAction = new DofusApiAction("OpenSocial", OpenSocialAction);
        public static const FriendsListRequest:DofusApiAction = new DofusApiAction("FriendsListRequest", FriendsListRequestAction);
        public static const EnemiesListRequest:DofusApiAction = new DofusApiAction("EnemiesListRequest", EnemiesListRequestAction);
        public static const SpouseRequest:DofusApiAction = new DofusApiAction("SpouseRequest", SpouseRequestAction);
        public static const AddFriend:DofusApiAction = new DofusApiAction("AddFriend", AddFriendAction);
        public static const AddEnemy:DofusApiAction = new DofusApiAction("AddEnemy", AddEnemyAction);
        public static const RemoveFriend:DofusApiAction = new DofusApiAction("RemoveFriend", RemoveFriendAction);
        public static const RemoveEnemy:DofusApiAction = new DofusApiAction("RemoveEnemy", RemoveEnemyAction);
        public static const AddIgnored:DofusApiAction = new DofusApiAction("AddIgnored", AddIgnoredAction);
        public static const RemoveIgnored:DofusApiAction = new DofusApiAction("RemoveIgnored", RemoveIgnoredAction);
        public static const JoinFriend:DofusApiAction = new DofusApiAction("JoinFriend", JoinFriendAction);
        public static const JoinSpouse:DofusApiAction = new DofusApiAction("JoinSpouse", JoinSpouseAction);
        public static const FriendSpouseFollow:DofusApiAction = new DofusApiAction("FriendSpouseFollow", FriendSpouseFollowAction);
        public static const FriendWarningSet:DofusApiAction = new DofusApiAction("FriendWarningSet", FriendWarningSetAction);
        public static const MemberWarningSet:DofusApiAction = new DofusApiAction("MemberWarningSet", MemberWarningSetAction);
        public static const FriendOrGuildMemberLevelUpWarningSet:DofusApiAction = new DofusApiAction("FriendOrGuildMemberLevelUpWarningSet", FriendOrGuildMemberLevelUpWarningSetAction);
        public static const GuildGetInformations:DofusApiAction = new DofusApiAction("GuildGetInformations", GuildGetInformationsAction);
        public static const GuildCreationValid:DofusApiAction = new DofusApiAction("GuildCreationValid", GuildCreationValidAction);
        public static const GuildModificationValid:DofusApiAction = new DofusApiAction("GuildModificationValid", GuildModificationValidAction);
        public static const GuildModificationNameValid:DofusApiAction = new DofusApiAction("GuildModificationNameValid", GuildModificationNameValidAction);
        public static const GuildModificationEmblemValid:DofusApiAction = new DofusApiAction("GuildModificationEmblemValid", GuildModificationEmblemValidAction);
        public static const GuildInvitation:DofusApiAction = new DofusApiAction("GuildInvitation", GuildInvitationAction);
        public static const GuildInvitationByName:DofusApiAction = new DofusApiAction("GuildInvitationByName", GuildInvitationByNameAction);
        public static const GuildInvitationAnswer:DofusApiAction = new DofusApiAction("GuildInvitationAnswer", GuildInvitationAnswerAction);
        public static const GuildKickRequest:DofusApiAction = new DofusApiAction("GuildKickRequest", GuildKickRequestAction);
        public static const GuildChangeMemberParameters:DofusApiAction = new DofusApiAction("GuildChangeMemberParameters", GuildChangeMemberParametersAction);
        public static const GuildSpellUpgradeRequest:DofusApiAction = new DofusApiAction("GuildSpellUpgradeRequest", GuildSpellUpgradeRequestAction);
        public static const GuildCharacsUpgradeRequest:DofusApiAction = new DofusApiAction("GuildCharacsUpgradeRequest", GuildCharacsUpgradeRequestAction);
        public static const GuildFarmTeleportRequest:DofusApiAction = new DofusApiAction("GuildFarmTeleportRequest", GuildFarmTeleportRequestAction);
        public static const GuildHouseTeleportRequest:DofusApiAction = new DofusApiAction("GuildHouseTeleportRequest", GuildHouseTeleportRequestAction);
        public static const GuildFightJoinRequest:DofusApiAction = new DofusApiAction("GuildFightJoinRequest", GuildFightJoinRequestAction);
        public static const GuildFightTakePlaceRequest:DofusApiAction = new DofusApiAction("GuildFightTakePlaceRequest", GuildFightTakePlaceRequestAction);
        public static const GuildFightLeaveRequest:DofusApiAction = new DofusApiAction("GuildFightLeaveRequest", GuildFightLeaveRequestAction);
        public static const TaxCollectorHireRequest:DofusApiAction = new DofusApiAction("TaxCollectorHireRequest", TaxCollectorHireRequestAction);
        public static const GameRolePlayTaxCollectorFightRequest:DofusApiAction = new DofusApiAction("GameRolePlayTaxCollectorFightRequest", GameRolePlayTaxCollectorFightRequestAction);
        public static const CharacterReportRequest:DofusApiAction = new DofusApiAction("CharacterReport", CharacterReportAction);
        public static const ChatReportRequest:DofusApiAction = new DofusApiAction("ChatReport", ChatReportAction);

        public function ApiSocialActionList()
        {
            return;
        }// end function

    }
}
