package com.hurlant.util.der
{
    import com.hurlant.util.der.*;
    import flash.net.*;
    import flash.utils.*;

    public class ObjectIdentifier extends Object implements IAsn1Type
    {
        private var type:uint;
        private var len:uint;
        private var oid:Array;

        public function ObjectIdentifier(param1:uint = 0, param2:uint = 0, param3 = null)
        {
            this.type = param1;
            this.len = param2;
            if (param3 is ByteArray)
            {
                this.parse(param3 as ByteArray);
            }
            else if (param3 is String)
            {
                this.generate(param3 as String);
            }
            else
            {
                throw new Error("Invalid call to new ObjectIdentifier");
            }
            return;
        }// end function

        private function generate(param1:String) : void
        {
            this.oid = param1.split(".");
            return;
        }// end function

        private function parse(param1:ByteArray) : void
        {
            var _loc_5:Boolean = false;
            var _loc_2:* = param1.readUnsignedByte();
            var _loc_3:Array = [];
            _loc_3.push(uint(_loc_2 / 40));
            _loc_3.push(uint(_loc_2 % 40));
            var _loc_4:uint = 0;
            while (param1.bytesAvailable > 0)
            {
                
                _loc_2 = param1.readUnsignedByte();
                _loc_5 = (_loc_2 & 128) == 0;
                _loc_2 = _loc_2 & 127;
                _loc_4 = _loc_4 * 128 + _loc_2;
                if (_loc_5)
                {
                    _loc_3.push(_loc_4);
                    _loc_4 = 0;
                }
            }
            this.oid = _loc_3;
            return;
        }// end function

        public function getLength() : uint
        {
            return this.len;
        }// end function

        public function getType() : uint
        {
            return this.type;
        }// end function

        public function toDER() : ByteArray
        {
            var _loc_4:int = 0;
            var _loc_1:Array = [];
            _loc_1[0] = this.oid[0] * 40 + this.oid[1];
            var _loc_2:int = 2;
            while (_loc_2 < this.oid.length)
            {
                
                _loc_4 = parseInt(this.oid[_loc_2]);
                if (_loc_4 < 128)
                {
                    _loc_1.push(_loc_4);
                }
                else if (_loc_4 < 128 * 128)
                {
                    _loc_1.push(_loc_4 >> 7 | 128);
                    _loc_1.push(_loc_4 & 127);
                }
                else if (_loc_4 < 128 * 128 * 128)
                {
                    _loc_1.push(_loc_4 >> 14 | 128);
                    _loc_1.push(_loc_4 >> 7 & 127 | 128);
                    _loc_1.push(_loc_4 & 127);
                }
                else if (_loc_4 < 128 * 128 * 128 * 128)
                {
                    _loc_1.push(_loc_4 >> 21 | 128);
                    _loc_1.push(_loc_4 >> 14 & 127 | 128);
                    _loc_1.push(_loc_4 >> 7 & 127 | 128);
                    _loc_1.push(_loc_4 & 127);
                }
                else
                {
                    throw new Error("OID element bigger than we thought. :(");
                }
                _loc_2++;
            }
            this.len = _loc_1.length;
            if (this.type == 0)
            {
                this.type = 6;
            }
            _loc_1.unshift(this.len);
            _loc_1.unshift(this.type);
            var _loc_3:* = new ByteArray();
            _loc_2 = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3[_loc_2] = _loc_1[_loc_2];
                _loc_2++;
            }
            return _loc_3;
        }// end function

        public function toString() : String
        {
            return DER.indent + this.oid.join(".");
        }// end function

        public function dump() : String
        {
            return "OID[" + this.type + "][" + this.len + "][" + this.toString() + "]";
        }// end function

        registerClassAlias("com.hurlant.util.der.ObjectIdentifier", ObjectIdentifier);
    }
}
