package com.ankamagames.berilia.utils.errors
{
   public class UntrustedApiCallError extends Error
   {
      
      public function UntrustedApiCallError(message:String = "", id:int = 0) {
         super(message,id);
      }
   }
}
