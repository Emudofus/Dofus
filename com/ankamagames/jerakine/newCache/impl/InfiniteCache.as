package com.ankamagames.jerakine.newCache.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.utils.Dictionary;
   
   public class InfiniteCache extends Object implements ICache
   {
      
      public function InfiniteCache() {
         this._cache = new Dictionary(true);
         super();
      }
      
      protected var _cache:Dictionary;
      
      protected var _size:uint;
      
      public function get size() : uint {
         return this._size;
      }
      
      public function contains(param1:*) : Boolean {
         return !(this._cache[param1] == null);
      }
      
      public function extract(param1:*) : * {
         var _loc2_:* = this._cache[param1];
         delete this._cache[[param1]];
         this._size--;
         return _loc2_;
      }
      
      public function peek(param1:*) : * {
         return this._cache[param1];
      }
      
      public function store(param1:*, param2:*) : Boolean {
         this._cache[param1] = param2;
         this._size++;
         return true;
      }
      
      public function destroy() : void {
         this._cache = new Dictionary(true);
         this._size = 0;
      }
   }
}
