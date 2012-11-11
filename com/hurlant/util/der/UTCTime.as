package com.hurlant.util.der
{
    import com.hurlant.util.der.*;
    import flash.utils.*;

    public class UTCTime extends Object implements IAsn1Type
    {
        protected var type:uint;
        protected var len:uint;
        public var date:Date;

        public function UTCTime(param1:uint, param2:uint)
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

        public function setUTCTime(param1:String) : void
        {
            var _loc_2:* = parseInt(param1.substr(0, 2));
            if (_loc_2 < 50)
            {
                _loc_2 = _loc_2 + 2000;
            }
            else
            {
                _loc_2 = _loc_2 + 1900;
            }
            var _loc_3:* = parseInt(param1.substr(2, 2));
            var _loc_4:* = parseInt(param1.substr(4, 2));
            var _loc_5:* = parseInt(param1.substr(6, 2));
            var _loc_6:* = parseInt(param1.substr(8, 2));
            this.date = new Date(_loc_2, (_loc_3 - 1), _loc_4, _loc_5, _loc_6);
            return;
        }// end function

        public function toString() : String
        {
            return DER.indent + "UTCTime[" + this.type + "][" + this.len + "][" + this.date + "]";
        }// end function

        public function toDER() : ByteArray
        {
            return null;
        }// end function

    }
}
