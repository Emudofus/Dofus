package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenMainMenuAction extends Object implements Action
   {
      
      public function OpenMainMenuAction() {
         super();
      }
      
      public static function create() : OpenMainMenuAction {
         return new OpenMainMenuAction();
      }
   }
}
