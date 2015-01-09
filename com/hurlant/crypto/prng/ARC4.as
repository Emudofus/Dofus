package com.hurlant.crypto.prng
{
    import com.hurlant.crypto.symmetric.IStreamCipher;
    import flash.utils.ByteArray;
    import com.hurlant.util.Memory;

    public class ARC4 implements IPRNG, IStreamCipher 
    {

        private const psize:uint = 0x0100;

        private var i:int = 0;
        private var j:int = 0;
        private var S:ByteArray;

        public function ARC4(key:ByteArray=null)
        {
            this.S = new ByteArray();
            if (key)
            {
                this.init(key);
            };
        }

        public function getPoolSize():uint
        {
            return (this.psize);
        }

        public function init(key:ByteArray):void
        {
            var i:int;
            var j:int;
            var t:int;
            i = 0;
            while (i < 0x0100)
            {
                this.S[i] = i;
                i++;
            };
            j = 0;
            i = 0;
            while (i < 0x0100)
            {
                j = (((j + this.S[i]) + key[(i % key.length)]) & 0xFF);
                t = this.S[i];
                this.S[i] = this.S[j];
                this.S[j] = t;
                i++;
            };
            this.i = 0;
            this.j = 0;
        }

        public function next():uint
        {
            var t:int;
            this.i = ((this.i + 1) & 0xFF);
            this.j = ((this.j + this.S[this.i]) & 0xFF);
            t = this.S[this.i];
            this.S[this.i] = this.S[this.j];
            this.S[this.j] = t;
            return (this.S[((t + this.S[this.i]) & 0xFF)]);
        }

        public function getBlockSize():uint
        {
            return (1);
        }

        public function encrypt(block:ByteArray):void
        {
            var i:uint;
            while (i < block.length)
            {
                var _local_3 = i++;
                block[_local_3] = (block[_local_3] ^ this.next());
            };
        }

        public function decrypt(block:ByteArray):void
        {
            this.encrypt(block);
        }

        public function dispose():void
        {
            var i:uint;
            if (this.S != null)
            {
                i = 0;
                while (i < this.S.length)
                {
                    this.S[i] = (Math.random() * 0x0100);
                    i++;
                };
                this.S.length = 0;
                this.S = null;
            };
            this.i = 0;
            this.j = 0;
            Memory.gc();
        }

        public function toString():String
        {
            return ("rc4");
        }


    }
}//package com.hurlant.crypto.prng

