package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;

    public class OFBMode extends IVMode implements IMode 
    {

        public function OFBMode(key:ISymmetricKey, padding:IPad=null)
        {
            super(key, null);
        }

        public function encrypt(src:ByteArray):void
        {
            var vector:ByteArray = getIV4e();
            this.core(src, vector);
        }

        public function decrypt(src:ByteArray):void
        {
            var vector:ByteArray = getIV4d();
            this.core(src, vector);
        }

        private function core(src:ByteArray, iv:ByteArray):void
        {
            var chunk:uint;
            var j:uint;
            var l:uint = src.length;
            var tmp:ByteArray = new ByteArray();
            var i:uint;
            while (i < src.length)
            {
                key.encrypt(iv);
                tmp.position = 0;
                tmp.writeBytes(iv);
                chunk = ((((i + blockSize))<l) ? blockSize : (l - i));
                j = 0;
                while (j < chunk)
                {
                    src[(i + j)] = (src[(i + j)] ^ iv[j]);
                    j++;
                };
                iv.position = 0;
                iv.writeBytes(tmp);
                i = (i + blockSize);
            };
        }

        public function toString():String
        {
            return ((key.toString() + "-ofb"));
        }


    }
}//package com.hurlant.crypto.symmetric

