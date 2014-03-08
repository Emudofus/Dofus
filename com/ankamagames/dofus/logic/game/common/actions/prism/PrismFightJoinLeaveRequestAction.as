package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismFightJoinLeaveRequestAction extends Object implements Action
   {
      
      public function PrismFightJoinLeaveRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:Boolean) : PrismFightJoinLeaveRequestAction {
         var _loc3_:PrismFightJoinLeaveRequestAction = new PrismFightJoinLeaveRequestAction();
         _loc3_.subAreaId = param1;
         _loc3_.join = param2;
         return _loc3_;
      }
      
      public var subAreaId:uint;
      
      public var join:Boolean;
   }
}
