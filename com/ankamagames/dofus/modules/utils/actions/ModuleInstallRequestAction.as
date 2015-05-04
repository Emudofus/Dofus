package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ModuleInstallRequestAction extends Object implements Action
   {
      
      public function ModuleInstallRequestAction()
      {
         super();
      }
      
      public static function create(param1:String) : ModuleInstallRequestAction
      {
         var _loc2_:ModuleInstallRequestAction = new ModuleInstallRequestAction();
         _loc2_.moduleUrl = param1;
         return _loc2_;
      }
      
      public var moduleUrl:String;
   }
}
