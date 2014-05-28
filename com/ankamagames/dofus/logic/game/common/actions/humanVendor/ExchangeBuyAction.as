package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBuyAction extends Object implements Action
   {
      
      public function ExchangeBuyAction() {
         super();
      }
      
      public static function create(pObjectUID:uint, pQuantity:uint) : ExchangeBuyAction {
         var a:ExchangeBuyAction = new ExchangeBuyAction();
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         return a;
      }
      
      public var objectUID:uint;
      
      public var quantity:uint;
   }
}
