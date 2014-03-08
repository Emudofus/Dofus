package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeItemGoldAddAsPaymentAction extends Object implements Action
   {
      
      public function ExchangeItemGoldAddAsPaymentAction() {
         super();
      }
      
      public static function create(param1:Boolean, param2:uint) : ExchangeItemGoldAddAsPaymentAction {
         var _loc3_:ExchangeItemGoldAddAsPaymentAction = new ExchangeItemGoldAddAsPaymentAction();
         _loc3_.onlySuccess = param1;
         _loc3_.kamas = param2;
         return _loc3_;
      }
      
      public var onlySuccess:Boolean;
      
      public var kamas:uint;
   }
}
