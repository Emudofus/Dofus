package com.ankamagames.jerakine.resources.adapters
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.pools.PoolableURLLoader;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import flash.net.URLRequest;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.filesystem.FileMode;
   import flash.net.URLLoaderDataFormat;
   import flash.utils.ByteArray;
   import flash.net.URLRequestHeader;
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
      
      public function AbstractUrlLoaderAdapter()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractUrlLoaderAdapter));
      
      private var _ldr:PoolableURLLoader;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void
      {
         var r:URLRequest = null;
         var f:File = null;
         var fs:FileStream = null;
         var dataFormat:String = null;
         var data:* = undefined;
         var uri:Uri = param1;
         var path:String = param2;
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
            this._dispatchProgress = dispatchProgress;
            if(SystemManager.getSingleton().os == OperatingSystem.MAC_OS && !AirScanner.isStreamingVersion() && (Uri.checkAbsolutePath(path)))
            {
               try
               {
                  f = uri.toFile();
                  fs = new FileStream();
                  dataFormat = this.getDataFormat();
                  fs.open(uri.toFile(),FileMode.READ);
                  if(dataFormat == URLLoaderDataFormat.TEXT)
                  {
                     data = fs.readUTFBytes(fs.bytesAvailable);
                  }
                  else
                  {
                     data = new ByteArray();
                     fs.readBytes(data);
                  }
                  fs.close();
                  this.process(dataFormat,data);
               }
               catch(error:Error)
               {
                  prepareLoader();
                  r = new URLRequest(path);
                  r.requestHeaders = [new URLRequestHeader("pragma","no-cache")];
                  _ldr.load(r);
               }
            }
            else
            {
               this.prepareLoader();
               r = new URLRequest(path);
               r.requestHeaders = [new URLRequestHeader("pragma","no-cache")];
               this._ldr.load(r);
            }
            if(SystemManager.getSingleton().os == OperatingSystem.MAC_OS && !AirScanner.isStreamingVersion() && (Uri.checkAbsolutePath(path)))
            {
               return;
            }
            return;
         }
      }
      
      public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void
      {
         if(this._ldr)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         else
         {
            this._observer = param3;
            this._uri = param1;
            this.process(URLLoaderDataFormat.BINARY,param2);
            return;
         }
      }
      
      public function free() : void
      {
         this.releaseLoader();
         this._uri = null;
         this._observer = null;
      }
      
      protected function process(param1:String, param2:*) : void
      {
         this.dispatchSuccess(param1,param2);
      }
      
      protected function dispatchSuccess(param1:String, param2:*) : void
      {
         var _loc3_:* = this.getResource(param1,param2);
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),_loc3_);
      }
      
      protected function dispatchFailure(param1:String, param2:uint) : void
      {
         this.releaseLoader();
         this._observer.onFailed(this._uri,param1,param2);
      }
      
      protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.TEXT;
      }
      
      protected function getUri() : Uri
      {
         return this._uri;
      }
      
      protected function getResource(param1:String, param2:*) : *
      {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      public function getResourceType() : uint
      {
         throw new AbstractMethodCallError("This method should be overrided.");
      }
      
      private function prepareLoader() : void
      {
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
      
      private function releaseLoader() : void
      {
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
      
      protected function onComplete(param1:Event) : void
      {
         this.process(this._ldr.dataFormat,this._ldr.data);
      }
      
      protected function onError(param1:ErrorEvent) : void
      {
         this.releaseLoader();
         this._observer.onFailed(this._uri,param1.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
      }
      
      protected function onProgress(param1:ProgressEvent) : void
      {
         this._observer.onProgress(this._uri,param1.bytesLoaded,param1.bytesTotal);
      }
   }
}
