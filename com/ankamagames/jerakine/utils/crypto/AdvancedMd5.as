package com.ankamagames.jerakine.utils.crypto
{
   public class AdvancedMd5 extends Object
   {
      
      public function AdvancedMd5() {
         super();
      }
      
      public static const HEX_FORMAT_LOWERCASE:uint = 0;
      
      public static const HEX_FORMAT_UPPERCASE:uint = 1;
      
      public static const BASE64_PAD_CHARACTER_DEFAULT_COMPLIANCE:String = "";
      
      public static const BASE64_PAD_CHARACTER_RFC_COMPLIANCE:String = "=";
      
      public static var hexcase:uint = 0;
      
      public static var b64pad:String = "";
      
      public static function encrypt(param1:String) : String {
         return hex_md5(param1);
      }
      
      public static function hex_md5(param1:String) : String {
         return rstr2hex(rstr_md5(str2rstr_utf8(param1)));
      }
      
      public static function b64_md5(param1:String) : String {
         return rstr2b64(rstr_md5(str2rstr_utf8(param1)));
      }
      
      public static function any_md5(param1:String, param2:String) : String {
         return rstr2any(rstr_md5(str2rstr_utf8(param1)),param2);
      }
      
      public static function hex_hmac_md5(param1:String, param2:String) : String {
         return rstr2hex(rstr_hmac_md5(str2rstr_utf8(param1),str2rstr_utf8(param2)));
      }
      
      public static function b64_hmac_md5(param1:String, param2:String) : String {
         return rstr2b64(rstr_hmac_md5(str2rstr_utf8(param1),str2rstr_utf8(param2)));
      }
      
      public static function any_hmac_md5(param1:String, param2:String, param3:String) : String {
         return rstr2any(rstr_hmac_md5(str2rstr_utf8(param1),str2rstr_utf8(param2)),param3);
      }
      
      public static function md5_vm_test() : Boolean {
         return hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72";
      }
      
      public static function rstr_md5(param1:String) : String {
         return binl2rstr(binl_md5(rstr2binl(param1),param1.length * 8));
      }
      
      public static function rstr_hmac_md5(param1:String, param2:String) : String {
         var _loc3_:Array = rstr2binl(param1);
         if(_loc3_.length > 16)
         {
            _loc3_ = binl_md5(_loc3_,param1.length * 8);
         }
         var _loc4_:Array = new Array(16);
         var _loc5_:Array = new Array(16);
         var _loc6_:Number = 0;
         while(_loc6_ < 16)
         {
            _loc4_[_loc6_] = _loc3_[_loc6_] ^ 909522486;
            _loc5_[_loc6_] = _loc3_[_loc6_] ^ 1549556828;
            _loc6_++;
         }
         var _loc7_:Array = binl_md5(_loc4_.concat(rstr2binl(param2)),512 + param2.length * 8);
         return binl2rstr(binl_md5(_loc5_.concat(_loc7_),512 + 128));
      }
      
      public static function rstr2hex(param1:String) : String {
         var _loc4_:* = NaN;
         var _loc2_:String = hexcase?"0123456789ABCDEF":"0123456789abcdef";
         var _loc3_:* = "";
         var _loc5_:Number = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1.charCodeAt(_loc5_);
            _loc3_ = _loc3_ + (_loc2_.charAt(_loc4_ >>> 4 & 15) + _loc2_.charAt(_loc4_ & 15));
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function rstr2b64(param1:String) : String {
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc2_:* = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
         var _loc3_:* = "";
         var _loc4_:Number = param1.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.charCodeAt(_loc5_) << 16 | (_loc5_ + 1 < _loc4_?param1.charCodeAt(_loc5_ + 1) << 8:0) | (_loc5_ + 2 < _loc4_?param1.charCodeAt(_loc5_ + 2):0);
            _loc7_ = 0;
            while(_loc7_ < 4)
            {
               if(_loc5_ * 8 + _loc7_ * 6 > param1.length * 8)
               {
                  _loc3_ = _loc3_ + b64pad;
               }
               else
               {
                  _loc3_ = _loc3_ + _loc2_.charAt(_loc6_ >>> 6 * (3 - _loc7_) & 63);
               }
               _loc7_++;
            }
            _loc5_ = _loc5_ + 3;
         }
         return _loc3_;
      }
      
      public static function rstr2any(param1:String, param2:String) : String {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:Array = null;
         var _loc3_:Number = param2.length;
         var _loc4_:Array = [];
         var _loc9_:Array = new Array(param1.length / 2);
         _loc5_ = 0;
         while(_loc5_ < _loc9_.length)
         {
            _loc9_[_loc5_] = param1.charCodeAt(_loc5_ * 2) << 8 | param1.charCodeAt(_loc5_ * 2 + 1);
            _loc5_++;
         }
         while(_loc9_.length > 0)
         {
            _loc8_ = [];
            _loc7_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc9_.length)
            {
               _loc7_ = (_loc7_ << 16) + _loc9_[_loc5_];
               _loc6_ = Math.floor(_loc7_ / _loc3_);
               _loc7_ = _loc7_ - _loc6_ * _loc3_;
               if(_loc8_.length > 0 || _loc6_ > 0)
               {
                  _loc8_[_loc8_.length] = _loc6_;
               }
               _loc5_++;
            }
            _loc4_[_loc4_.length] = _loc7_;
            _loc9_ = _loc8_;
         }
         var _loc10_:* = "";
         _loc5_ = _loc4_.length-1;
         while(_loc5_ >= 0)
         {
            _loc10_ = _loc10_ + param2.charAt(_loc4_[_loc5_]);
            _loc5_--;
         }
         return _loc10_;
      }
      
      public static function str2rstr_utf8(param1:String) : String {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc2_:* = "";
         var _loc3_:Number = -1;
         while(++_loc3_ < param1.length)
         {
            _loc4_ = param1.charCodeAt(_loc3_);
            _loc5_ = _loc3_ + 1 < param1.length?param1.charCodeAt(_loc3_ + 1):0;
            if(55296 <= _loc4_ && _loc4_ <= 56319 && 56320 <= _loc5_ && _loc5_ <= 57343)
            {
               _loc4_ = 65536 + ((_loc4_ & 1023) << 10) + (_loc5_ & 1023);
               _loc3_++;
            }
            if(_loc4_ <= 127)
            {
               _loc2_ = _loc2_ + String.fromCharCode(_loc4_);
            }
            else
            {
               if(_loc4_ <= 2047)
               {
                  _loc2_ = _loc2_ + String.fromCharCode(192 | _loc4_ >>> 6 & 31,128 | _loc4_ & 63);
               }
               else
               {
                  if(_loc4_ <= 65535)
                  {
                     _loc2_ = _loc2_ + String.fromCharCode(224 | _loc4_ >>> 12 & 15,128 | _loc4_ >>> 6 & 63,128 | _loc4_ & 63);
                  }
                  else
                  {
                     if(_loc4_ <= 2097151)
                     {
                        _loc2_ = _loc2_ + String.fromCharCode(240 | _loc4_ >>> 18 & 7,128 | _loc4_ >>> 12 & 63,128 | _loc4_ >>> 6 & 63,128 | _loc4_ & 63);
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public static function str2rstr_utf16le(param1:String) : String {
         var _loc2_:* = "";
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + String.fromCharCode(param1.charCodeAt(_loc3_) & 255,param1.charCodeAt(_loc3_) >>> 8 & 255);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function str2rstr_utf16be(param1:String) : String {
         var _loc2_:* = "";
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + String.fromCharCode(param1.charCodeAt(_loc3_) >>> 8 & 255,param1.charCodeAt(_loc3_) & 255);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function rstr2binl(param1:String) : Array {
         var _loc2_:Array = new Array(param1.length >> 2);
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = 0;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length * 8)
         {
            _loc2_[_loc3_ >> 5] = _loc2_[_loc3_ >> 5] | (param1.charCodeAt(_loc3_ / 8) & 255) << _loc3_ % 32;
            _loc3_ = _loc3_ + 8;
         }
         return _loc2_;
      }
      
      public static function binl2rstr(param1:Array) : String {
         var _loc2_:* = "";
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length * 32)
         {
            _loc2_ = _loc2_ + String.fromCharCode(param1[_loc3_ >> 5] >>> _loc3_ % 32 & 255);
            _loc3_ = _loc3_ + 8;
         }
         return _loc2_;
      }
      
      public static function binl_md5(param1:Array, param2:Number) : Array {
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         param1[param2 >> 5] = param1[param2 >> 5] | 128 << param2 % 32;
         param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
         var _loc3_:Number = 1732584193;
         var _loc4_:Number = -271733879;
         var _loc5_:Number = -1732584194;
         var _loc6_:Number = 271733878;
         var _loc7_:Number = 0;
         while(_loc7_ < param1.length)
         {
            _loc8_ = _loc3_;
            _loc9_ = _loc4_;
            _loc10_ = _loc5_;
            _loc11_ = _loc6_;
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],7,-680876936);
            _loc6_ = md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 1],12,-389564586);
            _loc5_ = md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],17,606105819);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 3],22,-1044525330);
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],7,-176418897);
            _loc6_ = md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 5],12,1200080426);
            _loc5_ = md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],17,-1473231341);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 7],22,-45705983);
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],7,1770035416);
            _loc6_ = md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 9],12,-1958414417);
            _loc5_ = md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],17,-42063);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 11],22,-1990404162);
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],7,1804603682);
            _loc6_ = md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 13],12,-40341101);
            _loc5_ = md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],17,-1502002290);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 15],22,1236535329);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],5,-165796510);
            _loc6_ = md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 6],9,-1069501632);
            _loc5_ = md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],14,643717713);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 0],20,-373897302);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],5,-701558691);
            _loc6_ = md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 10],9,38016083);
            _loc5_ = md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],14,-660478335);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 4],20,-405537848);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],5,568446438);
            _loc6_ = md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 14],9,-1019803690);
            _loc5_ = md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],14,-187363961);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 8],20,1163531501);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],5,-1444681467);
            _loc6_ = md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 2],9,-51403784);
            _loc5_ = md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],14,1735328473);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 12],20,-1926607734);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],4,-378558);
            _loc6_ = md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 8],11,-2022574463);
            _loc5_ = md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],16,1839030562);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 14],23,-35309556);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],4,-1530992060);
            _loc6_ = md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 4],11,1272893353);
            _loc5_ = md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],16,-155497632);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 10],23,-1094730640);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],4,681279174);
            _loc6_ = md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 0],11,-358537222);
            _loc5_ = md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],16,-722521979);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 6],23,76029189);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],4,-640364487);
            _loc6_ = md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 12],11,-421815835);
            _loc5_ = md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],16,530742520);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 2],23,-995338651);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],6,-198630844);
            _loc6_ = md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 7],10,1126891415);
            _loc5_ = md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],15,-1416354905);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 5],21,-57434055);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],6,1700485571);
            _loc6_ = md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 3],10,-1894986606);
            _loc5_ = md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],15,-1051523);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 1],21,-2054922799);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],6,1873313359);
            _loc6_ = md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 15],10,-30611744);
            _loc5_ = md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],15,-1560198380);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 13],21,1309151649);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],6,-145523070);
            _loc6_ = md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 11],10,-1120210379);
            _loc5_ = md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],15,718787259);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 9],21,-343485551);
            _loc3_ = safe_add(_loc3_,_loc8_);
            _loc4_ = safe_add(_loc4_,_loc9_);
            _loc5_ = safe_add(_loc5_,_loc10_);
            _loc6_ = safe_add(_loc6_,_loc11_);
            _loc7_ = _loc7_ + 16;
         }
         return [_loc3_,_loc4_,_loc5_,_loc6_];
      }
      
      public static function md5_cmn(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number {
         return safe_add(bit_rol(safe_add(safe_add(param2,param1),safe_add(param4,param6)),param5),param3);
      }
      
      public static function md5_ff(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
         return md5_cmn(param2 & param3 | ~param2 & param4,param1,param2,param5,param6,param7);
      }
      
      public static function md5_gg(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
         return md5_cmn(param2 & param4 | param3 & ~param4,param1,param2,param5,param6,param7);
      }
      
      public static function md5_hh(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
         return md5_cmn(param2 ^ param3 ^ param4,param1,param2,param5,param6,param7);
      }
      
      public static function md5_ii(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
         return md5_cmn(param3 ^ (param2 | ~param4),param1,param2,param5,param6,param7);
      }
      
      public static function safe_add(param1:Number, param2:Number) : Number {
         var _loc3_:Number = (param1 & 65535) + (param2 & 65535);
         var _loc4_:Number = (param1 >> 16) + (param2 >> 16) + (_loc3_ >> 16);
         return _loc4_ << 16 | _loc3_ & 65535;
      }
      
      public static function bit_rol(param1:Number, param2:Number) : Number {
         return param1 << param2 | param1 >>> 32 - param2;
      }
   }
}
