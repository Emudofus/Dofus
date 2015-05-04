package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class NullPad extends Object implements IPad
   {
      
      public function NullPad()
      {
         super();
      }
      
      public function unpad(param1:ByteArray) : void
      {
      }
      
      public function pad(param1:ByteArray) : void
      {
      }
      
      public function setBlockSize(param1:uint) : void
      {
      }
   }
}
