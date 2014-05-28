package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeHandleMountStableAction extends Object implements Action
   {
      
      public function ExchangeHandleMountStableAction() {
         super();
      }
      
      public static function create(actionType:uint, mountId:uint) : ExchangeHandleMountStableAction {
         var act:ExchangeHandleMountStableAction = new ExchangeHandleMountStableAction();
         act.actionType = actionType;
         act.rideId = mountId;
         return act;
      }
      
      public var rideId:uint;
      
      public var actionType:int;
   }
}
