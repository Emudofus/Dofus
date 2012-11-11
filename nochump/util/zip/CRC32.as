package nochump.util.zip
{
    import flash.utils.*;

    public class CRC32 extends Object
    {
        private var crc:uint;
        private static var crcTable:Array = makeCrcTable();

        public function CRC32()
        {
            return;
        }// end function

        public function getValue() : uint
        {
            return this.crc & 4294967295;
        }// end function

        public function reset() : void
        {
            this.crc = 0;
            return;
        }// end function

        public function update(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = param1.length;
            var _loc_4:* = ~this.crc;
            while (--_loc_3 >= 0)
            {
                
                _loc_4 = crcTable[(_loc_4 ^ param1[_loc_2++]) & 255] ^ _loc_4 >>> 8;
            }
            this.crc = ~_loc_4;
            return;
        }// end function

        private static function makeCrcTable() : Array
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = new Array(256);
            var _loc_2:* = 0;
            while (_loc_2 < 256)
            {
                
                _loc_3 = _loc_2;
                _loc_4 = 8;
                while (--_loc_4 >= 0)
                {
                    
                    if ((_loc_3 & 1) != 0)
                    {
                        _loc_3 = 3988292384 ^ _loc_3 >>> 1;
                        continue;
                    }
                    _loc_3 = _loc_3 >>> 1;
                }
                _loc_1[_loc_2] = _loc_3;
                _loc_2++;
            }
            return _loc_1;
        }// end function

    }
}
