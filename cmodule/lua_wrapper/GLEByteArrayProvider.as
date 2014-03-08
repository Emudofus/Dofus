package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class GLEByteArrayProvider extends Object
   {
      
      function GLEByteArrayProvider() {
         super();
      }
      
      public static function get() : ByteArray {
         var result:ByteArray = null;
         try
         {
            result = GLEByteArrayProvider.currentDomain.domainMemory;
         }
         catch(e:*)
         {
         }
         if(!result)
         {
            result = new LEByteArray();
            try
            {
               result.length = GLEByteArrayProvider.MIN_DOMAIN_MEMORY_LENGTH;
               GLEByteArrayProvider.currentDomain.domainMemory = result;
            }
            catch(e:*)
            {
               log(3,"Not using domain memory");
            }
         }
         return result;
      }
   }
}
