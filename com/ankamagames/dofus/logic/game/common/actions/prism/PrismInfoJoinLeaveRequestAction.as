package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismInfoJoinLeaveRequestAction extends Object implements Action
   {
      
      public function PrismInfoJoinLeaveRequestAction() {
         super();
      }
      
      public static function create(join:Boolean) : PrismInfoJoinLeaveRequestAction {
         var action:PrismInfoJoinLeaveRequestAction = new PrismInfoJoinLeaveRequestAction();
         action.join = join;
         return action;
      }
      
      public var join:Boolean;
   }
}
