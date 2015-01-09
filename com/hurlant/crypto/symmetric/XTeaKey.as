package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;
    import com.hurlant.crypto.prng.Random;
    import com.hurlant.util.Memory;

    public class XTeaKey implements ISymmetricKey 
    {

        public const NUM_ROUNDS:uint = 64;

        private var k:Array;

        public function XTeaKey(a:ByteArray)
        {
            a.position = 0;
            this.k = [a.readUnsignedInt(), a.readUnsignedInt(), a.readUnsignedInt(), a.readUnsignedInt()];
        }

        public static function parseKey(K:String):XTeaKey
        {
            var a:ByteArray = new ByteArray();
            a.writeUnsignedInt(parseInt(K.substr(0, 8), 16));
            a.writeUnsignedInt(parseInt(K.substr(8, 8), 16));
            a.writeUnsignedInt(parseInt(K.substr(16, 8), 16));
            a.writeUnsignedInt(parseInt(K.substr(24, 8), 16));
            a.position = 0;
            return (new (XTeaKey)(a));
        }


        public function getBlockSize():uint
        {
            return (8);
        }

        public function encrypt(block:ByteArray, index:uint=0):void
        {
            var i:uint;
            block.position = index;
            var v0:uint = block.readUnsignedInt();
            var v1:uint = block.readUnsignedInt();
            var sum:uint;
            var delta:uint = 2654435769;
            i = 0;
            while (i < this.NUM_ROUNDS)
            {
                v0 = (v0 + ((((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + this.k[(sum & 3)])));
                sum = (sum + delta);
                v1 = (v1 + ((((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + this.k[((sum >> 11) & 3)])));
                i++;
            };
            block.position = (block.position - 8);
            block.writeUnsignedInt(v0);
            block.writeUnsignedInt(v1);
        }

        public function decrypt(block:ByteArray, index:uint=0):void
        {
            var i:uint;
            block.position = index;
            var v0:uint = block.readUnsignedInt();
            var v1:uint = block.readUnsignedInt();
            var delta:uint = 2654435769;
            var sum:uint = (delta * this.NUM_ROUNDS);
            i = 0;
            while (i < this.NUM_ROUNDS)
            {
                v1 = (v1 - ((((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + this.k[((sum >> 11) & 3)])));
                sum = (sum - delta);
                v0 = (v0 - ((((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + this.k[(sum & 3)])));
                i++;
            };
            block.position = (block.position - 8);
            block.writeUnsignedInt(v0);
            block.writeUnsignedInt(v1);
        }

        public function dispose():void
        {
            var r:Random = new Random();
            var i:uint;
            while (i < this.k.length)
            {
                this.k[i] = r.nextByte();
                delete this.k[i];
                i++;
            };
            this.k = null;
            Memory.gc();
        }

        public function toString():String
        {
            return ("xtea");
        }


    }
}//package com.hurlant.crypto.symmetric

