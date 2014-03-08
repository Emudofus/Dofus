package com.ankamagames.jerakine.resources.adapters
{
   import com.ankamagames.jerakine.pools.PoolableURLLoader;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import flash.errors.IllegalOperationError;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.utils.ByteArray;
   import flash.net.URLLoaderDataFormat;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.ErrorEvent;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   
   public class AbstractUrlLoaderAdapter extends Object
   {
      
      public function AbstractUrlLoaderAdapter() {
         super();
      }
      
      private var _ldr:PoolableURLLoader;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      public function loadDirectly(uri:Uri, path:String, observer:IResourceObserver, dispatchProgress:Boolean) : void {
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         else
         {
            this._observer = observer;
            this._uri = uri;
            this._dispatchProgress = dispatchProgress;
            this.prepareLoader();
            r = new URLRequest(path);
            r.requestHeaders = [new URLRequestHeader("pragma","no-cache")];
            this._ldr.load(r);
            return;
         }
      }
      
      public function loadFromData(uri:Uri, data:ByteArray, observer:IResourceObserver, dispatchProgress:Boolean) : void {
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         else
         {
            this._observer = observer;
            this._uri = uri;
            this.process(URLLoaderDataFormat.BINARY,data);
            return;
         }
      }
      
      public function free() : void {
         this.releaseLoader();
         this._uri = null;
         this._observer = null;
      }
      
      protected function process(dataFormat:String, data:*) : void {
         this.dispatchSuccess(dataFormat,data);
      }
      
      protected function dispatchSuccess(dataFormat:String, data:*) : void {
         var res:* = this.getResource(dataFormat,data);
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),res);
      }
      
      protected function dispatchFailure(errorMsg:String, errorCode:uint) : void {
         this.releaseLoader();
         this._observer.onFailed(this._uri,errorMsg,errorCode);
      }
      
      protected function getDataFormat() : String {
         return URLLoaderDataFormat.TEXT;
      }
      
      protected function getUri() : Uri {
         return this._uri;
      }
      
      protected function getResource(dataFormat:String, data:*) : * {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      public function getResourceType() : uint {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      private function prepareLoader() : void {
         this._ldr = PoolsManager.getInstance().getURLLoaderPool().checkOut() as PoolableURLLoader;
         this._ldr.dataFormat = this.getDataFormat();
         this._ldr.addEventListener(Event.COMPLETE,this.onComplete);
         this._ldr.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._ldr.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._ldr.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
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
            this._ldr.removeEventListener(Event.COMPLETE,this.onComplete);
            this._ldr.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._ldr.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
            this._ldr.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            PoolsManager.getInstance().getURLLoaderPool().checkIn(this._ldr);
         }
         this._ldr = null;
      }
      
      protected function onComplete(e:Event) : void {
         this.process(this._ldr.dataFormat,this._ldr.data);
      }
      
      protected function onError(ee:ErrorEvent) : void {
         this.releaseLoader();
         this._observer.onFailed(this._uri,ee.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
      }
      
      protected function onProgress(pe:ProgressEvent) : void {
         this._observer.onProgress(this._uri,pe.bytesLoaded,pe.bytesTotal);
      }
   }
}
