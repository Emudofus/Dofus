package com.ankamagames.jerakine.resources.adapters
{
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class AbstractUrlLoaderAdapter extends Object
    {
        private var _ldr:PoolableURLLoader;
        private var _observer:IResourceObserver;
        private var _uri:Uri;
        private var _dispatchProgress:Boolean;

        public function AbstractUrlLoaderAdapter()
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
            this.prepareLoader();
            var _loc_5:* = new URLRequest(param2);
            this._ldr.load(_loc_5);
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
            this.process(URLLoaderDataFormat.BINARY, param2);
            return;
        }// end function

        public function free() : void
        {
            this.releaseLoader();
            this._uri = null;
            this._observer = null;
            return;
        }// end function

        protected function process(param1:String, param2) : void
        {
            this.dispatchSuccess(param1, param2);
            return;
        }// end function

        protected function dispatchSuccess(param1:String, param2) : void
        {
            var _loc_3:* = this.getResource(param1, param2);
            this.releaseLoader();
            this._observer.onLoaded(this._uri, this.getResourceType(), _loc_3);
            return;
        }// end function

        protected function dispatchFailure(param1:String, param2:uint) : void
        {
            this.releaseLoader();
            this._observer.onFailed(this._uri, param1, param2);
            return;
        }// end function

        protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.TEXT;
        }// end function

        protected function getUri() : Uri
        {
            return this._uri;
        }// end function

        protected function getResource(param1:String, param2)
        {
            throw new AbstractMethodCallError("This method should be overrided.");
        }// end function

        public function getResourceType() : uint
        {
            throw new AbstractMethodCallError("This method should be overrided.");
        }// end function

        private function prepareLoader() : void
        {
            this._ldr = PoolsManager.getInstance().getURLLoaderPool().checkOut() as PoolableURLLoader;
            this._ldr.dataFormat = this.getDataFormat();
            this._ldr.addEventListener(Event.COMPLETE, this.onComplete);
            this._ldr.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._ldr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            if (this._dispatchProgress)
            {
                this._ldr.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
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
                this._ldr.removeEventListener(Event.COMPLETE, this.onComplete);
                this._ldr.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this._ldr.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
                this._ldr.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
                PoolsManager.getInstance().getURLLoaderPool().checkIn(this._ldr);
            }
            this._ldr = null;
            return;
        }// end function

        protected function onComplete(event:Event) : void
        {
            this.process(this._ldr.dataFormat, this._ldr.data);
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
