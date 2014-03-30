package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ModuleInstallRequestAction extends Object implements Action
   {
      
      public function ModuleInstallRequestAction() {
         super();
      }
      
      public static function create(url:String) : ModuleInstallRequestAction {
         var action:ModuleInstallRequestAction = new ModuleInstallRequestAction();
         action.moduleUrl = url;
         return action;
      }
      
      public var moduleUrl:String;
   }
}
