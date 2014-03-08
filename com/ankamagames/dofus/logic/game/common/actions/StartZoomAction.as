package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartZoomAction extends Object implements Action
   {
      
      public function StartZoomAction() {
         super();
      }
      
      public static function create(param1:uint, param2:Number) : StartZoomAction {
         var _loc3_:StartZoomAction = new StartZoomAction();
         _loc3_.playerId = param1;
         _loc3_.value = param2;
         return _loc3_;
      }
      
      public var playerId:uint;
      
      public var value:Number;
   }
}
