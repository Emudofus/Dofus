package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeItemObjectAddAsPaymentAction extends Object implements Action
   {
      
      public function ExchangeItemObjectAddAsPaymentAction() {
         super();
      }
      
      public static function create(pOnlySuccess:Boolean, pObjectUID:uint, pIsAdd:Boolean, pQuantity:int) : ExchangeItemObjectAddAsPaymentAction {
         var action:ExchangeItemObjectAddAsPaymentAction = new ExchangeItemObjectAddAsPaymentAction();
         action.onlySuccess = pOnlySuccess;
         action.objectUID = pObjectUID;
         action.quantity = pQuantity;
         action.isAdd = pIsAdd;
         return action;
      }
      
      public var onlySuccess:Boolean;
      
      public var objectUID:uint;
      
      public var quantity:int;
      
      public var isAdd:Boolean;
   }
}
