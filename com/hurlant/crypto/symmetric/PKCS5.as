package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class PKCS5 extends Object implements IPad
   {
      
      public function PKCS5(param1:uint=0) {
         super();
         this.blockSize = param1;
      }
      
      private var blockSize:uint;
      
      public function pad(param1:ByteArray) : void {
         var _loc2_:uint = this.blockSize - param1.length % this.blockSize;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            param1[param1.length] = _loc2_;
            _loc3_++;
         }
      }
      
      public function unpad(param1:ByteArray) : void {
         var _loc4_:uint = 0;
         var _loc2_:uint = param1.length % this.blockSize;
         if(_loc2_ != 0)
         {
            throw new Error("PKCS#5::unpad: ByteArray.length isn\'t a multiple of the blockSize");
         }
         else
         {
            _loc2_ = param1[param1.length-1];
            _loc3_ = _loc2_;
            while(_loc3_ > 0)
            {
               _loc4_ = param1[param1.length-1];
               param1.length--;
               if(_loc2_ != _loc4_)
               {
                  throw new Error("PKCS#5:unpad: Invalid padding value. expected [" + _loc2_ + "], found [" + _loc4_ + "]");
               }
               else
               {
                  _loc3_--;
                  continue;
               }
            }
            return;
         }
      }
      
      public function setBlockSize(param1:uint) : void {
         this.blockSize = param1;
      }
   }
}
