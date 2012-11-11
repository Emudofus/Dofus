package com.ankamagames.jerakine.utils.crypto
{
    import flash.utils.*;

    public class CRC32 extends Object
    {
        private var _crc32:uint;
        private static var CRCTable:Array = initCRCTable();

        public function CRC32()
        {
            return;
        }// end function

        public function update(param1:ByteArray, param2:int = 0, param3:int = 0) : void
        {
            param3 = param3 == 0 ? (param1.length) : (param3);
            var _loc_4:* = ~this._crc32;
            var _loc_5:* = param2;
            while (_loc_5 < param3)
            {
                
                _loc_4 = CRCTable[(_loc_4 ^ param1[_loc_5]) & 255] ^ _loc_4 >>> 8;
                _loc_5++;
            }
            this._crc32 = ~_loc_4;
            return;
        }// end function

        public function getValue() : uint
        {
            return this._crc32 & 4294967295;
        }// end function

        public function reset() : void
        {
            this._crc32 = 0;
            return;
        }// end function

        private static function initCRCTable() : Array
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = new Array(256);
            var _loc_2:* = 0;
            while (_loc_2 < 256)
            {
                
                _loc_3 = _loc_2;
                _loc_4 = 0;
                while (_loc_4 < 8)
                {
                    
                    _loc_3 = _loc_3 & 1 ? (_loc_3 >>> 1 ^ 3988292384) : (_loc_3 >>> 1);
                    _loc_4++;
                }
                _loc_1[_loc_2] = _loc_3;
                _loc_2++;
            }
            return _loc_1;
        }// end function

    }
}
