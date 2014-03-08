package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightTurnFinishAction extends Object implements Action
   {
      
      public function GameFightTurnFinishAction() {
         super();
      }
      
      public static function create() : GameFightTurnFinishAction {
         return new GameFightTurnFinishAction();
      }
   }
}
