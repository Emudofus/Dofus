package com.ankamagames.jerakine.pools
{
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Pool extends Object
    {
        private var _pooledClass:Class;
        private var _pool:Array;
        private var _growSize:int;
        private var _warnLimit:int;
        private var _totalSize:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Pool));

        public function Pool(param1:Class, param2:int, param3:int, param4:int = 0)
        {
            this._pooledClass = param1;
            this._pool = new Array();
            this._growSize = param3;
            this._warnLimit = param4;
            var _loc_5:uint = 0;
            while (_loc_5 < param2)
            {
                
                this._pool.push(new this._pooledClass());
                _loc_5 = _loc_5 + 1;
            }
            this._totalSize = param2;
            return;
        }// end function

        public function get pooledClass() : Class
        {
            return this._pooledClass;
        }// end function

        public function get poolArray() : Array
        {
            return this._pool;
        }// end function

        public function get growSize() : int
        {
            return this._growSize;
        }// end function

        public function get warnLimit() : int
        {
            return this._warnLimit;
        }// end function

        public function checkOut() : Poolable
        {
            var _loc_2:uint = 0;
            if (this._pool.length == 0)
            {
                _loc_2 = 0;
                while (_loc_2 < this._growSize)
                {
                    
                    this._pool.push(new this._pooledClass());
                    _loc_2 = _loc_2 + 1;
                }
                this._totalSize = this._totalSize + this._growSize;
                if (this._warnLimit > 0 && this._totalSize > this._warnLimit)
                {
                    _log.warn("Pool of " + this._pooledClass + " size beyond the warning limit. Size: " + this._pool.length + ", limit: " + this._warnLimit + ".");
                }
            }
            var _loc_1:* = this._pool.shift();
            return _loc_1;
        }// end function

        public function checkIn(param1:Poolable) : void
        {
            param1.free();
            this._pool.push(param1);
            return;
        }// end function

    }
}
