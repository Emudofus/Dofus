package com.hurlant.crypto.prng
{
    import flash.utils.ByteArray;
    import flash.text.Font;
    import flash.system.System;
    import flash.system.Capabilities;
    import flash.utils.getTimer;
    import com.hurlant.util.Memory;

    public class Random 
    {

        private var state:IPRNG;
        private var ready:Boolean = false;
        private var pool:ByteArray;
        private var psize:int;
        private var pptr:int;
        private var seeded:Boolean = false;

        public function Random(prng:Class=null)
        {
            var t:uint;
            super();
            if (prng == null)
            {
                prng = ARC4;
            };
            this.state = (new (prng)() as IPRNG);
            this.psize = this.state.getPoolSize();
            this.pool = new ByteArray();
            this.pptr = 0;
            while (this.pptr < this.psize)
            {
                t = (65536 * Math.random());
                var _local_3 = this.pptr++;
                this.pool[_local_3] = (t >>> 8);
                var _local_4 = this.pptr++;
                this.pool[_local_4] = (t & 0xFF);
            };
            this.pptr = 0;
            this.seed();
        }

        public function seed(x:int=0):void
        {
            if (x == 0)
            {
                x = new Date().getTime();
            };
            var _local_2 = this.pptr++;
            this.pool[_local_2] = (this.pool[_local_2] ^ (x & 0xFF));
            var _local_3 = this.pptr++;
            this.pool[_local_3] = (this.pool[_local_3] ^ ((x >> 8) & 0xFF));
            var _local_4 = this.pptr++;
            this.pool[_local_4] = (this.pool[_local_4] ^ ((x >> 16) & 0xFF));
            var _local_5 = this.pptr++;
            this.pool[_local_5] = (this.pool[_local_5] ^ ((x >> 24) & 0xFF));
            this.pptr = (this.pptr % this.psize);
            this.seeded = true;
        }

        public function autoSeed():void
        {
            var f:Font;
            var b:ByteArray = new ByteArray();
            b.writeUnsignedInt(System.totalMemory);
            b.writeUTF(Capabilities.serverString);
            b.writeUnsignedInt(getTimer());
            b.writeUnsignedInt(new Date().getTime());
            var a:Array = Font.enumerateFonts(true);
            for each (f in a)
            {
                b.writeUTF(f.fontName);
                b.writeUTF(f.fontStyle);
                b.writeUTF(f.fontType);
            };
            b.position = 0;
            while (b.bytesAvailable >= 4)
            {
                this.seed(b.readUnsignedInt());
            };
        }

        public function nextBytes(buffer:ByteArray, length:int):void
        {
            while (length--)
            {
                buffer.writeByte(this.nextByte());
            };
        }

        public function nextByte():int
        {
            if (!(this.ready))
            {
                if (!(this.seeded))
                {
                    this.autoSeed();
                };
                this.state.init(this.pool);
                this.pool.length = 0;
                this.pptr = 0;
                this.ready = true;
            };
            return (this.state.next());
        }

        public function dispose():void
        {
            var i:uint;
            while (i < this.pool.length)
            {
                this.pool[i] = (Math.random() * 0x0100);
                i++;
            };
            this.pool.length = 0;
            this.pool = null;
            this.state.dispose();
            this.state = null;
            this.psize = 0;
            this.pptr = 0;
            Memory.gc();
        }

        public function toString():String
        {
            return (("random-" + this.state.toString()));
        }


    }
}//package com.hurlant.crypto.prng

