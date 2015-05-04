package com.hurlant.crypto.symmetric
{
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   public class SimpleIVMode extends Object implements IMode, ICipher
   {
      
      public function SimpleIVMode(param1:IVMode)
      {
         super();
         this.mode = param1;
         this.cipher = param1 as ICipher;
      }
      
      protected var mode:IVMode;
      
      protected var cipher:ICipher;
      
      public function getBlockSize() : uint
      {
         return this.mode.getBlockSize();
      }
      
      public function dispose() : void
      {
         this.mode.dispose();
         this.mode = null;
         this.cipher = null;
         Memory.gc();
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         this.cipher.encrypt(param1);
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(this.mode.IV);
         _loc2_.writeBytes(param1);
         param1.position = 0;
         param1.writeBytes(_loc2_);
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(param1,0,this.getBlockSize());
         this.mode.IV = _loc2_;
         _loc2_ = new ByteArray();
         _loc2_.writeBytes(param1,this.getBlockSize());
         this.cipher.decrypt(_loc2_);
         param1.length = 0;
         param1.writeBytes(_loc2_);
      }
      
      public function toString() : String
      {
         return "simple-" + this.cipher.toString();
      }
   }
}
