package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightReadyAction extends Object implements Action
   {
      
      public function GameFightReadyAction() {
         super();
      }
      
      public static function create(isReady:Boolean) : GameFightReadyAction {
         var a:GameFightReadyAction = new GameFightReadyAction();
         a.isReady = isReady;
         return a;
      }
      
      public var isReady:Boolean;
   }
}
