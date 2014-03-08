package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseSearchAction extends Object implements Action
   {
      
      public function ExchangeBidHouseSearchAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : ExchangeBidHouseSearchAction {
         var _loc3_:ExchangeBidHouseSearchAction = new ExchangeBidHouseSearchAction();
         _loc3_.type = param1;
         _loc3_.genId = param2;
         return _loc3_;
      }
      
      public var type:uint;
      
      public var genId:uint;
   }
}
