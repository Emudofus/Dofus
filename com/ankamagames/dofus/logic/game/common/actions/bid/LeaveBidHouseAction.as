package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveBidHouseAction extends Object implements Action
   {
      
      public function LeaveBidHouseAction() {
         super();
      }
      
      public static function create() : LeaveBidHouseAction {
         var _loc1_:LeaveBidHouseAction = new LeaveBidHouseAction();
         return _loc1_;
      }
   }
}
