package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.jerakine.utils.misc.StringUtils;

    [InstanciedApi]
    public class AveragePricesApi implements IApi 
    {

        protected var _log:Logger;
        private var _module:UiModule;

        public function AveragePricesApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(AveragePricesApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Trusted]
        public function getItemAveragePrice(pItemId:uint):int
        {
            var avgPrice:int;
            var avgPricesFrame:AveragePricesFrame;
            if (this.dataAvailable())
            {
                avgPricesFrame = (Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame);
                avgPrice = avgPricesFrame.pricesData.items[("item" + pItemId)];
            };
            return (avgPrice);
        }

        [Trusted]
        public function getItemAveragePriceString(pItem:*, pAddLineBreakBefore:Boolean=false):String
        {
            var averagePrice:int;
            var priceAvailable:Boolean;
            var str:String = "";
            if (pItem.exchangeable)
            {
                averagePrice = this.getItemAveragePrice(pItem.objectGID);
                priceAvailable = (averagePrice > 0);
                str = (str + (((((pAddLineBreakBefore) ? "\n" : "") + I18n.getUiText("ui.item.averageprice")) + I18n.getUiText("ui.common.colon")) + ((priceAvailable) ? StringUtils.kamasToString(averagePrice) : I18n.getUiText("ui.item.averageprice.unavailable"))));
                if (((priceAvailable) && ((pItem.quantity > 1))))
                {
                    str = (str + ((("\n" + I18n.getUiText("ui.item.averageprice.stack")) + I18n.getUiText("ui.common.colon")) + StringUtils.kamasToString((averagePrice * pItem.quantity))));
                };
            };
            return (str);
        }

        [Trusted]
        public function dataAvailable():Boolean
        {
            var avgPricesFrame:AveragePricesFrame = (Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame);
            return (avgPricesFrame.dataAvailable);
        }


    }
}//package com.ankamagames.dofus.uiApi

