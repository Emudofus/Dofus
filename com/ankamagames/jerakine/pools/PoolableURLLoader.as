package com.ankamagames.jerakine.pools
{
   import flash.net.URLLoader;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.errors.IOError;
   import flash.net.URLRequest;
   
   public class PoolableURLLoader extends URLLoader implements Poolable
   {
      
      public function PoolableURLLoader(request:URLRequest = null) {
         super(request);
      }
      
      protected static const _log:Logger;
      
      public function free() : void {
         try
         {
            close();
         }
         catch(ioe:IOError)
         {
         }
      }
   }
}
