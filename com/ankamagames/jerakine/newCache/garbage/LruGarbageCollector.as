package com.ankamagames.jerakine.newCache.garbage
{
   import com.ankamagames.jerakine.newCache.ICacheGarbageCollector;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class LruGarbageCollector extends Object implements ICacheGarbageCollector
   {
      
      public function LruGarbageCollector() {
         this._usageCount = new Dictionary(true);
         super();
      }
      
      protected var _usageCount:Dictionary;
      
      private var _cache:ICache;
      
      public function set cache(param1:ICache) : void {
         this._cache = param1;
      }
      
      public function used(param1:*) : void {
         if(this._usageCount[param1])
         {
            this._usageCount[param1]++;
         }
         else
         {
            this._usageCount[param1] = 1;
         }
      }
      
      public function purge(param1:uint) : void {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:Array = new Array();
         for (_loc3_ in this._usageCount)
         {
            _loc2_.push(
               {
                  "ref":_loc3_,
                  "count":this._usageCount[_loc3_]
               });
         }
         _loc2_.sortOn("count",Array.NUMERIC | Array.DESCENDING);
         while(this._cache.size > param1 && (_loc2_.length))
         {
            _loc4_ = this._cache.extract(_loc2_.pop().ref);
            if(_loc4_ is IDestroyable)
            {
               (_loc4_ as IDestroyable).destroy();
            }
            if(_loc4_ is BitmapData)
            {
               (_loc4_ as BitmapData).dispose();
            }
            if(_loc4_ is ByteArray)
            {
               (_loc4_ as ByteArray).clear();
            }
         }
      }
   }
}
