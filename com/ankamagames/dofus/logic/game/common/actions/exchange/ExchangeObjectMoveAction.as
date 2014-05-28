package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectMoveAction extends Object implements Action
   {
      
      public function ExchangeObjectMoveAction() {
         super();
      }
      
      public static function create(pObjectUID:uint, pQuantity:int) : ExchangeObjectMoveAction {
         var a:ExchangeObjectMoveAction = new ExchangeObjectMoveAction();
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         return a;
      }
      
      public var objectUID:uint;
      
      public var quantity:int;
   }
}
