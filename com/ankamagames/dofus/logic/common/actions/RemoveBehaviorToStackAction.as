package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveBehaviorToStackAction extends Object implements Action
   {
      
      public function RemoveBehaviorToStackAction() {
         super();
      }
      
      public var behavior:String;
      
      public function create(param1:String) : RemoveBehaviorToStackAction {
         var _loc2_:RemoveBehaviorToStackAction = new RemoveBehaviorToStackAction();
         _loc2_.behavior = param1;
         return _loc2_;
      }
   }
}
