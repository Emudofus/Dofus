package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeWorldInteractionAction extends Object implements Action
   {
      
      public function ChangeWorldInteractionAction() {
         super();
      }
      
      public static function create(param1:Boolean, param2:Boolean=true) : ChangeWorldInteractionAction {
         var _loc3_:ChangeWorldInteractionAction = new ChangeWorldInteractionAction();
         _loc3_.enabled = param1;
         _loc3_.total = param2;
         return _loc3_;
      }
      
      public var enabled:Boolean;
      
      public var total:Boolean;
   }
}
