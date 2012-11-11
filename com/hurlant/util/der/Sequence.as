package com.hurlant.util.der
{
    import com.hurlant.util.der.*;
    import flash.utils.*;

    dynamic public class Sequence extends Array implements IAsn1Type
    {
        protected var type:uint;
        protected var len:uint;

        public function Sequence(param1:uint = 48, param2:uint = 0)
        {
            this.type = param1;
            this.len = param2;
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
            var _loc_3:* = null;
            var _loc_1:* = new ByteArray();
            var _loc_2:* = 0;
            while (_loc_2 < length)
            {
                
                _loc_3 = this[_loc_2];
                if (_loc_3 == null)
                {
                    _loc_1.writeByte(5);
                    _loc_1.writeByte(0);
                }
                else
                {
                    _loc_1.writeBytes(_loc_3.toDER());
                }
                _loc_2++;
            }
            return DER.wrapDER(this.type, _loc_1);
        }// end function

        public function toString() : String
        {
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_1:* = DER.indent;
            DER.indent = DER.indent + "    ";
            var _loc_2:* = "";
            var _loc_3:* = 0;
            while (_loc_3 < length)
            {
                
                if (this[_loc_3] == null)
                {
                }
                else
                {
                    _loc_4 = false;
                    for (_loc_5 in this)
                    {
                        
                        if (_loc_3.toString() != _loc_5 && this[_loc_3] == this[_loc_5])
                        {
                            _loc_2 = _loc_2 + (_loc_5 + ": " + this[_loc_3] + "\n");
                            _loc_4 = true;
                            break;
                        }
                    }
                    if (!_loc_4)
                    {
                        _loc_2 = _loc_2 + (this[_loc_3] + "\n");
                    }
                }
                _loc_3++;
            }
            DER.indent = _loc_1;
            return DER.indent + "Sequence[" + this.type + "][" + this.len + "][\n" + _loc_2 + "\n" + _loc_1 + "]";
        }// end function

        public function findAttributeValue(param1:String) : IAsn1Type
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            for each (_loc_2 in this)
            {
                
                if (_loc_2 is Set)
                {
                    _loc_3 = _loc_2[0];
                    if (_loc_3 is Sequence)
                    {
                        _loc_4 = _loc_3[0];
                        if (_loc_4 is ObjectIdentifier)
                        {
                            _loc_5 = _loc_4 as ObjectIdentifier;
                            if (_loc_5.toString() == param1)
                            {
                                return _loc_3[1] as IAsn1Type;
                            }
                        }
                    }
                }
            }
            return null;
        }// end function

    }
}
