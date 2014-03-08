package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CloseInventoryAction extends Object implements Action
   {
      
      public function CloseInventoryAction() {
         super();
      }
      
      public static function create() : CloseInventoryAction {
         var _loc1_:CloseInventoryAction = new CloseInventoryAction();
         return _loc1_;
      }
   }
}
