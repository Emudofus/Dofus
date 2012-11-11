package com.ankamagames.jerakine.newCache.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class DisplayObjectCache extends Object implements ICache
    {
        private var _cache:Dictionary;
        private var _size:uint = 0;
        private var _bounds:uint;
        private var _useCount:Dictionary;

        public function DisplayObjectCache(param1:uint)
        {
            this._cache = new Dictionary(true);
            this._useCount = new Dictionary(true);
            this._bounds = param1;
            return;
        }// end function

        public function get size() : uint
        {
            return this._size;
        }// end function

        public function contains(param1) : Boolean
        {
            var _loc_3:* = null;
            var _loc_2:* = this._cache[param1];
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.resource && (_loc_3.resource is ASwf || !_loc_3.resource.parent))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function extract(param1)
        {
            return this.peek(param1);
        }// end function

        public function peek(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = this._cache[param1];
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.resource && (_loc_3.resource is ASwf || !_loc_3.resource.parent))
                {
                    var _loc_6:* = this._useCount;
                    var _loc_7:* = param1;
                    var _loc_8:* = this._useCount[param1] + 1;
                    _loc_6[_loc_7] = _loc_8;
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function store(param1, param2) : void
        {
            if (!this._cache[param1])
            {
                this._cache[param1] = new Array();
                this._useCount[param1] = 0;
                var _loc_3:* = this;
                var _loc_4:* = this._size + 1;
                _loc_3._size = _loc_4;
                if (this._size > this._bounds)
                {
                    this.garbage();
                }
            }
            var _loc_3:* = this._useCount;
            var _loc_4:* = param1;
            var _loc_5:* = this._useCount[param1] + 1;
            _loc_3[_loc_4] = _loc_5;
            this._cache[param1].push(param2);
            return;
        }// end function

        public function destroy() : void
        {
            this._cache = new Dictionary(true);
            this._size = 0;
            this._bounds = 0;
            this._useCount = new Dictionary(true);
            return;
        }// end function

        private function garbage() : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = undefined;
            var _loc_1:* = new Array();
            for (_loc_2 in this._cache)
            {
                
                if (this._cache[_loc_2] != null && this._useCount[_loc_8])
                {
                    _loc_1.push({ref:_loc_2, useCount:this._useCount[_loc_8]});
                }
            }
            _loc_1.sortOn("useCount", Array.NUMERIC);
            _loc_3 = this._bounds * 0.1;
            _loc_4 = _loc_1.length;
            _loc_7 = 0;
            while (_loc_7 < _loc_4 && this._size > _loc_3)
            {
                
                _loc_6 = false;
                _loc_5 = this._cache[_loc_1[_loc_7].ref];
                for each (_loc_8 in _loc_5)
                {
                    
                    if (_loc_8 && _loc_8.resource && (!(_loc_8.resource is ASwf) || _loc_8.resource.parent))
                    {
                        _loc_6 = true;
                        break;
                    }
                }
                if (!_loc_6)
                {
                    delete this._cache[_loc_1[_loc_7].ref];
                    delete this._useCount[_loc_1[_loc_7].ref];
                    var _loc_9:* = this;
                    var _loc_10:* = this._size - 1;
                    _loc_9._size = _loc_10;
                }
                _loc_7 = _loc_7 + 1;
            }
            return;
        }// end function

    }
}
