package com.ankamagames.jerakine.newCache.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.CacheableResource;
   import com.ankamagames.jerakine.types.ASwf;
   
   public class DisplayObjectCache extends Object implements ICache
   {
      
      public function DisplayObjectCache(param1:uint) {
         this._cache = new Dictionary(true);
         this._useCount = new Dictionary(true);
         super();
         this._bounds = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisplayObjectCache));
      
      private var _cache:Dictionary;
      
      private var _size:uint = 0;
      
      private var _bounds:uint;
      
      private var _useCount:Dictionary;
      
      public function get size() : uint {
         return this._size;
      }
      
      public function contains(param1:*) : Boolean {
         var _loc3_:CacheableResource = null;
         var _loc2_:Array = this._cache[param1];
         for each (_loc3_ in _loc2_)
         {
            if((_loc3_.resource) && ((_loc3_.resource is ASwf) || ((_loc3_.resource.hasOwnProperty("parent")) && (!_loc3_.resource.parent))))
            {
               return true;
            }
         }
         return false;
      }
      
      public function extract(param1:*) : * {
         var _loc2_:* = this.peek(param1);
         if(_loc2_)
         {
            delete this._cache[[param1]];
            delete this._useCount[[param1]];
            this._size--;
         }
         return _loc2_;
      }
      
      public function peek(param1:*) : * {
         var _loc3_:CacheableResource = null;
         var _loc2_:Array = this._cache[param1];
         for each (_loc3_ in _loc2_)
         {
            if((_loc3_.resource) && ((_loc3_.resource is ASwf) || ((_loc3_.resource.hasOwnProperty("parent")) && (!_loc3_.resource.parent))))
            {
               this._useCount[param1]++;
               return _loc3_;
            }
         }
         return null;
      }
      
      public function store(param1:*, param2:*) : Boolean {
         if(!(param2 is CacheableResource))
         {
            _log.error("Tried to store something which is not a CacheableResource... Caching file " + param1 + " failed.");
            return false;
         }
         var _loc3_:* = param2.resource is ASwf;
         if(!this._cache[param1])
         {
            this._cache[param1] = new Array();
            this._useCount[param1] = 0;
            this._size++;
            if(this._size > this._bounds)
            {
               this.garbage();
            }
         }
         this._useCount[param1]++;
         this._cache[param1].push(param2);
         return true;
      }
      
      public function destroy() : void {
         this._cache = new Dictionary(true);
         this._size = 0;
         this._bounds = 0;
         this._useCount = new Dictionary(true);
      }
      
      private function garbage() : void {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:* = false;
         var _loc7_:uint = 0;
         var _loc8_:CacheableResource = null;
         var _loc1_:Array = new Array();
         for (_loc2_ in this._cache)
         {
            if(!(this._cache[_loc2_] == null) && (this._useCount[_loc2_]))
            {
               _loc1_.push(
                  {
                     "ref":_loc2_,
                     "useCount":this._useCount[_loc2_]
                  });
            }
         }
         _loc1_.sortOn("useCount",Array.NUMERIC);
         _loc3_ = this._bounds * 0.1;
         _loc4_ = _loc1_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_ && this._size > _loc3_)
         {
            _loc6_ = false;
            _loc5_ = this._cache[_loc1_[_loc7_].ref];
            for each (_loc8_ in _loc5_)
            {
               if((_loc8_) && (_loc8_.resource) && ((_loc8_.resource is ASwf) || (_loc8_.resource.hasOwnProperty("parent") && _loc8_.resource.parent)))
               {
                  _loc6_ = true;
                  break;
               }
            }
            if(!_loc6_)
            {
               delete this._cache[[_loc1_[_loc7_].ref]];
               delete this._useCount[[_loc1_[_loc7_].ref]];
               this._size--;
            }
            _loc7_++;
         }
      }
   }
}
