package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightReadyAction extends Object implements Action
   {
      
      public function GameFightReadyAction() {
         super();
      }
      
      public static function create(param1:Boolean) : GameFightReadyAction {
         var _loc2_:GameFightReadyAction = new GameFightReadyAction();
         _loc2_.isReady = param1;
         return _loc2_;
      }
      
      public var isReady:Boolean;
   }
}
