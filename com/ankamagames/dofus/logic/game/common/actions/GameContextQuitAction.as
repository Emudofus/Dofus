package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameContextQuitAction extends Object implements Action
   {
      
      public function GameContextQuitAction() {
         super();
      }
      
      public static function create() : GameContextQuitAction {
         return new GameContextQuitAction();
      }
   }
}
