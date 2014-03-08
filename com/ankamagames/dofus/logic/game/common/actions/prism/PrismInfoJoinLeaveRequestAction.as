package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismInfoJoinLeaveRequestAction extends Object implements Action
   {
      
      public function PrismInfoJoinLeaveRequestAction() {
         super();
      }
      
      public static function create(param1:Boolean) : PrismInfoJoinLeaveRequestAction {
         var _loc2_:PrismInfoJoinLeaveRequestAction = new PrismInfoJoinLeaveRequestAction();
         _loc2_.join = param1;
         return _loc2_;
      }
      
      public var join:Boolean;
   }
}
