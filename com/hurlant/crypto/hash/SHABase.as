package com.hurlant.crypto.hash
{
    import flash.utils.Endian;
    import flash.utils.ByteArray;

    public class SHABase implements IHash 
    {

        public var pad_size:int = 40;


        public function getInputSize():uint
        {
            return (64);
        }

        public function getHashSize():uint
        {
            return (0);
        }

        public function getPadSize():int
        {
            return (this.pad_size);
        }

        public function hash(src:ByteArray):ByteArray
        {
            var savedLength:uint = src.length;
            var savedEndian:String = src.endian;
            src.endian = Endian.BIG_ENDIAN;
            var len:uint = (savedLength * 8);
            while ((src.length % 4) != 0)
            {
                src[src.length] = 0;
            };
            src.position = 0;
            var a:Array = [];
            var i:uint;
            while (i < src.length)
            {
                a.push(src.readUnsignedInt());
                i = (i + 4);
            };
            var h:Array = this.core(a, len);
            var out:ByteArray = new ByteArray();
            var words:uint = (this.getHashSize() / 4);
            i = 0;
            while (i < words)
            {
                out.writeUnsignedInt(h[i]);
                i++;
            };
            src.length = savedLength;
            src.endian = savedEndian;
            return (out);
        }

        protected function core(x:Array, len:uint):Array
        {
            return (null);
        }

        public function toString():String
        {
            return ("sha");
        }


    }
}//package com.hurlant.crypto.hash

