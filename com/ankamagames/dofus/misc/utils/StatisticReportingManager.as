package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.BuildInfos;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class StatisticReportingManager 
    {

        private static var _self:StatisticReportingManager;
        private static var WEB_SERVICE:String = "http://www.ankama.com/stats/dofus";

        protected var _log:Logger;
        private var _dt:DataStoreType;

        public function StatisticReportingManager()
        {
            this._log = Log.getLogger(getQualifiedClassName(StatisticReportingManager));
            this._dt = new DataStoreType("StatisticReportingManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            super();
            if (_self)
            {
                throw (new SingletonError());
            };
        }

        public static function getInstance():StatisticReportingManager
        {
            if (!(_self))
            {
                _self = new (StatisticReportingManager)();
            };
            return (_self);
        }


        public function report(key:String, value:String):Boolean
        {
            var _local_3:String;
            var _local_4:URLRequest;
            var _local_5:URLLoader;
            if (!(key))
            {
                return (false);
            };
            try
            {
                _local_3 = StoreDataManager.getInstance().getData(this._dt, key);
                if (((_local_3) && ((_local_3 == value))))
                {
                    return (false);
                };
                _local_4 = new URLRequest(WEB_SERVICE);
                _local_4.method = URLRequestMethod.POST;
                _local_4.data = new URLVariables();
                _local_4.data.guid = MD5.hash(PlayerManager.getInstance().nickname);
                _local_4.data.version = BuildInfos.BUILD_TYPE;
                _local_4.data.key = key;
                _local_4.data.value = value;
                _local_5 = new URLLoader();
                _local_5.addEventListener(Event.COMPLETE, this.onSended);
                _local_5.addEventListener(IOErrorEvent.IO_ERROR, this.onSendError);
                _local_5.load(_local_4);
                StoreDataManager.getInstance().setData(this._dt, key, value);
                return (true);
            }
            catch(e:Error)
            {
            };
            return (false);
        }

        public function isReported(key:String):Boolean
        {
            var oldValue:String = StoreDataManager.getInstance().getData(this._dt, key);
            if (oldValue)
            {
                return (true);
            };
            return (false);
        }

        private function onSended(e:Event):void
        {
            trace("ok");
        }

        private function onSendError(e:Event):void
        {
            trace("error");
        }


    }
}//package com.ankamagames.dofus.misc.utils

