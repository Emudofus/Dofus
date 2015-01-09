package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.newCache.ICache;
    import com.ankamagames.jerakine.types.CustomSharedObject;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.jerakine.JerakineConstants;
    import com.ankamagames.jerakine.newCache.impl.InfiniteCache;
    import com.ankamagames.jerakine.newCache.impl.Cache;
    import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;

    public class AbstractDataManager 
    {

        static const DATA_KEY:String = "data";

        protected const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractDataManager));

        protected var _cacheSO:ICache;
        protected var _cacheKey:ICache;
        protected var _soPrefix:String = "";


        public function getObject(key:uint):Object
        {
            var v:*;
            var foo:*;
            var _local_7:CustomSharedObject;
            var realKey:String = (this._soPrefix + key);
            if (this._cacheKey.contains(realKey))
            {
                return (this._cacheKey.peek(realKey));
            };
            var chunkLength:uint = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO, (this._soPrefix + "_chunkLength"));
            var soName:String = (this._soPrefix + Math.floor((key / chunkLength)));
            if (this._cacheSO.contains(soName))
            {
                foo = this._cacheSO.peek(soName);
                v = CustomSharedObject(this._cacheSO.peek(soName)).data[DATA_KEY][key];
                this._cacheKey.store(realKey, v);
                return (v);
            };
            _local_7 = CustomSharedObject.getLocal(soName);
            if (((!(_local_7)) || (!(_local_7.data[DATA_KEY]))))
            {
                return (null);
            };
            this._cacheSO.store(soName, _local_7);
            v = _local_7.data[DATA_KEY][key];
            this._cacheKey.store(realKey, v);
            return (v);
        }

        public function getObjects():Array
        {
            var soName:String;
            var fileNum:uint;
            var _local_5:CustomSharedObject;
            var fileList:Array = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO, (this._soPrefix + "_filelist"));
            if (!(fileList))
            {
                return (null);
            };
            var data:Array = new Array();
            for each (fileNum in fileList)
            {
                soName = (this._soPrefix + fileNum);
                if (this._cacheSO.contains(soName))
                {
                    data = data.concat(CustomSharedObject(this._cacheSO.peek(soName)).data[DATA_KEY]);
                }
                else
                {
                    _local_5 = CustomSharedObject.getLocal(soName);
                    if (!((!(_local_5)) || (!(_local_5.data[DATA_KEY]))))
                    {
                        this._cacheSO.store(soName, _local_5);
                        data = data.concat(_local_5.data[DATA_KEY]);
                    };
                };
            };
            return (data);
        }

        function init(soCacheSize:uint, keyCacheSize:uint, soPrefix:String=""):void
        {
            if (keyCacheSize == uint.MAX_VALUE)
            {
                this._cacheKey = new InfiniteCache();
            }
            else
            {
                this._cacheKey = Cache.create(keyCacheSize, new LruGarbageCollector(), (getQualifiedClassName(this) + "_key"));
            };
            this._cacheSO = Cache.create(soCacheSize, new LruGarbageCollector(), (getQualifiedClassName(this) + "_so"));
            this._soPrefix = soPrefix;
        }


    }
}//package com.ankamagames.jerakine.data

