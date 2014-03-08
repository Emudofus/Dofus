package by.blooddy.crypto
{
   import flash.utils.ByteArray;
   import flash.system.ApplicationDomain;
   
   public class MD5 extends Object
   {
      
      public function MD5() {
      }
      
      public static function hash(param1:String) : String {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         var _loc3_:String = MD5.hashBytes(_loc2_);
         return _loc3_;
      }
      
      public static function hashBytes(param1:ByteArray) : String {
         var _loc2_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc3_:uint = param1.length << 3;
         var _loc4_:uint = (_loc3_ + 64 >>> 9 << 4) + 15 << 2;
         var _loc6_:uint = _loc4_ + 4;
         var _loc7_:ByteArray = new ByteArray();
         if(_loc6_ != 0)
         {
            _loc7_.length = _loc6_;
         }
         var _loc5_:ByteArray = _loc7_;
         _loc5_.writeBytes(param1);
         if(_loc5_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc5_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc5_;
         var _loc8_:int = 1732584193;
         var _loc9_:int = -271733879;
         var _loc10_:int = -1732584194;
         var _loc11_:int = 271733878;
         var _loc12_:int = _loc8_;
         var _loc13_:int = _loc9_;
         var _loc14_:int = _loc10_;
         var _loc15_:int = _loc11_;
         _loc3_ = 0;
         do
         {
               _loc12_ = _loc8_;
               _loc13_ = _loc9_;
               _loc14_ = _loc10_;
               _loc15_ = _loc11_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + op_li32(_loc3_) /*Alchemy*/ + -680876936);
               _loc8_ = (_loc8_ << (7) | _loc8_ >>> 25) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + op_li32(_loc3_ + 4) /*Alchemy*/ + -389564586);
               _loc11_ = (_loc11_ << (12) | _loc11_ >>> 20) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + op_li32(_loc3_ + 8) /*Alchemy*/ + 606105819);
               _loc10_ = (_loc10_ << (17) | _loc10_ >>> 15) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + op_li32(_loc3_ + 12) /*Alchemy*/ + -1044525330);
               _loc9_ = (_loc9_ << (22) | _loc9_ >>> 10) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + op_li32(_loc3_ + 16) /*Alchemy*/ + -176418897);
               _loc8_ = (_loc8_ << (7) | _loc8_ >>> 25) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + op_li32(_loc3_ + 20) /*Alchemy*/ + 1200080426);
               _loc11_ = (_loc11_ << (12) | _loc11_ >>> 20) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + op_li32(_loc3_ + 24) /*Alchemy*/ + -1473231341);
               _loc10_ = (_loc10_ << (17) | _loc10_ >>> 15) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + op_li32(_loc3_ + 28) /*Alchemy*/ + -45705983);
               _loc9_ = (_loc9_ << (22) | _loc9_ >>> 10) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + op_li32(_loc3_ + 32) /*Alchemy*/ + 1770035416);
               _loc8_ = (_loc8_ << (7) | _loc8_ >>> 25) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + op_li32(_loc3_ + 36) /*Alchemy*/ + -1958414417);
               _loc11_ = (_loc11_ << (12) | _loc11_ >>> 20) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + op_li32(_loc3_ + 40) /*Alchemy*/ + -42063);
               _loc10_ = (_loc10_ << (17) | _loc10_ >>> 15) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + op_li32(_loc3_ + 44) /*Alchemy*/ + -1990404162);
               _loc9_ = (_loc9_ << (22) | _loc9_ >>> 10) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + op_li32(_loc3_ + 48) /*Alchemy*/ + 1804603682);
               _loc8_ = (_loc8_ << (7) | _loc8_ >>> 25) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + op_li32(_loc3_ + 52) /*Alchemy*/ + -40341101);
               _loc11_ = (_loc11_ << (12) | _loc11_ >>> 20) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + op_li32(_loc3_ + 56) /*Alchemy*/ + -1502002290);
               _loc10_ = (_loc10_ << (17) | _loc10_ >>> 15) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + op_li32(_loc3_ + 60) /*Alchemy*/ + 1236535329);
               _loc9_ = (_loc9_ << (22) | _loc9_ >>> 10) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + op_li32(_loc3_ + 4) /*Alchemy*/ + -165796510);
               _loc8_ = (_loc8_ << (5) | _loc8_ >>> 27) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + op_li32(_loc3_ + 24) /*Alchemy*/ + -1069501632);
               _loc11_ = (_loc11_ << (9) | _loc11_ >>> 23) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + op_li32(_loc3_ + 44) /*Alchemy*/ + 643717713);
               _loc10_ = (_loc10_ << (14) | _loc10_ >>> 18) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + op_li32(_loc3_) /*Alchemy*/ + -373897302);
               _loc9_ = (_loc9_ << (20) | _loc9_ >>> 12) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + op_li32(_loc3_ + 20) /*Alchemy*/ + -701558691);
               _loc8_ = (_loc8_ << (5) | _loc8_ >>> 27) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + op_li32(_loc3_ + 40) /*Alchemy*/ + 38016083);
               _loc11_ = (_loc11_ << (9) | _loc11_ >>> 23) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + op_li32(_loc3_ + 60) /*Alchemy*/ + -660478335);
               _loc10_ = (_loc10_ << (14) | _loc10_ >>> 18) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + op_li32(_loc3_ + 16) /*Alchemy*/ + -405537848);
               _loc9_ = (_loc9_ << (20) | _loc9_ >>> 12) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + op_li32(_loc3_ + 36) /*Alchemy*/ + 568446438);
               _loc8_ = (_loc8_ << (5) | _loc8_ >>> 27) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + op_li32(_loc3_ + 56) /*Alchemy*/ + -1019803690);
               _loc11_ = (_loc11_ << (9) | _loc11_ >>> 23) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + op_li32(_loc3_ + 12) /*Alchemy*/ + -187363961);
               _loc10_ = (_loc10_ << (14) | _loc10_ >>> 18) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + op_li32(_loc3_ + 32) /*Alchemy*/ + 1163531501);
               _loc9_ = (_loc9_ << (20) | _loc9_ >>> 12) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + op_li32(_loc3_ + 52) /*Alchemy*/ + -1444681467);
               _loc8_ = (_loc8_ << (5) | _loc8_ >>> 27) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + op_li32(_loc3_ + 8) /*Alchemy*/ + -51403784);
               _loc11_ = (_loc11_ << (9) | _loc11_ >>> 23) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + op_li32(_loc3_ + 28) /*Alchemy*/ + 1735328473);
               _loc10_ = (_loc10_ << (14) | _loc10_ >>> 18) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + op_li32(_loc3_ + 48) /*Alchemy*/ + -1926607734);
               _loc9_ = (_loc9_ << (20) | _loc9_ >>> 12) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ ^ _loc10_ ^ _loc11_) + op_li32(_loc3_ + 20) /*Alchemy*/ + -378558);
               _loc8_ = (_loc8_ << (4) | _loc8_ >>> 28) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ ^ _loc9_ ^ _loc10_) + op_li32(_loc3_ + 32) /*Alchemy*/ + -2022574463);
               _loc11_ = (_loc11_ << (11) | _loc11_ >>> 21) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ ^ _loc8_ ^ _loc9_) + op_li32(_loc3_ + 44) /*Alchemy*/ + 1839030562);
               _loc10_ = (_loc10_ << (16) | _loc10_ >>> 16) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ ^ _loc11_ ^ _loc8_) + op_li32(_loc3_ + 56) /*Alchemy*/ + -35309556);
               _loc9_ = (_loc9_ << (23) | _loc9_ >>> 9) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ ^ _loc10_ ^ _loc11_) + op_li32(_loc3_ + 4) /*Alchemy*/ + -1530992060);
               _loc8_ = (_loc8_ << (4) | _loc8_ >>> 28) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ ^ _loc9_ ^ _loc10_) + op_li32(_loc3_ + 16) /*Alchemy*/ + 1272893353);
               _loc11_ = (_loc11_ << (11) | _loc11_ >>> 21) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ ^ _loc8_ ^ _loc9_) + op_li32(_loc3_ + 28) /*Alchemy*/ + -155497632);
               _loc10_ = (_loc10_ << (16) | _loc10_ >>> 16) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ ^ _loc11_ ^ _loc8_) + op_li32(_loc3_ + 40) /*Alchemy*/ + -1094730640);
               _loc9_ = (_loc9_ << (23) | _loc9_ >>> 9) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ ^ _loc10_ ^ _loc11_) + op_li32(_loc3_ + 52) /*Alchemy*/ + 681279174);
               _loc8_ = (_loc8_ << (4) | _loc8_ >>> 28) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ ^ _loc9_ ^ _loc10_) + op_li32(_loc3_) /*Alchemy*/ + -358537222);
               _loc11_ = (_loc11_ << (11) | _loc11_ >>> 21) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ ^ _loc8_ ^ _loc9_) + op_li32(_loc3_ + 12) /*Alchemy*/ + -722521979);
               _loc10_ = (_loc10_ << (16) | _loc10_ >>> 16) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ ^ _loc11_ ^ _loc8_) + op_li32(_loc3_ + 24) /*Alchemy*/ + 76029189);
               _loc9_ = (_loc9_ << (23) | _loc9_ >>> 9) + _loc10_;
               _loc8_ = _loc8_ + ((_loc9_ ^ _loc10_ ^ _loc11_) + op_li32(_loc3_ + 36) /*Alchemy*/ + -640364487);
               _loc8_ = (_loc8_ << (4) | _loc8_ >>> 28) + _loc9_;
               _loc11_ = _loc11_ + ((_loc8_ ^ _loc9_ ^ _loc10_) + op_li32(_loc3_ + 48) /*Alchemy*/ + -421815835);
               _loc11_ = (_loc11_ << (11) | _loc11_ >>> 21) + _loc8_;
               _loc10_ = _loc10_ + ((_loc11_ ^ _loc8_ ^ _loc9_) + op_li32(_loc3_ + 60) /*Alchemy*/ + 530742520);
               _loc10_ = (_loc10_ << (16) | _loc10_ >>> 16) + _loc11_;
               _loc9_ = _loc9_ + ((_loc10_ ^ _loc11_ ^ _loc8_) + op_li32(_loc3_ + 8) /*Alchemy*/ + -995338651);
               _loc9_ = (_loc9_ << (23) | _loc9_ >>> 9) + _loc10_;
               _loc8_ = _loc8_ + ((_loc10_ ^ (_loc9_ | ~_loc11_)) + op_li32(_loc3_) /*Alchemy*/ + -198630844);
               _loc8_ = (_loc8_ << (6) | _loc8_ >>> 26) + _loc9_;
               _loc11_ = _loc11_ + ((_loc9_ ^ (_loc8_ | ~_loc10_)) + op_li32(_loc3_ + 28) /*Alchemy*/ + 1126891415);
               _loc11_ = (_loc11_ << (10) | _loc11_ >>> 22) + _loc8_;
               _loc10_ = _loc10_ + ((_loc8_ ^ (_loc11_ | ~_loc9_)) + op_li32(_loc3_ + 56) /*Alchemy*/ + -1416354905);
               _loc10_ = (_loc10_ << (15) | _loc10_ >>> 17) + _loc11_;
               _loc9_ = _loc9_ + ((_loc11_ ^ (_loc10_ | ~_loc8_)) + op_li32(_loc3_ + 20) /*Alchemy*/ + -57434055);
               _loc9_ = (_loc9_ << (21) | _loc9_ >>> 11) + _loc10_;
               _loc8_ = _loc8_ + ((_loc10_ ^ (_loc9_ | ~_loc11_)) + op_li32(_loc3_ + 48) /*Alchemy*/ + 1700485571);
               _loc8_ = (_loc8_ << (6) | _loc8_ >>> 26) + _loc9_;
               _loc11_ = _loc11_ + ((_loc9_ ^ (_loc8_ | ~_loc10_)) + op_li32(_loc3_ + 12) /*Alchemy*/ + -1894986606);
               _loc11_ = (_loc11_ << (10) | _loc11_ >>> 22) + _loc8_;
               _loc10_ = _loc10_ + ((_loc8_ ^ (_loc11_ | ~_loc9_)) + op_li32(_loc3_ + 40) /*Alchemy*/ + -1051523);
               _loc10_ = (_loc10_ << (15) | _loc10_ >>> 17) + _loc11_;
               _loc9_ = _loc9_ + ((_loc11_ ^ (_loc10_ | ~_loc8_)) + op_li32(_loc3_ + 4) /*Alchemy*/ + -2054922799);
               _loc9_ = (_loc9_ << (21) | _loc9_ >>> 11) + _loc10_;
               _loc8_ = _loc8_ + ((_loc10_ ^ (_loc9_ | ~_loc11_)) + op_li32(_loc3_ + 32) /*Alchemy*/ + 1873313359);
               _loc8_ = (_loc8_ << (6) | _loc8_ >>> 26) + _loc9_;
               _loc11_ = _loc11_ + ((_loc9_ ^ (_loc8_ | ~_loc10_)) + op_li32(_loc3_ + 60) /*Alchemy*/ + -30611744);
               _loc11_ = (_loc11_ << (10) | _loc11_ >>> 22) + _loc8_;
               _loc10_ = _loc10_ + ((_loc8_ ^ (_loc11_ | ~_loc9_)) + op_li32(_loc3_ + 24) /*Alchemy*/ + -1560198380);
               _loc10_ = (_loc10_ << (15) | _loc10_ >>> 17) + _loc11_;
               _loc9_ = _loc9_ + ((_loc11_ ^ (_loc10_ | ~_loc8_)) + op_li32(_loc3_ + 52) /*Alchemy*/ + 1309151649);
               _loc9_ = (_loc9_ << (21) | _loc9_ >>> 11) + _loc10_;
               _loc8_ = _loc8_ + ((_loc10_ ^ (_loc9_ | ~_loc11_)) + op_li32(_loc3_ + 16) /*Alchemy*/ + -145523070);
               _loc8_ = (_loc8_ << (6) | _loc8_ >>> 26) + _loc9_;
               _loc11_ = _loc11_ + ((_loc9_ ^ (_loc8_ | ~_loc10_)) + op_li32(_loc3_ + 44) /*Alchemy*/ + -1120210379);
               _loc11_ = (_loc11_ << (10) | _loc11_ >>> 22) + _loc8_;
               _loc10_ = _loc10_ + ((_loc8_ ^ (_loc11_ | ~_loc9_)) + op_li32(_loc3_ + 8) /*Alchemy*/ + 718787259);
               _loc10_ = (_loc10_ << (15) | _loc10_ >>> 17) + _loc11_;
               _loc9_ = _loc9_ + ((_loc11_ ^ (_loc10_ | ~_loc8_)) + op_li32(_loc3_ + 36) /*Alchemy*/ + -343485551);
               _loc9_ = (_loc9_ << (21) | _loc9_ >>> 11) + _loc10_;
               _loc8_ = _loc8_ + _loc12_;
               _loc9_ = _loc9_ + _loc13_;
               _loc10_ = _loc10_ + _loc14_;
               _loc11_ = _loc11_ + _loc15_;
               _loc3_ = _loc3_ + 64;
            }while(_loc3_ < _loc4_);
            
            _loc5_.position = 0;
            _loc5_.writeUTFBytes("0123456789abcdef");
            _loc9_ = 31;
            _loc3_ = 16;
            do
            {
                  _loc8_ = op_li8(_loc3_) /*Alchemy*/;
                  _loc9_++;
                  _loc9_++;
                  _loc3_++;
               }while(_loc3_ < 32);
               
               ApplicationDomain.currentDomain.domainMemory = _loc2_;
               _loc5_.position = 32;
               return _loc5_.readUTFBytes(32);
            }
         }
      }
