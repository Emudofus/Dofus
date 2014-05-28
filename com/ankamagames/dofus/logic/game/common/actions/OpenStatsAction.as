package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenStatsAction extends Object implements Action
   {
      
      public function OpenStatsAction() {
         super();
      }
      
      public static function create() : OpenStatsAction {
         var a:OpenStatsAction = new OpenStatsAction();
         return a;
      }
   }
}
