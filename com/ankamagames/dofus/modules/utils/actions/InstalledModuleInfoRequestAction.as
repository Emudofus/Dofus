package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InstalledModuleInfoRequestAction extends Object implements Action
   {
      
      public function InstalledModuleInfoRequestAction()
      {
         super();
      }
      
      public static function create(param1:String) : InstalledModuleInfoRequestAction
      {
         var _loc2_:InstalledModuleInfoRequestAction = new InstalledModuleInfoRequestAction();
         _loc2_.moduleId = param1;
         return _loc2_;
      }
      
      public var moduleId:String;
   }
}
