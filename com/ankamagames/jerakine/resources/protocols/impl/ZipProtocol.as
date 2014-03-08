package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.files.ZipLoader;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import flash.errors.IllegalOperationError;
   import flash.net.URLRequest;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ProgressEvent;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import flash.events.ErrorEvent;
   
   public class ZipProtocol extends AbstractProtocol implements IProtocol
   {
      
      public function ZipProtocol() {
         super();
      }
      
      private static const ZIP_CACHE_PREFIX:String = "RES_ZIP_";
      
      private static var _singleLoadingZips:Dictionary = new Dictionary(true);
      
      private static var _loadingZips:Dictionary = new Dictionary(true);
      
      private var _uri:Uri;
      
      private var _forcedAdapter:Class;
      
      private var _zldr:ZipLoader;
      
      private var _cache:ICache;
      
      private var _dispatchProgress:Boolean;
      
      public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         if(this._zldr)
         {
            throw new IllegalOperationError("A ZipProtocol can\'t handle more than one operation at a time.");
         }
         else
         {
            this._uri = param1;
            this._forcedAdapter = param5;
            _observer = param2;
            this._cache = param4;
            this._dispatchProgress = param3;
            if((this._cache) && (this._cache.contains(ZIP_CACHE_PREFIX + param1.path)))
            {
               this._zldr = this._cache.peek(ZIP_CACHE_PREFIX + param1.path);
               this.onComplete(null);
            }
            else
            {
               if(_loadingZips[param1.path])
               {
                  _loadingZips[param1.path].push(this);
               }
               else
               {
                  _loadingZips[param1.path] = [this];
                  this.prepareZipLoader();
                  this._zldr.load(new URLRequest(param1.path));
               }
            }
            return;
         }
      }
      
      override public function cancel() : void {
         super.cancel();
         this.release();
      }
      
      override protected function release() : void {
         this.releaseZipLoader();
         this._uri = null;
         _observer = null;
         this._cache = null;
      }
      
      private function prepareZipLoader() : void {
         this._zldr = new ZipLoader();
         this._zldr.addEventListener(Event.COMPLETE,this.onComplete);
         this._zldr.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._zldr.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._zldr.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      private function releaseZipLoader() : void {
         if(this._zldr)
         {
            this._zldr.removeEventListener(Event.COMPLETE,this.onComplete);
            this._zldr.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._zldr.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
            this._zldr.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
         this._zldr.destroy();
         this._zldr = null;
      }
      
      private function onComplete(param1:Event) : void {
         var _loc2_:ZipProtocol = null;
         for each (_loc2_ in _loadingZips[this._uri.path])
         {
            if(this._zldr.fileExists(_loc2_._uri.subPath))
            {
               _loc2_.loadFromData(_loc2_._uri,this._zldr.getFileDatas(_loc2_._uri.subPath),_loc2_._observer,_loc2_._dispatchProgress,_loc2_._forcedAdapter);
            }
            else
            {
               _loc2_._observer.onFailed(this._uri,"File " + _loc2_._uri.subPath + " cannot be found in the ZIP file " + _loc2_._uri.path + ".",ResourceErrorCode.ZIP_FILE_NOT_FOUND_IN_ARCHIVE);
            }
         }
         delete _loadingZips[[this._uri.path]];
         if(this._cache)
         {
            this._cache.store(ZIP_CACHE_PREFIX + this._uri.path,this._zldr);
         }
         this.releaseZipLoader();
      }
      
      private function onError(param1:ErrorEvent) : void {
         var _loc2_:ZipProtocol = null;
         for each (_loc2_ in _loadingZips[this._uri.path])
         {
            _loc2_._observer.onFailed(_loc2_._uri,"Can\'t load the ZIP file " + _loc2_._uri.path + ": " + param1.text,ResourceErrorCode.ZIP_NOT_FOUND);
         }
         delete _loadingZips[[this._uri.path]];
         this.releaseZipLoader();
      }
      
      private function onProgress(param1:ProgressEvent) : void {
         var _loc2_:ZipProtocol = null;
         for each (_loc2_ in _loadingZips[this._uri.path])
         {
            _loc2_._observer.onProgress(_loc2_._uri,param1.bytesLoaded,param1.bytesTotal);
         }
      }
   }
}
