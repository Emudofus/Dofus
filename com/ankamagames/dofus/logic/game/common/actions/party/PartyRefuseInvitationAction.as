package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyRefuseInvitationAction extends Object implements Action
   {
      
      public function PartyRefuseInvitationAction() {
         super();
      }
      
      public static function create(partyId:int) : PartyRefuseInvitationAction {
         var a:PartyRefuseInvitationAction = new PartyRefuseInvitationAction();
         a.partyId = partyId;
         return a;
      }
      
      public var partyId:int;
   }
}
