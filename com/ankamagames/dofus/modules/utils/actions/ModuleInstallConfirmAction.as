package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ModuleInstallConfirmAction extends Object implements Action
   {
      
      public function ModuleInstallConfirmAction() {
         super();
      }
      
      public static function create(update:Boolean=false) : ModuleInstallConfirmAction {
         var action:ModuleInstallConfirmAction = new ModuleInstallConfirmAction();
         action.isUpdate = update;
         return action;
      }
      
      public var isUpdate:Boolean;
   }
}
