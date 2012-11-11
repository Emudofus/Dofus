package com.ankamagames.jerakine.resources.adapters
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class AbstractLoaderAdapter extends Object
    {
        private var _ldr:PoolableLoader;
        private var _observer:IResourceObserver;
        private var _uri:Uri;
        private var _dispatchProgress:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractLoaderAdapter));
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function AbstractLoaderAdapter()
        {
            MEMORY_LOG[this] = 1;
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
            this._ldr.load(new URLRequest(param2), param1.loaderContext);
            return;
        }// end function

        public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void
        {
            var uri:* = param1;
            var data:* = param2;
            var observer:* = param3;
            var dispatchProgress:* = param4;
            if (this._ldr)
            {
                throw new IllegalOperationError("A single adapter can\'t handle two simultaneous loadings.");
            }
            this._observer = observer;
            this._uri = uri;
            this.prepareLoader();
            try
            {
                if (this._uri.loaderContext)
                {
                    AirScanner.allowByteCodeExecution(this._uri.loaderContext, true);
                }
                else
                {
                    this._uri.loaderContext = new LoaderContext();
                    AirScanner.allowByteCodeExecution(this._uri.loaderContext, true);
                }
                this._ldr.loadBytes(data, this._uri.loaderContext);
            }
            catch (e:SecurityError)
            {
                trace("Erreur de sécurité en chargeant le fichier " + uri + " : \n" + e.getStackTrace());
                throw e;
            }
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
            throw new AbstractMethodCallError("This method should be overrided.");
        }// end function

        public function getResourceType() : uint
        {
            throw new AbstractMethodCallError("This method should be overrided.");
        }// end function

        private function prepareLoader() : void
        {
            this._ldr = PoolsManager.getInstance().getLoadersPool().checkOut() as PoolableLoader;
            this._ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInit);
            this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            if (this._dispatchProgress)
            {
                this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
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
                this._ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onInit);
                this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this._ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
                PoolsManager.getInstance().getLoadersPool().checkIn(this._ldr);
            }
            this._ldr = null;
            return;
        }// end function

        protected function init(param1:LoaderInfo) : void
        {
            var _loc_2:* = this.getResource(LoaderInfo(param1));
            this.releaseLoader();
            this._observer.onLoaded(this._uri, this.getResourceType(), _loc_2);
            return;
        }// end function

        protected function onInit(event:Event) : void
        {
            this.init(LoaderInfo(event.target));
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
