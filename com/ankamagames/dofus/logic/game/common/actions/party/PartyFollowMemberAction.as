package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyFollowMemberAction extends Object implements Action
   {
      
      public function PartyFollowMemberAction() {
         super();
      }
      
      public static function create(param1:int, param2:uint) : PartyFollowMemberAction {
         var _loc3_:PartyFollowMemberAction = new PartyFollowMemberAction();
         _loc3_.partyId = param1;
         _loc3_.playerId = param2;
         return _loc3_;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
