package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeWorldInteractionAction extends Object implements Action
   {
      
      public function ChangeWorldInteractionAction() {
         super();
      }
      
      public static function create(enabled:Boolean, total:Boolean=true) : ChangeWorldInteractionAction {
         var a:ChangeWorldInteractionAction = new ChangeWorldInteractionAction();
         a.enabled = enabled;
         a.total = total;
         return a;
      }
      
      public var enabled:Boolean;
      
      public var total:Boolean;
   }
}
