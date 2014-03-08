package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBuyAction extends Object implements Action
   {
      
      public function ExchangeBuyAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : ExchangeBuyAction {
         var _loc3_:ExchangeBuyAction = new ExchangeBuyAction();
         _loc3_.objectUID = param1;
         _loc3_.quantity = param2;
         return _loc3_;
      }
      
      public var objectUID:uint;
      
      public var quantity:uint;
   }
}
