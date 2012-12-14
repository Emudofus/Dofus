package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.inventory.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class AveragePricesFrame extends Object implements Frame
    {
        private var _serverName:String;
        private var _pricesData:Object;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AveragePricesFrame));
        private static var _dataStoreType:DataStoreType;

        public function AveragePricesFrame()
        {
            this._serverName = PlayerManager.getInstance().server.name;
            if (!_dataStoreType)
            {
                _dataStoreType = new DataStoreType("averagePrices", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            }
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get dataAvailable() : Boolean
        {
            return this._pricesData;
        }// end function

        public function get pricesData() : Object
        {
            return this._pricesData;
        }// end function

        public function pushed() : Boolean
        {
            this._pricesData = StoreDataManager.getInstance().getData(_dataStoreType, this._serverName);
            return true;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(true)
            {
                case param1 is GameContextCreateMessage:
                {
                    _loc_2 = param1 as GameContextCreateMessage;
                    if (_loc_2.context == GameContextEnum.ROLE_PLAY && this.updateAllowed())
                    {
                        this.askPricesData();
                    }
                    return false;
                }
                case param1 is ObjectAveragePricesMessage:
                {
                    _loc_3 = param1 as ObjectAveragePricesMessage;
                    this.updatePricesData(_loc_3.ids, _loc_3.avgPrices);
                    return true;
                }
                case param1 is ObjectAveragePricesErrorMessage:
                {
                    _loc_4 = param1 as ObjectAveragePricesErrorMessage;
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function updatePricesData(param1:Vector.<uint>, param2:Vector.<uint>) : void
        {
            var _loc_3:* = param1.length;
            this._pricesData = {lastUpdate:new Date(), items:{}};
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this._pricesData.items["item" + param1[_loc_4]] = param2[_loc_4];
                _loc_4++;
            }
            StoreDataManager.getInstance().setData(_dataStoreType, this._serverName, this._pricesData);
            return;
        }// end function

        private function updateAllowed() : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
            var _loc_2:* = OptionalFeature.getOptionalFeatureByKeyword("biz.prices");
            if (!_loc_1.isOptionalFeatureActive(_loc_2.id))
            {
                return false;
            }
            if (this.dataAvailable)
            {
                _loc_3 = new Date();
                _loc_4 = TimeManager.getInstance().formatClock(this._pricesData.lastUpdate.getTime());
                if (_loc_3.getFullYear() == this._pricesData.lastUpdate.getFullYear() && _loc_3.getMonth() == this._pricesData.lastUpdate.getMonth() && _loc_3.getDate() == this._pricesData.lastUpdate.getDate())
                {
                    return false;
                }
            }
            return true;
        }// end function

        private function askPricesData() : void
        {
            var _loc_1:* = new ObjectAveragePricesGetMessage();
            _loc_1.initObjectAveragePricesGetMessage();
            ConnectionsHandler.getConnection().send(_loc_1);
            return;
        }// end function

    }
}
