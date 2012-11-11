package com.hurlant.math
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class BigInteger extends Object
    {
        public var t:int;
        var s:int;
        var a:Array;
        public static const DB:int = 30;
        public static const DV:int = 1 << DB;
        public static const DM:int = DV - 1;
        public static const BI_FP:int = 52;
        public static const FV:Number = Math.pow(2, BI_FP);
        public static const F1:int = 22;
        public static const F2:int = 8;
        public static const ZERO:BigInteger = nbv(0);
        public static const ONE:BigInteger = nbv(1);
        public static const lowprimes:Array = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509];
        public static const lplim:int = (1 << 26) / lowprimes[(lowprimes.length - 1)];

        public function BigInteger(param1 = null, param2:int = 0, param3:Boolean = false)
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            this.a = new Array();
            if (param1 is String)
            {
                if (param2 && param2 != 16)
                {
                    throw new Error("BigInteger construction with radix!=16 is not supported.");
                }
                param1 = Hex.toArray(param1);
                param2 = 0;
            }
            if (param1 is ByteArray)
            {
                _loc_4 = param1 as ByteArray;
                _loc_5 = param2 || _loc_4.length - _loc_4.position;
                this.fromArray(_loc_4, _loc_5, param3);
            }
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = new Random();
            var _loc_2:* = 0;
            while (_loc_2 < this.a.length)
            {
                
                this.a[_loc_2] = _loc_1.nextByte();
                delete this.a[_loc_2];
                _loc_2 = _loc_2 + 1;
            }
            this.a = null;
            this.t = 0;
            this.s = 0;
            Memory.gc();
            return;
        }// end function

        public function toString(param1:Number = 16) : String
        {
            var _loc_2:* = 0;
            if (this.s < 0)
            {
                return "-" + this.negate().toString(param1);
            }
            switch(param1)
            {
                case 2:
                {
                    _loc_2 = 1;
                    break;
                }
                case 4:
                {
                    _loc_2 = 2;
                    break;
                }
                case 8:
                {
                    _loc_2 = 3;
                    break;
                }
                case 16:
                {
                    _loc_2 = 4;
                    break;
                }
                case 32:
                {
                    _loc_2 = 5;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:* = (1 << _loc_2) - 1;
            var _loc_4:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = "";
            var _loc_7:* = this.t;
            var _loc_8:* = DB - _loc_7 * DB % _loc_2;
            if (_loc_7-- > 0)
            {
                var _loc_9:* = this.a[_loc_7] >> _loc_8;
                _loc_4 = this.a[_loc_7] >> _loc_8;
                if (_loc_8 < DB && _loc_9 > 0)
                {
                    _loc_5 = true;
                    _loc_6 = _loc_4.toString(36);
                }
                while (_loc_7 >= 0)
                {
                    
                    if (_loc_8 < _loc_2)
                    {
                        _loc_4 = (this.a[_loc_7] & (1 << _loc_8) - 1) << _loc_2 - _loc_8;
                        var _loc_9:* = _loc_8 + (DB - _loc_2);
                        _loc_8 = _loc_8 + (DB - _loc_2);
                        _loc_4 = _loc_4 | this.a[--_loc_7] >> _loc_9;
                    }
                    else
                    {
                        var _loc_9:* = _loc_8 - _loc_2;
                        _loc_8 = _loc_8 - _loc_2;
                        _loc_4 = this.a[--_loc_7] >> _loc_9 & _loc_3;
                        if (_loc_8 <= 0)
                        {
                            _loc_8 = _loc_8 + DB;
                            _loc_7 = _loc_7 - 1;
                        }
                    }
                    if (_loc_4 > 0)
                    {
                        _loc_5 = true;
                    }
                    if (_loc_5)
                    {
                        _loc_6 = _loc_6 + _loc_4.toString(36);
                    }
                }
            }
            return _loc_5 ? (_loc_6) : ("0");
        }// end function

        public function toArray(param1:ByteArray) : uint
        {
            var _loc_2:* = 8;
            var _loc_3:* = (1 << 8) - 1;
            var _loc_4:* = 0;
            var _loc_5:* = this.t;
            var _loc_6:* = DB - _loc_5 * DB % _loc_2;
            var _loc_7:* = false;
            var _loc_8:* = 0;
            if (_loc_5-- > 0)
            {
                var _loc_9:* = this.a[_loc_5] >> _loc_6;
                _loc_4 = this.a[_loc_5] >> _loc_6;
                if (_loc_6 < DB && _loc_9 > 0)
                {
                    _loc_7 = true;
                    param1.writeByte(_loc_4);
                    _loc_8++;
                }
                while (_loc_5 >= 0)
                {
                    
                    if (_loc_6 < _loc_2)
                    {
                        _loc_4 = (this.a[_loc_5] & (1 << _loc_6) - 1) << _loc_2 - _loc_6;
                        var _loc_9:* = _loc_6 + (DB - _loc_2);
                        _loc_6 = _loc_6 + (DB - _loc_2);
                        _loc_4 = _loc_4 | this.a[--_loc_5] >> _loc_9;
                    }
                    else
                    {
                        var _loc_9:* = _loc_6 - _loc_2;
                        _loc_6 = _loc_6 - _loc_2;
                        _loc_4 = this.a[--_loc_5] >> _loc_9 & _loc_3;
                        if (_loc_6 <= 0)
                        {
                            _loc_6 = _loc_6 + DB;
                            _loc_5 = _loc_5 - 1;
                        }
                    }
                    if (_loc_4 > 0)
                    {
                        _loc_7 = true;
                    }
                    if (_loc_7)
                    {
                        param1.writeByte(_loc_4);
                        _loc_8++;
                    }
                }
            }
            return _loc_8;
        }// end function

        public function valueOf() : Number
        {
            if (this.s == -1)
            {
                return -this.negate().valueOf();
            }
            var _loc_1:* = 1;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this.t)
            {
                
                _loc_2 = _loc_2 + this.a[_loc_3] * _loc_1;
                _loc_1 = _loc_1 * DV;
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function negate() : BigInteger
        {
            var _loc_1:* = this.nbi();
            ZERO.subTo(this, _loc_1);
            return _loc_1;
        }// end function

        public function abs() : BigInteger
        {
            return this.s < 0 ? (this.negate()) : (this);
        }// end function

        public function compareTo(param1:BigInteger) : int
        {
            var _loc_2:* = this.s - param1.s;
            if (_loc_2 != 0)
            {
                return _loc_2;
            }
            var _loc_3:* = this.t;
            _loc_2 = _loc_3 - param1.t;
            if (_loc_2 != 0)
            {
                return _loc_2;
            }
            while (--_loc_3 >= 0)
            {
                
                _loc_2 = this.a[_loc_3] - param1.a[_loc_3];
                if (_loc_2 != 0)
                {
                    return _loc_2;
                }
            }
            return 0;
        }// end function

        function nbits(param1:int) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = 1;
            var _loc_4:* = param1 >>> 16;
            _loc_3 = param1 >>> 16;
            if (_loc_4 != 0)
            {
                param1 = _loc_3;
                _loc_2 = _loc_2 + 16;
            }
            var _loc_4:* = param1 >> 8;
            _loc_3 = param1 >> 8;
            if (_loc_4 != 0)
            {
                param1 = _loc_3;
                _loc_2 = _loc_2 + 8;
            }
            var _loc_4:* = param1 >> 4;
            _loc_3 = param1 >> 4;
            if (_loc_4 != 0)
            {
                param1 = _loc_3;
                _loc_2 = _loc_2 + 4;
            }
            var _loc_4:* = param1 >> 2;
            _loc_3 = param1 >> 2;
            if (_loc_4 != 0)
            {
                param1 = _loc_3;
                _loc_2 = _loc_2 + 2;
            }
            var _loc_4:* = param1 >> 1;
            _loc_3 = param1 >> 1;
            if (_loc_4 != 0)
            {
                param1 = _loc_3;
                _loc_2 = _loc_2 + 1;
            }
            return _loc_2;
        }// end function

        public function bitLength() : int
        {
            if (this.t <= 0)
            {
                return 0;
            }
            return DB * (this.t - 1) + this.nbits(this.a[(this.t - 1)] ^ this.s & DM);
        }// end function

        public function mod(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = this.nbi();
            this.abs().divRemTo(param1, null, _loc_2);
            if (this.s < 0 && _loc_2.compareTo(ZERO) > 0)
            {
                param1.subTo(_loc_2, _loc_2);
            }
            return _loc_2;
        }// end function

        public function modPowInt(param1:int, param2:BigInteger) : BigInteger
        {
            var _loc_3:* = null;
            if (param1 < 256 || param2.isEven())
            {
                _loc_3 = new ClassicReduction(param2);
            }
            else
            {
                _loc_3 = new MontgomeryReduction(param2);
            }
            return this.exp(param1, _loc_3);
        }// end function

        function copyTo(param1:BigInteger) : void
        {
            var _loc_2:* = this.t - 1;
            while (_loc_2 >= 0)
            {
                
                param1.a[_loc_2] = this.a[_loc_2];
                _loc_2 = _loc_2 - 1;
            }
            param1.t = this.t;
            param1.s = this.s;
            return;
        }// end function

        function fromInt(param1:int) : void
        {
            this.t = 1;
            this.s = param1 < 0 ? (-1) : (0);
            if (param1 > 0)
            {
                this.a[0] = param1;
            }
            else if (param1 < -1)
            {
                this.a[0] = param1 + DV;
            }
            else
            {
                this.t = 0;
            }
            return;
        }// end function

        function fromArray(param1:ByteArray, param2:int, param3:Boolean = false) : void
        {
            var _loc_8:* = 0;
            var _loc_4:* = param1.position;
            var _loc_5:* = param1.position + param2;
            var _loc_6:* = 0;
            var _loc_7:* = 8;
            this.t = 0;
            this.s = 0;
            while (--_loc_5 >= _loc_4)
            {
                
                _loc_8 = _loc_5 < param1.length ? (param1[_loc_5]) : (0);
                if (_loc_6 == 0)
                {
                    var _loc_10:* = this;
                    _loc_10.t = this.t + 1;
                    this.a[++this.t] = _loc_8;
                }
                else if (_loc_6 + _loc_7 > DB)
                {
                    this.a[(this.t - 1)] = this.a[(this.t - 1)] | (_loc_8 & (1 << DB - _loc_6) - 1) << _loc_6;
                    var _loc_10:* = this;
                    _loc_10.t = this.t + 1;
                    this.a[++this.t] = _loc_8 >> DB - _loc_6;
                }
                else
                {
                    this.a[(this.t - 1)] = this.a[(this.t - 1)] | _loc_8 << _loc_6;
                }
                _loc_6 = _loc_6 + _loc_7;
                if (_loc_6 >= DB)
                {
                    _loc_6 = _loc_6 - DB;
                }
            }
            if (!param3 && (param1[0] & 128) == 128)
            {
                this.s = -1;
                if (_loc_6 > 0)
                {
                    this.a[(this.t - 1)] = this.a[(this.t - 1)] | (1 << DB - _loc_6) - 1 << _loc_6;
                }
            }
            this.clamp();
            param1.position = Math.min(_loc_4 + param2, param1.length);
            return;
        }// end function

        function clamp() : void
        {
            var _loc_1:* = this.s & DM;
            while (this.t > 0 && this.a[(this.t - 1)] == _loc_1)
            {
                
                var _loc_2:* = this;
                var _loc_3:* = this.t - 1;
                _loc_2.t = _loc_3;
            }
            return;
        }// end function

        function dlShiftTo(param1:int, param2:BigInteger) : void
        {
            var _loc_3:* = 0;
            _loc_3 = this.t - 1;
            while (_loc_3 >= 0)
            {
                
                param2.a[_loc_3 + param1] = this.a[_loc_3];
                _loc_3 = _loc_3 - 1;
            }
            _loc_3 = param1 - 1;
            while (_loc_3 >= 0)
            {
                
                param2.a[_loc_3] = 0;
                _loc_3 = _loc_3 - 1;
            }
            param2.t = this.t + param1;
            param2.s = this.s;
            return;
        }// end function

        function drShiftTo(param1:int, param2:BigInteger) : void
        {
            var _loc_3:* = 0;
            _loc_3 = param1;
            while (_loc_3 < this.t)
            {
                
                param2.a[_loc_3 - param1] = this.a[_loc_3];
                _loc_3++;
            }
            param2.t = Math.max(this.t - param1, 0);
            param2.s = this.s;
            return;
        }// end function

        function lShiftTo(param1:int, param2:BigInteger) : void
        {
            var _loc_8:* = 0;
            var _loc_3:* = param1 % DB;
            var _loc_4:* = DB - _loc_3;
            var _loc_5:* = (1 << _loc_4) - 1;
            var _loc_6:* = param1 / DB;
            var _loc_7:* = this.s << _loc_3 & DM;
            _loc_8 = this.t - 1;
            while (_loc_8 >= 0)
            {
                
                param2.a[_loc_8 + _loc_6 + 1] = this.a[_loc_8] >> _loc_4 | _loc_7;
                _loc_7 = (this.a[_loc_8] & _loc_5) << _loc_3;
                _loc_8 = _loc_8 - 1;
            }
            _loc_8 = _loc_6 - 1;
            while (_loc_8 >= 0)
            {
                
                param2.a[_loc_8] = 0;
                _loc_8 = _loc_8 - 1;
            }
            param2.a[_loc_6] = _loc_7;
            param2.t = this.t + _loc_6 + 1;
            param2.s = this.s;
            param2.clamp();
            return;
        }// end function

        function rShiftTo(param1:int, param2:BigInteger) : void
        {
            var _loc_7:* = 0;
            param2.s = this.s;
            var _loc_3:* = param1 / DB;
            if (_loc_3 >= this.t)
            {
                param2.t = 0;
                return;
            }
            var _loc_4:* = param1 % DB;
            var _loc_5:* = DB - _loc_4;
            var _loc_6:* = (1 << _loc_4) - 1;
            param2.a[0] = this.a[_loc_3] >> _loc_4;
            _loc_7 = _loc_3 + 1;
            while (_loc_7 < this.t)
            {
                
                param2.a[_loc_7 - _loc_3 - 1] = param2.a[_loc_7 - _loc_3 - 1] | (this.a[_loc_7] & _loc_6) << _loc_5;
                param2.a[_loc_7 - _loc_3] = this.a[_loc_7] >> _loc_4;
                _loc_7++;
            }
            if (_loc_4 > 0)
            {
                param2.a[this.t - _loc_3 - 1] = param2.a[this.t - _loc_3 - 1] | (this.s & _loc_6) << _loc_5;
            }
            param2.t = this.t - _loc_3;
            param2.clamp();
            return;
        }// end function

        function subTo(param1:BigInteger, param2:BigInteger) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = Math.min(param1.t, this.t);
            while (_loc_3 < _loc_5)
            {
                
                _loc_4 = _loc_4 + (this.a[_loc_3] - param1.a[_loc_3]);
                param2.a[++_loc_3] = _loc_4 & DM;
                _loc_4 = _loc_4 >> DB;
            }
            if (param1.t < this.t)
            {
                _loc_4 = _loc_4 - param1.s;
                while (_loc_3 < this.t)
                {
                    
                    _loc_4 = _loc_4 + this.a[_loc_3];
                    param2.a[++_loc_3] = _loc_4 & DM;
                    _loc_4 = _loc_4 >> DB;
                }
                _loc_4 = _loc_4 + this.s;
            }
            else
            {
                _loc_4 = _loc_4 + this.s;
                while (_loc_3 < param1.t)
                {
                    
                    _loc_4 = _loc_4 - param1.a[_loc_3];
                    param2.a[++_loc_3] = _loc_4 & DM;
                    _loc_4 = _loc_4 >> DB;
                }
                _loc_4 = _loc_4 - param1.s;
            }
            param2.s = _loc_4 < 0 ? (-1) : (0);
            if (_loc_4 < -1)
            {
                param2.a[++_loc_3] = DV + _loc_4;
            }
            else if (_loc_4 > 0)
            {
                param2.a[++_loc_3] = _loc_4;
            }
            param2.t = _loc_3;
            param2.clamp();
            return;
        }// end function

        function am(param1:int, param2:int, param3:BigInteger, param4:int, param5:int, param6:int) : int
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_7:* = param2 & 32767;
            var _loc_8:* = param2 >> 15;
            while (--param6 >= 0)
            {
                
                _loc_9 = this.a[param1] & 32767;
                _loc_10 = this.a[param1++] >> 15;
                _loc_11 = _loc_8 * _loc_9 + _loc_10 * _loc_7;
                _loc_9 = _loc_7 * _loc_9 + ((_loc_11 & 32767) << 15) + param3.a[param4] + (param5 & 1073741823);
                param5 = (_loc_9 >>> 30) + (_loc_11 >>> 15) + _loc_8 * _loc_10 + (param5 >>> 30);
                param3.a[++param4] = _loc_9 & 1073741823;
            }
            return param5;
        }// end function

        function multiplyTo(param1:BigInteger, param2:BigInteger) : void
        {
            var _loc_3:* = this.abs();
            var _loc_4:* = param1.abs();
            var _loc_5:* = _loc_3.t;
            param2.t = _loc_5 + _loc_4.t;
            while (--_loc_5 >= 0)
            {
                
                param2.a[_loc_5] = 0;
            }
            --_loc_5 = 0;
            while (_loc_5 < _loc_4.t)
            {
                
                param2.a[--_loc_5 + _loc_3.t] = _loc_3.am(0, _loc_4.a[_loc_5], param2, _loc_5, 0, _loc_3.t);
                _loc_5++;
            }
            param2.s = 0;
            param2.clamp();
            if (this.s != param1.s)
            {
                ZERO.subTo(param2, param2);
            }
            return;
        }// end function

        function squareTo(param1:BigInteger) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = this.abs();
            var _loc_5:* = 2 * _loc_2.t;
            param1.t = 2 * _loc_2.t;
            var _loc_3:* = _loc_5;
            while (--_loc_3 >= 0)
            {
                
                param1.a[_loc_3] = 0;
            }
            --_loc_3 = 0;
            while (_loc_3 < (_loc_2.t - 1))
            {
                
                _loc_4 = _loc_2.am(--_loc_3, _loc_2.a[--_loc_3], param1, 2 * _loc_3, 0, 1);
                var _loc_5:* = param1.a[_loc_3 + _loc_2.t] + _loc_2.am((_loc_3 + 1), 2 * _loc_2.a[_loc_3], param1, 2 * _loc_3 + 1, _loc_4, _loc_2.t - _loc_3 - 1);
                param1.a[_loc_3 + _loc_2.t] = param1.a[_loc_3 + _loc_2.t] + _loc_2.am((_loc_3 + 1), 2 * _loc_2.a[_loc_3], param1, 2 * _loc_3 + 1, _loc_4, _loc_2.t - _loc_3 - 1);
                if (_loc_5 >= DV)
                {
                    param1.a[_loc_3 + _loc_2.t] = param1.a[_loc_3 + _loc_2.t] - DV;
                    param1.a[_loc_3 + _loc_2.t + 1] = 1;
                }
                _loc_3++;
            }
            if (param1.t > 0)
            {
                param1.a[(param1.t - 1)] = param1.a[(param1.t - 1)] + _loc_2.am(_loc_3, _loc_2.a[_loc_3], param1, 2 * _loc_3, 0, 1);
            }
            param1.s = 0;
            param1.clamp();
            return;
        }// end function

        function divRemTo(param1:BigInteger, param2:BigInteger = null, param3:BigInteger = null) : void
        {
            var qd:int;
            var m:* = param1;
            var q:* = param2;
            var r:* = param3;
            var pm:* = m.abs();
            if (pm.t <= 0)
            {
                return;
            }
            var pt:* = this.abs();
            if (pt.t < pm.t)
            {
                if (q != null)
                {
                    q.fromInt(0);
                }
                if (r != null)
                {
                    this.copyTo(r);
                }
                return;
            }
            if (r == null)
            {
                r = this.nbi();
            }
            var y:* = this.nbi();
            var ts:* = this.s;
            var ms:* = m.s;
            var nsh:* = DB - this.nbits(pm.a[(pm.t - 1)]);
            if (nsh > 0)
            {
                pm.lShiftTo(nsh, y);
                pt.lShiftTo(nsh, r);
            }
            else
            {
                pm.copyTo(y);
                pt.copyTo(r);
            }
            var ys:* = y.t;
            var y0:* = y.a[(ys - 1)];
            if (y0 == 0)
            {
                return;
            }
            var yt:* = y0 * (1 << F1) + (ys > 1 ? (y.a[ys - 2] >> F2) : (0));
            var d1:* = FV / yt;
            var d2:* = (1 << F1) / yt;
            var e:* = 1 << F2;
            var i:* = r.t;
            var j:* = i - ys;
            var t:* = q == null ? (this.nbi()) : (q);
            y.dlShiftTo(j, t);
            if (r.compareTo(t) >= 0)
            {
                var _loc_6:* = r;
                _loc_6.t = r.t + 1;
                r.a[++r.t] = 1;
                r.subTo(t, r);
            }
            ONE.dlShiftTo(ys, t);
            t.subTo(y, y);
            while (y.t < ys)
            {
                
                var _loc_6:* = 0;
                var _loc_7:* = y;
                var _loc_5:* = new XMLList("");
                for each (_loc_8 in _loc_7)
                {
                    
                    var _loc_9:* = _loc_7[_loc_6];
                    with (_loc_7[_loc_6])
                    {
                        var _loc_10:* = y;
                        var _loc_11:* = y.t + 1;
                        _loc_10.t = _loc_11;
                        if (0)
                        {
                            _loc_5[_loc_6] = _loc_8;
                        }
                    }
                }
            }
            do
            {
                
                i = (i - 1);
                qd = r.a[(i - 1)] == y0 ? (DM) : (Number(r.a[i]) * d1 + (Number(r.a[(i - 1)]) + e) * d2);
                var _loc_5:* = r.a[i] + y.am(0, qd, r, j, 0, ys);
                r.a[i] = r.a[i] + y.am(0, qd, r, j, 0, ys);
                if (_loc_5 < qd)
                {
                    y.dlShiftTo(j, t);
                    r.subTo(t, r);
                    do
                    {
                        
                        r.subTo(t, r);
                        qd = (qd - 1);
                    }while (r.a[i] < (qd - 1))
                }
                j = (j - 1);
            }while ((j - 1) >= 0)
            if (q != null)
            {
                r.drShiftTo(ys, q);
                if (ts != ms)
                {
                    ZERO.subTo(q, q);
                }
            }
            r.t = ys;
            r.clamp();
            if (nsh > 0)
            {
                r.rShiftTo(nsh, r);
            }
            if (ts < 0)
            {
                ZERO.subTo(r, r);
            }
            return;
        }// end function

        function invDigit() : int
        {
            if (this.t < 1)
            {
                return 0;
            }
            var _loc_1:* = this.a[0];
            if ((_loc_1 & 1) == 0)
            {
                return 0;
            }
            var _loc_2:* = _loc_1 & 3;
            _loc_2 = _loc_2 * (2 - (_loc_1 & 15) * _loc_2) & 15;
            _loc_2 = _loc_2 * (2 - (_loc_1 & 255) * _loc_2) & 255;
            _loc_2 = _loc_2 * (2 - ((_loc_1 & 65535) * _loc_2 & 65535)) & 65535;
            _loc_2 = _loc_2 * (2 - _loc_1 * _loc_2 % DV) % DV;
            return _loc_2 > 0 ? (DV - _loc_2) : (-_loc_2);
        }// end function

        function isEven() : Boolean
        {
            return (this.t > 0 ? (this.a[0] & 1) : (this.s)) == 0;
        }// end function

        function exp(param1:int, param2:IReduction) : BigInteger
        {
            var _loc_7:* = null;
            if (param1 > 4294967295 || param1 < 1)
            {
                return ONE;
            }
            var _loc_3:* = this.nbi();
            var _loc_4:* = this.nbi();
            var _loc_5:* = param2.convert(this);
            var _loc_6:* = this.nbits(param1) - 1;
            _loc_5.copyTo(_loc_3);
            while (--_loc_6 >= 0)
            {
                
                param2.sqrTo(_loc_3, _loc_4);
                if ((param1 & 1 << _loc_6) > 0)
                {
                    param2.mulTo(_loc_4, _loc_5, _loc_3);
                    continue;
                }
                _loc_7 = _loc_3;
                _loc_3 = _loc_4;
                _loc_4 = _loc_7;
            }
            return param2.revert(_loc_3);
        }// end function

        function intAt(param1:String, param2:int) : int
        {
            return parseInt(param1.charAt(param2), 36);
        }// end function

        protected function nbi()
        {
            return new BigInteger();
        }// end function

        public function clone() : BigInteger
        {
            var _loc_1:* = new BigInteger();
            this.copyTo(_loc_1);
            return _loc_1;
        }// end function

        public function intValue() : int
        {
            if (this.s < 0)
            {
                if (this.t == 1)
                {
                    return this.a[0] - DV;
                }
                if (this.t == 0)
                {
                    return -1;
                }
            }
            else
            {
                if (this.t == 1)
                {
                    return this.a[0];
                }
                if (this.t == 0)
                {
                    return 0;
                }
            }
            return (this.a[1] & (1 << 32 - DB) - 1) << DB | this.a[0];
        }// end function

        public function byteValue() : int
        {
            return this.t == 0 ? (this.s) : (this.a[0] << 24 >> 24);
        }// end function

        public function shortValue() : int
        {
            return this.t == 0 ? (this.s) : (this.a[0] << 16 >> 16);
        }// end function

        protected function chunkSize(param1:Number) : int
        {
            return Math.floor(Math.LN2 * DB / Math.log(param1));
        }// end function

        public function sigNum() : int
        {
            if (this.s < 0)
            {
                return -1;
            }
            if (this.t <= 0 || this.t == 1 && this.a[0] <= 0)
            {
                return 0;
            }
            return 1;
        }// end function

        protected function toRadix(param1:uint = 10) : String
        {
            if (this.sigNum() == 0 || param1 < 2 || param1 > 32)
            {
                return "0";
            }
            var _loc_2:* = this.chunkSize(param1);
            var _loc_3:* = Math.pow(param1, _loc_2);
            var _loc_4:* = nbv(_loc_3);
            var _loc_5:* = this.nbi();
            var _loc_6:* = this.nbi();
            var _loc_7:* = "";
            this.divRemTo(_loc_4, _loc_5, _loc_6);
            while (_loc_5.sigNum() > 0)
            {
                
                _loc_7 = (_loc_3 + _loc_6.intValue()).toString(param1).substr(1) + _loc_7;
                _loc_5.divRemTo(_loc_4, _loc_5, _loc_6);
            }
            return _loc_6.intValue().toString(param1) + _loc_7;
        }// end function

        protected function fromRadix(param1:String, param2:int = 10) : void
        {
            var _loc_9:* = 0;
            this.fromInt(0);
            var _loc_3:* = this.chunkSize(param2);
            var _loc_4:* = Math.pow(param2, _loc_3);
            var _loc_5:* = false;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            while (_loc_8 < param1.length)
            {
                
                _loc_9 = this.intAt(param1, _loc_8);
                if (_loc_9 < 0)
                {
                    if (param1.charAt(_loc_8) == "-" && this.sigNum() == 0)
                    {
                        _loc_5 = true;
                    }
                }
                else
                {
                    _loc_7 = param2 * _loc_7 + _loc_9;
                    if (++_loc_6 >= _loc_3)
                    {
                        this.dMultiply(_loc_4);
                        this.dAddOffset(_loc_7, 0);
                        ++_loc_6 = 0;
                        _loc_7 = 0;
                    }
                }
                _loc_8++;
            }
            if (++_loc_6 > 0)
            {
                this.dMultiply(Math.pow(param2, _loc_6));
                this.dAddOffset(_loc_7, 0);
            }
            if (_loc_5)
            {
                BigInteger.ZERO.subTo(this, this);
            }
            return;
        }// end function

        public function toByteArray() : ByteArray
        {
            var _loc_4:* = 0;
            var _loc_1:* = this.t;
            var _loc_2:* = new ByteArray();
            _loc_2[0] = this.s;
            var _loc_3:* = DB - _loc_1 * DB % 8;
            var _loc_5:* = 0;
            if (_loc_1-- > 0)
            {
                var _loc_6:* = this.a[_loc_1] >> _loc_3;
                _loc_4 = this.a[_loc_1] >> _loc_3;
                if (_loc_3 < DB && _loc_6 != (this.s & DM) >> _loc_3)
                {
                    _loc_2[++_loc_5] = _loc_4 | this.s << DB - _loc_3;
                }
                while (_loc_1 >= 0)
                {
                    
                    if (_loc_3 < 8)
                    {
                        _loc_4 = (this.a[_loc_1] & (1 << _loc_3) - 1) << 8 - _loc_3;
                        var _loc_6:* = _loc_3 + (DB - 8);
                        _loc_3 = _loc_3 + (DB - 8);
                        _loc_4 = _loc_4 | this.a[--_loc_1] >> _loc_6;
                    }
                    else
                    {
                        var _loc_6:* = _loc_3 - 8;
                        _loc_3 = _loc_3 - 8;
                        _loc_4 = this.a[--_loc_1] >> _loc_6 & 255;
                        if (_loc_3 <= 0)
                        {
                            _loc_3 = _loc_3 + DB;
                            _loc_1 = _loc_1 - 1;
                        }
                    }
                    if ((_loc_4 & 128) != 0)
                    {
                        _loc_4 = _loc_4 | -256;
                    }
                    if (_loc_5 == 0 && (this.s & 128) != (_loc_4 & 128))
                    {
                        _loc_5++;
                    }
                    if (_loc_5 > 0 || _loc_4 != this.s)
                    {
                        _loc_2[++_loc_5] = _loc_4;
                    }
                }
            }
            return _loc_2;
        }// end function

        public function equals(param1:BigInteger) : Boolean
        {
            return this.compareTo(param1) == 0;
        }// end function

        public function min(param1:BigInteger) : BigInteger
        {
            return this.compareTo(param1) < 0 ? (this) : (param1);
        }// end function

        public function max(param1:BigInteger) : BigInteger
        {
            return this.compareTo(param1) > 0 ? (this) : (param1);
        }// end function

        protected function bitwiseTo(param1:BigInteger, param2:Function, param3:BigInteger) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = Math.min(param1.t, this.t);
            _loc_4 = 0;
            while (_loc_4 < _loc_6)
            {
                
                param3.a[_loc_4] = this.param2(this.a[_loc_4], param1.a[_loc_4]);
                _loc_4++;
            }
            if (param1.t < this.t)
            {
                _loc_5 = param1.s & DM;
                _loc_4 = _loc_6;
                while (_loc_4 < this.t)
                {
                    
                    param3.a[_loc_4] = this.param2(this.a[_loc_4], _loc_5);
                    _loc_4++;
                }
                param3.t = this.t;
            }
            else
            {
                _loc_5 = this.s & DM;
                _loc_4 = _loc_6;
                while (_loc_4 < param1.t)
                {
                    
                    param3.a[_loc_4] = this.param2(_loc_5, param1.a[_loc_4]);
                    _loc_4++;
                }
                param3.t = param1.t;
            }
            param3.s = this.param2(this.s, param1.s);
            param3.clamp();
            return;
        }// end function

        private function op_and(param1:int, param2:int) : int
        {
            return param1 & param2;
        }// end function

        public function and(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.bitwiseTo(param1, this.op_and, _loc_2);
            return _loc_2;
        }// end function

        private function op_or(param1:int, param2:int) : int
        {
            return param1 | param2;
        }// end function

        public function or(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.bitwiseTo(param1, this.op_or, _loc_2);
            return _loc_2;
        }// end function

        private function op_xor(param1:int, param2:int) : int
        {
            return param1 ^ param2;
        }// end function

        public function xor(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.bitwiseTo(param1, this.op_xor, _loc_2);
            return _loc_2;
        }// end function

        private function op_andnot(param1:int, param2:int) : int
        {
            return param1 & ~param2;
        }// end function

        public function andNot(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.bitwiseTo(param1, this.op_andnot, _loc_2);
            return _loc_2;
        }// end function

        public function not() : BigInteger
        {
            var _loc_1:* = new BigInteger();
            var _loc_2:* = 0;
            while (_loc_2 < this.t)
            {
                
                _loc_1[_loc_2] = DM & ~this.a[_loc_2];
                _loc_2++;
            }
            _loc_1.t = this.t;
            _loc_1.s = ~this.s;
            return _loc_1;
        }// end function

        public function shiftLeft(param1:int) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            if (param1 < 0)
            {
                this.rShiftTo(-param1, _loc_2);
            }
            else
            {
                this.lShiftTo(param1, _loc_2);
            }
            return _loc_2;
        }// end function

        public function shiftRight(param1:int) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            if (param1 < 0)
            {
                this.lShiftTo(-param1, _loc_2);
            }
            else
            {
                this.rShiftTo(param1, _loc_2);
            }
            return _loc_2;
        }// end function

        private function lbit(param1:int) : int
        {
            if (param1 == 0)
            {
                return -1;
            }
            var _loc_2:* = 0;
            if ((param1 & 65535) == 0)
            {
                param1 = param1 >> 16;
                _loc_2 = _loc_2 + 16;
            }
            if ((param1 & 255) == 0)
            {
                param1 = param1 >> 8;
                _loc_2 = _loc_2 + 8;
            }
            if ((param1 & 15) == 0)
            {
                param1 = param1 >> 4;
                _loc_2 = _loc_2 + 4;
            }
            if ((param1 & 3) == 0)
            {
                param1 = param1 >> 2;
                _loc_2 = _loc_2 + 2;
            }
            if ((param1 & 1) == 0)
            {
                _loc_2++;
            }
            return _loc_2;
        }// end function

        public function getLowestSetBit() : int
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.t)
            {
                
                if (this.a[_loc_1] != 0)
                {
                    return _loc_1 * DB + this.lbit(this.a[_loc_1]);
                }
                _loc_1++;
            }
            if (this.s < 0)
            {
                return this.t * DB;
            }
            return -1;
        }// end function

        private function cbit(param1:int) : int
        {
            var _loc_2:* = 0;
            while (param1 != 0)
            {
                
                param1 = param1 & (param1 - 1);
                _loc_2 = _loc_2 + 1;
            }
            return _loc_2;
        }// end function

        public function bitCount() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = this.s & DM;
            var _loc_3:* = 0;
            while (_loc_3 < this.t)
            {
                
                _loc_1 = _loc_1 + this.cbit(this.a[_loc_3] ^ _loc_2);
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function testBit(param1:int) : Boolean
        {
            var _loc_2:* = Math.floor(param1 / DB);
            if (_loc_2 >= this.t)
            {
                return this.s != 0;
            }
            return (this.a[_loc_2] & 1 << param1 % DB) != 0;
        }// end function

        protected function changeBit(param1:int, param2:Function) : BigInteger
        {
            var _loc_3:* = BigInteger.ONE.shiftLeft(param1);
            this.bitwiseTo(_loc_3, param2, _loc_3);
            return _loc_3;
        }// end function

        public function setBit(param1:int) : BigInteger
        {
            return this.changeBit(param1, this.op_or);
        }// end function

        public function clearBit(param1:int) : BigInteger
        {
            return this.changeBit(param1, this.op_andnot);
        }// end function

        public function flipBit(param1:int) : BigInteger
        {
            return this.changeBit(param1, this.op_xor);
        }// end function

        protected function addTo(param1:BigInteger, param2:BigInteger) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = Math.min(param1.t, this.t);
            while (_loc_3 < _loc_5)
            {
                
                _loc_4 = _loc_4 + (this.a[_loc_3] + param1.a[_loc_3]);
                param2.a[++_loc_3] = _loc_4 & DM;
                _loc_4 = _loc_4 >> DB;
            }
            if (param1.t < this.t)
            {
                _loc_4 = _loc_4 + param1.s;
                while (_loc_3 < this.t)
                {
                    
                    _loc_4 = _loc_4 + this.a[_loc_3];
                    param2.a[++_loc_3] = _loc_4 & DM;
                    _loc_4 = _loc_4 >> DB;
                }
                _loc_4 = _loc_4 + this.s;
            }
            else
            {
                _loc_4 = _loc_4 + this.s;
                while (_loc_3 < param1.t)
                {
                    
                    _loc_4 = _loc_4 + param1.a[_loc_3];
                    param2.a[++_loc_3] = _loc_4 & DM;
                    _loc_4 = _loc_4 >> DB;
                }
                _loc_4 = _loc_4 + param1.s;
            }
            param2.s = _loc_4 < 0 ? (-1) : (0);
            if (_loc_4 > 0)
            {
                param2.a[++_loc_3] = _loc_4;
            }
            else if (_loc_4 < -1)
            {
                param2.a[++_loc_3] = DV + _loc_4;
            }
            param2.t = _loc_3;
            param2.clamp();
            return;
        }// end function

        public function add(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.addTo(param1, _loc_2);
            return _loc_2;
        }// end function

        public function subtract(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.subTo(param1, _loc_2);
            return _loc_2;
        }// end function

        public function multiply(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.multiplyTo(param1, _loc_2);
            return _loc_2;
        }// end function

        public function divide(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.divRemTo(param1, _loc_2, null);
            return _loc_2;
        }// end function

        public function remainder(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            this.divRemTo(param1, null, _loc_2);
            return _loc_2;
        }// end function

        public function divideAndRemainder(param1:BigInteger) : Array
        {
            var _loc_2:* = new BigInteger();
            var _loc_3:* = new BigInteger();
            this.divRemTo(param1, _loc_2, _loc_3);
            return [_loc_2, _loc_3];
        }// end function

        function dMultiply(param1:int) : void
        {
            this.a[this.t] = this.am(0, (param1 - 1), this, 0, 0, this.t);
            var _loc_2:* = this;
            var _loc_3:* = this.t + 1;
            _loc_2.t = _loc_3;
            this.clamp();
            return;
        }// end function

        function dAddOffset(param1:int, param2:int) : void
        {
            while (this.t <= param2)
            {
                
                var _loc_4:* = this;
                _loc_4.t = this.t + 1;
                var _loc_3:* = this.t + 1;
                this.a[_loc_3] = 0;
            }
            this.a[param2] = this.a[param2] + param1;
            while (this.a[_loc_2] >= DV)
            {
                
                this.a[param2] = this.a[param2] - DV;
                if (++param2 >= this.t)
                {
                    var _loc_4:* = this;
                    _loc_4.t = this.t + 1;
                    var _loc_3:* = this.t + 1;
                    this.a[_loc_3] = 0;
                }
                var _loc_3:* = this.a;
                var _loc_5:* = this.a[++param2] + 1;
                _loc_3[++param2] = _loc_5;
            }
            return;
        }// end function

        public function pow(param1:int) : BigInteger
        {
            return this.exp(param1, new NullReduction());
        }// end function

        function multiplyLowerTo(param1:BigInteger, param2:int, param3:BigInteger) : void
        {
            var _loc_5:* = 0;
            var _loc_4:* = Math.min(this.t + param1.t, param2);
            param3.s = 0;
            param3.t = _loc_4;
            while (--_loc_4 > 0)
            {
                
                param3.a[--_loc_4] = 0;
            }
            _loc_5 = param3.t - this.t;
            while (_loc_4 < _loc_5)
            {
                
                param3.a[_loc_4 + this.t] = this.am(0, param1.a[_loc_4], param3, _loc_4, 0, this.t);
                _loc_4++;
            }
            _loc_5 = Math.min(param1.t, param2);
            while (_loc_4 < _loc_5)
            {
                
                this.am(0, param1.a[_loc_4], param3, _loc_4, 0, param2 - _loc_4);
                _loc_4++;
            }
            param3.clamp();
            return;
        }// end function

        function multiplyUpperTo(param1:BigInteger, param2:int, param3:BigInteger) : void
        {
            param2 = param2 - 1;
            var _loc_5:* = this.t + param1.t - param2;
            param3.t = this.t + param1.t - param2;
            var _loc_4:* = _loc_5;
            param3.s = 0;
            while (--_loc_4 >= 0)
            {
                
                param3.a[_loc_4] = 0;
            }
            --_loc_4 = Math.max(param2 - this.t, 0);
            while (_loc_4 < param1.t)
            {
                
                param3.a[this.t + --_loc_4 - param2] = this.am(param2 - _loc_4, param1.a[_loc_4], param3, 0, 0, this.t + _loc_4 - param2);
                _loc_4++;
            }
            param3.clamp();
            param3.drShiftTo(1, param3);
            return;
        }// end function

        public function modPow(param1:BigInteger, param2:BigInteger) : BigInteger
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_12:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_3:* = param1.bitLength();
            var _loc_5:* = nbv(1);
            if (_loc_3 <= 0)
            {
                return _loc_5;
            }
            if (_loc_3 < 18)
            {
                _loc_4 = 1;
            }
            else if (_loc_3 < 48)
            {
                _loc_4 = 3;
            }
            else if (_loc_3 < 144)
            {
                _loc_4 = 4;
            }
            else if (_loc_3 < 768)
            {
                _loc_4 = 5;
            }
            else
            {
                _loc_4 = 6;
            }
            if (_loc_3 < 8)
            {
                _loc_6 = new ClassicReduction(param2);
            }
            else if (param2.isEven())
            {
                _loc_6 = new BarrettReduction(param2);
            }
            else
            {
                _loc_6 = new MontgomeryReduction(param2);
            }
            var _loc_7:* = [];
            var _loc_8:* = 3;
            var _loc_9:* = _loc_4 - 1;
            var _loc_10:* = (1 << _loc_4) - 1;
            _loc_7[1] = _loc_6.convert(this);
            if (_loc_4 > 1)
            {
                _loc_16 = new BigInteger();
                _loc_6.sqrTo(_loc_7[1], _loc_16);
                while (_loc_8 <= _loc_10)
                {
                    
                    _loc_7[_loc_8] = new BigInteger();
                    _loc_6.mulTo(_loc_16, _loc_7[_loc_8 - 2], _loc_7[_loc_8]);
                    _loc_8 = _loc_8 + 2;
                }
            }
            var _loc_11:* = param1.t - 1;
            var _loc_13:* = true;
            var _loc_14:* = new BigInteger();
            _loc_3 = this.nbits(param1.a[_loc_11]) - 1;
            while (_loc_11 >= 0)
            {
                
                if (_loc_3 >= _loc_9)
                {
                    _loc_12 = param1.a[_loc_11] >> _loc_3 - _loc_9 & _loc_10;
                }
                else
                {
                    _loc_12 = (param1.a[_loc_11] & (1 << (_loc_3 + 1)) - 1) << _loc_9 - _loc_3;
                    if (_loc_11 > 0)
                    {
                        _loc_12 = _loc_12 | param1.a[(_loc_11 - 1)] >> DB + _loc_3 - _loc_9;
                    }
                }
                _loc_8 = _loc_4;
                while ((_loc_12 & 1) == 0)
                {
                    
                    _loc_12 = _loc_12 >> 1;
                    _loc_8 = _loc_8 - 1;
                }
                var _loc_17:* = _loc_3 - _loc_8;
                _loc_3 = _loc_3 - _loc_8;
                if (_loc_17 < 0)
                {
                    _loc_3 = _loc_3 + DB;
                    _loc_11 = _loc_11 - 1;
                }
                if (_loc_13)
                {
                    _loc_7[_loc_12].copyTo(_loc_5);
                    _loc_13 = false;
                }
                else
                {
                    while (_loc_8 > 1)
                    {
                        
                        _loc_6.sqrTo(_loc_5, _loc_14);
                        _loc_6.sqrTo(_loc_14, _loc_5);
                        _loc_8 = _loc_8 - 2;
                    }
                    if (_loc_8 > 0)
                    {
                        _loc_6.sqrTo(_loc_5, _loc_14);
                    }
                    else
                    {
                        _loc_15 = _loc_5;
                        _loc_5 = _loc_14;
                        _loc_14 = _loc_15;
                    }
                    _loc_6.mulTo(_loc_14, _loc_7[_loc_12], _loc_5);
                }
                while (_loc_11 >= 0 && (param1.a[_loc_11] & 1 << --_loc_3) == 0)
                {
                    
                    _loc_6.sqrTo(_loc_5, _loc_14);
                    _loc_15 = _loc_5;
                    _loc_5 = _loc_14;
                    _loc_14 = _loc_15;
                    if (--_loc_3 < 0)
                    {
                        --_loc_3 = DB - 1;
                        _loc_11 = _loc_11 - 1;
                    }
                }
            }
            return _loc_6.revert(_loc_5);
        }// end function

        public function gcd(param1:BigInteger) : BigInteger
        {
            var _loc_6:* = null;
            var _loc_2:* = this.s < 0 ? (this.negate()) : (this.clone());
            var _loc_3:* = param1.s < 0 ? (param1.negate()) : (param1.clone());
            if (_loc_2.compareTo(_loc_3) < 0)
            {
                _loc_6 = _loc_2;
                _loc_2 = _loc_3;
                _loc_3 = _loc_6;
            }
            var _loc_4:* = _loc_2.getLowestSetBit();
            var _loc_5:* = _loc_3.getLowestSetBit();
            if (_loc_3.getLowestSetBit() < 0)
            {
                return _loc_2;
            }
            if (_loc_4 < _loc_5)
            {
                _loc_5 = _loc_4;
            }
            if (_loc_5 > 0)
            {
                _loc_2.rShiftTo(_loc_5, _loc_2);
                _loc_3.rShiftTo(_loc_5, _loc_3);
            }
            while (_loc_2.sigNum() > 0)
            {
                
                var _loc_7:* = _loc_2.getLowestSetBit();
                _loc_4 = _loc_2.getLowestSetBit();
                if (_loc_7 > 0)
                {
                    _loc_2.rShiftTo(_loc_4, _loc_2);
                }
                var _loc_7:* = _loc_3.getLowestSetBit();
                _loc_4 = _loc_3.getLowestSetBit();
                if (_loc_7 > 0)
                {
                    _loc_3.rShiftTo(_loc_4, _loc_3);
                }
                if (_loc_2.compareTo(_loc_3) >= 0)
                {
                    _loc_2.subTo(_loc_3, _loc_2);
                    _loc_2.rShiftTo(1, _loc_2);
                    continue;
                }
                _loc_3.subTo(_loc_2, _loc_3);
                _loc_3.rShiftTo(1, _loc_3);
            }
            if (_loc_5 > 0)
            {
                _loc_3.lShiftTo(_loc_5, _loc_3);
            }
            return _loc_3;
        }// end function

        protected function modInt(param1:int) : int
        {
            var _loc_4:* = 0;
            if (param1 <= 0)
            {
                return 0;
            }
            var _loc_2:* = DV % param1;
            var _loc_3:* = this.s < 0 ? ((param1 - 1)) : (0);
            if (this.t > 0)
            {
                if (_loc_2 == 0)
                {
                    _loc_3 = this.a[0] % param1;
                }
                else
                {
                    _loc_4 = this.t - 1;
                    while (_loc_4 >= 0)
                    {
                        
                        _loc_3 = (_loc_2 * _loc_3 + this.a[_loc_4]) % param1;
                        _loc_4 = _loc_4 - 1;
                    }
                }
            }
            return _loc_3;
        }// end function

        public function modInverse(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = param1.isEven();
            if (this.isEven() && _loc_2 || param1.sigNum() == 0)
            {
                return BigInteger.ZERO;
            }
            var _loc_3:* = param1.clone();
            var _loc_4:* = this.clone();
            var _loc_5:* = nbv(1);
            var _loc_6:* = nbv(0);
            var _loc_7:* = nbv(0);
            var _loc_8:* = nbv(1);
            while (_loc_3.sigNum() != 0)
            {
                
                while (_loc_3.isEven())
                {
                    
                    _loc_3.rShiftTo(1, _loc_3);
                    if (_loc_2)
                    {
                        if (!_loc_5.isEven() || !_loc_6.isEven())
                        {
                            _loc_5.addTo(this, _loc_5);
                            _loc_6.subTo(param1, _loc_6);
                        }
                        _loc_5.rShiftTo(1, _loc_5);
                    }
                    else if (!_loc_6.isEven())
                    {
                        _loc_6.subTo(param1, _loc_6);
                    }
                    _loc_6.rShiftTo(1, _loc_6);
                }
                while (_loc_4.isEven())
                {
                    
                    _loc_4.rShiftTo(1, _loc_4);
                    if (_loc_2)
                    {
                        if (!_loc_7.isEven() || !_loc_8.isEven())
                        {
                            _loc_7.addTo(this, _loc_7);
                            _loc_8.subTo(param1, _loc_8);
                        }
                        _loc_7.rShiftTo(1, _loc_7);
                    }
                    else if (!_loc_8.isEven())
                    {
                        _loc_8.subTo(param1, _loc_8);
                    }
                    _loc_8.rShiftTo(1, _loc_8);
                }
                if (_loc_3.compareTo(_loc_4) >= 0)
                {
                    _loc_3.subTo(_loc_4, _loc_3);
                    if (_loc_2)
                    {
                        _loc_5.subTo(_loc_7, _loc_5);
                    }
                    _loc_6.subTo(_loc_8, _loc_6);
                    continue;
                }
                _loc_4.subTo(_loc_3, _loc_4);
                if (_loc_2)
                {
                    _loc_7.subTo(_loc_5, _loc_7);
                }
                _loc_8.subTo(_loc_6, _loc_8);
            }
            if (_loc_4.compareTo(BigInteger.ONE) != 0)
            {
                return BigInteger.ZERO;
            }
            if (_loc_8.compareTo(param1) >= 0)
            {
                return _loc_8.subtract(param1);
            }
            if (_loc_8.sigNum() < 0)
            {
                _loc_8.addTo(param1, _loc_8);
            }
            else
            {
                return _loc_8;
            }
            if (_loc_8.sigNum() < 0)
            {
                return _loc_8.add(param1);
            }
            return _loc_8;
        }// end function

        public function isProbablePrime(param1:int) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_3:* = this.abs();
            if (_loc_3.t == 1 && _loc_3.a[0] <= lowprimes[(lowprimes.length - 1)])
            {
                _loc_2 = 0;
                while (_loc_2 < lowprimes.length)
                {
                    
                    if (_loc_3[0] == lowprimes[_loc_2])
                    {
                        return true;
                    }
                    _loc_2++;
                }
                return false;
            }
            if (_loc_3.isEven())
            {
                return false;
            }
            _loc_2 = 1;
            while (_loc_2 < lowprimes.length)
            {
                
                _loc_4 = lowprimes[_loc_2];
                _loc_5 = _loc_2 + 1;
                while (_loc_5 < lowprimes.length && _loc_4 < lplim)
                {
                    
                    _loc_4 = _loc_4 * lowprimes[_loc_5++];
                }
                _loc_4 = _loc_3.modInt(_loc_4);
                while (_loc_2 < _loc_5)
                {
                    
                    if (_loc_4 % lowprimes[_loc_2++] == 0)
                    {
                        return false;
                    }
                }
            }
            return _loc_3.millerRabin(param1);
        }// end function

        protected function millerRabin(param1:int) : Boolean
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_2:* = this.subtract(BigInteger.ONE);
            var _loc_3:* = _loc_2.getLowestSetBit();
            if (_loc_3 <= 0)
            {
                return false;
            }
            var _loc_4:* = _loc_2.shiftRight(_loc_3);
            param1 = (param1 + 1) >> 1;
            if (param1 > lowprimes.length)
            {
                param1 = lowprimes.length;
            }
            var _loc_5:* = new BigInteger();
            var _loc_6:* = 0;
            while (_loc_6 < param1)
            {
                
                _loc_5.fromInt(lowprimes[_loc_6]);
                _loc_7 = _loc_5.modPow(_loc_4, this);
                if (_loc_7.compareTo(BigInteger.ONE) != 0 && _loc_7.compareTo(_loc_2) != 0)
                {
                    _loc_8 = 1;
                    while (_loc_8++ < _loc_3 && _loc_7.compareTo(_loc_2) != 0)
                    {
                        
                        _loc_7 = _loc_7.modPowInt(2, this);
                        if (_loc_7.compareTo(BigInteger.ONE) == 0)
                        {
                            return false;
                        }
                    }
                    if (_loc_7.compareTo(_loc_2) != 0)
                    {
                        return false;
                    }
                }
                _loc_6++;
            }
            return true;
        }// end function

        public function primify(param1:int, param2:int) : void
        {
            if (!this.testBit((param1 - 1)))
            {
                this.bitwiseTo(BigInteger.ONE.shiftLeft((param1 - 1)), this.op_or, this);
            }
            if (this.isEven())
            {
                this.dAddOffset(1, 0);
            }
            while (!this.isProbablePrime(param2))
            {
                
                this.dAddOffset(2, 0);
                while (this.bitLength() > param1)
                {
                    
                    this.subTo(BigInteger.ONE.shiftLeft((param1 - 1)), this);
                }
            }
            return;
        }// end function

        public static function nbv(param1:int) : BigInteger
        {
            var _loc_2:* = new BigInteger;
            _loc_2.fromInt(param1);
            return _loc_2;
        }// end function

    }
}
