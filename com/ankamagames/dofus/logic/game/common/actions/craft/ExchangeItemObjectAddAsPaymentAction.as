package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeItemObjectAddAsPaymentAction extends Object implements Action
   {
      
      public function ExchangeItemObjectAddAsPaymentAction() {
         super();
      }
      
      public static function create(param1:Boolean, param2:uint, param3:Boolean, param4:int) : ExchangeItemObjectAddAsPaymentAction {
         var _loc5_:ExchangeItemObjectAddAsPaymentAction = new ExchangeItemObjectAddAsPaymentAction();
         _loc5_.onlySuccess = param1;
         _loc5_.objectUID = param2;
         _loc5_.quantity = param4;
         _loc5_.isAdd = param3;
         return _loc5_;
      }
      
      public var onlySuccess:Boolean;
      
      public var objectUID:uint;
      
      public var quantity:int;
      
      public var isAdd:Boolean;
   }
}
