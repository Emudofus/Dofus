package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleLockPartyAction extends Object implements Action
   {
      
      public function ToggleLockPartyAction() {
         super();
      }
      
      public static function create() : ToggleLockPartyAction {
         var a:ToggleLockPartyAction = new ToggleLockPartyAction();
         return a;
      }
   }
}
