package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowRecipeManager extends Object
   {
      
      public function HyperlinkShowRecipeManager() {
         super();
      }
      
      public static function showRecipe(param1:uint) : void {
         var _loc2_:ItemWrapper = ItemWrapper.create(0,0,param1,1,null,false);
         if(_loc2_)
         {
            KernelEventsManager.getInstance().processCallback(HookList.OpenRecipe,_loc2_);
         }
      }
      
      public static function getRecipeName(param1:int) : String {
         var _loc2_:Item = Item.getItemById(param1);
         if(_loc2_)
         {
            return "[" + PatternDecoder.combine(I18n.getUiText("ui.common.recipes"),"n",true) + I18n.getUiText("ui.common.colon") + _loc2_.name + "]";
         }
         return "[null]";
      }
      
      public static function rollOver(param1:int, param2:int, param3:uint) : void {
         var _loc4_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc5_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.recipe"));
         TooltipManager.show(_loc5_,_loc4_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
