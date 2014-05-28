package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAllFollowMemberAction extends Object implements Action
   {
      
      public function PartyAllFollowMemberAction() {
         super();
      }
      
      public static function create(partyId:int, pPlayerId:uint) : PartyAllFollowMemberAction {
         var a:PartyAllFollowMemberAction = new PartyAllFollowMemberAction();
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
