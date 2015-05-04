package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementSwapPositionsCancelAction extends Object implements Action
   {
      
      public function GameFightPlacementSwapPositionsCancelAction()
      {
         super();
      }
      
      public static function create(param1:uint) : GameFightPlacementSwapPositionsCancelAction
      {
         var _loc2_:GameFightPlacementSwapPositionsCancelAction = new GameFightPlacementSwapPositionsCancelAction();
         _loc2_.requestId = param1;
         return _loc2_;
      }
      
      public var requestId:uint;
   }
}
