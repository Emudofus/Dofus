package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class PrismFightJoinLeaveRequestAction extends Object implements Action
   {
         

      public function PrismFightJoinLeaveRequestAction() {
         super();
      }

      public static function create(join:Boolean) : PrismFightJoinLeaveRequestAction {
         var action:PrismFightJoinLeaveRequestAction = new PrismFightJoinLeaveRequestAction();
         action.join=join;
         return action;
      }

      public var join:Boolean;
   }

}