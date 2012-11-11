package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;
    import org.audiofx.mp3.*;

    public class MP3Adapter extends Object implements IAdapter
    {
        private var _sound:Sound;
        private var _observer:IResourceObserver;
        private var _uri:Uri;
        private var _dispatchProgress:Boolean;
        private var _mp3BinaryLoader:MP3FileReferenceLoader;
        private static var _a:Array = [];

        public function MP3Adapter()
        {
            return;
        }// end function

        public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void
        {
            if (this._sound)
            {
                throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
            }
            this._observer = param3;
            this._uri = param1;
            this._dispatchProgress = param4;
            this.prepareLoader();
            this._sound.load(new URLRequest(param2));
            return;
        }// end function

        public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void
        {
            this._observer = param3;
            this._uri = param1;
            this._dispatchProgress = param4;
            this._mp3BinaryLoader = new MP3FileReferenceLoader();
            this._mp3BinaryLoader.addEventListener(MP3SoundEvent.COMPLETE, this.onMp3BinaryParsed);
            this._mp3BinaryLoader.loadMP3ByteArray(param2);
            _a[this] = this._mp3BinaryLoader;
            return;
        }// end function

        public function free() : void
        {
            this.releaseLoader();
            this._observer = null;
            this._uri = null;
            return;
        }// end function

        protected function getResource(param1:LoaderInfo)
        {
            return this._sound;
        }// end function

        public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_MP3;
        }// end function

        private function prepareLoader() : void
        {
            this._sound = new Sound();
            this._sound.addEventListener(Event.COMPLETE, this.onInit);
            this._sound.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            if (this._dispatchProgress)
            {
                this._sound.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            }
            return;
        }// end function

        private function releaseLoader() : void
        {
            if (this._sound)
            {
                try
                {
                    this._sound.close();
                }
                catch (e:Error)
                {
                }
                this._sound.removeEventListener(Event.COMPLETE, this.onInit);
                this._sound.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this._sound.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            }
            this._sound = null;
            return;
        }// end function

        private function onMp3BinaryParsed(event:MP3SoundEvent) : void
        {
            var _loc_2:* = event.sound;
            this.releaseLoader();
            this._observer.onLoaded(this._uri, this.getResourceType(), _loc_2);
            return;
        }// end function

        protected function onInit(event:Event) : void
        {
            var _loc_2:* = event.target as Sound;
            this.releaseLoader();
            this._observer.onLoaded(this._uri, this.getResourceType(), _loc_2);
            return;
        }// end function

        protected function onError(event:ErrorEvent) : void
        {
            this.releaseLoader();
            this._observer.onFailed(this._uri, event.text, ResourceErrorCode.RESOURCE_NOT_FOUND);
            return;
        }// end function

        protected function onProgress(event:ProgressEvent) : void
        {
            this._observer.onProgress(this._uri, event.bytesLoaded, event.bytesTotal);
            return;
        }// end function

    }
}
