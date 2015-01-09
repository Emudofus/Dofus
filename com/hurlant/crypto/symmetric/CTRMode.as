package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;

    public class CTRMode extends IVMode implements IMode 
    {

        public function CTRMode(key:ISymmetricKey, padding:IPad=null)
        {
            super(key, padding);
        }

        public function encrypt(src:ByteArray):void
        {
            padding.pad(src);
            var vector:ByteArray = getIV4e();
            this.core(src, vector);
        }

        public function decrypt(src:ByteArray):void
        {
            var vector:ByteArray = getIV4d();
            this.core(src, vector);
            padding.unpad(src);
        }

        private function core(src:ByteArray, iv:ByteArray):void
        {
            var j:uint;
            var X:ByteArray = new ByteArray();
            var Xenc:ByteArray = new ByteArray();
            X.writeBytes(iv);
            var i:uint;
            while (i < src.length)
            {
                Xenc.position = 0;
                Xenc.writeBytes(X);
                key.encrypt(Xenc);
                j = 0;
                while (j < blockSize)
                {
                    src[(i + j)] = (src[(i + j)] ^ Xenc[j]);
                    j++;
                };
                j = (blockSize - 1);
                while (j >= 0)
                {
                    var _local_7 = X;
                    var _local_8 = j;
                    var _local_9 = (_local_7[_local_8] + 1);
                    _local_7[_local_8] = _local_9;
                    if (X[j] != 0)
                    {
                        break;
                    };
                    j--;
                };
                i = (i + blockSize);
            };
        }

        public function toString():String
        {
            return ((key.toString() + "-ctr"));
        }


    }
}//package com.hurlant.crypto.symmetric

