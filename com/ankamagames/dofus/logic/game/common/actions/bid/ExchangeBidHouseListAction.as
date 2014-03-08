package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseListAction extends Object implements Action
   {
      
      public function ExchangeBidHouseListAction() {
         super();
      }
      
      public static function create(pId:uint) : ExchangeBidHouseListAction {
         var a:ExchangeBidHouseListAction = new ExchangeBidHouseListAction();
         a.id = pId;
         return a;
      }
      
      public var id:uint;
   }
}
