package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class AbstractDataManager extends Object
    {
        protected var _cacheSO:ICache;
        protected var _cacheKey:ICache;
        protected var _soPrefix:String = "";
        protected const _log:Logger;
        static const DATA_KEY:String = "data";

        public function AbstractDataManager()
        {
            this._log = Log.getLogger(getQualifiedClassName(AbstractDataManager));
            return;
        }// end function

        public function getObject(param1:uint) : Object
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_2:* = this._soPrefix + param1;
            if (this._cacheKey.contains(_loc_2))
            {
                return this._cacheKey.peek(_loc_2);
            }
            var _loc_3:* = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO, this._soPrefix + "_chunkLength");
            var _loc_4:* = this._soPrefix + Math.floor(param1 / _loc_3);
            if (this._cacheSO.contains(_loc_4))
            {
                _loc_6 = this._cacheSO.peek(_loc_4);
                _loc_5 = CustomSharedObject(this._cacheSO.peek(_loc_4)).data[DATA_KEY][param1];
                this._cacheKey.store(_loc_2, _loc_5);
                return _loc_5;
            }
            _loc_7 = CustomSharedObject.getLocal(_loc_4);
            if (!_loc_7 || !_loc_7.data[DATA_KEY])
            {
                return null;
            }
            this._cacheSO.store(_loc_4, _loc_7);
            _loc_5 = _loc_7.data[DATA_KEY][param1];
            this._cacheKey.store(_loc_2, _loc_5);
            return _loc_5;
        }// end function

        public function getObjects() : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO, this._soPrefix + "_filelist");
            if (!_loc_1)
            {
                return null;
            }
            var _loc_2:* = new Array();
            for each (_loc_4 in _loc_1)
            {
                
                _loc_3 = this._soPrefix + _loc_4;
                if (this._cacheSO.contains(_loc_3))
                {
                    _loc_2 = _loc_2.concat(CustomSharedObject(this._cacheSO.peek(_loc_3)).data[DATA_KEY]);
                    continue;
                }
                _loc_5 = CustomSharedObject.getLocal(_loc_3);
                if (!_loc_5 || !_loc_5.data[DATA_KEY])
                {
                    continue;
                }
                this._cacheSO.store(_loc_3, _loc_5);
                _loc_2 = _loc_2.concat(_loc_5.data[DATA_KEY]);
            }
            return _loc_2;
        }// end function

        function init(param1:uint, param2:uint, param3:String = "") : void
        {
            if (param2 == uint.MAX_VALUE)
            {
                this._cacheKey = new InfiniteCache();
            }
            else
            {
                this._cacheKey = Cache.create(param2, new LruGarbageCollector(), getQualifiedClassName(this) + "_key");
            }
            this._cacheSO = Cache.create(param1, new LruGarbageCollector(), getQualifiedClassName(this) + "_so");
            this._soPrefix = param3;
            return;
        }// end function

    }
}
