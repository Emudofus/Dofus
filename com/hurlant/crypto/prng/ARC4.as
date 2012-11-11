package com.hurlant.crypto.prng
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class ARC4 extends Object implements IPRNG, IStreamCipher
    {
        private var i:int = 0;
        private var j:int = 0;
        private var S:ByteArray;
        private const psize:uint = 256;

        public function ARC4(param1:ByteArray = null)
        {
            this.S = new ByteArray();
            if (param1)
            {
                this.init(param1);
            }
            return;
        }// end function

        public function getPoolSize() : uint
        {
            return this.psize;
        }// end function

        public function init(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_2 = 0;
            while (_loc_2 < 256)
            {
                
                this.S[_loc_2] = _loc_2;
                _loc_2++;
            }
            _loc_3 = 0;
            _loc_2 = 0;
            while (_loc_2 < 256)
            {
                
                _loc_3 = _loc_3 + this.S[_loc_2] + param1[_loc_2 % param1.length] & 255;
                _loc_4 = this.S[_loc_2];
                this.S[_loc_2] = this.S[_loc_3];
                this.S[_loc_3] = _loc_4;
                _loc_2++;
            }
            this.i = 0;
            this.j = 0;
            return;
        }// end function

        public function next() : uint
        {
            var _loc_1:* = 0;
            this.i = (this.i + 1) & 255;
            this.j = this.j + this.S[this.i] & 255;
            _loc_1 = this.S[this.i];
            this.S[this.i] = this.S[this.j];
            this.S[this.j] = _loc_1;
            return this.S[_loc_1 + this.S[this.i] & 255];
        }// end function

        public function getBlockSize() : uint
        {
            return 1;
        }// end function

        public function encrypt(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                var _loc_3:* = _loc_2 + 1;
                param1[_loc_3] = param1[_loc_3] ^ this.next();
            }
            return;
        }// end function

        public function decrypt(param1:ByteArray) : void
        {
            this.encrypt(param1);
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = 0;
            if (this.S != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this.S.length)
                {
                    
                    this.S[_loc_1] = Math.random() * 256;
                    _loc_1 = _loc_1 + 1;
                }
                this.S.length = 0;
                this.S = null;
            }
            this.i = 0;
            this.j = 0;
            Memory.gc();
            return;
        }// end function

        public function toString() : String
        {
            return "rc4";
        }// end function

    }
}
