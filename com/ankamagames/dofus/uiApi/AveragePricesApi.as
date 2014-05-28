package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class AveragePricesApi extends Object implements IApi
   {
      
      public function AveragePricesApi() {
         this._log = Log.getLogger(getQualifiedClassName(AveragePricesApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getItemAveragePrice(pItemId:uint) : int {
         var avgPrice:* = 0;
         var avgPricesFrame:AveragePricesFrame = null;
         if(this.dataAvailable())
         {
            avgPricesFrame = Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame;
            avgPrice = avgPricesFrame.pricesData.items["item" + pItemId];
         }
         return avgPrice;
      }
      
      public function getItemAveragePriceString(pItem:*, pAddLineBreakBefore:Boolean = false) : String {
         var averagePrice:* = 0;
         var priceAvailable:* = false;
         var str:String = "";
         if(pItem.exchangeable)
         {
            averagePrice = this.getItemAveragePrice(pItem.objectGID);
            priceAvailable = averagePrice > 0;
            str = str + ((pAddLineBreakBefore?"\n":"") + I18n.getUiText("ui.item.averageprice") + I18n.getUiText("ui.common.colon") + (priceAvailable?StringUtils.kamasToString(averagePrice):I18n.getUiText("ui.item.averageprice.unavailable")));
            if((priceAvailable) && (pItem.quantity > 1))
            {
               str = str + ("\n" + I18n.getUiText("ui.item.averageprice.stack") + I18n.getUiText("ui.common.colon") + StringUtils.kamasToString(averagePrice * pItem.quantity));
            }
         }
         return str;
      }
      
      public function dataAvailable() : Boolean {
         var avgPricesFrame:AveragePricesFrame = Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame;
         return avgPricesFrame.dataAvailable;
      }
   }
}
