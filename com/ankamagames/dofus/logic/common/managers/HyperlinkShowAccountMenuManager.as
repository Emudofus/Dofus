package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.factories.MenusFactory;
   
   public class HyperlinkShowAccountMenuManager extends Object
   {
      
      public function HyperlinkShowAccountMenuManager() {
         super();
      }
      
      public static function showAccountMenu(param1:String, param2:int) : void {
         var _loc3_:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         _loc3_.createContextMenu(MenusFactory.create(
            {
               "name":param1,
               "id":param2
            },"account"));
      }
   }
}
