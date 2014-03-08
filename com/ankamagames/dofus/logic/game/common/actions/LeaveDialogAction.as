package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveDialogAction extends Object implements Action
   {
      
      public function LeaveDialogAction() {
         super();
      }
      
      public static function create() : LeaveDialogAction {
         var _loc1_:LeaveDialogAction = new LeaveDialogAction();
         return _loc1_;
      }
   }
}
