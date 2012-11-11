package com.hurlant.util.der
{
    import com.hurlant.util.*;
    import com.hurlant.util.der.*;
    import flash.utils.*;

    public class ByteString extends ByteArray implements IAsn1Type
    {
        private var type:uint;
        private var len:uint;

        public function ByteString(param1:uint = 4, param2:uint = 0)
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
            return DER.wrapDER(this.type, this);
        }// end function

        override public function toString() : String
        {
            return DER.indent + "ByteString[" + this.type + "][" + this.len + "][" + Hex.fromArray(this) + "]";
        }// end function

    }
}
