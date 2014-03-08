package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseBuyAction extends Object implements Action
   {
      
      public function HouseBuyAction() {
         super();
      }
      
      public static function create(param1:uint) : HouseBuyAction {
         var _loc2_:HouseBuyAction = new HouseBuyAction();
         _loc2_.proposedPrice = param1;
         return _loc2_;
      }
      
      public var proposedPrice:uint;
   }
}
