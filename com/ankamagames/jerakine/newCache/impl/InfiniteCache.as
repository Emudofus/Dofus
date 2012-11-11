package com.ankamagames.jerakine.newCache.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import flash.utils.*;

    public class InfiniteCache extends Object implements ICache
    {
        protected var _cache:Dictionary;
        protected var _size:uint;

        public function InfiniteCache()
        {
            this._cache = new Dictionary(true);
            return;
        }// end function

        public function get size() : uint
        {
            return this._size;
        }// end function

        public function contains(param1) : Boolean
        {
            return this._cache[param1] != null;
        }// end function

        public function extract(param1)
        {
            var _loc_2:* = this._cache[param1];
            delete this._cache[param1];
            var _loc_3:* = this;
            var _loc_4:* = this._size - 1;
            _loc_3._size = _loc_4;
            return _loc_2;
        }// end function

        public function peek(param1)
        {
            return this._cache[param1];
        }// end function

        public function store(param1, param2) : void
        {
            this._cache[param1] = param2;
            var _loc_3:* = this;
            var _loc_4:* = this._size + 1;
            _loc_3._size = _loc_4;
            return;
        }// end function

        public function destroy() : void
        {
            this._cache = new Dictionary(true);
            this._size = 0;
            return;
        }// end function

    }
}
