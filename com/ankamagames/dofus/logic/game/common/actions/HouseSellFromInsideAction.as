package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseSellFromInsideAction extends Object implements Action
   {
      
      public function HouseSellFromInsideAction() {
         super();
      }
      
      public static function create(param1:uint) : HouseSellFromInsideAction {
         var _loc2_:HouseSellFromInsideAction = new HouseSellFromInsideAction();
         _loc2_.amount = param1;
         return _loc2_;
      }
      
      public var amount:uint;
   }
}
