// Action script...

// [Initial MovieClip Action of sprite 20691]
#initclip 212
if (!ank.utils.Md5)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.Md5 = function ()
    {
    }).prototype;
    _loc1.hex_md5 = function (s)
    {
        return (this.binl2hex(this.core_md5(this.str2binl(s), s.length * this.chrsz)));
    };
    _loc1.b64_md5 = function (s)
    {
        return (this.binl2b64(this.core_md5(this.str2binl(s), s.length * this.chrsz)));
    };
    _loc1.str_md5 = function (s)
    {
        return (this.binl2str(this.core_md5(this.str2binl(s), s.length * this.chrsz)));
    };
    _loc1.hex_hmac_md5 = function (key, data)
    {
        return (this.binl2hex(this.core_hmac_md5(key, data)));
    };
    _loc1.b64_hmac_md5 = function (key, data)
    {
        return (this.binl2b64(this.core_hmac_md5(key, data)));
    };
    _loc1.str_hmac_md5 = function (key, data)
    {
        return (this.binl2str(this.core_hmac_md5(key, data)));
    };
    _loc1.md5_vm_test = function ()
    {
        return (this.hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72");
    };
    _loc1.core_md5 = function (x, len)
    {
        x[len >> 5] = x[len >> 5] | 128 << len % 32;
        x[(len + 64 >>> 9 << 4) + 14] = len;
        var _loc4 = 1732584193;
        var _loc5 = -271733879;
        var _loc6 = -1732584194;
        var _loc7 = 271733878;
        var _loc8 = 0;
        
        while (_loc8 = _loc8 + 16, _loc8 < x.length)
        {
            var _loc9 = _loc4;
            var _loc10 = _loc5;
            var _loc11 = _loc6;
            var _loc12 = _loc7;
            _loc4 = this.md5_ff(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 0], 7, -680876936);
            _loc7 = this.md5_ff(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 1], 12, -389564586);
            _loc6 = this.md5_ff(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 2], 17, 606105819);
            _loc5 = this.md5_ff(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 3], 22, -1044525330);
            _loc4 = this.md5_ff(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 4], 7, -176418897);
            _loc7 = this.md5_ff(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 5], 12, 1200080426);
            _loc6 = this.md5_ff(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 6], 17, -1473231341);
            _loc5 = this.md5_ff(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 7], 22, -45705983);
            _loc4 = this.md5_ff(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 8], 7, 1770035416);
            _loc7 = this.md5_ff(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 9], 12, -1958414417);
            _loc6 = this.md5_ff(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 10], 17, -42063);
            _loc5 = this.md5_ff(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 11], 22, -1990404162);
            _loc4 = this.md5_ff(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 12], 7, 1804603682);
            _loc7 = this.md5_ff(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 13], 12, -40341101);
            _loc6 = this.md5_ff(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 14], 17, -1502002290);
            _loc5 = this.md5_ff(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 15], 22, 1236535329);
            _loc4 = this.md5_gg(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 1], 5, -165796510);
            _loc7 = this.md5_gg(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 6], 9, -1069501632);
            _loc6 = this.md5_gg(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 11], 14, 643717713);
            _loc5 = this.md5_gg(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 0], 20, -373897302);
            _loc4 = this.md5_gg(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 5], 5, -701558691);
            _loc7 = this.md5_gg(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 10], 9, 38016083);
            _loc6 = this.md5_gg(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 15], 14, -660478335);
            _loc5 = this.md5_gg(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 4], 20, -405537848);
            _loc4 = this.md5_gg(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 9], 5, 568446438);
            _loc7 = this.md5_gg(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 14], 9, -1019803690);
            _loc6 = this.md5_gg(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 3], 14, -187363961);
            _loc5 = this.md5_gg(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 8], 20, 1163531501);
            _loc4 = this.md5_gg(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 13], 5, -1444681467);
            _loc7 = this.md5_gg(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 2], 9, -51403784);
            _loc6 = this.md5_gg(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 7], 14, 1735328473);
            _loc5 = this.md5_gg(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 12], 20, -1926607734);
            _loc4 = this.md5_hh(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 5], 4, -378558);
            _loc7 = this.md5_hh(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 8], 11, -2022574463);
            _loc6 = this.md5_hh(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 11], 16, 1839030562);
            _loc5 = this.md5_hh(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 14], 23, -35309556);
            _loc4 = this.md5_hh(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 1], 4, -1530992060);
            _loc7 = this.md5_hh(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 4], 11, 1272893353);
            _loc6 = this.md5_hh(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 7], 16, -155497632);
            _loc5 = this.md5_hh(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 10], 23, -1094730640);
            _loc4 = this.md5_hh(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 13], 4, 681279174);
            _loc7 = this.md5_hh(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 0], 11, -358537222);
            _loc6 = this.md5_hh(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 3], 16, -722521979);
            _loc5 = this.md5_hh(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 6], 23, 76029189);
            _loc4 = this.md5_hh(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 9], 4, -640364487);
            _loc7 = this.md5_hh(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 12], 11, -421815835);
            _loc6 = this.md5_hh(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 15], 16, 530742520);
            _loc5 = this.md5_hh(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 2], 23, -995338651);
            _loc4 = this.md5_ii(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 0], 6, -198630844);
            _loc7 = this.md5_ii(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 7], 10, 1126891415);
            _loc6 = this.md5_ii(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 14], 15, -1416354905);
            _loc5 = this.md5_ii(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 5], 21, -57434055);
            _loc4 = this.md5_ii(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 12], 6, 1700485571);
            _loc7 = this.md5_ii(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 3], 10, -1894986606);
            _loc6 = this.md5_ii(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 10], 15, -1051523);
            _loc5 = this.md5_ii(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 1], 21, -2054922799);
            _loc4 = this.md5_ii(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 8], 6, 1873313359);
            _loc7 = this.md5_ii(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 15], 10, -30611744);
            _loc6 = this.md5_ii(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 6], 15, -1560198380);
            _loc5 = this.md5_ii(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 13], 21, 1309151649);
            _loc4 = this.md5_ii(_loc4, _loc5, _loc6, _loc7, x[_loc8 + 4], 6, -145523070);
            _loc7 = this.md5_ii(_loc7, _loc4, _loc5, _loc6, x[_loc8 + 11], 10, -1120210379);
            _loc6 = this.md5_ii(_loc6, _loc7, _loc4, _loc5, x[_loc8 + 2], 15, 718787259);
            _loc5 = this.md5_ii(_loc5, _loc6, _loc7, _loc4, x[_loc8 + 9], 21, -343485551);
            _loc4 = this.safe_add(_loc4, _loc9);
            _loc5 = this.safe_add(_loc5, _loc10);
            _loc6 = this.safe_add(_loc6, _loc11);
            _loc7 = this.safe_add(_loc7, _loc12);
        } // end while
        return ([_loc4, _loc5, _loc6, _loc7]);
    };
    _loc1.md5_cmn = function (q, a, b, x, s, t)
    {
        return (this.safe_add(this.bit_rol(this.safe_add(this.safe_add(a, q), this.safe_add(x, t)), s), b));
    };
    _loc1.md5_ff = function (a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(b & c | (b ^ -1) & d, a, b, x, s, t));
    };
    _loc1.md5_gg = function (a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(b & d | c & (d ^ -1), a, b, x, s, t));
    };
    _loc1.md5_hh = function (a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(b ^ c ^ d, a, b, x, s, t));
    };
    _loc1.md5_ii = function (a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(c ^ (b | d ^ -1), a, b, x, s, t));
    };
    _loc1.core_hmac_md5 = function (key, data)
    {
        var _loc4 = this.str2binl(key);
        if (_loc4.length > 16)
        {
            _loc4 = this.core_md5(_loc4, key.length * this.chrsz);
        } // end if
        var _loc5 = (Array)(16);
        var _loc6 = (Array)(16);
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < 16)
        {
            _loc5[_loc7] = _loc4[_loc7] ^ 909522486;
            _loc6[_loc7] = _loc4[_loc7] ^ 1549556828;
        } // end while
        var _loc8 = this.core_md5(_loc5.concat(this.str2binl(data)), 512 + data.length * this.chrsz);
        return (this.core_md5(_loc6.concat(_loc8), 512 + 128));
    };
    _loc1.safe_add = function (x, y)
    {
        var _loc4 = (x & 65535) + (y & 65535);
        var _loc5 = (x >> 16) + (y >> 16) + (_loc4 >> 16);
        return (_loc5 << 16 | _loc4 & 65535);
    };
    _loc1.bit_rol = function (num, cnt)
    {
        return (num << cnt | num >>> 32 - cnt);
    };
    _loc1.str2binl = function (str)
    {
        var _loc3 = new Array();
        var _loc4 = (1 << this.chrsz) - 1;
        var _loc5 = 0;
        
        while (_loc5 = _loc5 + this.chrsz, _loc5 < str.length * this.chrsz)
        {
            _loc3[_loc5 >> 5] = _loc3[_loc5 >> 5] | (str.charCodeAt(_loc5 / this.chrsz) & _loc4) << _loc5 % 32;
        } // end while
        return (_loc3);
    };
    _loc1.binl2str = function (bin)
    {
        var _loc3 = "";
        var _loc4 = (1 << this.chrsz) - 1;
        var _loc5 = 0;
        
        while (_loc5 = _loc5 + this.chrsz, _loc5 < bin.length * 32)
        {
            _loc3 = _loc3 + String.fromCharCode(bin[_loc5 >> 5] >>> _loc5 % 32 & _loc4);
        } // end while
        return (_loc3);
    };
    _loc1.binl2hex = function (binarray)
    {
        var _loc3 = this.hexcase ? ("0123456789ABCDEF") : ("0123456789abcdef");
        var _loc4 = "";
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < binarray.length * 4)
        {
            _loc4 = _loc4 + (_loc3.charAt(binarray[_loc5 >> 2] >> _loc5 % 4 * 8 + 4 & 15) + _loc3.charAt(binarray[_loc5 >> 2] >> _loc5 % 4 * 8 & 15));
        } // end while
        return (_loc4);
    };
    _loc1.binl2b64 = function (binarray)
    {
        var _loc3 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        var _loc4 = "";
        var _loc5 = 0;
        
        while (_loc5 = _loc5 + 3, _loc5 < binarray.length * 4)
        {
            var _loc6 = (binarray[_loc5 >> 2] >> 8 * (_loc5 % 4) & 255) << 16 | (binarray[_loc5 + 1 >> 2] >> 8 * ((_loc5 + 1) % 4) & 255) << 8 | binarray[_loc5 + 2 >> 2] >> 8 * ((_loc5 + 2) % 4) & 255;
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < 4)
            {
                if (_loc5 * 8 + _loc7 * 6 > binarray.length * 32)
                {
                    _loc4 = _loc4 + this.b64pad;
                    continue;
                } // end if
                _loc4 = _loc4 + _loc3.charAt(_loc6 >> 6 * (3 - _loc7) & 63);
            } // end while
        } // end while
        return (_loc4);
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1.hexcase = 0;
    _loc1.b64pad = "";
    _loc1.chrsz = 8;
} // end if
#endinitclip
