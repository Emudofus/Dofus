package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyShowMenuAction extends Object implements Action
   {
      
      public function PartyShowMenuAction() {
         super();
      }
      
      public static function create(param1:uint, param2:int) : PartyShowMenuAction {
         var _loc3_:PartyShowMenuAction = new PartyShowMenuAction();
         _loc3_.playerId = param1;
         _loc3_.partyId = param2;
         return _loc3_;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
