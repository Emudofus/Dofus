package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NotificationResetAction extends Object implements Action
   {
      
      public function NotificationResetAction() {
         super();
      }
      
      public static function create() : NotificationResetAction {
         var action:NotificationResetAction = new NotificationResetAction();
         return action;
      }
   }
}
