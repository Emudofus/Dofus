package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class OFBMode extends IVMode implements IMode
   {
      
      public function OFBMode(param1:ISymmetricKey, param2:IPad = null)
      {
         super(param1,null);
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = getIV4e();
         this.core(param1,_loc2_);
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = getIV4d();
         this.core(param1,_loc2_);
      }
      
      private function core(param1:ByteArray, param2:ByteArray) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = param1.length;
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            key.encrypt(param2);
            _loc4_.position = 0;
            _loc4_.writeBytes(param2);
            _loc6_ = _loc5_ + blockSize < _loc3_?blockSize:_loc3_ - _loc5_;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               param1[_loc5_ + _loc7_] = param1[_loc5_ + _loc7_] ^ param2[_loc7_];
               _loc7_++;
            }
            param2.position = 0;
            param2.writeBytes(_loc4_);
            _loc5_ = _loc5_ + blockSize;
         }
      }
      
      public function toString() : String
      {
         return key.toString() + "-ofb";
      }
   }
}
