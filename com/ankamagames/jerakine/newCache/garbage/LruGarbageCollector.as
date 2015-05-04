package com.ankamagames.jerakine.newCache.garbage
{
   import com.ankamagames.jerakine.newCache.ICacheGarbageCollector;
   import com.ankamagames.jerakine.pools.Pool;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class LruGarbageCollector extends Object implements ICacheGarbageCollector
   {
      
      public function LruGarbageCollector()
      {
         this._usageCount = new Dictionary(true);
         super();
         if(!_pool)
         {
            _pool = new Pool(LruGarbageCollector,500,50);
         }
      }
      
      private static var _pool:Pool;
      
      protected var _usageCount:Dictionary;
      
      private var _cache:ICache;
      
      public function set cache(param1:ICache) : void
      {
         this._cache = param1;
      }
      
      public function used(param1:*) : void
      {
         if(this._usageCount[param1])
         {
            this._usageCount[param1]++;
         }
         else
         {
            this._usageCount[param1] = 1;
         }
      }
      
      public function purge(param1:uint) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:UsageCountHelper = null;
         var _loc5_:* = undefined;
         var _loc2_:Array = new Array();
         for(_loc3_ in this._usageCount)
         {
            _loc2_.push((_pool.checkOut() as LruGarbageCollector).init(_loc3_,this._usageCount[_loc3_]));
         }
         _loc2_.sortOn("count",Array.NUMERIC | Array.DESCENDING);
         for each(_loc4_ in _loc2_)
         {
            _loc4_.free();
            _pool.checkIn(_loc4_);
         }
         while(this._cache.size > param1 && (_loc2_.length))
         {
            _loc5_ = this._cache.extract(_loc2_.pop().ref);
            if(_loc5_ is IDestroyable)
            {
               (_loc5_ as IDestroyable).destroy();
            }
            if(_loc5_ is BitmapData)
            {
               (_loc5_ as BitmapData).dispose();
            }
            if(_loc5_ is ByteArray)
            {
               (_loc5_ as ByteArray).clear();
            }
         }
      }
   }
}
import com.ankamagames.jerakine.pools.Poolable;

class UsageCountHelper extends Object implements Poolable
{
   
   function UsageCountHelper()
   {
      super();
   }
   
   public var ref:Object;
   
   public var count:uint;
   
   public function init(param1:Object, param2:uint) : UsageCountHelper
   {
      this.ref = param1;
      this.count = param2;
      return this;
   }
   
   public function free() : void
   {
      this.ref = null;
      this.count = 0;
   }
}
