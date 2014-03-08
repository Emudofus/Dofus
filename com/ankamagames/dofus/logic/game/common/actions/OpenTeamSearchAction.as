package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenTeamSearchAction extends Object implements Action
   {
      
      public function OpenTeamSearchAction() {
         super();
      }
      
      public static function create() : OpenTeamSearchAction {
         var _loc1_:OpenTeamSearchAction = new OpenTeamSearchAction();
         return _loc1_;
      }
   }
}
