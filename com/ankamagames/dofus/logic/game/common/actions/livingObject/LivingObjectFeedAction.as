package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectFeedAction extends Object implements Action
   {
      
      public function LivingObjectFeedAction() {
         super();
      }
      
      public static function create(objectUID:uint, foodUID:uint, foodQuantity:uint) : LivingObjectFeedAction {
         var action:LivingObjectFeedAction = new LivingObjectFeedAction();
         action.objectUID = objectUID;
         action.foodUID = foodUID;
         action.foodQuantity = foodQuantity;
         return action;
      }
      
      public var objectUID:uint;
      
      public var foodUID:uint;
      
      public var foodQuantity:uint;
   }
}
