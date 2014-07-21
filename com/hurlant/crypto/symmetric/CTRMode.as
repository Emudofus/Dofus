package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class CTRMode extends IVMode implements IMode
   {
      
      public function CTRMode(key:ISymmetricKey, padding:IPad = null) {
         super(key,padding);
      }
      
      public function encrypt(src:ByteArray) : void {
         padding.pad(src);
         var vector:ByteArray = getIV4e();
         this.core(src,vector);
      }
      
      public function decrypt(src:ByteArray) : void {
         var vector:ByteArray = getIV4d();
         this.core(src,vector);
         padding.unpad(src);
      }
      
      private function core(src:ByteArray, iv:ByteArray) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function toString() : String {
         return key.toString() + "-ctr";
      }
   }
}
