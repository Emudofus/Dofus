package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.crypto.*;
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
            var oldValue:String;
            var urlRequest:URLRequest;
            var urlLoader:URLLoader;
            var key:* = param1;
            var value:* = param2;
            if (!key)
            {
                return false;
            }
            try
            {
                oldValue = StoreDataManager.getInstance().getData(this._dt, key);
                if (oldValue && oldValue == value)
                {
                    return false;
                }
                urlRequest = new URLRequest(WEB_SERVICE);
                urlRequest.method = URLRequestMethod.POST;
                urlRequest.data = new URLVariables();
                urlRequest.data.guid = MD5.hash(PlayerManager.getInstance().nickname);
                urlRequest.data.version = BuildInfos.BUILD_TYPE;
                urlRequest.data.key = key;
                urlRequest.data.value = value;
                urlLoader = new URLLoader();
                urlLoader.addEventListener(Event.COMPLETE, this.onSended);
                urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onSendError);
                urlLoader.load(urlRequest);
                StoreDataManager.getInstance().setData(this._dt, key, value);
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
