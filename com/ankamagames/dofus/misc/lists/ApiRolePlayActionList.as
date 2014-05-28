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
      
      public static const PlayerFightRequest:DofusApiAction;
      
      public static const PlayerFightFriendlyAnswer:DofusApiAction;
      
      public static const EmotePlayRequest:DofusApiAction;
      
      public static const DisplayContextualMenu:DofusApiAction;
      
      public static const ValidateSpellForget:DofusApiAction;
      
      public static const NpcGenericActionRequest:DofusApiAction;
      
      public static const HouseToSellFilter:DofusApiAction;
      
      public static const PaddockToSellFilter:DofusApiAction;
      
      public static const HouseToSellListRequest:DofusApiAction;
      
      public static const PaddockToSellListRequest:DofusApiAction;
      
      public static const DungeonPartyFinderAvailableDungeons:DofusApiAction;
      
      public static const DungeonPartyFinderListen:DofusApiAction;
      
      public static const DungeonPartyFinderRegister:DofusApiAction;
      
      public static const ArenaRegister:DofusApiAction;
      
      public static const ArenaUnregister:DofusApiAction;
      
      public static const ArenaFightAnswer:DofusApiAction;
      
      public static const TeleportBuddiesAnswer:DofusApiAction;
      
      public static const TeleportToBuddyAnswer:DofusApiAction;
   }
}
