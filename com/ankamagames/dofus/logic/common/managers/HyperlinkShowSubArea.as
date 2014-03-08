package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkShowSubArea extends Object
   {
      
      public function HyperlinkShowSubArea() {
         super();
      }
      
      public static function showSubArea(param1:int) : void {
         var _loc2_:SubArea = SubArea.getSubAreaById(param1);
         if(_loc2_)
         {
            KernelEventsManager.getInstance().processCallback(HookList.OpenCartographyPopup,_loc2_.name,_loc2_.id,null,null);
         }
      }
      
      public static function getSubAreaName(param1:int) : String {
         var _loc2_:SubArea = SubArea.getSubAreaById(param1);
         var _loc3_:String = _loc2_?"[" + _loc2_.name + "]":"";
         return _loc3_;
      }
   }
}
