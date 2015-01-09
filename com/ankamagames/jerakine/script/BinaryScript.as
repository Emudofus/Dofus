package com.ankamagames.jerakine.script
{
    import flash.utils.ByteArray;

    public class BinaryScript 
    {

        private var _data:ByteArray;
        public var path:String;

        public function BinaryScript(data:ByteArray, path:String)
        {
            this._data = data;
            this.path = path;
        }

        public function get data():ByteArray
        {
            this._data.position = 0;
            return (this._data);
        }


    }
}//package com.ankamagames.jerakine.script

