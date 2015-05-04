package com.ankamagames.dofus.modules.utils.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InstalledModuleListRequestAction extends Object implements Action
   {
      
      public function InstalledModuleListRequestAction()
      {
         super();
      }
      
      public static function create() : InstalledModuleListRequestAction
      {
         var _loc1_:InstalledModuleListRequestAction = new InstalledModuleListRequestAction();
         return _loc1_;
      }
   }
}
