package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;

    public class CFB8Mode extends IVMode implements IMode 
    {

        public function CFB8Mode(key:ISymmetricKey, padding:IPad=null)
        {
            super(key, null);
        }

        public function encrypt(src:ByteArray):void
        {
            var j:uint;
            var vector:ByteArray = getIV4e();
            var tmp:ByteArray = new ByteArray();
            var i:uint;
            while (i < src.length)
            {
                tmp.position = 0;
                tmp.writeBytes(vector);
                key.encrypt(vector);
                src[i] = (src[i] ^ vector[0]);
                j = 0;
                while (j < (blockSize - 1))
                {
                    vector[j] = tmp[(j + 1)];
                    j++;
                };
                vector[(blockSize - 1)] = src[i];
                i++;
            };
        }

        public function decrypt(src:ByteArray):void
        {
            var c:uint;
            var j:uint;
            var vector:ByteArray = getIV4d();
            var tmp:ByteArray = new ByteArray();
            var i:uint;
            while (i < src.length)
            {
                c = src[i];
                tmp.position = 0;
                tmp.writeBytes(vector);
                key.encrypt(vector);
                src[i] = (src[i] ^ vector[0]);
                j = 0;
                while (j < (blockSize - 1))
                {
                    vector[j] = tmp[(j + 1)];
                    j++;
                };
                vector[(blockSize - 1)] = c;
                i++;
            };
        }

        public function toString():String
        {
            return ((key.toString() + "-cfb8"));
        }


    }
}//package com.hurlant.crypto.symmetric

