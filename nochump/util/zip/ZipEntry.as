package nochump.util.zip
{
    import flash.utils.*;

    public class ZipEntry extends Object
    {
        private var _name:String;
        private var _size:int = -1;
        private var _compressedSize:int = -1;
        private var _crc:uint;
        var dostime:uint;
        private var _method:int = -1;
        private var _extra:ByteArray;
        private var _comment:String;
        var flag:int;
        var version:int;
        var offset:int;

        public function ZipEntry(param1:String)
        {
            this._name = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get time() : Number
        {
            var _loc_1:* = new Date((this.dostime >> 25 & 127) + 1980, (this.dostime >> 21 & 15) - 1, this.dostime >> 16 & 31, this.dostime >> 11 & 31, this.dostime >> 5 & 63, (this.dostime & 31) << 1);
            return _loc_1.time;
        }// end function

        public function set time(param1:Number) : void
        {
            var _loc_2:* = new Date(param1);
            this.dostime = (_loc_2.fullYear - 1980 & 127) << 25 | (_loc_2.month + 1) << 21 | _loc_2.day << 16 | _loc_2.hours << 11 | _loc_2.minutes << 5 | _loc_2.seconds >> 1;
            return;
        }// end function

        public function get size() : int
        {
            return this._size;
        }// end function

        public function set size(param1:int) : void
        {
            this._size = param1;
            return;
        }// end function

        public function get compressedSize() : int
        {
            return this._compressedSize;
        }// end function

        public function set compressedSize(param1:int) : void
        {
            this._compressedSize = param1;
            return;
        }// end function

        public function get crc() : uint
        {
            return this._crc;
        }// end function

        public function set crc(param1:uint) : void
        {
            this._crc = param1;
            return;
        }// end function

        public function get method() : int
        {
            return this._method;
        }// end function

        public function set method(param1:int) : void
        {
            this._method = param1;
            return;
        }// end function

        public function get extra() : ByteArray
        {
            return this._extra;
        }// end function

        public function set extra(param1:ByteArray) : void
        {
            this._extra = param1;
            return;
        }// end function

        public function get comment() : String
        {
            return this._comment;
        }// end function

        public function set comment(param1:String) : void
        {
            this._comment = param1;
            return;
        }// end function

        public function isDirectory() : Boolean
        {
            return this._name.charAt((this._name.length - 1)) == "/";
        }// end function

        public function toString() : String
        {
            return this._name;
        }// end function

    }
}
