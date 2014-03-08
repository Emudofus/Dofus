package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAcceptInvitationAction extends Object implements Action
   {
      
      public function PartyAcceptInvitationAction() {
         super();
      }
      
      public static function create(partyId:int) : PartyAcceptInvitationAction {
         var a:PartyAcceptInvitationAction = new PartyAcceptInvitationAction();
         a.partyId = partyId;
         return a;
      }
      
      public var partyId:int;
   }
}
