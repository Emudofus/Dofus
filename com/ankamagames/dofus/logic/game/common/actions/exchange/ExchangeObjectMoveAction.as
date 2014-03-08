package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectMoveAction extends Object implements Action
   {
      
      public function ExchangeObjectMoveAction() {
         super();
      }
      
      public static function create(param1:uint, param2:int) : ExchangeObjectMoveAction {
         var _loc3_:ExchangeObjectMoveAction = new ExchangeObjectMoveAction();
         _loc3_.objectUID = param1;
         _loc3_.quantity = param2;
         return _loc3_;
      }
      
      public var objectUID:uint;
      
      public var quantity:int;
   }
}
