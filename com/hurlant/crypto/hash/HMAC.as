package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   
   public class HMAC extends Object implements IHMAC
   {
      
      public function HMAC(param1:IHash, param2:uint = 0)
      {
         super();
         this.hash = param1;
         this.bits = param2;
      }
      
      private var hash:IHash;
      
      private var bits:uint;
      
      public function getHashSize() : uint
      {
         if(this.bits != 0)
         {
            return this.bits / 8;
         }
         return this.hash.getHashSize();
      }
      
      public function compute(param1:ByteArray, param2:ByteArray) : ByteArray
      {
         var _loc3_:ByteArray = null;
         if(param1.length > this.hash.getInputSize())
         {
            _loc3_ = this.hash.hash(param1);
         }
         else
         {
            _loc3_ = new ByteArray();
            _loc3_.writeBytes(param1);
         }
         while(_loc3_.length < this.hash.getInputSize())
         {
            _loc3_[_loc3_.length] = 0;
         }
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc4_[_loc6_] = _loc3_[_loc6_] ^ 54;
            _loc5_[_loc6_] = _loc3_[_loc6_] ^ 92;
            _loc6_++;
         }
         _loc4_.position = _loc3_.length;
         _loc4_.writeBytes(param2);
         var _loc7_:ByteArray = this.hash.hash(_loc4_);
         _loc5_.position = _loc3_.length;
         _loc5_.writeBytes(_loc7_);
         var _loc8_:ByteArray = this.hash.hash(_loc5_);
         if(this.bits > 0 && this.bits < 8 * _loc8_.length)
         {
            _loc8_.length = this.bits / 8;
         }
         return _loc8_;
      }
      
      public function dispose() : void
      {
         this.hash = null;
         this.bits = 0;
      }
      
      public function toString() : String
      {
         return "hmac-" + (this.bits > 0?this.bits + "-":"") + this.hash.toString();
      }
   }
}
