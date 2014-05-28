package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementPositionRequestAction extends Object implements Action
   {
      
      public function GameFightPlacementPositionRequestAction() {
         super();
      }
      
      public static function create(id:int) : GameFightPlacementPositionRequestAction {
         var a:GameFightPlacementPositionRequestAction = new GameFightPlacementPositionRequestAction();
         a.cellId = id;
         return a;
      }
      
      public var cellId:int;
   }
}
