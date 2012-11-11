package com.hurlant.crypto.prng
{
    import com.hurlant.util.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class Random extends Object
    {
        private var state:IPRNG;
        private var ready:Boolean = false;
        private var pool:ByteArray;
        private var psize:int;
        private var pptr:int;
        private var seeded:Boolean = false;

        public function Random(param1:Class = null)
        {
            var _loc_2:* = 0;
            if (param1 == null)
            {
                param1 = ARC4;
            }
            this.state = new param1 as IPRNG;
            this.psize = this.state.getPoolSize();
            this.pool = new ByteArray();
            this.pptr = 0;
            while (this.pptr < this.psize)
            {
                
                _loc_2 = 65536 * Math.random();
                var _loc_4:* = this;
                _loc_4.pptr = this.pptr + 1;
                var _loc_3:* = this.pptr + 1;
                this.pool[_loc_3] = _loc_2 >>> 8;
                var _loc_5:* = this;
                _loc_5.pptr = this.pptr + 1;
                this.pool[++this.pptr] = _loc_2 & 255;
            }
            this.pptr = 0;
            this.seed();
            return;
        }// end function

        public function seed(param1:int = 0) : void
        {
            if (param1 == 0)
            {
                param1 = new Date().getTime();
            }
            var _loc_3:* = this;
            _loc_3.pptr = this.pptr + 1;
            var _loc_2:* = this.pptr + 1;
            this.pool[_loc_2] = this.pool[_loc_2] ^ param1 & 255;
            var _loc_4:* = this;
            _loc_4.pptr = this.pptr + 1;
            var _loc_3:* = this.pptr + 1;
            this.pool[_loc_3] = this.pool[_loc_3] ^ param1 >> 8 & 255;
            var _loc_5:* = this;
            _loc_5.pptr = this.pptr + 1;
            this.pool[++this.pptr] = this.pool[++this.pptr] ^ param1 >> 16 & 255;
            var _loc_6:* = this;
            _loc_6.pptr = this.pptr + 1;
            this.pool[++this.pptr] = this.pool[++this.pptr] ^ param1 >> 24 & 255;
            this.pptr = this.pptr % this.psize;
            this.seeded = true;
            return;
        }// end function

        public function autoSeed() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = new ByteArray();
            _loc_1.writeUnsignedInt(System.totalMemory);
            _loc_1.writeUTF(Capabilities.serverString);
            _loc_1.writeUnsignedInt(getTimer());
            _loc_1.writeUnsignedInt(new Date().getTime());
            var _loc_2:* = Font.enumerateFonts(true);
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1.writeUTF(_loc_3.fontName);
                _loc_1.writeUTF(_loc_3.fontStyle);
                _loc_1.writeUTF(_loc_3.fontType);
            }
            _loc_1.position = 0;
            while (_loc_1.bytesAvailable >= 4)
            {
                
                this.seed(_loc_1.readUnsignedInt());
            }
            return;
        }// end function

        public function nextBytes(param1:ByteArray, param2:int) : void
        {
            while (param2--)
            {
                
                param1.writeByte(this.nextByte());
            }
            return;
        }// end function

        public function nextByte() : int
        {
            if (!this.ready)
            {
                if (!this.seeded)
                {
                    this.autoSeed();
                }
                this.state.init(this.pool);
                this.pool.length = 0;
                this.pptr = 0;
                this.ready = true;
            }
            return this.state.next();
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.pool.length)
            {
                
                this.pool[_loc_1] = Math.random() * 256;
                _loc_1 = _loc_1 + 1;
            }
            this.pool.length = 0;
            this.pool = null;
            this.state.dispose();
            this.state = null;
            this.psize = 0;
            this.pptr = 0;
            Memory.gc();
            return;
        }// end function

        public function toString() : String
        {
            return "random-" + this.state.toString();
        }// end function

    }
}
