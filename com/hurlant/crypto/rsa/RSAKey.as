package com.hurlant.crypto.rsa
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.crypto.tls.*;
    import com.hurlant.math.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class RSAKey extends Object
    {
        public var e:int;
        public var n:BigInteger;
        public var d:BigInteger;
        public var p:BigInteger;
        public var q:BigInteger;
        public var dmp1:BigInteger;
        public var dmq1:BigInteger;
        public var coeff:BigInteger;
        protected var canDecrypt:Boolean;
        protected var canEncrypt:Boolean;

        public function RSAKey(param1:BigInteger, param2:int, param3:BigInteger = null, param4:BigInteger = null, param5:BigInteger = null, param6:BigInteger = null, param7:BigInteger = null, param8:BigInteger = null)
        {
            this.n = param1;
            this.e = param2;
            this.d = param3;
            this.p = param4;
            this.q = param5;
            this.dmp1 = param6;
            this.dmq1 = param7;
            this.coeff = param8;
            this.canEncrypt = this.n != null && this.e != 0;
            this.canDecrypt = this.canEncrypt && this.d != null;
            return;
        }// end function

        public function getBlockSize() : uint
        {
            return (this.n.bitLength() + 7) / 8;
        }// end function

        public function dispose() : void
        {
            this.e = 0;
            this.n.dispose();
            this.n = null;
            Memory.gc();
            return;
        }// end function

        public function encrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            this._encrypt(this.doPublic, param1, param2, param3, param4, 2);
            return;
        }// end function

        public function decrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            this._decrypt(this.doPrivate2, param1, param2, param3, param4, 2);
            return;
        }// end function

        public function sign(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            this._encrypt(this.doPrivate2, param1, param2, param3, param4, 1);
            return;
        }// end function

        public function verify(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            this._decrypt(this.doPublic, param1, param2, param3, param4, 1);
            return;
        }// end function

        private function _encrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void
        {
            var _loc_9:BigInteger = null;
            var _loc_10:BigInteger = null;
            if (param5 == null)
            {
                param5 = this.pkcs1pad;
            }
            if (param2.position >= param2.length)
            {
                param2.position = 0;
            }
            var _loc_7:* = this.getBlockSize();
            var _loc_8:* = param2.position + param4;
            while (param2.position < _loc_8)
            {
                
                _loc_9 = new BigInteger(this.param5(param2, _loc_8, _loc_7, param6), _loc_7, true);
                _loc_10 = this.param1(_loc_9);
                _loc_10.toArray(param3);
            }
            return;
        }// end function

        private function _decrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void
        {
            var _loc_9:BigInteger = null;
            var _loc_10:BigInteger = null;
            var _loc_11:ByteArray = null;
            if (param5 == null)
            {
                param5 = this.pkcs1unpad;
            }
            if (param2.position >= param2.length)
            {
                param2.position = 0;
            }
            var _loc_7:* = this.getBlockSize();
            var _loc_8:* = param2.position + param4;
            while (param2.position < _loc_8)
            {
                
                _loc_9 = new BigInteger(param2, _loc_7, true);
                _loc_10 = this.param1(_loc_9);
                _loc_11 = this.param5(_loc_10, _loc_7, param6);
                if (_loc_11 == null)
                {
                    throw new TLSError("Decrypt error - padding function returned null!", TLSError.decode_error);
                }
                param3.writeBytes(_loc_11);
            }
            return;
        }// end function

        private function pkcs1pad(param1:ByteArray, param2:int, param3:uint, param4:uint = 2) : ByteArray
        {
            var _loc_8:Random = null;
            var _loc_9:int = 0;
            var _loc_5:* = new ByteArray();
            var _loc_6:* = param1.position;
            param2 = Math.min(param2, param1.length, _loc_6 + param3 - 11);
            param1.position = param2;
            var _loc_7:* = param2 - 1;
            while (_loc_7 >= _loc_6 && --param3 > 11)
            {
                
                _loc_5[--param3] = param1[_loc_7--];
            }
            _loc_5[--_loc_3] = 0;
            if (param4 == 2)
            {
                _loc_8 = new Random();
                _loc_9 = 0;
                while (_loc_3 > 2)
                {
                    
                    do
                    {
                        
                        _loc_9 = _loc_8.nextByte();
                    }while (_loc_9 == 0)
                    _loc_3 = --_loc_3 - 1;
                    var _loc_11:* = --_loc_3 - 1;
                    _loc_5[--_loc_3 - 1] = _loc_9;
                }
            }
            else
            {
                while (--_loc_3 > 2)
                {
                    
                    _loc_5[--_loc_3] = 255;
                }
            }
            _loc_5[--_loc_3] = param4;
            _loc_3 = --_loc_3 - 1;
            var _loc_12:* = --_loc_3 - 1;
            _loc_5[--_loc_3 - 1] = 0;
            return _loc_5;
        }// end function

        private function pkcs1unpad(param1:BigInteger, param2:uint, param3:uint = 2) : ByteArray
        {
            var _loc_4:* = param1.toByteArray();
            var _loc_5:* = new ByteArray();
            _loc_4.position = 0;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_4.length && _loc_4[_loc_6] == 0)
            {
                
                _loc_6++;
            }
            if (_loc_4.length - _loc_6 != (param2 - 1) || _loc_4[_loc_6] != param3)
            {
                trace("PKCS#1 unpad: i=" + _loc_6 + ", expected b[i]==" + param3 + ", got b[i]=" + _loc_4[_loc_6].toString(16));
                return null;
            }
            _loc_6++;
            while (_loc_4[_loc_6] != 0)
            {
                
                if (++_loc_6 >= _loc_4.length)
                {
                    trace("PKCS#1 unpad: i=" + ++_loc_6 + ", b[i-1]!=0 (=" + _loc_4[(_loc_6 - 1)].toString(16) + ")");
                    return null;
                }
            }
            while (++_loc_6 < _loc_4.length)
            {
                
                _loc_5.writeByte(_loc_4[_loc_6]);
            }
            _loc_5.position = 0;
            return _loc_5;
        }// end function

        public function rawpad(param1:ByteArray, param2:int, param3:uint, param4:uint = 0) : ByteArray
        {
            return param1;
        }// end function

        public function rawunpad(param1:BigInteger, param2:uint, param3:uint = 0) : ByteArray
        {
            return param1.toByteArray();
        }// end function

        public function toString() : String
        {
            return "rsa";
        }// end function

        public function dump() : String
        {
            var _loc_1:* = "N=" + this.n.toString(16) + "\n" + "E=" + this.e.toString(16) + "\n";
            if (this.canDecrypt)
            {
                _loc_1 = _loc_1 + ("D=" + this.d.toString(16) + "\n");
                if (this.p != null && this.q != null)
                {
                    _loc_1 = _loc_1 + ("P=" + this.p.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("Q=" + this.q.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("DMP1=" + this.dmp1.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("DMQ1=" + this.dmq1.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("IQMP=" + this.coeff.toString(16) + "\n");
                }
            }
            return _loc_1;
        }// end function

        protected function doPublic(param1:BigInteger) : BigInteger
        {
            return param1.modPowInt(this.e, this.n);
        }// end function

        protected function doPrivate2(param1:BigInteger) : BigInteger
        {
            if (this.p == null && this.q == null)
            {
                return param1.modPow(this.d, this.n);
            }
            var _loc_2:* = param1.mod(this.p).modPow(this.dmp1, this.p);
            var _loc_3:* = param1.mod(this.q).modPow(this.dmq1, this.q);
            while (_loc_2.compareTo(_loc_3) < 0)
            {
                
                _loc_2 = _loc_2.add(this.p);
            }
            var _loc_4:* = _loc_2.subtract(_loc_3).multiply(this.coeff).mod(this.p).multiply(this.q).add(_loc_3);
            return _loc_2.subtract(_loc_3).multiply(this.coeff).mod(this.p).multiply(this.q).add(_loc_3);
        }// end function

        protected function doPrivate(param1:BigInteger) : BigInteger
        {
            if (this.p == null || this.q == null)
            {
                return param1.modPow(this.d, this.n);
            }
            var _loc_2:* = param1.mod(this.p).modPow(this.dmp1, this.p);
            var _loc_3:* = param1.mod(this.q).modPow(this.dmq1, this.q);
            while (_loc_2.compareTo(_loc_3) < 0)
            {
                
                _loc_2 = _loc_2.add(this.p);
            }
            return _loc_2.subtract(_loc_3).multiply(this.coeff).mod(this.p).multiply(this.q).add(_loc_3);
        }// end function

        public static function parsePublicKey(param1:String, param2:String) : RSAKey
        {
            return new RSAKey(new BigInteger(param1, 16, true), parseInt(param2, 16));
        }// end function

        public static function parsePrivateKey(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null) : RSAKey
        {
            if (param4 == null)
            {
                return new RSAKey(new BigInteger(param1, 16, true), parseInt(param2, 16), new BigInteger(param3, 16, true));
            }
            return new RSAKey(new BigInteger(param1, 16, true), parseInt(param2, 16), new BigInteger(param3, 16, true), new BigInteger(param4, 16, true), new BigInteger(param5, 16, true), new BigInteger(param6, 16, true), new BigInteger(param7, 16, true), new BigInteger(param8, 16, true));
        }// end function

        public static function generate(param1:uint, param2:String) : RSAKey
        {
            var _loc_7:BigInteger = null;
            var _loc_8:BigInteger = null;
            var _loc_9:BigInteger = null;
            var _loc_10:BigInteger = null;
            var _loc_3:* = new Random();
            var _loc_4:* = param1 >> 1;
            var _loc_5:* = new RSAKey(null, 0, null);
            new RSAKey(null, 0, null).e = parseInt(param2, 16);
            var _loc_6:* = new BigInteger(param2, 16, true);
            while (true)
            {
                
                while (true)
                {
                    
                    _loc_5.p = bigRandom(param1 - _loc_4, _loc_3);
                    if (_loc_5.p.subtract(BigInteger.ONE).gcd(_loc_6).compareTo(BigInteger.ONE) == 0 && _loc_5.p.isProbablePrime(10))
                    {
                        break;
                    }
                }
                while (true)
                {
                    
                    _loc_5.q = bigRandom(_loc_4, _loc_3);
                    if (_loc_5.q.subtract(BigInteger.ONE).gcd(_loc_6).compareTo(BigInteger.ONE) == 0 && _loc_5.q.isProbablePrime(10))
                    {
                        break;
                    }
                }
                if (_loc_5.p.compareTo(_loc_5.q) <= 0)
                {
                    _loc_10 = _loc_5.p;
                    _loc_5.p = _loc_5.q;
                    _loc_5.q = _loc_10;
                }
                _loc_7 = _loc_5.p.subtract(BigInteger.ONE);
                _loc_8 = _loc_5.q.subtract(BigInteger.ONE);
                _loc_9 = _loc_7.multiply(_loc_8);
                if (_loc_9.gcd(_loc_6).compareTo(BigInteger.ONE) == 0)
                {
                    _loc_5.n = _loc_5.p.multiply(_loc_5.q);
                    _loc_5.d = _loc_6.modInverse(_loc_9);
                    _loc_5.dmp1 = _loc_5.d.mod(_loc_7);
                    _loc_5.dmq1 = _loc_5.d.mod(_loc_8);
                    _loc_5.coeff = _loc_5.q.modInverse(_loc_5.p);
                    break;
                }
            }
            return _loc_5;
        }// end function

        static function bigRandom(param1:int, param2:Random) : BigInteger
        {
            if (param1 < 2)
            {
                return BigInteger.nbv(1);
            }
            var _loc_3:* = new ByteArray();
            param2.nextBytes(_loc_3, param1 >> 3);
            _loc_3.position = 0;
            var _loc_4:* = new BigInteger(_loc_3, 0, true);
            new BigInteger(_loc_3, 0, true).primify(param1, 1);
            return _loc_4;
        }// end function

    }
}
