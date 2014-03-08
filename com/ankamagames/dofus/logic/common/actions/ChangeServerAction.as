package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeServerAction extends Object implements Action
   {
      
      public function ChangeServerAction() {
         super();
      }
      
      public static function create() : ChangeServerAction {
         return new ChangeServerAction();
      }
   }
}
