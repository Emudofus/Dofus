package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenStatsAction extends Object implements Action
   {
      
      public function OpenStatsAction() {
         super();
      }
      
      public static function create() : OpenStatsAction {
         var _loc1_:OpenStatsAction = new OpenStatsAction();
         return _loc1_;
      }
   }
}
