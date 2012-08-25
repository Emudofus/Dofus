package com.ankamagames.jerakine.cache
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import flash.system.*;
    import flash.utils.*;

    public class Cache extends Object
    {
        private var _dicCache:Dictionary;
        private var _dicIndexObject:Dictionary;
        private var _nMaxMemory:int;
        private var _nWarnMemory:int;
        private var _nMaxCount:int;
        private var _nWarnCount:int;
        private var _nCheckMemorySystem:uint;
        private var _nObjectCount:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Cache));
        public static const CHECK_SYSTEM_MEMORY:uint = 1;
        public static const CHECK_OBJECT_COUNT:uint = 2;

        public function Cache(param1:uint, param2:uint, param3:uint)
        {
            this._dicCache = new Dictionary(true);
            this._dicIndexObject = new Dictionary(true);
            this._nObjectCount = 0;
            this._nCheckMemorySystem = param1;
            if (this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
            {
                this._nWarnMemory = param3;
                this._nMaxMemory = param2;
            }
            else if (this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
            {
                this._nWarnCount = param3;
                this._nMaxCount = param2;
            }
            else
            {
                _log.error("ERROR ! You have to choose a cache size verification system. Objects\'s counter will be used by default.");
                this._nCheckMemorySystem = CHECK_OBJECT_COUNT;
                this._nWarnCount = 750;
                this._nMaxCount = 1000;
            }
            return;
        }// end function

        public function get cacheArray() : Dictionary
        {
            return this._dicCache;
        }// end function

        public function get warnMemory() : int
        {
            return this._nWarnMemory;
        }// end function

        public function set warnMemory(param1:int) : void
        {
            this._nWarnMemory = param1;
            return;
        }// end function

        public function get maxMemory() : int
        {
            return this._nMaxMemory;
        }// end function

        public function set maxMemory(param1:int) : void
        {
            this._nMaxMemory = param1;
            return;
        }// end function

        public function get warnCount() : int
        {
            return this._nWarnCount;
        }// end function

        public function set warnCount(param1:int) : void
        {
            this._nWarnCount = param1;
            return;
        }// end function

        public function get maxCount() : int
        {
            return this._nMaxCount;
        }// end function

        public function set maxCount(param1:int) : void
        {
            this._nMaxCount = param1;
            return;
        }// end function

        public function get objectCount() : int
        {
            return this._nObjectCount;
        }// end function

        public function cacheObject(param1:ICachable) : void
        {
            this.cleanMemoryCache();
            this.registerObject(param1);
            return;
        }// end function

        public function cleanMemoryCache() : void
        {
            var _loc_1:Boolean = true;
            var _loc_2:uint = 0;
            if (this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
            {
                while (this._nObjectCount >= this._nMaxCount)
                {
                    
                    if (_loc_1)
                    {
                        _loc_1 = this.cleanCache();
                    }
                    else
                    {
                        this.onCleanFailed();
                    }
                    _loc_2 = _loc_2 + 1;
                    if (_loc_2 >= 20)
                    {
                        _log.error("the clean memory task seems to be in an infinite loop, we stop it now.");
                        break;
                    }
                }
                if (this._nObjectCount >= this._nWarnCount && this._nObjectCount < this._nMaxCount)
                {
                    _log.trace("WARNING ! The limit of cache memory will soon be reached");
                }
            }
            if (this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
            {
                while (System.totalMemory >= this._nMaxMemory)
                {
                    
                    if (_loc_1)
                    {
                        _loc_1 = this.cleanCache();
                    }
                    else
                    {
                        this.onCleanFailed();
                    }
                    _loc_2 = _loc_2 + 1;
                    if (_loc_2 >= 20)
                    {
                        _log.error("the clean memory task seems to be in an infinite loop, we stop it now.");
                        break;
                    }
                }
                if (System.totalMemory >= this._nWarnMemory && System.totalMemory < this._nMaxMemory)
                {
                    _log.trace("WARNING ! The limit of cache memory will soon be reached");
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:ICachable = null;
            var _loc_2:String = null;
            for (_loc_2 in this._dicIndexObject)
            {
                
                _loc_1 = this._dicIndexObject[_loc_2];
                if (!_loc_1)
                {
                    continue;
                }
                delete this._dicCache[_loc_1];
                delete this._dicIndexObject[this.getIndex(_loc_1)];
                var _loc_5:String = this;
                var _loc_6:* = this._nObjectCount - 1;
                _loc_5._nObjectCount = _loc_6;
                _loc_1.destroy();
            }
            return;
        }// end function

        public function containsCachable(param1:Class, param2:String) : Boolean
        {
            var _loc_4:Number = NaN;
            var _loc_3:Boolean = false;
            if (param2 != "")
            {
                _loc_4 = this.getIndexFromString(this.getStringFromClassAndName(param1, param2));
                _loc_3 = this._dicIndexObject[_loc_4] != null || this._dicIndexObject[_loc_4] != undefined;
                if (_loc_3)
                {
                    this._dicCache[this._dicIndexObject[_loc_4]] = getTimer();
                }
            }
            else
            {
                _log.error("[Cache] Error, invalid object name.");
            }
            return _loc_3;
        }// end function

        public function getFromCache(param1:Class, param2:String)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = this.getIndexFromString(this.getStringFromClassAndName(param1, param2));
            _loc_3 = this._dicIndexObject[_loc_4];
            return _loc_3;
        }// end function

        private function getStringFromClassAndName(param1:Class, param2:String) : String
        {
            var _loc_3:String = null;
            var _loc_4:* = getQualifiedClassName(param1).split("::");
            _loc_3 = getQualifiedClassName(param1).split("::")[1] + "" + param2;
            return _loc_3;
        }// end function

        private function getIndex(param1:ICachable) : Number
        {
            var _loc_2:* = getQualifiedClassName(param1) + "" + param1.name;
            var _loc_3:* = _loc_2.split("::");
            _loc_2 = _loc_3[1];
            return this.getIndexFromString(_loc_2);
        }// end function

        private function getIndexFromString(param1:String) : Number
        {
            var _loc_2:* = new CRC32();
            var _loc_3:* = new ByteArray();
            _loc_3.writeMultiByte(param1, "utf-8");
            _loc_2.update(_loc_3);
            var _loc_4:* = _loc_2.getValue();
            _loc_2.reset();
            return _loc_4;
        }// end function

        private function registerObject(param1:ICachable) : void
        {
            this._dicCache[param1] = getTimer();
            this._dicIndexObject[this.getIndex(param1)] = param1;
            var _loc_2:String = this;
            var _loc_3:* = this._nObjectCount + 1;
            _loc_2._nObjectCount = _loc_3;
            return;
        }// end function

        private function cleanCache() : Boolean
        {
            var _loc_2:String = null;
            var _loc_3:* = undefined;
            var _loc_1:* = getTimer();
            for (_loc_2 in this._dicIndexObject)
            {
                
                if (!ICachable(this._dicIndexObject[_loc_2]).inUse)
                {
                    if (this._dicCache[this._dicIndexObject[_loc_2]] < _loc_1)
                    {
                        _loc_1 = this._dicCache[this._dicIndexObject[_loc_2]];
                        _loc_3 = this._dicIndexObject[_loc_2];
                    }
                }
            }
            if (_loc_3 != null && _loc_3["name"] != null)
            {
                _log.error("Objet " + _loc_3["name"] + " supprimé du cache.");
                delete this._dicCache[_loc_3];
                delete this._dicIndexObject[this.getIndex(_loc_3)];
                var _loc_4:* = _loc_3;
                _loc_4._loc_3["destroy"]();
                var _loc_4:String = this;
                var _loc_5:* = this._nObjectCount - 1;
                _loc_4._nObjectCount = _loc_5;
                return true;
            }
            return false;
        }// end function

        private function extendMaxSize() : void
        {
            if (this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
            {
                this._nMaxMemory = this._nMaxMemory + this._nMaxMemory / 5;
                this._nWarnMemory = this._nWarnMemory + this._nMaxMemory / 5;
            }
            if (this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
            {
                this._nMaxCount = this._nMaxCount + this._nMaxCount / 5;
                this._nWarnCount = this._nWarnCount + this._nMaxCount / 5;
            }
            return;
        }// end function

        private function onCleanFailed() : void
        {
            _log.error("[Cache] FAILURE !  The whole cache is used, impossible to clean. The cache size will increase.");
            this.extendMaxSize();
            return;
        }// end function

    }
}
