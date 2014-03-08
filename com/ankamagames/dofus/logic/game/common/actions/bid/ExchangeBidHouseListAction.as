package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseListAction extends Object implements Action
   {
      
      public function ExchangeBidHouseListAction() {
         super();
      }
      
      public static function create(param1:uint) : ExchangeBidHouseListAction {
         var _loc2_:ExchangeBidHouseListAction = new ExchangeBidHouseListAction();
         _loc2_.id = param1;
         return _loc2_;
      }
      
      public var id:uint;
   }
}
