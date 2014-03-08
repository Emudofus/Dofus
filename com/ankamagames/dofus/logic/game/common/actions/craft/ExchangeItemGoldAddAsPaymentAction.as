package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeItemGoldAddAsPaymentAction extends Object implements Action
   {
      
      public function ExchangeItemGoldAddAsPaymentAction() {
         super();
      }
      
      public static function create(pOnlySuccess:Boolean, pKamas:uint) : ExchangeItemGoldAddAsPaymentAction {
         var action:ExchangeItemGoldAddAsPaymentAction = new ExchangeItemGoldAddAsPaymentAction();
         action.onlySuccess = pOnlySuccess;
         action.kamas = pKamas;
         return action;
      }
      
      public var onlySuccess:Boolean;
      
      public var kamas:uint;
   }
}
