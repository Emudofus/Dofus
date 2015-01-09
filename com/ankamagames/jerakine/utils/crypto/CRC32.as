package com.ankamagames.jerakine.utils.crypto
{
    import flash.utils.ByteArray;

    public class CRC32 
    {

        private static var CRCTable:Array = initCRCTable();

        private var _crc32:uint;


        private static function initCRCTable():Array
        {
            var crc:uint;
            var j:int;
            var crcTable:Array = new Array(0x0100);
            var i:int;
            while (i < 0x0100)
            {
                crc = i;
                j = 0;
                while (j < 8)
                {
                    crc = (((crc & 1)) ? ((crc >>> 1) ^ 3988292384) : (crc >>> 1));
                    j++;
                };
                crcTable[i] = crc;
                i++;
            };
            return (crcTable);
        }


        public function update(buffer:ByteArray, offset:int=0, length:int=0):void
        {
            length = (((length == 0)) ? buffer.length : length);
            var crc:uint = ~(this._crc32);
            var i:int = offset;
            while (i < length)
            {
                crc = (CRCTable[((crc ^ buffer[i]) & 0xFF)] ^ (crc >>> 8));
                i++;
            };
            this._crc32 = ~(crc);
        }

        public function getValue():uint
        {
            return ((this._crc32 & 0xFFFFFFFF));
        }

        public function reset():void
        {
            this._crc32 = 0;
        }


    }
}//package com.ankamagames.jerakine.utils.crypto

