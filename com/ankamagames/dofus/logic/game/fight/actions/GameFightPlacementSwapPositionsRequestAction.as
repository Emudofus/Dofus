package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementSwapPositionsRequestAction extends Object implements Action
   {
      
      public function GameFightPlacementSwapPositionsRequestAction()
      {
         super();
      }
      
      public static function create(param1:uint, param2:int) : GameFightPlacementSwapPositionsRequestAction
      {
         var _loc3_:GameFightPlacementSwapPositionsRequestAction = new GameFightPlacementSwapPositionsRequestAction();
         _loc3_.cellId = param1;
         _loc3_.requestedId = param2;
         return _loc3_;
      }
      
      public var cellId:uint;
      
      public var requestedId:int;
   }
}
