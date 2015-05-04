package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementSwapPositionsAcceptAction extends Object implements Action
   {
      
      public function GameFightPlacementSwapPositionsAcceptAction()
      {
         super();
      }
      
      public static function create(param1:uint) : GameFightPlacementSwapPositionsAcceptAction
      {
         var _loc2_:GameFightPlacementSwapPositionsAcceptAction = new GameFightPlacementSwapPositionsAcceptAction();
         _loc2_.requestId = param1;
         return _loc2_;
      }
      
      public var requestId:uint;
   }
}
