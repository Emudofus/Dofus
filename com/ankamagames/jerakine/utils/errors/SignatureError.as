package com.ankamagames.jerakine.utils.errors
{
   public class SignatureError extends Error
   {
      
      public function SignatureError(message:* = "", id:* = 0) {
         super(message,id);
      }
      
      public static const INVALID_HEADER:uint = 1;
      
      public static const INVALID_SIGNATURE:uint = 2;
   }
}
