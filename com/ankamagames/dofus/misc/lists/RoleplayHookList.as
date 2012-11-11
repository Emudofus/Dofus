package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.*;

    public class RoleplayHookList extends Object
    {
        public static const PlayerFightRequestSent:Hook = new Hook("PlayerFightRequestSent", false);
        public static const PlayerFightFriendlyRequested:Hook = new Hook("PlayerFightFriendlyRequested", false);
        public static const FightRequestCanceled:Hook = new Hook("FightRequestCanceled", false);
        public static const PlayerFightFriendlyAnswer:Hook = new Hook("PlayerFightFriendlyAnswer", false);
        public static const PlayerFightFriendlyAnswered:Hook = new Hook("PlayerFightFriendlyAnswered", false);
        public static const EmoteListUpdated:Hook = new Hook("EmoteListUpdated", false);
        public static const EmoteUnabledListUpdated:Hook = new Hook("EmoteUnabledListUpdated", false);
        public static const SpellForgetUI:Hook = new Hook("SpellForgetUI", false);
        public static const DocumentReadingBegin:Hook = new Hook("DocumentReadingBegin", false);
        public static const TeleportDestinationList:Hook = new Hook("TeleportDestinationList", false);
        public static const EstateToSellList:Hook = new Hook("EstateToSellList", false);
        public static const DungeonPartyFinderAvailableDungeons:Hook = new Hook("DungeonPartyFinderAvailableDungeons", false);
        public static const DungeonPartyFinderRoomContent:Hook = new Hook("DungeonPartyFinderRoomContent", false);
        public static const DungeonPartyFinderRegister:Hook = new Hook("DungeonPartyFinderRegister", false);
        public static const ArenaRegistrationStatusUpdate:Hook = new Hook("ArenaRegistrationStatusUpdate", false);
        public static const ArenaFightProposition:Hook = new Hook("ArenaFightProposition", false);
        public static const ArenaFighterStatusUpdate:Hook = new Hook("ArenaFighterStatusUpdate", false);
        public static const ArenaUpdateRank:Hook = new Hook("ArenaUpdateRank", false);

        public function RoleplayHookList()
        {
            return;
        }// end function

    }
}
