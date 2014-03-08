package com.ankamagames.jerakine.resources.adapters
{
   import flash.display.Loader;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.display.LoaderInfo;
   import com.ankamagames.jerakine.resources.ResourceType;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.ErrorEvent;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   
   public class SimpleLoaderAdapter extends Object implements IAdapter
   {
      
      public function SimpleLoaderAdapter() {
         super();
      }
      
      private var _ldr:Loader;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      private var _signedFileAdapter:SignedFileAdapter;
      
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
            if(param1.fileType.charAt(param1.fileType.length-1) == "s")
            {
               this._signedFileAdapter = new SignedFileAdapter(null,true);
               this._signedFileAdapter.loadDirectly(param1,param2,new ResourceObserverWrapper(this.onSignedFileLoaded,this.onSignedFileError),false);
            }
            else
            {
               this.prepareLoader();
               this._ldr.load(new URLRequest(param2),param1.loaderContext);
            }
            return;
         }
      }
      
      public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void {
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         else
         {
            this._observer = param3;
            this._uri = param1;
            this.prepareLoader();
            this._ldr.loadBytes(param2,param1.loaderContext);
            return;
         }
      }
      
      public function free() : void {
         this.releaseLoader();
         this._observer = null;
         this._uri = null;
      }
      
      protected function getResource(param1:LoaderInfo) : * {
         return this._ldr;
      }
      
      public function getResourceType() : uint {
         return ResourceType.RESOURCE_NONE;
      }
      
      private function prepareLoader() : void {
         this._ldr = new Loader();
         this._ldr.contentLoaderInfo.addEventListener(Event.INIT,this.onInit,false,0,true);
         this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError,false,0,true);
         if(this._dispatchProgress)
         {
            this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
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
            this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
         this._ldr = null;
      }
      
      protected function onInit(param1:Event) : void {
         var _loc2_:* = this.getResource(LoaderInfo(param1.target));
         this._observer.onLoaded(this._uri,this.getResourceType(),_loc2_);
         this._uri = null;
      }
      
      protected function onError(param1:ErrorEvent) : void {
         this.releaseLoader();
         this._observer.onFailed(this._uri,param1.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
         this._uri = null;
      }
      
      protected function onProgress(param1:ProgressEvent) : void {
         this._observer.onProgress(this._uri,param1.bytesLoaded,param1.bytesTotal);
      }
      
      private function onSignedFileLoaded(param1:Uri, param2:uint, param3:*) : void {
         this.loadFromData(param1,param3 as ByteArray,this._observer,this._dispatchProgress);
      }
      
      private function onSignedFileError(param1:Uri, param2:String, param3:uint) : void {
         this.onError(new ErrorEvent(param2));
      }
   }
}
