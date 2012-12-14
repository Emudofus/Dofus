package com.ankamagames.dofus.misc.utils
{
    import by.blooddy.crypto.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class StatisticReportingManager extends Object
    {
        protected var _log:Logger;
        private var _dt:DataStoreType;
        private static var _self:StatisticReportingManager;
        private static var WEB_SERVICE:String = "http://www.ankama.com/stats/dofus";

        public function StatisticReportingManager()
        {
            this._log = Log.getLogger(getQualifiedClassName());
            this._dt = new DataStoreType("StatisticReportingManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function report(param1:String, param2:String) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!param1)
            {
                return false;
            }
            try
            {
                _loc_3 = StoreDataManager.getInstance().getData(this._dt, param1);
                if (_loc_3 && _loc_3 == param2)
                {
                    return false;
                }
                _loc_4 = new URLRequest(WEB_SERVICE);
                _loc_4.method = URLRequestMethod.POST;
                _loc_4.data = new URLVariables();
                _loc_4.data.guid = MD5.hash(PlayerManager.getInstance().nickname);
                _loc_4.data.version = BuildInfos.BUILD_TYPE;
                _loc_4.data.key = param1;
                _loc_4.data.value = param2;
                _loc_5 = new URLLoader();
                _loc_5.addEventListener(Event.COMPLETE, this.onSended);
                _loc_5.addEventListener(IOErrorEvent.IO_ERROR, this.onSendError);
                _loc_5.load(_loc_4);
                StoreDataManager.getInstance().setData(this._dt, param1, param2);
                return true;
            }
            catch (e:Error)
            {
            }
            return false;
        }// end function

        public function isReported(param1:String) : Boolean
        {
            var _loc_2:* = StoreDataManager.getInstance().getData(this._dt, param1);
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function onSended(event:Event) : void
        {
            return;
        }// end function

        private function onSendError(event:Event) : void
        {
            return;
        }// end function

        public static function getInstance() : StatisticReportingManager
        {
            if (!_self)
            {
                _self = new StatisticReportingManager;
            }
            return _self;
        }// end function

    }
}
