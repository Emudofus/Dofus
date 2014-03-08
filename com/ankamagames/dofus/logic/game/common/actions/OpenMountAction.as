package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenMountAction extends Object implements Action
   {
      
      public function OpenMountAction() {
         super();
      }
      
      public static function create() : OpenMountAction {
         return new OpenMountAction();
      }
   }
}
