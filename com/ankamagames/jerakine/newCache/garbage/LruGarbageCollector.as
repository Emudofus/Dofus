package com.ankamagames.jerakine.newCache.garbage
{
    import com.ankamagames.jerakine.newCache.ICacheGarbageCollector;
    import com.ankamagames.jerakine.pools.Pool;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.newCache.ICache;
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    public class LruGarbageCollector implements ICacheGarbageCollector 
    {

        private static var _pool:Pool;

        protected var _usageCount:Dictionary;
        private var _cache:ICache;

        public function LruGarbageCollector():void
        {
            this._usageCount = new Dictionary(true);
            super();
            if (!(_pool))
            {
                _pool = new Pool(UsageCountHelper, 500, 50);
            };
        }

        public function set cache(cache:ICache):void
        {
            this._cache = cache;
        }

        public function used(ref:*):void
        {
            if (this._usageCount[ref])
            {
                var _local_2 = this._usageCount;
                var _local_3 = ref;
                var _local_4 = (_local_2[_local_3] + 1);
                _local_2[_local_3] = _local_4;
            }
            else
            {
                this._usageCount[ref] = 1;
            };
        }

        public function purge(bounds:uint):void
        {
            var obj:*;
            var el:UsageCountHelper;
            var poke:*;
            var elements:Array = new Array();
            for (obj in this._usageCount)
            {
                elements.push((_pool.checkOut() as UsageCountHelper).init(obj, this._usageCount[obj]));
            };
            elements.sortOn("count", (Array.NUMERIC | Array.DESCENDING));
            for each (el in elements)
            {
                el.free();
                _pool.checkIn(el);
            };
            while ((((this._cache.size > bounds)) && (elements.length)))
            {
                poke = this._cache.extract(elements.pop().ref);
                if ((poke is IDestroyable))
                {
                    (poke as IDestroyable).destroy();
                };
                if ((poke is BitmapData))
                {
                    (poke as BitmapData).dispose();
                };
                if ((poke is ByteArray))
                {
                    (poke as ByteArray).clear();
                };
            };
        }


    }
}//package com.ankamagames.jerakine.newCache.garbage

import com.ankamagames.jerakine.pools.Poolable;

class UsageCountHelper implements Poolable 
{

    public var ref:Object;
    public var count:uint;


    public function init(ref:Object, count:uint):UsageCountHelper
    {
        this.ref = ref;
        this.count = count;
        return (this);
    }

    public function free():void
    {
        this.ref = null;
        this.count = 0;
    }


}

