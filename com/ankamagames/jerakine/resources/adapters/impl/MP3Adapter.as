package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.media.Sound;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import org.audiofx.mp3.MP3FileReferenceLoader;
   import flash.errors.IllegalOperationError;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import org.audiofx.mp3.MP3SoundEvent;
   import flash.display.LoaderInfo;
   import com.ankamagames.jerakine.resources.ResourceType;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.ErrorEvent;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   
   public class MP3Adapter extends Object implements IAdapter
   {
      
      public function MP3Adapter() {
         super();
      }
      
      private static var _a:Array = [];
      
      private var _sound:Sound;
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      private var _mp3BinaryLoader:MP3FileReferenceLoader;
      
      public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void {
         if(this._sound)
         {
            throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
         }
         else
         {
            this._observer = param3;
            this._uri = param1;
            this._dispatchProgress = param4;
            this.prepareLoader();
            this._sound.load(new URLRequest(param2));
            return;
         }
      }
      
      public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void {
         this._observer = param3;
         this._uri = param1;
         this._dispatchProgress = param4;
         this._mp3BinaryLoader = new MP3FileReferenceLoader();
         this._mp3BinaryLoader.addEventListener(MP3SoundEvent.COMPLETE,this.onMp3BinaryParsed);
         this._mp3BinaryLoader.loadMP3ByteArray(param2);
         _a[this] = this._mp3BinaryLoader;
      }
      
      public function free() : void {
         this.releaseLoader();
         this._observer = null;
         this._uri = null;
      }
      
      protected function getResource(param1:LoaderInfo) : * {
         return this._sound;
      }
      
      public function getResourceType() : uint {
         return ResourceType.RESOURCE_MP3;
      }
      
      private function prepareLoader() : void {
         this._sound = new Sound();
         this._sound.addEventListener(Event.COMPLETE,this.onInit);
         this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._sound.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      private function releaseLoader() : void {
         if(this._sound)
         {
            try
            {
               this._sound.close();
            }
            catch(e:Error)
            {
            }
            this._sound.removeEventListener(Event.COMPLETE,this.onInit);
            this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
         this._sound = null;
      }
      
      private function onMp3BinaryParsed(param1:MP3SoundEvent) : void {
         var _loc2_:* = param1.sound;
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),_loc2_);
      }
      
      protected function onInit(param1:Event) : void {
         var _loc2_:* = param1.target as Sound;
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),_loc2_);
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
