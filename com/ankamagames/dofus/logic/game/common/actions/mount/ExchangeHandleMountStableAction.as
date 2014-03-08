package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeHandleMountStableAction extends Object implements Action
   {
      
      public function ExchangeHandleMountStableAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : ExchangeHandleMountStableAction {
         var _loc3_:ExchangeHandleMountStableAction = new ExchangeHandleMountStableAction();
         _loc3_.actionType = param1;
         _loc3_.rideId = param2;
         return _loc3_;
      }
      
      public var rideId:uint;
      
      public var actionType:int;
   }
}
