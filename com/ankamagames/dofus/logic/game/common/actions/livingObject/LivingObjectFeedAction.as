package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectFeedAction extends Object implements Action
   {
      
      public function LivingObjectFeedAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint) : LivingObjectFeedAction {
         var _loc4_:LivingObjectFeedAction = new LivingObjectFeedAction();
         _loc4_.objectUID = param1;
         _loc4_.foodUID = param2;
         _loc4_.foodQuantity = param3;
         return _loc4_;
      }
      
      public var objectUID:uint;
      
      public var foodUID:uint;
      
      public var foodQuantity:uint;
   }
}
