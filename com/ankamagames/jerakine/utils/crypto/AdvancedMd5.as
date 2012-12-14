package com.ankamagames.jerakine.utils.crypto
{

    public class AdvancedMd5 extends Object
    {
        public static const HEX_FORMAT_LOWERCASE:uint = 0;
        public static const HEX_FORMAT_UPPERCASE:uint = 1;
        public static const BASE64_PAD_CHARACTER_DEFAULT_COMPLIANCE:String = "";
        public static const BASE64_PAD_CHARACTER_RFC_COMPLIANCE:String = "=";
        public static var hexcase:uint = 0;
        public static var b64pad:String = "";

        public function AdvancedMd5()
        {
            return;
        }// end function

        public static function encrypt(param1:String) : String
        {
            return hex_md5(param1);
        }// end function

        public static function hex_md5(param1:String) : String
        {
            return rstr2hex(rstr_md5(str2rstr_utf8(param1)));
        }// end function

        public static function b64_md5(param1:String) : String
        {
            return rstr2b64(rstr_md5(str2rstr_utf8(param1)));
        }// end function

        public static function any_md5(param1:String, param2:String) : String
        {
            return rstr2any(rstr_md5(str2rstr_utf8(param1)), param2);
        }// end function

        public static function hex_hmac_md5(param1:String, param2:String) : String
        {
            return rstr2hex(rstr_hmac_md5(str2rstr_utf8(param1), str2rstr_utf8(param2)));
        }// end function

        public static function b64_hmac_md5(param1:String, param2:String) : String
        {
            return rstr2b64(rstr_hmac_md5(str2rstr_utf8(param1), str2rstr_utf8(param2)));
        }// end function

        public static function any_hmac_md5(param1:String, param2:String, param3:String) : String
        {
            return rstr2any(rstr_hmac_md5(str2rstr_utf8(param1), str2rstr_utf8(param2)), param3);
        }// end function

        public static function md5_vm_test() : Boolean
        {
            return hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72";
        }// end function

        public static function rstr_md5(param1:String) : String
        {
            return binl2rstr(binl_md5(rstr2binl(param1), param1.length * 8));
        }// end function

        public static function rstr_hmac_md5(param1:String, param2:String) : String
        {
            var _loc_3:* = rstr2binl(param1);
            if (_loc_3.length > 16)
            {
                _loc_3 = binl_md5(_loc_3, param1.length * 8);
            }
            var _loc_4:* = new Array(16);
            var _loc_5:* = new Array(16);
            var _loc_6:* = 0;
            while (_loc_6 < 16)
            {
                
                _loc_4[_loc_6] = _loc_3[_loc_6] ^ 909522486;
                _loc_5[_loc_6] = _loc_3[_loc_6] ^ 1549556828;
                _loc_6 = _loc_6 + 1;
            }
            var _loc_7:* = binl_md5(_loc_4.concat(rstr2binl(param2)), 512 + param2.length * 8);
            return binl2rstr(binl_md5(_loc_5.concat(_loc_7), 512 + 128));
        }// end function

        public static function rstr2hex(param1:String) : String
        {
            var _loc_4:* = NaN;
            var _loc_2:* = hexcase ? ("0123456789ABCDEF") : ("0123456789abcdef");
            var _loc_3:* = "";
            var _loc_5:* = 0;
            while (_loc_5 < param1.length)
            {
                
                _loc_4 = param1.charCodeAt(_loc_5);
                _loc_3 = _loc_3 + (_loc_2.charAt(_loc_4 >>> 4 & 15) + _loc_2.charAt(_loc_4 & 15));
                _loc_5 = _loc_5 + 1;
            }
            return _loc_3;
        }// end function

        public static function rstr2b64(param1:String) : String
        {
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_2:* = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var _loc_3:* = "";
            var _loc_4:* = param1.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = param1.charCodeAt(_loc_5) << 16 | ((_loc_5 + 1) < _loc_4 ? (param1.charCodeAt((_loc_5 + 1)) << 8) : (0)) | (_loc_5 + 2 < _loc_4 ? (param1.charCodeAt(_loc_5 + 2)) : (0));
                _loc_7 = 0;
                while (_loc_7 < 4)
                {
                    
                    if (_loc_5 * 8 + _loc_7 * 6 > param1.length * 8)
                    {
                        _loc_3 = _loc_3 + b64pad;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + _loc_2.charAt(_loc_6 >>> 6 * (3 - _loc_7) & 63);
                    }
                    _loc_7 = _loc_7 + 1;
                }
                _loc_5 = _loc_5 + 3;
            }
            return _loc_3;
        }// end function

        public static function rstr2any(param1:String, param2:String) : String
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = null;
            var _loc_3:* = param2.length;
            var _loc_4:* = [];
            var _loc_9:* = new Array(param1.length / 2);
            _loc_5 = 0;
            while (_loc_5 < _loc_9.length)
            {
                
                _loc_9[_loc_5] = param1.charCodeAt(_loc_5 * 2) << 8 | param1.charCodeAt(_loc_5 * 2 + 1);
                _loc_5 = _loc_5 + 1;
            }
            while (_loc_9.length > 0)
            {
                
                _loc_8 = [];
                _loc_7 = 0;
                _loc_5 = 0;
                while (_loc_5 < _loc_9.length)
                {
                    
                    _loc_7 = (_loc_7 << 16) + _loc_9[_loc_5];
                    _loc_6 = Math.floor(_loc_7 / _loc_3);
                    _loc_7 = _loc_7 - _loc_6 * _loc_3;
                    if (_loc_8.length > 0 || _loc_6 > 0)
                    {
                        _loc_8[_loc_8.length] = _loc_6;
                    }
                    _loc_5 = _loc_5 + 1;
                }
                _loc_4[_loc_4.length] = _loc_7;
                _loc_9 = _loc_8;
            }
            var _loc_10:* = "";
            _loc_5 = _loc_4.length - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_10 = _loc_10 + param2.charAt(_loc_4[_loc_5]);
                _loc_5 = _loc_5 - 1;
            }
            return _loc_10;
        }// end function

        public static function str2rstr_utf8(param1:String) : String
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_2:* = "";
            var _loc_3:* = -1;
            while (++_loc_3 < param1.length)
            {
                
                _loc_4 = param1.charCodeAt(_loc_3);
                _loc_5 = (_loc_3 + 1) < param1.length ? (param1.charCodeAt((_loc_3 + 1))) : (0);
                if (_loc_4 >= 55296 && _loc_4 <= 56319 && _loc_5 >= 56320 && _loc_5 <= 57343)
                {
                    _loc_4 = 65536 + ((_loc_4 & 1023) << 10) + (_loc_5 & 1023);
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_4 <= 127)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(_loc_4);
                    continue;
                }
                if (_loc_4 <= 2047)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(192 | _loc_4 >>> 6 & 31, 128 | _loc_4 & 63);
                    continue;
                }
                if (_loc_4 <= 65535)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(224 | _loc_4 >>> 12 & 15, 128 | _loc_4 >>> 6 & 63, 128 | _loc_4 & 63);
                    continue;
                }
                if (_loc_4 <= 2097151)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(240 | _loc_4 >>> 18 & 7, 128 | _loc_4 >>> 12 & 63, 128 | _loc_4 >>> 6 & 63, 128 | _loc_4 & 63);
                }
            }
            return _loc_2;
        }// end function

        public static function str2rstr_utf16le(param1:String) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = _loc_2 + String.fromCharCode(param1.charCodeAt(_loc_3) & 255, param1.charCodeAt(_loc_3) >>> 8 & 255);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public static function str2rstr_utf16be(param1:String) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = _loc_2 + String.fromCharCode(param1.charCodeAt(_loc_3) >>> 8 & 255, param1.charCodeAt(_loc_3) & 255);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public static function rstr2binl(param1:String) : Array
        {
            var _loc_2:* = new Array(param1.length >> 2);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3] = 0;
                _loc_3 = _loc_3 + 1;
            }
            _loc_3 = 0;
            while (_loc_3 < param1.length * 8)
            {
                
                _loc_2[_loc_3 >> 5] = _loc_2[_loc_3 >> 5] | (param1.charCodeAt(_loc_3 / 8) & 255) << _loc_3 % 32;
                _loc_3 = _loc_3 + 8;
            }
            return _loc_2;
        }// end function

        public static function binl2rstr(param1:Array) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = 0;
            while (_loc_3 < param1.length * 32)
            {
                
                _loc_2 = _loc_2 + String.fromCharCode(param1[_loc_3 >> 5] >>> _loc_3 % 32 & 255);
                _loc_3 = _loc_3 + 8;
            }
            return _loc_2;
        }// end function

        public static function binl_md5(param1:Array, param2:Number) : Array
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            param1[param2 >> 5] = param1[param2 >> 5] | 128 << param2 % 32;
            param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
            var _loc_3:* = 1732584193;
            var _loc_4:* = -271733879;
            var _loc_5:* = -1732584194;
            var _loc_6:* = 271733878;
            var _loc_7:* = 0;
            while (_loc_7 < param1.length)
            {
                
                _loc_8 = _loc_3;
                _loc_9 = _loc_4;
                _loc_10 = _loc_5;
                _loc_11 = _loc_6;
                _loc_3 = md5_ff(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 0], 7, -680876936);
                _loc_6 = md5_ff(_loc_6, _loc_3, _loc_4, _loc_5, param1[(_loc_7 + 1)], 12, -389564586);
                _loc_5 = md5_ff(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 2], 17, 606105819);
                _loc_4 = md5_ff(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 3], 22, -1044525330);
                _loc_3 = md5_ff(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 4], 7, -176418897);
                _loc_6 = md5_ff(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 5], 12, 1200080426);
                _loc_5 = md5_ff(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 6], 17, -1473231341);
                _loc_4 = md5_ff(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 7], 22, -45705983);
                _loc_3 = md5_ff(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 8], 7, 1770035416);
                _loc_6 = md5_ff(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 9], 12, -1958414417);
                _loc_5 = md5_ff(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 10], 17, -42063);
                _loc_4 = md5_ff(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 11], 22, -1990404162);
                _loc_3 = md5_ff(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 12], 7, 1804603682);
                _loc_6 = md5_ff(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 13], 12, -40341101);
                _loc_5 = md5_ff(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 14], 17, -1502002290);
                _loc_4 = md5_ff(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 15], 22, 1236535329);
                _loc_3 = md5_gg(_loc_3, _loc_4, _loc_5, _loc_6, param1[(_loc_7 + 1)], 5, -165796510);
                _loc_6 = md5_gg(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 6], 9, -1069501632);
                _loc_5 = md5_gg(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 11], 14, 643717713);
                _loc_4 = md5_gg(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 0], 20, -373897302);
                _loc_3 = md5_gg(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 5], 5, -701558691);
                _loc_6 = md5_gg(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 10], 9, 38016083);
                _loc_5 = md5_gg(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 15], 14, -660478335);
                _loc_4 = md5_gg(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 4], 20, -405537848);
                _loc_3 = md5_gg(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 9], 5, 568446438);
                _loc_6 = md5_gg(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 14], 9, -1019803690);
                _loc_5 = md5_gg(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 3], 14, -187363961);
                _loc_4 = md5_gg(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 8], 20, 1163531501);
                _loc_3 = md5_gg(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 13], 5, -1444681467);
                _loc_6 = md5_gg(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 2], 9, -51403784);
                _loc_5 = md5_gg(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 7], 14, 1735328473);
                _loc_4 = md5_gg(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 12], 20, -1926607734);
                _loc_3 = md5_hh(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 5], 4, -378558);
                _loc_6 = md5_hh(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 8], 11, -2022574463);
                _loc_5 = md5_hh(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 11], 16, 1839030562);
                _loc_4 = md5_hh(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 14], 23, -35309556);
                _loc_3 = md5_hh(_loc_3, _loc_4, _loc_5, _loc_6, param1[(_loc_7 + 1)], 4, -1530992060);
                _loc_6 = md5_hh(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 4], 11, 1272893353);
                _loc_5 = md5_hh(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 7], 16, -155497632);
                _loc_4 = md5_hh(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 10], 23, -1094730640);
                _loc_3 = md5_hh(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 13], 4, 681279174);
                _loc_6 = md5_hh(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 0], 11, -358537222);
                _loc_5 = md5_hh(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 3], 16, -722521979);
                _loc_4 = md5_hh(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 6], 23, 76029189);
                _loc_3 = md5_hh(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 9], 4, -640364487);
                _loc_6 = md5_hh(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 12], 11, -421815835);
                _loc_5 = md5_hh(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 15], 16, 530742520);
                _loc_4 = md5_hh(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 2], 23, -995338651);
                _loc_3 = md5_ii(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 0], 6, -198630844);
                _loc_6 = md5_ii(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 7], 10, 1126891415);
                _loc_5 = md5_ii(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 14], 15, -1416354905);
                _loc_4 = md5_ii(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 5], 21, -57434055);
                _loc_3 = md5_ii(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 12], 6, 1700485571);
                _loc_6 = md5_ii(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 3], 10, -1894986606);
                _loc_5 = md5_ii(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 10], 15, -1051523);
                _loc_4 = md5_ii(_loc_4, _loc_5, _loc_6, _loc_3, param1[(_loc_7 + 1)], 21, -2054922799);
                _loc_3 = md5_ii(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 8], 6, 1873313359);
                _loc_6 = md5_ii(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 15], 10, -30611744);
                _loc_5 = md5_ii(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 6], 15, -1560198380);
                _loc_4 = md5_ii(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 13], 21, 1309151649);
                _loc_3 = md5_ii(_loc_3, _loc_4, _loc_5, _loc_6, param1[_loc_7 + 4], 6, -145523070);
                _loc_6 = md5_ii(_loc_6, _loc_3, _loc_4, _loc_5, param1[_loc_7 + 11], 10, -1120210379);
                _loc_5 = md5_ii(_loc_5, _loc_6, _loc_3, _loc_4, param1[_loc_7 + 2], 15, 718787259);
                _loc_4 = md5_ii(_loc_4, _loc_5, _loc_6, _loc_3, param1[_loc_7 + 9], 21, -343485551);
                _loc_3 = safe_add(_loc_3, _loc_8);
                _loc_4 = safe_add(_loc_4, _loc_9);
                _loc_5 = safe_add(_loc_5, _loc_10);
                _loc_6 = safe_add(_loc_6, _loc_11);
                _loc_7 = _loc_7 + 16;
            }
            return [_loc_3, _loc_4, _loc_5, _loc_6];
        }// end function

        public static function md5_cmn(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number
        {
            return safe_add(bit_rol(safe_add(safe_add(param2, param1), safe_add(param4, param6)), param5), param3);
        }// end function

        public static function md5_ff(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number
        {
            return md5_cmn(param2 & param3 | ~param2 & param4, param1, param2, param5, param6, param7);
        }// end function

        public static function md5_gg(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number
        {
            return md5_cmn(param2 & param4 | param3 & ~param4, param1, param2, param5, param6, param7);
        }// end function

        public static function md5_hh(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number
        {
            return md5_cmn(param2 ^ param3 ^ param4, param1, param2, param5, param6, param7);
        }// end function

        public static function md5_ii(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number
        {
            return md5_cmn(param3 ^ (param2 | ~param4), param1, param2, param5, param6, param7);
        }// end function

        public static function safe_add(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = (param1 & 65535) + (param2 & 65535);
            var _loc_4:* = (param1 >> 16) + (param2 >> 16) + (_loc_3 >> 16);
            return (param1 >> 16) + (param2 >> 16) + (_loc_3 >> 16) << 16 | _loc_3 & 65535;
        }// end function

        public static function bit_rol(param1:Number, param2:Number) : Number
        {
            return param1 << param2 | param1 >>> 32 - param2;
        }// end function

    }
}
