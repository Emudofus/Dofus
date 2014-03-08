package by.blooddy.crypto
{
   import flash.utils.ByteArray;
   import flash.system.ApplicationDomain;
   
   public class SHA256 extends Object
   {
      
      public function SHA256() {
      }
      
      public static function hash(param1:String) : String {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         var _loc3_:String = SHA256.hashBytes(_loc2_);
         return _loc3_;
      }
      
      public static function hashBytes(param1:ByteArray) : String {
         var _loc14_:uint = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc2_:int = 1779033703;
         var _loc3_:int = -1150833019;
         var _loc4_:int = 1013904242;
         var _loc5_:int = -1521486534;
         var _loc6_:int = 1359893119;
         var _loc7_:int = -1694144372;
         var _loc8_:int = 528734635;
         var _loc9_:int = 1541459225;
         var _loc10_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc11_:uint = param1.length << 3;
         var _loc12_:uint = 512 + ((_loc11_ + 64 >>> 9 << 4) + 15 << 2);
         _loc14_ = _loc12_ + 4;
         var _loc15_:ByteArray = new ByteArray();
         if(_loc14_ != 0)
         {
            _loc15_.length = _loc14_;
         }
         var _loc13_:ByteArray = _loc15_;
         _loc13_.position = 512;
         _loc13_.writeBytes(param1);
         if(_loc13_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc13_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc13_;
         var _loc16_:Array = [1116352408,1899447441,-1245643825,-373957723,961987163,1508970993,-1841331548,-1424204075,-670586216,310598401,607225278,1426881987,1925078388,-2132889090,-1680079193,-1046744716,-459576895,-272742522,264347078,604807628,770255983,1249150122,1555081692,1996064986,-1740746414,-1473132947,-1341970488,-1084653625,-958395405,-710438585,113926993,338241895,666307205,773529912,1294757372,1396182291,1695183700,1986661051,-2117940946,-1838011259,-1564481375,-1474664885,-1035236496,-949202525,-778901479,-694614492,-200395387,275423344,430227734,506948616,659060556,883997877,958139571,1322822218,1537002063,1747873779,1955562222,2024104815,-2067236844,-1933114872,-1866530822,-1538233109,-1090935817,-965641998];
         _loc11_ = 0;
         do
         {
               _loc11_++;
            }while(_loc11_ < 64);
            
            _loc11_ = 512;
            do
            {
                  _loc17_ = _loc2_;
                  _loc18_ = _loc3_;
                  _loc19_ = _loc4_;
                  _loc20_ = _loc5_;
                  _loc21_ = _loc6_;
                  _loc22_ = _loc7_;
                  _loc23_ = _loc8_;
                  _loc24_ = _loc9_;
                  _loc14_ = 0;
                  do
                  {
                        _loc27_ = op_li8(_loc11_ + _loc14_) /*Alchemy*/ << 24 | op_li8(_loc11_ + _loc14_ + 1) /*Alchemy*/ << 16 | op_li8(_loc11_ + _loc14_ + 2) /*Alchemy*/ << 8 | op_li8(_loc11_ + _loc14_ + 3) /*Alchemy*/;
                        _loc29_ = _loc24_ + ((_loc21_ << 26 | _loc21_ >>> 6) ^ (_loc21_ << 21 | _loc21_ >>> 11) ^ (_loc21_ << 7 | _loc21_ >>> 25)) + (_loc21_ & _loc22_ ^ ~_loc21_ & _loc23_) + op_li32(256 + _loc14_) /*Alchemy*/ + _loc27_;
                        _loc28_ = ((_loc17_ << 30 | _loc17_ >>> 2) ^ (_loc17_ << 19 | _loc17_ >>> 13) ^ (_loc17_ << 10 | _loc17_ >>> 22)) + (_loc17_ & _loc18_ ^ _loc17_ & _loc19_ ^ _loc18_ & _loc19_);
                        _loc24_ = _loc23_;
                        _loc23_ = _loc22_;
                        _loc22_ = _loc21_;
                        _loc21_ = _loc20_ + _loc29_;
                        _loc20_ = _loc19_;
                        _loc19_ = _loc18_;
                        _loc18_ = _loc17_;
                        _loc17_ = _loc29_ + _loc28_;
                        _loc14_ = _loc14_ + 4;
                     }while(_loc14_ < 64);
                     
                     do
                     {
                           _loc25_ = op_li32(_loc14_ - 8) /*Alchemy*/;
                           _loc26_ = op_li32(_loc14_ - 60) /*Alchemy*/;
                           _loc27_ = ((_loc25_ << 15 | _loc25_ >>> 17) ^ (_loc25_ << 13 | _loc25_ >>> 19) ^ _loc25_ >>> 10) + op_li32(_loc14_ - 28) /*Alchemy*/ + ((_loc26_ << 25 | _loc26_ >>> 7) ^ (_loc26_ << 14 | _loc26_ >>> 18) ^ _loc26_ >>> 3) + op_li32(_loc14_ - 64) /*Alchemy*/;
                           _loc29_ = _loc24_ + ((_loc21_ << 26 | _loc21_ >>> 6) ^ (_loc21_ << 21 | _loc21_ >>> 11) ^ (_loc21_ << 7 | _loc21_ >>> 25)) + (_loc21_ & _loc22_ ^ ~_loc21_ & _loc23_) + op_li32(256 + _loc14_) /*Alchemy*/ + _loc27_;
                           _loc28_ = ((_loc17_ << 30 | _loc17_ >>> 2) ^ (_loc17_ << 19 | _loc17_ >>> 13) ^ (_loc17_ << 10 | _loc17_ >>> 22)) + (_loc17_ & _loc18_ ^ _loc17_ & _loc19_ ^ _loc18_ & _loc19_);
                           _loc24_ = _loc23_;
                           _loc23_ = _loc22_;
                           _loc22_ = _loc21_;
                           _loc21_ = _loc20_ + _loc29_;
                           _loc20_ = _loc19_;
                           _loc19_ = _loc18_;
                           _loc18_ = _loc17_;
                           _loc17_ = _loc29_ + _loc28_;
                           _loc14_ = _loc14_ + 4;
                        }while(_loc14_ < 256);
                        
                        _loc2_ = _loc2_ + _loc17_;
                        _loc3_ = _loc3_ + _loc18_;
                        _loc4_ = _loc4_ + _loc19_;
                        _loc5_ = _loc5_ + _loc20_;
                        _loc6_ = _loc6_ + _loc21_;
                        _loc7_ = _loc7_ + _loc22_;
                        _loc8_ = _loc8_ + _loc23_;
                        _loc9_ = _loc9_ + _loc24_;
                        _loc11_ = _loc11_ + 64;
                     }while(_loc11_ < _loc12_);
                     
                     _loc13_.position = 0;
                     _loc13_.writeUTFBytes("0123456789abcdef");
                     _loc18_ = 47;
                     _loc11_ = 16;
                     do
                     {
                           _loc17_ = op_li8(_loc11_) /*Alchemy*/;
                           _loc18_++;
                           _loc18_++;
                           _loc11_++;
                        }while(_loc11_ < 48);
                        
                        ApplicationDomain.currentDomain.domainMemory = _loc10_;
                        _loc13_.position = 48;
                        return _loc13_.readUTFBytes(64);
                     }
                  }
               }
