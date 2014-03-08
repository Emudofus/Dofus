package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyPledgeLoyaltyRequestAction extends Object implements Action
   {
      
      public function PartyPledgeLoyaltyRequestAction() {
         super();
      }
      
      public static function create(param1:int, param2:Boolean) : PartyPledgeLoyaltyRequestAction {
         var _loc3_:PartyPledgeLoyaltyRequestAction = new PartyPledgeLoyaltyRequestAction();
         _loc3_.partyId = param1;
         _loc3_.loyal = param2;
         return _loc3_;
      }
      
      public var loyal:Boolean;
      
      public var partyId:int;
   }
}
