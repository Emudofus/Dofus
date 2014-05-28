package com.ankamagames.jerakine.newCache.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.newCache.ICacheGarbageCollector;
   
   public class Cache extends InfiniteCache implements ICache
   {
      
      public function Cache(bounds:uint, gc:ICacheGarbageCollector) {
         super();
         this._bounds = bounds;
         this._gc = gc;
         this._gc.cache = this;
      }
      
      private static var _namedCacheIndex:Array;
      
      public static function create(bounds:uint, gc:ICacheGarbageCollector, name:String) : Cache {
         var cache:Cache = null;
         if((name) && (_namedCacheIndex[name]))
         {
            return _namedCacheIndex[name];
         }
         cache = new Cache(bounds,gc);
         if(name)
         {
            _namedCacheIndex[name] = cache;
            cache._name = name;
         }
         return cache;
      }
      
      private var _bounds:uint;
      
      private var _gc:ICacheGarbageCollector;
      
      private var _name:String;
      
      override public function destroy() : void {
         if(this._name)
         {
            delete _namedCacheIndex[this._name];
         }
         super.destroy();
      }
      
      override public function extract(ref:*) : * {
         this._gc.used(ref);
         return super.extract(ref);
      }
      
      override public function peek(ref:*) : * {
         this._gc.used(ref);
         return super.peek(ref);
      }
      
      override public function store(ref:*, obj:*) : Boolean {
         if(_size + 1 > this._bounds)
         {
            this._gc.purge(this._bounds - 1);
         }
         super.store(ref,obj);
         this._gc.used(ref);
         return true;
      }
   }
}
