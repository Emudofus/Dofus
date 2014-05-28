package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NotificationUpdateFlagAction extends Object implements Action
   {
      
      public function NotificationUpdateFlagAction() {
         super();
      }
      
      public static function create(index:uint) : NotificationUpdateFlagAction {
         var action:NotificationUpdateFlagAction = new NotificationUpdateFlagAction();
         action.index = index;
         return action;
      }
      
      public var index:uint;
   }
}
