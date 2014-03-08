package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DisableAfkAction extends Object implements Action
   {
      
      public function DisableAfkAction() {
         super();
      }
      
      public static function create() : DisableAfkAction {
         var _loc1_:DisableAfkAction = new DisableAfkAction();
         return _loc1_;
      }
   }
}
