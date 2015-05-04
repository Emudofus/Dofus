package com.hurlant.crypto.symmetric
{
   import com.hurlant.crypto.prng.Random;
   import flash.utils.ByteArray;
   import com.hurlant.util.Memory;
   
   public class IVMode extends Object
   {
      
      public function IVMode(param1:ISymmetricKey, param2:IPad = null)
      {
         super();
         this.key = param1;
         this.blockSize = param1.getBlockSize();
         if(param2 == null)
         {
            var param2:IPad = new PKCS5(this.blockSize);
         }
         else
         {
            param2.setBlockSize(this.blockSize);
         }
         this.padding = param2;
         this.prng = new Random();
         this.iv = null;
         this.lastIV = new ByteArray();
      }
      
      protected var key:ISymmetricKey;
      
      protected var padding:IPad;
      
      protected var prng:Random;
      
      protected var iv:ByteArray;
      
      protected var lastIV:ByteArray;
      
      protected var blockSize:uint;
      
      public function getBlockSize() : uint
      {
         return this.key.getBlockSize();
      }
      
      public function dispose() : void
      {
         var _loc1_:uint = 0;
         if(this.iv != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.iv.length)
            {
               this.iv[_loc1_] = this.prng.nextByte();
               _loc1_++;
            }
            this.iv.length = 0;
            this.iv = null;
         }
         if(this.lastIV != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.iv.length)
            {
               this.lastIV[_loc1_] = this.prng.nextByte();
               _loc1_++;
            }
            this.lastIV.length = 0;
            this.lastIV = null;
         }
         this.key.dispose();
         this.key = null;
         this.padding = null;
         this.prng.dispose();
         this.prng = null;
         Memory.gc();
      }
      
      public function set IV(param1:ByteArray) : void
      {
         this.iv = param1;
         this.lastIV.length = 0;
         this.lastIV.writeBytes(this.iv);
      }
      
      public function get IV() : ByteArray
      {
         return this.lastIV;
      }
      
      protected function getIV4e() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         if(this.iv)
         {
            _loc1_.writeBytes(this.iv);
         }
         else
         {
            this.prng.nextBytes(_loc1_,this.blockSize);
         }
         this.lastIV.length = 0;
         this.lastIV.writeBytes(_loc1_);
         return _loc1_;
      }
      
      protected function getIV4d() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         if(this.iv)
         {
            _loc1_.writeBytes(this.iv);
            return _loc1_;
         }
         throw new Error("an IV must be set before calling decrypt()");
      }
   }
}
