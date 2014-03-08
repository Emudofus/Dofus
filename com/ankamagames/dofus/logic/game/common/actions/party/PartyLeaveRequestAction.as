package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyLeaveRequestAction extends Object implements Action
   {
      
      public function PartyLeaveRequestAction() {
         super();
      }
      
      public static function create(param1:int) : PartyLeaveRequestAction {
         var _loc2_:PartyLeaveRequestAction = new PartyLeaveRequestAction();
         _loc2_.partyId = param1;
         return _loc2_;
      }
      
      public var partyId:int;
   }
}
