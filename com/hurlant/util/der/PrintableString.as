package com.hurlant.util.der
{
    import com.hurlant.util.der.*;
    import flash.utils.*;

    public class PrintableString extends Object implements IAsn1Type
    {
        protected var type:uint;
        protected var len:uint;
        protected var str:String;

        public function PrintableString(param1:uint, param2:uint)
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

        public function setString(param1:String) : void
        {
            this.str = param1;
            return;
        }// end function

        public function getString() : String
        {
            return this.str;
        }// end function

        public function toString() : String
        {
            return DER.indent + this.str;
        }// end function

        public function toDER() : ByteArray
        {
            return null;
        }// end function

    }
}
