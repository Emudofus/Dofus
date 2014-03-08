package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleLockFightAction extends Object implements Action
   {
      
      public function ToggleLockFightAction() {
         super();
      }
      
      public static function create() : ToggleLockFightAction {
         var _loc1_:ToggleLockFightAction = new ToggleLockFightAction();
         return _loc1_;
      }
   }
}
