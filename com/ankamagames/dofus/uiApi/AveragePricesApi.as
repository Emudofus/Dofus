package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class AveragePricesApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function AveragePricesApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(AveragePricesApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getItemAveragePrice(param1:uint) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.dataAvailable())
            {
                _loc_3 = Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame;
                _loc_2 = _loc_3.pricesData.items["item" + param1];
            }
            return _loc_2;
        }// end function

        public function getItemAveragePriceString(param1, param2:Boolean = false) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = false;
            var _loc_3:* = "";
            if (param1.isTradeable)
            {
                _loc_4 = this.getItemAveragePrice(param1.objectGID);
                _loc_5 = _loc_4 > 0;
                _loc_3 = _loc_3 + ((param2 ? ("\n") : ("")) + I18n.getUiText("ui.item.averageprice") + " : " + (_loc_5 ? (StringUtils.kamasToString(_loc_4)) : (I18n.getUiText("ui.item.averageprice.unavailable"))));
                if (_loc_5 && param1.quantity > 1)
                {
                    _loc_3 = _loc_3 + ("\n" + I18n.getUiText("ui.item.averageprice.stack") + " : " + StringUtils.kamasToString(_loc_4 * param1.quantity));
                }
            }
            return _loc_3;
        }// end function

        public function dataAvailable() : Boolean
        {
            var _loc_1:* = Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame;
            return _loc_1.dataAvailable;
        }// end function

    }
}
