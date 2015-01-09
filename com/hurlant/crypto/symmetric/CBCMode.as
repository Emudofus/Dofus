package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;

    public class CBCMode extends IVMode implements IMode 
    {

        public function CBCMode(key:ISymmetricKey, padding:IPad=null)
        {
            super(key, padding);
        }

        public function encrypt(src:ByteArray):void
        {
            var j:uint;
            padding.pad(src);
            var vector:ByteArray = getIV4e();
            var i:uint;
            while (i < src.length)
            {
                j = 0;
                while (j < blockSize)
                {
                    src[(i + j)] = (src[(i + j)] ^ vector[j]);
                    j++;
                };
                key.encrypt(src, i);
                vector.position = 0;
                vector.writeBytes(src, i, blockSize);
                i = (i + blockSize);
            };
        }

        public function decrypt(src:ByteArray):void
        {
            var j:uint;
            var vector:ByteArray = getIV4d();
            var tmp:ByteArray = new ByteArray();
            var i:uint;
            while (i < src.length)
            {
                tmp.position = 0;
                tmp.writeBytes(src, i, blockSize);
                key.decrypt(src, i);
                j = 0;
                while (j < blockSize)
                {
                    src[(i + j)] = (src[(i + j)] ^ vector[j]);
                    j++;
                };
                vector.position = 0;
                vector.writeBytes(tmp, 0, blockSize);
                i = (i + blockSize);
            };
            padding.unpad(src);
        }

        public function toString():String
        {
            return ((key.toString() + "-cbc"));
        }


    }
}//package com.hurlant.crypto.symmetric

