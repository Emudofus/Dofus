package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkMapPosition extends Object
   {
      
      public function HyperlinkMapPosition() {
         super();
      }
      
      public static function showPosition(param1:int, param2:int, param3:int) : void {
         KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_chat",I18n.getUiText("ui.cartography.chatFlag") + " (" + param1 + "," + param2 + ")",param3,param1,param2,16737792,true);
      }
      
      public static function getText(param1:int, param2:int, param3:int) : String {
         return "[" + param1 + "," + param2 + "]";
      }
      
      public static function rollOver(param1:int, param2:int, param3:int, param4:int) : void {
         var _loc5_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc6_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.position"));
         TooltipManager.show(_loc6_,_loc5_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
