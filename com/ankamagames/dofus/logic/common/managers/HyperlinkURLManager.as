package com.ankamagames.dofus.logic.common.managers
{
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkURLManager extends Object
   {
      
      public function HyperlinkURLManager() {
         super();
      }
      
      public static function openURL(param1:String) : void {
         navigateToURL(new URLRequest(param1),"_blank");
      }
      
      public static function chatLinkRelease(param1:String, param2:uint, param3:String) : void {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatLinkRelease,param1,param2,param3);
      }
      
      public static function chatWarning() : void {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatWarning);
      }
      
      public static function rollOver(param1:int, param2:int, param3:String, param4:uint, param5:String) : void {
         var _loc6_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc7_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.url"));
         TooltipManager.show(_loc7_,_loc6_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
