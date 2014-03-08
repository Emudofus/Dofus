package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ArenaUnregisterAction extends Object implements Action
   {
      
      public function ArenaUnregisterAction() {
         super();
      }
      
      public static function create() : ArenaUnregisterAction {
         var _loc1_:ArenaUnregisterAction = new ArenaUnregisterAction();
         return _loc1_;
      }
   }
}
