package com.ankamagames.jerakine.pools
{
   import flash.display.Loader;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class PoolableLoader extends Loader implements Poolable
   {
      
      public function PoolableLoader() {
         super();
      }
      
      protected static const _log:Logger;
      
      public function free() : void {
         unload();
      }
   }
}
