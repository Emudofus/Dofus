package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHousePriceAction extends Object implements Action
   {
      
      public function ExchangeBidHousePriceAction() {
         super();
      }
      
      public static function create(pGid:uint) : ExchangeBidHousePriceAction {
         var a:ExchangeBidHousePriceAction = new ExchangeBidHousePriceAction();
         a.genId = pGid;
         return a;
      }
      
      public var genId:uint;
   }
}
