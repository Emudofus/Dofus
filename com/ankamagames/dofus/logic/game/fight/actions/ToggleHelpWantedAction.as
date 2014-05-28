package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleHelpWantedAction extends Object implements Action
   {
      
      public function ToggleHelpWantedAction() {
         super();
      }
      
      public static function create() : ToggleHelpWantedAction {
         var a:ToggleHelpWantedAction = new ToggleHelpWantedAction();
         return a;
      }
   }
}
