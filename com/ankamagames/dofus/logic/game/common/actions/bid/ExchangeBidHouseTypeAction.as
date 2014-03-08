package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseTypeAction extends Object implements Action
   {
      
      public function ExchangeBidHouseTypeAction() {
         super();
      }
      
      public static function create(param1:uint) : ExchangeBidHouseTypeAction {
         var _loc2_:ExchangeBidHouseTypeAction = new ExchangeBidHouseTypeAction();
         _loc2_.type = param1;
         return _loc2_;
      }
      
      public var type:uint;
   }
}
