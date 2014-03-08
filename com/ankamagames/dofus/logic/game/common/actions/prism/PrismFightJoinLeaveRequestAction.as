package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismFightJoinLeaveRequestAction extends Object implements Action
   {
      
      public function PrismFightJoinLeaveRequestAction() {
         super();
      }
      
      public static function create(subAreaId:uint, join:Boolean) : PrismFightJoinLeaveRequestAction {
         var action:PrismFightJoinLeaveRequestAction = new PrismFightJoinLeaveRequestAction();
         action.subAreaId = subAreaId;
         action.join = join;
         return action;
      }
      
      public var subAreaId:uint;
      
      public var join:Boolean;
   }
}
