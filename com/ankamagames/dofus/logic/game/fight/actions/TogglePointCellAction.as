package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TogglePointCellAction extends Object implements Action
   {
      
      public function TogglePointCellAction() {
         super();
      }
      
      public static function create() : TogglePointCellAction {
         var _loc1_:TogglePointCellAction = new TogglePointCellAction();
         return _loc1_;
      }
   }
}
