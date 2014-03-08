package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAbdicateThroneAction extends Object implements Action
   {
      
      public function PartyAbdicateThroneAction() {
         super();
      }
      
      public static function create(param1:int, param2:uint) : PartyAbdicateThroneAction {
         var _loc3_:PartyAbdicateThroneAction = new PartyAbdicateThroneAction();
         _loc3_.partyId = param1;
         _loc3_.playerId = param2;
         return _loc3_;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
