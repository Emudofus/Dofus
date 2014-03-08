package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseToSellListRequestAction extends Object implements Action
   {
      
      public function HouseToSellListRequestAction() {
         super();
      }
      
      public static function create(pageIndex:uint) : HouseToSellListRequestAction {
         var a:HouseToSellListRequestAction = new HouseToSellListRequestAction();
         a.pageIndex = pageIndex;
         return a;
      }
      
      public var pageIndex:uint;
   }
}
