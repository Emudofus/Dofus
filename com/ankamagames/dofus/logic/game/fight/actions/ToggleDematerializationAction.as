package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleDematerializationAction extends Object implements Action
   {
      
      public function ToggleDematerializationAction() {
         super();
      }
      
      public static function create() : ToggleDematerializationAction {
         var _loc1_:ToggleDematerializationAction = new ToggleDematerializationAction();
         return _loc1_;
      }
   }
}
