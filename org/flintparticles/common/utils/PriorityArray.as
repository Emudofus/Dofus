package org.flintparticles.common.utils
{
    import flash.utils.*;

    public class PriorityArray extends Proxy
    {
        private var _values:Array;

        public function PriorityArray()
        {
            this._values = new Array();
            return;
        }// end function

        override function getProperty(param1)
        {
            var _loc_2:* = int(param1);
            if (_loc_2 == param1 && _loc_2 < this._values.length && this._values[_loc_2])
            {
                return this._values[_loc_2].value;
            }
            return undefined;
        }// end function

        override function setProperty(param1, param2) : void
        {
            var _loc_3:* = uint(param1);
            if (_loc_3 == param1 && _loc_3 < this._values.length)
            {
                this._values[_loc_3].value = param2;
            }
            return;
        }// end function

        override function nextNameIndex(param1:int) : int
        {
            if (param1 < this._values.length)
            {
                return (param1 + 1);
            }
            return 0;
        }// end function

        override function nextName(param1:int) : String
        {
            return ((param1 - 1)).toString();
        }// end function

        override function nextValue(param1:int)
        {
            return this._values[(param1 - 1)];
        }// end function

        public function add(param1, param2:Number) : uint
        {
            var _loc_3:* = this._values.length;
            var _loc_4:uint = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._values[_loc_4].priority < param2)
                {
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            this._values.splice(_loc_4, 0, new Pair(param2, param1));
            return this._values.length;
        }// end function

        public function remove(param1) : Boolean
        {
            var _loc_2:* = this._values.length;
            while (_loc_2--)
            {
                
                if (this._values[_loc_2].value == param1)
                {
                    this._values.splice(_loc_2, 1);
                    return true;
                }
            }
            return false;
        }// end function

        public function contains(param1) : Boolean
        {
            var _loc_2:* = this._values.length;
            while (_loc_2--)
            {
                
                if (this._values[_loc_2].value == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function removeAt(param1:uint)
        {
            var _loc_2:* = this._values[param1].value;
            this._values.splice(param1, 1);
            return _loc_2;
        }// end function

        public function clear() : void
        {
            this._values.length = 0;
            return;
        }// end function

        public function get length() : uint
        {
            return this._values.length;
        }// end function

    }
}
