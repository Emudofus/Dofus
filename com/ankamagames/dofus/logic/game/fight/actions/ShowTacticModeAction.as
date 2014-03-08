package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowTacticModeAction extends Object implements Action
   {
      
      public function ShowTacticModeAction() {
         super();
      }
      
      public static function create() : ShowTacticModeAction {
         var _loc1_:ShowTacticModeAction = new ShowTacticModeAction();
         return _loc1_;
      }
   }
}
