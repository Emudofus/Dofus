package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.newCache.impl.InfiniteCache;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.logger.Log;
   
   public class AbstractDataManager extends Object
   {
      
      public function AbstractDataManager() {
         super();
      }
      
      static const DATA_KEY:String = "data";
      
      protected var _cacheSO:ICache;
      
      protected var _cacheKey:ICache;
      
      protected var _soPrefix:String = "";
      
      protected const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractDataManager));
      
      public function getObject(param1:uint) : Object {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:CustomSharedObject = null;
         var _loc2_:String = this._soPrefix + param1;
         if(this._cacheKey.contains(_loc2_))
         {
            return this._cacheKey.peek(_loc2_);
         }
         var _loc3_:uint = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO,this._soPrefix + "_chunkLength");
         var _loc4_:String = this._soPrefix + Math.floor(param1 / _loc3_);
         if(this._cacheSO.contains(_loc4_))
         {
            _loc6_ = this._cacheSO.peek(_loc4_);
            _loc5_ = CustomSharedObject(this._cacheSO.peek(_loc4_)).data[DATA_KEY][param1];
            this._cacheKey.store(_loc2_,_loc5_);
            return _loc5_;
         }
         _loc7_ = CustomSharedObject.getLocal(_loc4_);
         if(!_loc7_ || !_loc7_.data[DATA_KEY])
         {
            return null;
         }
         this._cacheSO.store(_loc4_,_loc7_);
         _loc5_ = _loc7_.data[DATA_KEY][param1];
         this._cacheKey.store(_loc2_,_loc5_);
         return _loc5_;
      }
      
      public function getObjects() : Array {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:CustomSharedObject = null;
         var _loc1_:Array = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO,this._soPrefix + "_filelist");
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         for each (_loc4_ in _loc1_)
         {
            _loc3_ = this._soPrefix + _loc4_;
            if(this._cacheSO.contains(_loc3_))
            {
               _loc2_ = _loc2_.concat(CustomSharedObject(this._cacheSO.peek(_loc3_)).data[DATA_KEY]);
            }
            else
            {
               _loc5_ = CustomSharedObject.getLocal(_loc3_);
               if(!(!_loc5_ || !_loc5_.data[DATA_KEY]))
               {
                  this._cacheSO.store(_loc3_,_loc5_);
                  _loc2_ = _loc2_.concat(_loc5_.data[DATA_KEY]);
               }
            }
         }
         return _loc2_;
      }
      
      function init(param1:uint, param2:uint, param3:String="") : void {
         if(param2 == uint.MAX_VALUE)
         {
            this._cacheKey = new InfiniteCache();
         }
         else
         {
            this._cacheKey = Cache.create(param2,new LruGarbageCollector(),getQualifiedClassName(this) + "_key");
         }
         this._cacheSO = Cache.create(param1,new LruGarbageCollector(),getQualifiedClassName(this) + "_so");
         this._soPrefix = param3;
      }
   }
}
