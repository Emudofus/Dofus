package com.ankamagames.tubul.resources.adapters
{
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import com.ankamagames.tubul.utils.error.TubulError;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ProgressEvent;
   import com.ankamagames.tubul.resources.TubulResourceType;
   import flash.events.ErrorEvent;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   
   public class MP3Adapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      public function MP3Adapter() {
         super();
      }
      
      private var _observer:IResourceObserver;
      
      private var _uri:Uri;
      
      private var _dispatchProgress:Boolean;
      
      private var _sound:Sound;
      
      override public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void {
         this._observer = param3;
         this._uri = param1;
         this._dispatchProgress = param4;
         this._dispatchProgress = true;
         this.prepareLoader();
         this._sound.load(new URLRequest(param2));
      }
      
      override public function free() : void {
         this.releaseLoader();
         this._uri = null;
         this._observer = null;
      }
      
      override public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void {
         throw new TubulError("loadFromData can\'t be call for an MP3 adapter ! A sound can\'t be load with byteArray");
      }
      
      private function releaseLoader() : void {
         this._sound.removeEventListener(Event.COMPLETE,this.onComplete);
         this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._sound.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
      }
      
      private function prepareLoader() : void {
         this._sound = new Sound();
         this._sound.addEventListener(Event.COMPLETE,this.onComplete);
         this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         if(this._dispatchProgress)
         {
            this._sound.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      override protected function getResource(param1:String, param2:*) : * {
         return this._sound;
      }
      
      override public function getResourceType() : uint {
         return TubulResourceType.RESOURCE_MP3_SOUND;
      }
      
      override protected function onComplete(param1:Event) : void {
         this.releaseLoader();
         this._observer.onLoaded(this._uri,this.getResourceType(),this._sound);
      }
      
      override protected function onError(param1:ErrorEvent) : void {
         this.releaseLoader();
         this._observer.onFailed(this._uri,param1.text,ResourceErrorCode.RESOURCE_NOT_FOUND);
      }
      
      override protected function onProgress(param1:ProgressEvent) : void {
         this._observer.onProgress(this._uri,param1.bytesLoaded,param1.bytesTotal);
      }
   }
}
