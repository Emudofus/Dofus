package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAllStopFollowingMemberAction extends Object implements Action
   {
      
      public function PartyAllStopFollowingMemberAction() {
         super();
      }
      
      public static function create(partyId:int, pPlayerId:uint) : PartyAllStopFollowingMemberAction {
         var a:PartyAllStopFollowingMemberAction = new PartyAllStopFollowingMemberAction();
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
