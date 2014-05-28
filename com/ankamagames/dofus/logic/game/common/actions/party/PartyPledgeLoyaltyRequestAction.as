package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyPledgeLoyaltyRequestAction extends Object implements Action
   {
      
      public function PartyPledgeLoyaltyRequestAction() {
         super();
      }
      
      public static function create(partyId:int, loyal:Boolean) : PartyPledgeLoyaltyRequestAction {
         var a:PartyPledgeLoyaltyRequestAction = new PartyPledgeLoyaltyRequestAction();
         a.partyId = partyId;
         a.loyal = loyal;
         return a;
      }
      
      public var loyal:Boolean;
      
      public var partyId:int;
   }
}
