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
      
      public function set cache(cache:ICache) : void {
         this._cache = cache;
      }
      
      public function used(ref:*) : void {
         if(this._usageCount[ref])
         {
            this._usageCount[ref]++;
         }
         else
         {
            this._usageCount[ref] = 1;
         }
      }
      
      public function purge(bounds:uint) : void {
         var obj:* = undefined;
         var poke:* = undefined;
         var elements:Array = new Array();
         for (obj in this._usageCount)
         {
            elements.push(
               {
                  "ref":obj,
                  "count":this._usageCount[obj]
               });
         }
         elements.sortOn("count",Array.NUMERIC | Array.DESCENDING);
         while((this._cache.size > bounds) && (elements.length))
         {
            poke = this._cache.extract(elements.pop().ref);
            if(poke is IDestroyable)
            {
               (poke as IDestroyable).destroy();
            }
            if(poke is BitmapData)
            {
               (poke as BitmapData).dispose();
            }
            if(poke is ByteArray)
            {
               (poke as ByteArray).clear();
            }
         }
      }
   }
}
