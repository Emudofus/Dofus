package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkTaxCollectorPosition extends Object
   {
      
      public function HyperlinkTaxCollectorPosition()
      {
         super();
      }
      
      public static function showPosition(param1:int, param2:int, param3:int, param4:uint) : void
      {
         var _loc5_:TaxCollectorWrapper = TaxCollectorsManager.getInstance().taxCollectors[param4];
         if(_loc5_)
         {
            KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_taxcollector" + param4,param1 + "," + param2 + " (" + I18n.getUiText("ui.cartography.positionof",[_loc5_.firstName + " " + _loc5_.lastName]) + ")",param3,param1,param2,16737792,true);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_taxcollector" + param4,I18n.getUiText("ui.cartography.customFlag") + " (" + param1 + "," + param2 + ")",param3,param1,param2,16737792,true);
         }
      }
      
      public static function rollOver(param1:int, param2:int, param3:int, param4:uint, param5:int, param6:int) : void
      {
         var _loc7_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc8_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.position"));
         TooltipManager.show(_loc8_,_loc7_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
