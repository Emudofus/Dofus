package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockSellRequestAction extends Object implements Action
   {
      
      public function PaddockSellRequestAction() {
         super();
      }
      
      public static function create(price:uint) : PaddockSellRequestAction {
         var o:PaddockSellRequestAction = new PaddockSellRequestAction();
         o.price = price;
         return o;
      }
      
      public var price:uint;
   }
}
