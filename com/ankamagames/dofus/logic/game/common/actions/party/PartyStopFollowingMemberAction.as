package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyStopFollowingMemberAction extends Object implements Action
   {
      
      public function PartyStopFollowingMemberAction() {
         super();
      }
      
      public static function create(partyId:int, pPlayerId:uint) : PartyStopFollowingMemberAction {
         var a:PartyStopFollowingMemberAction = new PartyStopFollowingMemberAction();
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
