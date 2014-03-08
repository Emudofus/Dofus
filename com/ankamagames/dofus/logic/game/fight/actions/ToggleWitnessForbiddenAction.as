package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleWitnessForbiddenAction extends Object implements Action
   {
      
      public function ToggleWitnessForbiddenAction() {
         super();
      }
      
      public static function create() : ToggleWitnessForbiddenAction {
         var _loc1_:ToggleWitnessForbiddenAction = new ToggleWitnessForbiddenAction();
         return _loc1_;
      }
   }
}
