package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class EnemiesListRequestAction extends Object implements Action
   {
      
      public function EnemiesListRequestAction() {
         super();
      }
      
      public static function create() : EnemiesListRequestAction {
         var _loc1_:EnemiesListRequestAction = new EnemiesListRequestAction();
         return _loc1_;
      }
   }
}
