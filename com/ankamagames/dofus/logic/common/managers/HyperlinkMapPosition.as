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
      
      public static function showPosition(posX:int, posY:int, worldMapId:int) : void {
         KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_chat",I18n.getUiText("ui.cartography.chatFlag") + " (" + posX + "," + posY + ")",worldMapId,posX,posY,16737792,true);
      }
      
      public static function getText(posX:int, posY:int, worldMapId:int) : String {
         return "[" + posX + "," + posY + "]";
      }
      
      public static function rollOver(pX:int, pY:int, posX:int, posY:int) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.position"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
