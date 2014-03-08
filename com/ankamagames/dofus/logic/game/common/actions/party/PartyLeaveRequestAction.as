package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyLeaveRequestAction extends Object implements Action
   {
      
      public function PartyLeaveRequestAction() {
         super();
      }
      
      public static function create(partyId:int) : PartyLeaveRequestAction {
         var a:PartyLeaveRequestAction = new PartyLeaveRequestAction();
         a.partyId = partyId;
         return a;
      }
      
      public var partyId:int;
   }
}
