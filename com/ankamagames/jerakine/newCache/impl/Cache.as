package com.ankamagames.jerakine.newCache.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.newCache.ICacheGarbageCollector;
   
   public class Cache extends InfiniteCache implements ICache
   {
      
      public function Cache(param1:uint, param2:ICacheGarbageCollector) {
         super();
         this._bounds = param1;
         this._gc = param2;
         this._gc.cache = this;
      }
      
      private static var _namedCacheIndex:Array = new Array();
      
      public static function create(param1:uint, param2:ICacheGarbageCollector, param3:String) : Cache {
         var _loc4_:Cache = null;
         if((param3) && (_namedCacheIndex[param3]))
         {
            return _namedCacheIndex[param3];
         }
         _loc4_ = new Cache(param1,param2);
         if(param3)
         {
            _namedCacheIndex[param3] = _loc4_;
            _loc4_._name = param3;
         }
         return _loc4_;
      }
      
      private var _bounds:uint;
      
      private var _gc:ICacheGarbageCollector;
      
      private var _name:String;
      
      override public function destroy() : void {
         if(this._name)
         {
            delete _namedCacheIndex[[this._name]];
         }
         super.destroy();
      }
      
      override public function extract(param1:*) : * {
         this._gc.used(param1);
         return super.extract(param1);
      }
      
      override public function peek(param1:*) : * {
         this._gc.used(param1);
         return super.peek(param1);
      }
      
      override public function store(param1:*, param2:*) : Boolean {
         if(_size + 1 > this._bounds)
         {
            this._gc.purge(this._bounds-1);
         }
         super.store(param1,param2);
         this._gc.used(param1);
         return true;
      }
   }
}
