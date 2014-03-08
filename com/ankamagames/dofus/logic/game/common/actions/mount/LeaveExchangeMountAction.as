package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveExchangeMountAction extends Object implements Action
   {
      
      public function LeaveExchangeMountAction() {
         super();
      }
      
      public static function create() : LeaveExchangeMountAction {
         return new LeaveExchangeMountAction();
      }
   }
}
