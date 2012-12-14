package by.blooddy.crypto
{
    import flash.system.*;
    import flash.utils.*;

    public class SHA256 extends Object
    {

        public function SHA256() : void
        {
            return;
        }// end function

        public static function hash(param1:String) : String
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeUTFBytes(param1);
            var _loc_3:* = SHA256.hashBytes(_loc_2);
            return _loc_3;
        }// end function

        public static function hashBytes(param1:ByteArray) : String
        {
            var _loc_14:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_27:* = 0;
            var _loc_28:* = 0;
            var _loc_29:* = 0;
            var _loc_2:* = 1779033703;
            var _loc_3:* = -1150833019;
            var _loc_4:* = 1013904242;
            var _loc_5:* = -1521486534;
            var _loc_6:* = 1359893119;
            var _loc_7:* = -1694144372;
            var _loc_8:* = 528734635;
            var _loc_9:* = 1541459225;
            var _loc_10:* = ApplicationDomain.currentDomain.domainMemory;
            var _loc_11:* = param1.length << 3;
            var _loc_12:* = 512 + ((_loc_11 + 64 >>> 9 << 4) + 15 << 2);
            _loc_14 = 512 + ((_loc_11 + 64 >>> 9 << 4) + 15 << 2) + 4;
            var _loc_15:* = new ByteArray();
            if (_loc_14 != 0)
            {
                _loc_15.length = _loc_14;
            }
            var _loc_13:* = _loc_15;
            _loc_15.position = 512;
            _loc_13.writeBytes(param1);
            if (_loc_13.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _loc_13.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = _loc_13;
            var _loc_16:* = [1116352408, 1899447441, -1245643825, -373957723, 961987163, 1508970993, -1841331548, -1424204075, -670586216, 310598401, 607225278, 1426881987, 1925078388, -2132889090, -1680079193, -1046744716, -459576895, -272742522, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, -1740746414, -1473132947, -1341970488, -1084653625, -958395405, -710438585, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, -2117940946, -1838011259, -1564481375, -1474664885, -1035236496, -949202525, -778901479, -694614492, -200395387, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, -2067236844, -1933114872, -1866530822, -1538233109, -1090935817, -965641998];
            _loc_11 = 0;
            while (++_loc_11 < 64)
            {
                
            }
            ++_loc_11 = 512;
            do
            {
                
                _loc_17 = _loc_2;
                _loc_18 = _loc_3;
                _loc_19 = _loc_4;
                _loc_20 = _loc_5;
                _loc_21 = _loc_6;
                _loc_22 = _loc_7;
                _loc_23 = _loc_8;
                _loc_24 = _loc_9;
                _loc_14 = 0;
                do
                {
                    
                    _loc_27 = ++_loc_11 + _loc_14 << 24 | _loc_11 + _loc_14 + 1 << 16 | _loc_11 + _loc_14 + 2 << 8 | _loc_11 + _loc_14 + 3;
                    _loc_29 = _loc_24 + ((_loc_21 << 26 | _loc_21 >>> 6) ^ (_loc_21 << 21 | _loc_21 >>> 11) ^ (_loc_21 << 7 | _loc_21 >>> 25)) + (_loc_21 & _loc_22 ^ ~_loc_21 & _loc_23) + (256 + _loc_14) + _loc_27;
                    _loc_28 = ((_loc_17 << 30 | _loc_17 >>> 2) ^ (_loc_17 << 19 | _loc_17 >>> 13) ^ (_loc_17 << 10 | _loc_17 >>> 22)) + (_loc_17 & _loc_18 ^ _loc_17 & _loc_19 ^ _loc_18 & _loc_19);
                    _loc_24 = _loc_23;
                    _loc_23 = _loc_22;
                    _loc_22 = _loc_21;
                    _loc_21 = _loc_20 + _loc_29;
                    _loc_20 = _loc_19;
                    _loc_19 = _loc_18;
                    _loc_18 = _loc_17;
                    _loc_17 = _loc_29 + _loc_28;
                    _loc_14 = _loc_14 + 4;
                }while (_loc_14 < 64)
                do
                {
                    
                    _loc_25 = _loc_14 - 8;
                    _loc_26 = _loc_14 - 60;
                    _loc_27 = ((_loc_25 << 15 | _loc_25 >>> 17) ^ (_loc_25 << 13 | _loc_25 >>> 19) ^ _loc_25 >>> 10) + (_loc_14 - 28) + ((_loc_26 << 25 | _loc_26 >>> 7) ^ (_loc_26 << 14 | _loc_26 >>> 18) ^ _loc_26 >>> 3) + (_loc_14 - 64);
                    _loc_29 = _loc_24 + ((_loc_21 << 26 | _loc_21 >>> 6) ^ (_loc_21 << 21 | _loc_21 >>> 11) ^ (_loc_21 << 7 | _loc_21 >>> 25)) + (_loc_21 & _loc_22 ^ ~_loc_21 & _loc_23) + (256 + _loc_14) + _loc_27;
                    _loc_28 = ((_loc_17 << 30 | _loc_17 >>> 2) ^ (_loc_17 << 19 | _loc_17 >>> 13) ^ (_loc_17 << 10 | _loc_17 >>> 22)) + (_loc_17 & _loc_18 ^ _loc_17 & _loc_19 ^ _loc_18 & _loc_19);
                    _loc_24 = _loc_23;
                    _loc_23 = _loc_22;
                    _loc_22 = _loc_21;
                    _loc_21 = _loc_20 + _loc_29;
                    _loc_20 = _loc_19;
                    _loc_19 = _loc_18;
                    _loc_18 = _loc_17;
                    _loc_17 = _loc_29 + _loc_28;
                    _loc_14 = _loc_14 + 4;
                }while (_loc_14 < 256)
                _loc_2 = _loc_2 + _loc_17;
                _loc_3 = _loc_3 + _loc_18;
                _loc_4 = _loc_4 + _loc_19;
                _loc_5 = _loc_5 + _loc_20;
                _loc_6 = _loc_6 + _loc_21;
                _loc_7 = _loc_7 + _loc_22;
                _loc_8 = _loc_8 + _loc_23;
                _loc_9 = _loc_9 + _loc_24;
                _loc_11 = _loc_11 + 64;
            }while (_loc_11 < _loc_12)
            _loc_13.position = 0;
            _loc_13.writeUTFBytes("0123456789abcdef");
            _loc_18 = 47;
            _loc_11 = 16;
            do
            {
                
                _loc_17 = _loc_11;
                _loc_18++;
                _loc_18++;
            }while (++_loc_11 < 48)
            ApplicationDomain.currentDomain.domainMemory = _loc_10;
            _loc_13.position = 48;
            return _loc_13.readUTFBytes(64);
        }// end function

    }
}
