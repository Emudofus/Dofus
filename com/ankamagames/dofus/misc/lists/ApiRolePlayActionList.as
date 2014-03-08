package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightFriendlyAnswerAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DisplayContextualMenuAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ValidateSpellForgetAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderAvailableDungeonsAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderListenAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaUnregisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaFightAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.TeleportBuddiesAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.TeleportToBuddyAnswerAction;
   
   public class ApiRolePlayActionList extends Object
   {
      
      public function ApiRolePlayActionList() {
         super();
      }
      
      public static const PlayerFightRequest:DofusApiAction = new DofusApiAction("PlayerFightRequest",PlayerFightRequestAction);
      
      public static const PlayerFightFriendlyAnswer:DofusApiAction = new DofusApiAction("PlayerFightFriendlyAnswer",PlayerFightFriendlyAnswerAction);
      
      public static const EmotePlayRequest:DofusApiAction = new DofusApiAction("EmotePlayRequest",EmotePlayRequestAction);
      
      public static const DisplayContextualMenu:DofusApiAction = new DofusApiAction("DisplayContextualMenu",DisplayContextualMenuAction);
      
      public static const ValidateSpellForget:DofusApiAction = new DofusApiAction("ValidateSpellForget",ValidateSpellForgetAction);
      
      public static const NpcGenericActionRequest:DofusApiAction = new DofusApiAction("NpcGenericActionRequest",NpcGenericActionRequestAction);
      
      public static const HouseToSellFilter:DofusApiAction = new DofusApiAction("HouseToSellFilter",HouseToSellFilterAction);
      
      public static const PaddockToSellFilter:DofusApiAction = new DofusApiAction("PaddockToSellFilter",PaddockToSellFilterAction);
      
      public static const HouseToSellListRequest:DofusApiAction = new DofusApiAction("HouseToSellListRequest",HouseToSellListRequestAction);
      
      public static const PaddockToSellListRequest:DofusApiAction = new DofusApiAction("PaddockToSellListRequest",PaddockToSellListRequestAction);
      
      public static const DungeonPartyFinderAvailableDungeons:DofusApiAction = new DofusApiAction("DungeonPartyFinderAvailableDungeons",DungeonPartyFinderAvailableDungeonsAction);
      
      public static const DungeonPartyFinderListen:DofusApiAction = new DofusApiAction("DungeonPartyFinderListen",DungeonPartyFinderListenAction);
      
      public static const DungeonPartyFinderRegister:DofusApiAction = new DofusApiAction("DungeonPartyFinderRegister",DungeonPartyFinderRegisterAction);
      
      public static const ArenaRegister:DofusApiAction = new DofusApiAction("ArenaRegister",ArenaRegisterAction);
      
      public static const ArenaUnregister:DofusApiAction = new DofusApiAction("ArenaUnregister",ArenaUnregisterAction);
      
      public static const ArenaFightAnswer:DofusApiAction = new DofusApiAction("ArenaFightAnswer",ArenaFightAnswerAction);
      
      public static const TeleportBuddiesAnswer:DofusApiAction = new DofusApiAction("TeleportBuddiesAnswer",TeleportBuddiesAnswerAction);
      
      public static const TeleportToBuddyAnswer:DofusApiAction = new DofusApiAction("TeleportToBuddyAnswer",TeleportToBuddyAnswerAction);
   }
}
