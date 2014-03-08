package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockToSellListRequestAction extends Object implements Action
   {
      
      public function PaddockToSellListRequestAction() {
         super();
      }
      
      public static function create(pageIndex:uint) : PaddockToSellListRequestAction {
         var a:PaddockToSellListRequestAction = new PaddockToSellListRequestAction();
         a.pageIndex = pageIndex;
         return a;
      }
      
      public var pageIndex:uint;
   }
}
