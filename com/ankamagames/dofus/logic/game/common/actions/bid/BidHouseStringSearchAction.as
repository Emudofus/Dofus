package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BidHouseStringSearchAction extends Object implements Action
   {
      
      public function BidHouseStringSearchAction() {
         super();
      }
      
      public static function create(param1:String) : BidHouseStringSearchAction {
         var _loc2_:BidHouseStringSearchAction = new BidHouseStringSearchAction();
         _loc2_.searchString = param1;
         return _loc2_;
      }
      
      public var searchString:String;
   }
}
