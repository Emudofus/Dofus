package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyRefuseInvitationAction extends Object implements Action
   {
      
      public function PartyRefuseInvitationAction() {
         super();
      }
      
      public static function create(param1:int) : PartyRefuseInvitationAction {
         var _loc2_:PartyRefuseInvitationAction = new PartyRefuseInvitationAction();
         _loc2_.partyId = param1;
         return _loc2_;
      }
      
      public var partyId:int;
   }
}
