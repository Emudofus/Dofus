package by.blooddy.crypto
{
    import flash.system.*;
    import flash.utils.*;

    public class MD5 extends Object
    {

        public function MD5() : void
        {
            return;
        }// end function

        public static function hash(param1:String) : String
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeUTFBytes(param1);
            var _loc_3:* = MD5.hashBytes(_loc_2);
            return _loc_3;
        }// end function

        public static function hashBytes(param1:ByteArray) : String
        {
            var _loc_2:* = ApplicationDomain.currentDomain.domainMemory;
            var _loc_3:* = param1.length << 3;
            var _loc_4:* = (_loc_3 + 64 >>> 9 << 4) + 15 << 2;
            var _loc_6:* = ((_loc_3 + 64 >>> 9 << 4) + 15 << 2) + 4;
            var _loc_7:* = new ByteArray();
            if (_loc_6 != 0)
            {
                _loc_7.length = _loc_6;
            }
            var _loc_5:* = _loc_7;
            _loc_7.writeBytes(param1);
            if (_loc_5.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _loc_5.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = _loc_5;
            var _loc_8:* = 1732584193;
            var _loc_9:* = -271733879;
            var _loc_10:* = -1732584194;
            var _loc_11:* = 271733878;
            var _loc_12:* = _loc_8;
            var _loc_13:* = _loc_9;
            var _loc_14:* = _loc_10;
            var _loc_15:* = _loc_11;
            _loc_3 = 0;
            do
            {
                
                _loc_12 = _loc_8;
                _loc_13 = _loc_9;
                _loc_14 = _loc_10;
                _loc_15 = _loc_11;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_10 | ~_loc_9 & _loc_11) + _loc_3 + -680876936);
                _loc_8 = (_loc_8 << 7 | _loc_8 >>> 25) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_9 | ~_loc_8 & _loc_10) + (_loc_3 + 4) + -389564586);
                _loc_11 = (_loc_11 << 12 | _loc_11 >>> 20) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_8 | ~_loc_11 & _loc_9) + (_loc_3 + 8) + 606105819);
                _loc_10 = (_loc_10 << 17 | _loc_10 >>> 15) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_11 | ~_loc_10 & _loc_8) + (_loc_3 + 12) + -1044525330);
                _loc_9 = (_loc_9 << 22 | _loc_9 >>> 10) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_10 | ~_loc_9 & _loc_11) + (_loc_3 + 16) + -176418897);
                _loc_8 = (_loc_8 << 7 | _loc_8 >>> 25) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_9 | ~_loc_8 & _loc_10) + (_loc_3 + 20) + 1200080426);
                _loc_11 = (_loc_11 << 12 | _loc_11 >>> 20) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_8 | ~_loc_11 & _loc_9) + (_loc_3 + 24) + -1473231341);
                _loc_10 = (_loc_10 << 17 | _loc_10 >>> 15) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_11 | ~_loc_10 & _loc_8) + (_loc_3 + 28) + -45705983);
                _loc_9 = (_loc_9 << 22 | _loc_9 >>> 10) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_10 | ~_loc_9 & _loc_11) + (_loc_3 + 32) + 1770035416);
                _loc_8 = (_loc_8 << 7 | _loc_8 >>> 25) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_9 | ~_loc_8 & _loc_10) + (_loc_3 + 36) + -1958414417);
                _loc_11 = (_loc_11 << 12 | _loc_11 >>> 20) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_8 | ~_loc_11 & _loc_9) + (_loc_3 + 40) + -42063);
                _loc_10 = (_loc_10 << 17 | _loc_10 >>> 15) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_11 | ~_loc_10 & _loc_8) + (_loc_3 + 44) + -1990404162);
                _loc_9 = (_loc_9 << 22 | _loc_9 >>> 10) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_10 | ~_loc_9 & _loc_11) + (_loc_3 + 48) + 1804603682);
                _loc_8 = (_loc_8 << 7 | _loc_8 >>> 25) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_9 | ~_loc_8 & _loc_10) + (_loc_3 + 52) + -40341101);
                _loc_11 = (_loc_11 << 12 | _loc_11 >>> 20) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_8 | ~_loc_11 & _loc_9) + (_loc_3 + 56) + -1502002290);
                _loc_10 = (_loc_10 << 17 | _loc_10 >>> 15) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_11 | ~_loc_10 & _loc_8) + (_loc_3 + 60) + 1236535329);
                _loc_9 = (_loc_9 << 22 | _loc_9 >>> 10) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_11 | _loc_10 & ~_loc_11) + (_loc_3 + 4) + -165796510);
                _loc_8 = (_loc_8 << 5 | _loc_8 >>> 27) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_10 | _loc_9 & ~_loc_10) + (_loc_3 + 24) + -1069501632);
                _loc_11 = (_loc_11 << 9 | _loc_11 >>> 23) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_9 | _loc_8 & ~_loc_9) + (_loc_3 + 44) + 643717713);
                _loc_10 = (_loc_10 << 14 | _loc_10 >>> 18) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_8 | _loc_11 & ~_loc_8) + _loc_3 + -373897302);
                _loc_9 = (_loc_9 << 20 | _loc_9 >>> 12) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_11 | _loc_10 & ~_loc_11) + (_loc_3 + 20) + -701558691);
                _loc_8 = (_loc_8 << 5 | _loc_8 >>> 27) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_10 | _loc_9 & ~_loc_10) + (_loc_3 + 40) + 38016083);
                _loc_11 = (_loc_11 << 9 | _loc_11 >>> 23) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_9 | _loc_8 & ~_loc_9) + (_loc_3 + 60) + -660478335);
                _loc_10 = (_loc_10 << 14 | _loc_10 >>> 18) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_8 | _loc_11 & ~_loc_8) + (_loc_3 + 16) + -405537848);
                _loc_9 = (_loc_9 << 20 | _loc_9 >>> 12) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_11 | _loc_10 & ~_loc_11) + (_loc_3 + 36) + 568446438);
                _loc_8 = (_loc_8 << 5 | _loc_8 >>> 27) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_10 | _loc_9 & ~_loc_10) + (_loc_3 + 56) + -1019803690);
                _loc_11 = (_loc_11 << 9 | _loc_11 >>> 23) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_9 | _loc_8 & ~_loc_9) + (_loc_3 + 12) + -187363961);
                _loc_10 = (_loc_10 << 14 | _loc_10 >>> 18) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_8 | _loc_11 & ~_loc_8) + (_loc_3 + 32) + 1163531501);
                _loc_9 = (_loc_9 << 20 | _loc_9 >>> 12) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 & _loc_11 | _loc_10 & ~_loc_11) + (_loc_3 + 52) + -1444681467);
                _loc_8 = (_loc_8 << 5 | _loc_8 >>> 27) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 & _loc_10 | _loc_9 & ~_loc_10) + (_loc_3 + 8) + -51403784);
                _loc_11 = (_loc_11 << 9 | _loc_11 >>> 23) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 & _loc_9 | _loc_8 & ~_loc_9) + (_loc_3 + 28) + 1735328473);
                _loc_10 = (_loc_10 << 14 | _loc_10 >>> 18) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 & _loc_8 | _loc_11 & ~_loc_8) + (_loc_3 + 48) + -1926607734);
                _loc_9 = (_loc_9 << 20 | _loc_9 >>> 12) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 ^ _loc_10 ^ _loc_11) + (_loc_3 + 20) + -378558);
                _loc_8 = (_loc_8 << 4 | _loc_8 >>> 28) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 ^ _loc_9 ^ _loc_10) + (_loc_3 + 32) + -2022574463);
                _loc_11 = (_loc_11 << 11 | _loc_11 >>> 21) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 ^ _loc_8 ^ _loc_9) + (_loc_3 + 44) + 1839030562);
                _loc_10 = (_loc_10 << 16 | _loc_10 >>> 16) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 ^ _loc_11 ^ _loc_8) + (_loc_3 + 56) + -35309556);
                _loc_9 = (_loc_9 << 23 | _loc_9 >>> 9) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 ^ _loc_10 ^ _loc_11) + (_loc_3 + 4) + -1530992060);
                _loc_8 = (_loc_8 << 4 | _loc_8 >>> 28) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 ^ _loc_9 ^ _loc_10) + (_loc_3 + 16) + 1272893353);
                _loc_11 = (_loc_11 << 11 | _loc_11 >>> 21) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 ^ _loc_8 ^ _loc_9) + (_loc_3 + 28) + -155497632);
                _loc_10 = (_loc_10 << 16 | _loc_10 >>> 16) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 ^ _loc_11 ^ _loc_8) + (_loc_3 + 40) + -1094730640);
                _loc_9 = (_loc_9 << 23 | _loc_9 >>> 9) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 ^ _loc_10 ^ _loc_11) + (_loc_3 + 52) + 681279174);
                _loc_8 = (_loc_8 << 4 | _loc_8 >>> 28) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 ^ _loc_9 ^ _loc_10) + _loc_3 + -358537222);
                _loc_11 = (_loc_11 << 11 | _loc_11 >>> 21) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 ^ _loc_8 ^ _loc_9) + (_loc_3 + 12) + -722521979);
                _loc_10 = (_loc_10 << 16 | _loc_10 >>> 16) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 ^ _loc_11 ^ _loc_8) + (_loc_3 + 24) + 76029189);
                _loc_9 = (_loc_9 << 23 | _loc_9 >>> 9) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_9 ^ _loc_10 ^ _loc_11) + (_loc_3 + 36) + -640364487);
                _loc_8 = (_loc_8 << 4 | _loc_8 >>> 28) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_8 ^ _loc_9 ^ _loc_10) + (_loc_3 + 48) + -421815835);
                _loc_11 = (_loc_11 << 11 | _loc_11 >>> 21) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_11 ^ _loc_8 ^ _loc_9) + (_loc_3 + 60) + 530742520);
                _loc_10 = (_loc_10 << 16 | _loc_10 >>> 16) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_10 ^ _loc_11 ^ _loc_8) + (_loc_3 + 8) + -995338651);
                _loc_9 = (_loc_9 << 23 | _loc_9 >>> 9) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_10 ^ (_loc_9 | ~_loc_11)) + _loc_3 + -198630844);
                _loc_8 = (_loc_8 << 6 | _loc_8 >>> 26) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_9 ^ (_loc_8 | ~_loc_10)) + (_loc_3 + 28) + 1126891415);
                _loc_11 = (_loc_11 << 10 | _loc_11 >>> 22) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_8 ^ (_loc_11 | ~_loc_9)) + (_loc_3 + 56) + -1416354905);
                _loc_10 = (_loc_10 << 15 | _loc_10 >>> 17) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_11 ^ (_loc_10 | ~_loc_8)) + (_loc_3 + 20) + -57434055);
                _loc_9 = (_loc_9 << 21 | _loc_9 >>> 11) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_10 ^ (_loc_9 | ~_loc_11)) + (_loc_3 + 48) + 1700485571);
                _loc_8 = (_loc_8 << 6 | _loc_8 >>> 26) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_9 ^ (_loc_8 | ~_loc_10)) + (_loc_3 + 12) + -1894986606);
                _loc_11 = (_loc_11 << 10 | _loc_11 >>> 22) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_8 ^ (_loc_11 | ~_loc_9)) + (_loc_3 + 40) + -1051523);
                _loc_10 = (_loc_10 << 15 | _loc_10 >>> 17) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_11 ^ (_loc_10 | ~_loc_8)) + (_loc_3 + 4) + -2054922799);
                _loc_9 = (_loc_9 << 21 | _loc_9 >>> 11) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_10 ^ (_loc_9 | ~_loc_11)) + (_loc_3 + 32) + 1873313359);
                _loc_8 = (_loc_8 << 6 | _loc_8 >>> 26) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_9 ^ (_loc_8 | ~_loc_10)) + (_loc_3 + 60) + -30611744);
                _loc_11 = (_loc_11 << 10 | _loc_11 >>> 22) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_8 ^ (_loc_11 | ~_loc_9)) + (_loc_3 + 24) + -1560198380);
                _loc_10 = (_loc_10 << 15 | _loc_10 >>> 17) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_11 ^ (_loc_10 | ~_loc_8)) + (_loc_3 + 52) + 1309151649);
                _loc_9 = (_loc_9 << 21 | _loc_9 >>> 11) + _loc_10;
                _loc_8 = _loc_8 + ((_loc_10 ^ (_loc_9 | ~_loc_11)) + (_loc_3 + 16) + -145523070);
                _loc_8 = (_loc_8 << 6 | _loc_8 >>> 26) + _loc_9;
                _loc_11 = _loc_11 + ((_loc_9 ^ (_loc_8 | ~_loc_10)) + (_loc_3 + 44) + -1120210379);
                _loc_11 = (_loc_11 << 10 | _loc_11 >>> 22) + _loc_8;
                _loc_10 = _loc_10 + ((_loc_8 ^ (_loc_11 | ~_loc_9)) + (_loc_3 + 8) + 718787259);
                _loc_10 = (_loc_10 << 15 | _loc_10 >>> 17) + _loc_11;
                _loc_9 = _loc_9 + ((_loc_11 ^ (_loc_10 | ~_loc_8)) + (_loc_3 + 36) + -343485551);
                _loc_9 = (_loc_9 << 21 | _loc_9 >>> 11) + _loc_10;
                _loc_8 = _loc_8 + _loc_12;
                _loc_9 = _loc_9 + _loc_13;
                _loc_10 = _loc_10 + _loc_14;
                _loc_11 = _loc_11 + _loc_15;
                _loc_3 = _loc_3 + 64;
            }while (_loc_3 < _loc_4)
            _loc_5.position = 0;
            _loc_5.writeUTFBytes("0123456789abcdef");
            _loc_9 = 31;
            _loc_3 = 16;
            do
            {
                
                _loc_8 = _loc_3;
                _loc_9++;
                _loc_9++;
            }while (++_loc_3 < 32)
            ApplicationDomain.currentDomain.domainMemory = _loc_2;
            _loc_5.position = 32;
            return _loc_5.readUTFBytes(32);
        }// end function

    }
}
