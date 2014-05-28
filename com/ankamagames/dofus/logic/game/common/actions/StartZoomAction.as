package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartZoomAction extends Object implements Action
   {
      
      public function StartZoomAction() {
         super();
      }
      
      public static function create(playerId:uint, value:Number) : StartZoomAction {
         var action:StartZoomAction = new StartZoomAction();
         action.playerId = playerId;
         action.value = value;
         return action;
      }
      
      public var playerId:uint;
      
      public var value:Number;
   }
}
