package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.interfaces.Secure;
   import com.ankamagames.jerakine.interfaces.INoBoxing;
   
   public dynamic class DynamicSecureObject extends Object implements Secure, INoBoxing
   {
      
      public function DynamicSecureObject() {
         super();
      }
      
      public function getObject(param1:Object) : * {
         return this;
      }
   }
}
