package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   
   public class HyperlinkAdminManager extends Object
   {
      
      public function HyperlinkAdminManager() {
         super();
      }
      
      public static function addCmd(param1:String, param2:String) : void {
         KernelEventsManager.getInstance().processCallback(HookList.ConsoleAddCmd,param1.toLowerCase() == "true",Base64.decode(param2));
      }
   }
}
