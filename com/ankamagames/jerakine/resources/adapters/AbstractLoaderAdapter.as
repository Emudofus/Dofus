package com.ankamagames.jerakine.resources.adapters
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.pools.PoolableLoader;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import flash.errors.IllegalOperationError;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.LoaderContext;
   import flash.display.LoaderInfo;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.ErrorEvent;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   
   public class AbstractLoaderAdapter extends Object
   {
      
      public function AbstractLoaderAdapter() {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractLoaderAdapter));
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private var _ldr:PoolableLoader;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void {
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         else
         {
            this._observer = param3;
            this._uri = param1;
            this._dispatchProgress = param4;
            this.prepareLoader();
            this._ldr.load(new URLRequest(param2),param1.loaderContext);
            return;
         }
      }
      
      public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void {
         var uri:Uri = param1;
         var data:ByteArray = param2;
         var observer:IResourceObserver = param3;
         var dispatchProgress:Boolean = param4;
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         else
         {
            this._observer = observer;
            this._uri = uri;
            this.prepareLoader();
            try
            {
               if(this._uri.loaderContext)
               {
                  AirScanner.allowByteCodeExecution(this._uri.loaderContext,true);
               }
               else
               {
                  this._uri.loaderContext = new LoaderContext();
                  AirScanner.allowByteCodeExecution(this._uri.loaderContext,true);
               }
               this._ldr.loadBytes(data,this._uri.loaderContext);
            }
            catch(e:SecurityError)
            {
               trace("Erreur de sécurité en chargeant le fichier " + uri + " : \n" + e.getStackTrace());
               throw e;
            }
            return;
         }
      }
      
      public function free() : void {
         this.releaseLoader();
         this._observer = null;
         this._uri = null;
      }
      
      protected function getResource(param1:LoaderInfo) : * {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      public function getResourceType() : uint {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      private function prepareLoader() : void {
         this._ldr = PoolsManager.getInstance().getLoadersPool().checkOut() as PoolableLoader;
         this._ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onInit);
         this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      private function releaseLoader() : void {
         if(this._ldr)
         {
            try
            {
               this._ldr.close();
            }
            catch(e:Error)
            {
            }
            this._ldr.contentLoaderInfo.removeEventListener(Event.INIT,this.onInit);
            this._ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onInit);
            this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            if(this._dispatchProgress)
            {
               this._ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            }
            PoolsManager.getInstance().getLoadersPool().checkIn(this._ldr);
         }
         this._ldr = null;
      }
      
      protected function init(param1:LoaderInfo) : void {
         var _loc2_:* = this.getResource(LoaderInfo(param1));
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),_loc2_);
      }
      
      protected function onInit(param1:Event) : void {
         this.init(LoaderInfo(param1.target));
      }
      
      protected function onError(param1:ErrorEvent) : void {
         this.releaseLoader();
         this._observer.onFailed(this._uri,param1.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
      }
      
      protected function onProgress(param1:ProgressEvent) : void {
         this._observer.onProgress(this._uri,param1.bytesLoaded,param1.bytesTotal);
      }
   }
}
