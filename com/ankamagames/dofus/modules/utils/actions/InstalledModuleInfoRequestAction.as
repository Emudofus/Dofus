package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InstalledModuleInfoRequestAction extends Object implements Action
   {
      
      public function InstalledModuleInfoRequestAction() {
         super();
      }
      
      public static function create(moduleId:String) : InstalledModuleInfoRequestAction {
         var action:InstalledModuleInfoRequestAction = new InstalledModuleInfoRequestAction();
         action.moduleId = moduleId;
         return action;
      }
      
      public var moduleId:String;
   }
}
