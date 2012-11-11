package com.ankamagames.jerakine.resources.adapters
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class SimpleLoaderAdapter extends Object implements IAdapter
    {
        private var _ldr:Loader;
        private var _observer:IResourceObserver;
        private var _uri:Uri;
        private var _dispatchProgress:Boolean;
        private var _signedFileAdapter:SignedFileAdapter;

        public function SimpleLoaderAdapter()
        {
            return;
        }// end function

        public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void
        {
            if (this._ldr)
            {
                throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
            }
            this._observer = param3;
            this._uri = param1;
            this._dispatchProgress = param4;
            if (param1.fileType.charAt((param1.fileType.length - 1)) == "s")
            {
                this._signedFileAdapter = new SignedFileAdapter(null, true);
                this._signedFileAdapter.loadDirectly(param1, param2, new ResourceObserverWrapper(this.onSignedFileLoaded, this.onSignedFileError), false);
            }
            else
            {
                this.prepareLoader();
                this._ldr.load(new URLRequest(param2), param1.loaderContext);
            }
            return;
        }// end function

        public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void
        {
            if (this._ldr)
            {
                throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
            }
            this._observer = param3;
            this._uri = param1;
            this.prepareLoader();
            this._ldr.loadBytes(param2, param1.loaderContext);
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
            return this._ldr;
        }// end function

        public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_NONE;
        }// end function

        private function prepareLoader() : void
        {
            this._ldr = new Loader();
            this._ldr.contentLoaderInfo.addEventListener(Event.INIT, this.onInit, false, 0, true);
            this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError, false, 0, true);
            if (this._dispatchProgress)
            {
                this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress, false, 0, true);
            }
            return;
        }// end function

        private function releaseLoader() : void
        {
            if (this._ldr)
            {
                try
                {
                    this._ldr.close();
                }
                catch (e:Error)
                {
                }
                this._ldr.contentLoaderInfo.removeEventListener(Event.INIT, this.onInit);
                this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this._ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            }
            this._ldr = null;
            return;
        }// end function

        protected function onInit(event:Event) : void
        {
            var _loc_2:* = this.getResource(LoaderInfo(event.target));
            this._observer.onLoaded(this._uri, this.getResourceType(), _loc_2);
            this._uri = null;
            return;
        }// end function

        protected function onError(event:ErrorEvent) : void
        {
            this.releaseLoader();
            this._observer.onFailed(this._uri, event.text, ResourceErrorCode.RESOURCE_NOT_FOUND);
            this._uri = null;
            return;
        }// end function

        protected function onProgress(event:ProgressEvent) : void
        {
            this._observer.onProgress(this._uri, event.bytesLoaded, event.bytesTotal);
            return;
        }// end function

        private function onSignedFileLoaded(param1:Uri, param2:uint, param3) : void
        {
            this.loadFromData(param1, param3 as ByteArray, this._observer, this._dispatchProgress);
            return;
        }// end function

        private function onSignedFileError(param1:Uri, param2:String, param3:uint) : void
        {
            this.onError(new ErrorEvent(param2));
            return;
        }// end function

    }
}
