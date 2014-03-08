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
      
      public function PoolableURLLoader(param1:URLRequest=null) {
         super(param1);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolableURLLoader));
      
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
