package com.ankamagames.jerakine.newCache.impl
{
    import com.ankamagames.jerakine.newCache.*;

    public class Cache extends InfiniteCache implements ICache
    {
        private var _bounds:uint;
        private var _gc:ICacheGarbageCollector;
        private var _name:String;
        private static var _namedCacheIndex:Array = new Array();

        public function Cache(param1:uint, param2:ICacheGarbageCollector)
        {
            this._bounds = param1;
            this._gc = param2;
            this._gc.cache = this;
            return;
        }// end function

        override public function destroy() : void
        {
            if (this._name)
            {
                delete _namedCacheIndex[this._name];
            }
            super.destroy();
            return;
        }// end function

        override public function extract(param1)
        {
            this._gc.used(param1);
            return super.extract(param1);
        }// end function

        override public function peek(param1)
        {
            this._gc.used(param1);
            return super.peek(param1);
        }// end function

        override public function store(param1, param2) : void
        {
            if ((_size + 1) > this._bounds)
            {
                this._gc.purge((this._bounds - 1));
            }
            super.store(param1, param2);
            this._gc.used(param1);
            return;
        }// end function

        public static function create(param1:uint, param2:ICacheGarbageCollector, param3:String) : Cache
        {
            var _loc_4:Cache = null;
            if (param3 && _namedCacheIndex[param3])
            {
                return _namedCacheIndex[param3];
            }
            _loc_4 = new Cache(param1, param2);
            if (param3)
            {
                _namedCacheIndex[param3] = _loc_4;
                _loc_4._name = param3;
            }
            return _loc_4;
        }// end function

    }
}
