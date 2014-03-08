package com.ankamagames.jerakine.resources.loaders
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.CacheableResource;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceProgressEvent;
   
   public class AbstractRessourceLoader extends EventDispatcher implements IResourceObserver
   {
      
      public function AbstractRessourceLoader() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractRessourceLoader));
      
      public static var MEMORY_TEST:Dictionary = new Dictionary(true);
      
      protected static const RES_CACHE_PREFIX:String = "RES_";
      
      protected var _cache:ICache;
      
      protected var _completed:Boolean;
      
      protected var _filesLoaded:uint = 0;
      
      protected var _filesTotal:uint = 0;
      
      protected function checkCache(param1:Uri) : Boolean {
         var _loc2_:CacheableResource = this.getCachedValue(param1);
         if(_loc2_ != null)
         {
            this.dispatchSuccess(param1,_loc2_.resourceType,_loc2_.resource);
            return true;
         }
         return false;
      }
      
      private function getCachedValue(param1:Uri) : CacheableResource {
         var _loc2_:CacheableResource = null;
         var _loc3_:String = null;
         if(param1.protocol == "pak" || !(param1.fileType == "swf") || !param1.subPath || param1.subPath.length == 0)
         {
            _loc3_ = RES_CACHE_PREFIX + param1.toSum();
         }
         else
         {
            _loc3_ = RES_CACHE_PREFIX + new Uri(param1.path).toSum();
         }
         if((this._cache) && (this._cache.contains(_loc3_)))
         {
            _loc2_ = this._cache.peek(_loc3_);
         }
         return _loc2_;
      }
      
      public function isInCache(param1:Uri) : Boolean {
         return !(this.getCachedValue(param1) == null);
      }
      
      public function cancel() : void {
         this._filesTotal = 0;
         this._filesLoaded = 0;
         this._completed = false;
         this._cache = null;
      }
      
      protected function dispatchSuccess(param1:Uri, param2:uint, param3:*) : void {
         var _loc4_:String = null;
         var _loc5_:CacheableResource = null;
         var _loc6_:ResourceLoadedEvent = null;
         var _loc7_:ResourceLoaderProgressEvent = null;
         if(!(param1.fileType == "swf") || !param1.subPath || param1.subPath.length == 0)
         {
            _loc4_ = RES_CACHE_PREFIX + param1.toSum();
         }
         else
         {
            _loc4_ = RES_CACHE_PREFIX + new Uri(param1.path).toSum();
         }
         if((this._cache) && !this._cache.contains(_loc4_))
         {
            _loc5_ = new CacheableResource(param2,param3);
            this._cache.store(_loc4_,_loc5_);
         }
         this._filesLoaded++;
         if(hasEventListener(ResourceLoadedEvent.LOADED))
         {
            _loc6_ = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
            _loc6_.uri = param1;
            _loc6_.resourceType = param2;
            _loc6_.resource = param3;
            dispatchEvent(_loc6_);
         }
         if(hasEventListener(ResourceLoaderProgressEvent.LOADER_PROGRESS))
         {
            _loc7_ = new ResourceLoaderProgressEvent(ResourceLoaderProgressEvent.LOADER_PROGRESS);
            _loc7_.uri = param1;
            _loc7_.filesTotal = this._filesTotal;
            _loc7_.filesLoaded = this._filesLoaded;
            dispatchEvent(_loc7_);
         }
         if(this._filesLoaded == this._filesTotal)
         {
            this.dispatchComplete();
         }
      }
      
      protected function dispatchFailure(param1:Uri, param2:String, param3:uint) : void {
         var _loc4_:ResourceErrorEvent = null;
         this._filesLoaded++;
         if(hasEventListener(ResourceErrorEvent.ERROR))
         {
            _loc4_ = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
            _loc4_.uri = param1;
            _loc4_.errorMsg = param2;
            _loc4_.errorCode = param3;
            dispatchEvent(_loc4_);
         }
         else
         {
            _log.error("[Error code " + param3.toString(16) + "] Unable to load resource " + param1 + ": " + param2);
         }
         if(this._filesLoaded == this._filesTotal)
         {
            this.dispatchComplete();
         }
      }
      
      private function dispatchComplete() : void {
         var _loc1_:ResourceLoaderProgressEvent = null;
         if(!this._completed)
         {
            this._completed = true;
            _loc1_ = new ResourceLoaderProgressEvent(ResourceLoaderProgressEvent.LOADER_COMPLETE);
            _loc1_.filesTotal = this._filesTotal;
            _loc1_.filesLoaded = this._filesLoaded;
            dispatchEvent(_loc1_);
         }
      }
      
      public function onLoaded(param1:Uri, param2:uint, param3:*) : void {
         MEMORY_TEST[param3] = 1;
         this.dispatchSuccess(param1,param2,param3);
      }
      
      public function onFailed(param1:Uri, param2:String, param3:uint) : void {
         this.dispatchFailure(param1,param2,param3);
      }
      
      public function onProgress(param1:Uri, param2:uint, param3:uint) : void {
         var _loc4_:ResourceProgressEvent = new ResourceProgressEvent(ResourceProgressEvent.PROGRESS);
         _loc4_.uri = param1;
         _loc4_.bytesLoaded = param2;
         _loc4_.bytesTotal = param3;
         dispatchEvent(_loc4_);
      }
   }
}
