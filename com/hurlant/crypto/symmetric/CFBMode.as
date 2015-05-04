package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class CFBMode extends IVMode implements IMode
   {
      
      public function CFBMode(param1:ISymmetricKey, param2:IPad = null)
      {
         super(param1,null);
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = param1.length;
         var _loc3_:ByteArray = getIV4e();
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            key.encrypt(_loc3_);
            _loc5_ = _loc4_ + blockSize < _loc2_?blockSize:_loc2_ - _loc4_;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               param1[_loc4_ + _loc6_] = param1[_loc4_ + _loc6_] ^ _loc3_[_loc6_];
               _loc6_++;
            }
            _loc3_.position = 0;
            _loc3_.writeBytes(param1,_loc4_,_loc5_);
            _loc4_ = _loc4_ + blockSize;
         }
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:uint = param1.length;
         var _loc3_:ByteArray = getIV4d();
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            key.encrypt(_loc3_);
            _loc6_ = _loc5_ + blockSize < _loc2_?blockSize:_loc2_ - _loc5_;
            _loc4_.position = 0;
            _loc4_.writeBytes(param1,_loc5_,_loc6_);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               param1[_loc5_ + _loc7_] = param1[_loc5_ + _loc7_] ^ _loc3_[_loc7_];
               _loc7_++;
            }
            _loc3_.position = 0;
            _loc3_.writeBytes(_loc4_);
            _loc5_ = _loc5_ + blockSize;
         }
      }
      
      public function toString() : String
      {
         return key.toString() + "-cfb";
      }
   }
}
