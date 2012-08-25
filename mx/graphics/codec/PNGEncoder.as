package mx.graphics.codec
{
    import flash.display.*;
    import flash.utils.*;
    import mx.graphics.codec.*;

    public class PNGEncoder extends Object implements IImageEncoder
    {
        private var crcTable:Array;
        static const VERSION:String = "4.1.0.16076";
        private static const CONTENT_TYPE:String = "image/png";

        public function PNGEncoder()
        {
            this.initializeCRCTable();
            return;
        }// end function

        public function get contentType() : String
        {
            return CONTENT_TYPE;
        }// end function

        public function encode(param1:BitmapData) : ByteArray
        {
            return this.internalEncode(param1, param1.width, param1.height, param1.transparent);
        }// end function

        public function encodeByteArray(param1:ByteArray, param2:int, param3:int, param4:Boolean = true) : ByteArray
        {
            return this.internalEncode(param1, param2, param3, param4);
        }// end function

        private function initializeCRCTable() : void
        {
            var _loc_2:uint = 0;
            var _loc_3:uint = 0;
            this.crcTable = [];
            var _loc_1:uint = 0;
            while (_loc_1 < 256)
            {
                
                _loc_2 = _loc_1;
                _loc_3 = 0;
                while (_loc_3 < 8)
                {
                    
                    if (_loc_2 & 1)
                    {
                        _loc_2 = uint(uint(3988292384) ^ uint(_loc_2 >>> 1));
                    }
                    else
                    {
                        _loc_2 = uint(_loc_2 >>> 1);
                    }
                    _loc_3 = _loc_3 + 1;
                }
                this.crcTable[_loc_1] = _loc_2;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function internalEncode(param1:Object, param2:int, param3:int, param4:Boolean = true) : ByteArray
        {
            var _loc_11:int = 0;
            var _loc_12:uint = 0;
            var _loc_5:* = param1 as BitmapData;
            var _loc_6:* = param1 as ByteArray;
            if (param1 as ByteArray)
            {
                _loc_6.position = 0;
            }
            var _loc_7:* = new ByteArray();
            new ByteArray().writeUnsignedInt(2303741511);
            _loc_7.writeUnsignedInt(218765834);
            var _loc_8:* = new ByteArray();
            new ByteArray().writeInt(param2);
            _loc_8.writeInt(param3);
            _loc_8.writeByte(8);
            _loc_8.writeByte(6);
            _loc_8.writeByte(0);
            _loc_8.writeByte(0);
            _loc_8.writeByte(0);
            this.writeChunk(_loc_7, 1229472850, _loc_8);
            var _loc_9:* = new ByteArray();
            var _loc_10:int = 0;
            while (_loc_10 < param3)
            {
                
                _loc_9.writeByte(0);
                if (!param4)
                {
                    _loc_11 = 0;
                    while (_loc_11 < param2)
                    {
                        
                        if (_loc_5)
                        {
                            _loc_12 = _loc_5.getPixel(_loc_11, _loc_10);
                        }
                        else
                        {
                            _loc_12 = _loc_6.readUnsignedInt();
                        }
                        _loc_9.writeUnsignedInt(uint((_loc_12 & 16777215) << 8 | 255));
                        _loc_11++;
                    }
                }
                else
                {
                    _loc_11 = 0;
                    while (_loc_11 < param2)
                    {
                        
                        if (_loc_5)
                        {
                            _loc_12 = _loc_5.getPixel32(_loc_11, _loc_10);
                        }
                        else
                        {
                            _loc_12 = _loc_6.readUnsignedInt();
                        }
                        _loc_9.writeUnsignedInt(uint((_loc_12 & 16777215) << 8 | _loc_12 >>> 24));
                        _loc_11++;
                    }
                }
                _loc_10++;
            }
            _loc_9.compress();
            this.writeChunk(_loc_7, 1229209940, _loc_9);
            this.writeChunk(_loc_7, 1229278788, null);
            _loc_7.position = 0;
            return _loc_7;
        }// end function

        private function writeChunk(param1:ByteArray, param2:uint, param3:ByteArray) : void
        {
            var _loc_4:uint = 0;
            if (param3)
            {
                _loc_4 = param3.length;
            }
            param1.writeUnsignedInt(_loc_4);
            var _loc_5:* = param1.position;
            param1.writeUnsignedInt(param2);
            if (param3)
            {
                param1.writeBytes(param3);
            }
            var _loc_6:* = param1.position;
            param1.position = _loc_5;
            var _loc_7:uint = 4294967295;
            var _loc_8:* = _loc_5;
            while (_loc_8 < _loc_6)
            {
                
                _loc_7 = uint(this.crcTable[(_loc_7 ^ param1.readUnsignedByte()) & uint(255)] ^ uint(_loc_7 >>> 8));
                _loc_8 = _loc_8 + 1;
            }
            _loc_7 = uint(_loc_7 ^ uint(4294967295));
            param1.position = _loc_6;
            param1.writeUnsignedInt(_loc_7);
            return;
        }// end function

    }
}
