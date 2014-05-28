package com.ankamagames.berilia.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class UriCacheFactory extends Object
   {
      
      public function UriCacheFactory() {
         super();
      }
      
      private static var _log:Logger;
      
      private static var _aCache:Array;
      
      public static function init(path:String, cacheClass:ICache) : ICache {
         _aCache[path] = cacheClass;
         return cacheClass;
      }
      
      public static function getCacheFromUri(uri:Uri) : ICache {
         var key:String = null;
         var currentPath:String = uri.normalizedUri;
         for(key in _aCache)
         {
            if(currentPath.indexOf(key) != -1)
            {
               return _aCache[key];
            }
         }
         return null;
      }
      
      public static function get caches() : Array {
         return _aCache;
      }
   }
}
