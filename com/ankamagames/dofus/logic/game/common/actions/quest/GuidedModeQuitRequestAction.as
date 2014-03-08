package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuidedModeQuitRequestAction extends Object implements Action
   {
      
      public function GuidedModeQuitRequestAction() {
         super();
      }
      
      public static function create() : GuidedModeQuitRequestAction {
         return new GuidedModeQuitRequestAction();
      }
   }
}
