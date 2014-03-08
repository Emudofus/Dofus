package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountFeedRequestAction extends Object implements Action
   {
      
      public function MountFeedRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:uint) : MountFeedRequestAction {
         var _loc5_:MountFeedRequestAction = new MountFeedRequestAction();
         _loc5_.mountId = param1;
         _loc5_.mountLocation = param2 + 1;
         _loc5_.mountFoodUid = param3;
         _loc5_.quantity = param4;
         return _loc5_;
      }
      
      public var mountId:uint;
      
      public var mountLocation:uint;
      
      public var mountFoodUid:uint;
      
      public var quantity:uint;
   }
}
