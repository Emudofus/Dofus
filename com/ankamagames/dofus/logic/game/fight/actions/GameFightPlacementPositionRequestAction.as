package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementPositionRequestAction extends Object implements Action
   {
      
      public function GameFightPlacementPositionRequestAction() {
         super();
      }
      
      public static function create(param1:int) : GameFightPlacementPositionRequestAction {
         var _loc2_:GameFightPlacementPositionRequestAction = new GameFightPlacementPositionRequestAction();
         _loc2_.cellId = param1;
         return _loc2_;
      }
      
      public var cellId:int;
   }
}
