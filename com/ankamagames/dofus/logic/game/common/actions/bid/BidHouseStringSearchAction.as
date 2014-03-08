package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BidHouseStringSearchAction extends Object implements Action
   {
      
      public function BidHouseStringSearchAction() {
         super();
      }
      
      public static function create(pSearchString:String) : BidHouseStringSearchAction {
         var a:BidHouseStringSearchAction = new BidHouseStringSearchAction();
         a.searchString = pSearchString;
         return a;
      }
      
      public var searchString:String;
   }
}
