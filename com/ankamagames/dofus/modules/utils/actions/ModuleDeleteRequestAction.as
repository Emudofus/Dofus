package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ModuleDeleteRequestAction extends Object implements Action
   {
      
      public function ModuleDeleteRequestAction() {
         super();
      }
      
      public static function create(directoryName:String) : ModuleDeleteRequestAction {
         var action:ModuleDeleteRequestAction = new ModuleDeleteRequestAction();
         action.moduleDirectory = directoryName;
         return action;
      }
      
      public var moduleDirectory:String;
   }
}
