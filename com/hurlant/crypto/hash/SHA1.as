package com.hurlant.crypto.hash
{
   public class SHA1 extends SHABase implements IHash
   {
      
      public function SHA1()
      {
         super();
      }
      
      public static const HASH_SIZE:int = 20;
      
      override public function getHashSize() : uint
      {
         return HASH_SIZE;
      }
      
      override protected function core(param1:Array, param2:uint) : Array
      {
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         param1[param2 >> 5] = param1[param2 >> 5] | 128 << 24 - param2 % 32;
         param1[(param2 + 64 >> 9 << 4) + 15] = param2;
         var _loc3_:Array = [];
         var _loc4_:uint = 1732584193;
         var _loc5_:uint = 4.023233417E9;
         var _loc6_:uint = 2.562383102E9;
         var _loc7_:uint = 271733878;
         var _loc8_:uint = 3.28537752E9;
         var _loc9_:uint = 0;
         while(_loc9_ < param1.length)
         {
            _loc10_ = _loc4_;
            _loc11_ = _loc5_;
            _loc12_ = _loc6_;
            _loc13_ = _loc7_;
            _loc14_ = _loc8_;
            _loc15_ = 0;
            while(_loc15_ < 80)
            {
               if(_loc15_ < 16)
               {
                  _loc3_[_loc15_] = param1[_loc9_ + _loc15_] || 0;
               }
               else
               {
                  _loc3_[_loc15_] = this.rol(_loc3_[_loc15_ - 3] ^ _loc3_[_loc15_ - 8] ^ _loc3_[_loc15_ - 14] ^ _loc3_[_loc15_ - 16],1);
               }
               _loc16_ = this.rol(_loc4_,5) + this.ft(_loc15_,_loc5_,_loc6_,_loc7_) + _loc8_ + _loc3_[_loc15_] + this.kt(_loc15_);
               _loc8_ = _loc7_;
               _loc7_ = _loc6_;
               _loc6_ = this.rol(_loc5_,30);
               _loc5_ = _loc4_;
               _loc4_ = _loc16_;
               _loc15_++;
            }
            _loc4_ = _loc4_ + _loc10_;
            _loc5_ = _loc5_ + _loc11_;
            _loc6_ = _loc6_ + _loc12_;
            _loc7_ = _loc7_ + _loc13_;
            _loc8_ = _loc8_ + _loc14_;
            _loc9_ = _loc9_ + 16;
         }
         return [_loc4_,_loc5_,_loc6_,_loc7_,_loc8_];
      }
      
      private function rol(param1:uint, param2:uint) : uint
      {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      private function ft(param1:uint, param2:uint, param3:uint, param4:uint) : uint
      {
         if(param1 < 20)
         {
            return param2 & param3 | ~param2 & param4;
         }
         if(param1 < 40)
         {
            return param2 ^ param3 ^ param4;
         }
         if(param1 < 60)
         {
            return param2 & param3 | param2 & param4 | param3 & param4;
         }
         return param2 ^ param3 ^ param4;
      }
      
      private function kt(param1:uint) : uint
      {
         return param1 < 20?1518500249:param1 < 40?1859775393:param1 < 60?2.400959708E9:3.395469782E9;
      }
      
      override public function toString() : String
      {
         return "sha1";
      }
   }
}
