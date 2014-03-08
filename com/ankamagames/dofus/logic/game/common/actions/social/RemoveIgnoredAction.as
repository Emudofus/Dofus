package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveIgnoredAction extends Object implements Action
   {
      
      public function RemoveIgnoredAction() {
         super();
      }
      
      public static function create(param1:int) : RemoveIgnoredAction {
         var _loc2_:RemoveIgnoredAction = new RemoveIgnoredAction();
         _loc2_.accountId = param1;
         return _loc2_;
      }
      
      public var accountId:int;
   }
}
