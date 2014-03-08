package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseToSellListRequestAction extends Object implements Action
   {
      
      public function HouseToSellListRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : HouseToSellListRequestAction {
         var _loc2_:HouseToSellListRequestAction = new HouseToSellListRequestAction();
         _loc2_.pageIndex = param1;
         return _loc2_;
      }
      
      public var pageIndex:uint;
   }
}
