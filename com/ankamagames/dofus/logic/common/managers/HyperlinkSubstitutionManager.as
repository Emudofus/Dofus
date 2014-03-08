package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkSubstitutionManager extends Object
   {
      
      public function HyperlinkSubstitutionManager() {
         super();
      }
      
      public static function substitute(param1:String, param2:int) : String {
         switch(param1)
         {
            case "autoanswer":
               return I18n.getUiText("ui.chat.status.autoanswer");
            default:
               return "Error";
         }
      }
      
      public static function openAnkabox(param1:String, param2:int=0) : void {
         KernelEventsManager.getInstance().processCallback(HookList.OpenWebPortal,WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE,false,[param2]);
      }
      
      public static function rollOver(param1:int, param2:int, param3:uint, param4:uint=0) : void {
         var _loc5_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc6_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.chat.status.autoanswertooltip"));
         TooltipManager.show(_loc6_,_loc5_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),true,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
