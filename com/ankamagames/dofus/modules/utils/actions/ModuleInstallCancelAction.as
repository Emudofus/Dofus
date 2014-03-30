package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ModuleInstallCancelAction extends Object implements Action
   {
      
      public function ModuleInstallCancelAction() {
         super();
      }
      
      public static function create() : ModuleInstallCancelAction {
         var action:ModuleInstallCancelAction = new ModuleInstallCancelAction();
         return action;
      }
   }
}
