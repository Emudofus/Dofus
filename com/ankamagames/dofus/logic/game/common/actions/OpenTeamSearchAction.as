package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenTeamSearchAction extends Object implements Action
   {
      
      public function OpenTeamSearchAction() {
         super();
      }
      
      public static function create() : OpenTeamSearchAction {
         var a:OpenTeamSearchAction = new OpenTeamSearchAction();
         return a;
      }
   }
}
