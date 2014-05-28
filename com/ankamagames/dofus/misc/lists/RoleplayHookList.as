package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class RoleplayHookList extends Object
   {
      
      public function RoleplayHookList() {
         super();
      }
      
      public static const PlayerFightRequestSent:Hook;
      
      public static const PlayerFightFriendlyRequested:Hook;
      
      public static const FightRequestCanceled:Hook;
      
      public static const PlayerFightFriendlyAnswer:Hook;
      
      public static const PlayerFightFriendlyAnswered:Hook;
      
      public static const EmoteListUpdated:Hook;
      
      public static const EmoteUnabledListUpdated:Hook;
      
      public static const SpellForgetUI:Hook;
      
      public static const DocumentReadingBegin:Hook;
      
      public static const TeleportDestinationList:Hook;
      
      public static const EstateToSellList:Hook;
      
      public static const DungeonPartyFinderAvailableDungeons:Hook;
      
      public static const DungeonPartyFinderRoomContent:Hook;
      
      public static const DungeonPartyFinderRegister:Hook;
      
      public static const ArenaRegistrationStatusUpdate:Hook;
      
      public static const ArenaFightProposition:Hook;
      
      public static const ArenaFighterStatusUpdate:Hook;
      
      public static const ArenaUpdateRank:Hook;
      
      public static const NpcDialogCreation:Hook;
      
      public static const PonyDialogCreation:Hook;
      
      public static const PrismDialogCreation:Hook;
      
      public static const PortalDialogCreation:Hook;
      
      public static const NpcDialogCreationFailure:Hook;
      
      public static const NpcDialogQuestion:Hook;
      
      public static const PortalDialogQuestion:Hook;
   }
}
