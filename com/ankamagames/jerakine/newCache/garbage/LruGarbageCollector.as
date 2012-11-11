package com.ankamagames.jerakine.newCache.garbage
{
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.newCache.*;
    import flash.display.*;
    import flash.utils.*;

    public class LruGarbageCollector extends Object implements ICacheGarbageCollector
    {
        protected var _usageCount:Dictionary;
        private var _cache:ICache;

        public function LruGarbageCollector()
        {
            this._usageCount = new Dictionary(true);
            return;
        }// end function

        public function set cache(param1:ICache) : void
        {
            this._cache = param1;
            return;
        }// end function

        public function used(param1) : void
        {
            if (this._usageCount[param1])
            {
                var _loc_2:* = this._usageCount;
                var _loc_3:* = param1;
                var _loc_4:* = this._usageCount[param1] + 1;
                _loc_2[_loc_3] = _loc_4;
            }
            else
            {
                this._usageCount[param1] = 1;
            }
            return;
        }// end function

        public function purge(param1:uint) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_2:* = new Array();
            for (_loc_3 in this._usageCount)
            {
                
                _loc_2.push({ref:_loc_3, count:this._usageCount[_loc_3]});
            }
            _loc_2.sortOn("count", Array.NUMERIC | Array.DESCENDING);
            while (this._cache.size > param1 && _loc_2.length)
            {
                
                _loc_4 = this._cache.extract(_loc_2.pop().ref);
                if (_loc_4 is IDestroyable)
                {
                    (_loc_4 as IDestroyable).destroy();
                }
                if (_loc_4 is BitmapData)
                {
                    (_loc_4 as BitmapData).dispose();
                }
                if (_loc_4 is ByteArray)
                {
                    (_loc_4 as ByteArray).clear();
                }
            }
            return;
        }// end function

    }
}
