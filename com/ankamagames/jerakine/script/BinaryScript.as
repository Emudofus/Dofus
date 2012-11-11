package com.ankamagames.jerakine.script
{
    import flash.utils.*;

    public class BinaryScript extends Object
    {
        private var _data:ByteArray;
        public var path:String;

        public function BinaryScript(param1:ByteArray, param2:String)
        {
            this._data = param1;
            this.path = param2;
            return;
        }// end function

        public function get data() : ByteArray
        {
            this._data.position = 0;
            return this._data;
        }// end function

    }
}
