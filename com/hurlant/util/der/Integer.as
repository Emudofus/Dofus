package com.hurlant.util.der
{
    import com.hurlant.math.*;
    import com.hurlant.util.der.*;
    import flash.utils.*;

    public class Integer extends BigInteger implements IAsn1Type
    {
        private var type:uint;
        private var len:uint;

        public function Integer(param1:uint, param2:uint, param3:ByteArray)
        {
            this.type = param1;
            this.len = param2;
            super(param3);
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

        override public function toString(param1:Number = 0) : String
        {
            return DER.indent + "Integer[" + this.type + "][" + this.len + "][" + super.toString(16) + "]";
        }// end function

        public function toDER() : ByteArray
        {
            return null;
        }// end function

    }
}
