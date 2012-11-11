package com.ankamagames.tubul.resources.adapters
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tubul.resources.*;
    import com.ankamagames.tubul.utils.error.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;

    public class MP3Adapter extends AbstractUrlLoaderAdapter implements IAdapter
    {
        private var _observer:IResourceObserver;
        private var _uri:Uri;
        private var _dispatchProgress:Boolean;
        private var _sound:Sound;

        public function MP3Adapter()
        {
            return;
        }// end function

        override public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void
        {
            this._observer = param3;
            this._uri = param1;
            this._dispatchProgress = param4;
            this._dispatchProgress = true;
            this.prepareLoader();
            this._sound.load(new URLRequest(param2));
            return;
        }// end function

        override public function free() : void
        {
            this.releaseLoader();
            this._uri = null;
            this._observer = null;
            return;
        }// end function

        override public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void
        {
            throw new TubulError("loadFromData can\'t be call for an MP3 adapter ! A sound can\'t be load with byteArray");
        }// end function

        private function releaseLoader() : void
        {
            this._sound.removeEventListener(Event.COMPLETE, this.onComplete);
            this._sound.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._sound.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            this._sound.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            return;
        }// end function

        private function prepareLoader() : void
        {
            this._sound = new Sound();
            this._sound.addEventListener(Event.COMPLETE, this.onComplete);
            this._sound.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            if (this._dispatchProgress)
            {
                this._sound.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            }
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            return this._sound;
        }// end function

        override public function getResourceType() : uint
        {
            return TubulResourceType.RESOURCE_MP3_SOUND;
        }// end function

        override protected function onComplete(event:Event) : void
        {
            this.releaseLoader();
            this._observer.onLoaded(this._uri, this.getResourceType(), this._sound);
            return;
        }// end function

        override protected function onError(event:ErrorEvent) : void
        {
            this.releaseLoader();
            this._observer.onFailed(this._uri, event.text, ResourceErrorCode.RESOURCE_NOT_FOUND);
            return;
        }// end function

        override protected function onProgress(event:ProgressEvent) : void
        {
            this._observer.onProgress(this._uri, event.bytesLoaded, event.bytesTotal);
            return;
        }// end function

    }
}
