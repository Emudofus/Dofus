package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class ZipProtocol extends AbstractProtocol implements IProtocol
    {
        private var _uri:Uri;
        private var _forcedAdapter:Class;
        private var _zldr:ZipLoader;
        private var _cache:ICache;
        private var _dispatchProgress:Boolean;
        private static const ZIP_CACHE_PREFIX:String = "RES_ZIP_";
        private static var _singleLoadingZips:Dictionary = new Dictionary(true);
        private static var _loadingZips:Dictionary = new Dictionary(true);

        public function ZipProtocol()
        {
            return;
        }// end function

        public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            if (this._zldr)
            {
                throw new IllegalOperationError("A ZipProtocol can\'t handle more than one operation at a time.");
            }
            this._uri = param1;
            this._forcedAdapter = param5;
            _observer = param2;
            this._cache = param4;
            this._dispatchProgress = param3;
            if (this._cache && this._cache.contains(ZIP_CACHE_PREFIX + param1.path))
            {
                this._zldr = this._cache.peek(ZIP_CACHE_PREFIX + param1.path);
                this.onComplete(null);
            }
            else if (_loadingZips[param1.path])
            {
                _loadingZips[param1.path].push(this);
            }
            else
            {
                _loadingZips[param1.path] = [this];
                this.prepareZipLoader();
                this._zldr.load(new URLRequest(param1.path));
            }
            return;
        }// end function

        override public function cancel() : void
        {
            super.cancel();
            this.release();
            return;
        }// end function

        override protected function release() : void
        {
            this.releaseZipLoader();
            this._uri = null;
            _observer = null;
            this._cache = null;
            return;
        }// end function

        private function prepareZipLoader() : void
        {
            this._zldr = new ZipLoader();
            this._zldr.addEventListener(Event.COMPLETE, this.onComplete);
            this._zldr.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._zldr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            if (this._dispatchProgress)
            {
                this._zldr.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            }
            return;
        }// end function

        private function releaseZipLoader() : void
        {
            if (this._zldr)
            {
                this._zldr.removeEventListener(Event.COMPLETE, this.onComplete);
                this._zldr.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this._zldr.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
                this._zldr.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            }
            this._zldr.destroy();
            this._zldr = null;
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            var _loc_2:ZipProtocol = null;
            for each (_loc_2 in _loadingZips[this._uri.path])
            {
                
                if (this._zldr.fileExists(_loc_2._uri.subPath))
                {
                    _loc_2.loadFromData(_loc_2._uri, this._zldr.getFileDatas(_loc_2._uri.subPath), _loc_2._observer, _loc_2._dispatchProgress, _loc_2._forcedAdapter);
                    continue;
                }
                _loc_2._observer.onFailed(this._uri, "File " + _loc_2._uri.subPath + " cannot be found in the ZIP file " + _loc_2._uri.path + ".", ResourceErrorCode.ZIP_FILE_NOT_FOUND_IN_ARCHIVE);
            }
            delete _loadingZips[this._uri.path];
            if (this._cache)
            {
                this._cache.store(ZIP_CACHE_PREFIX + this._uri.path, this._zldr);
            }
            this.releaseZipLoader();
            return;
        }// end function

        private function onError(event:ErrorEvent) : void
        {
            var _loc_2:ZipProtocol = null;
            for each (_loc_2 in _loadingZips[this._uri.path])
            {
                
                _loc_2._observer.onFailed(_loc_2._uri, "Can\'t load the ZIP file " + _loc_2._uri.path + ": " + event.text, ResourceErrorCode.ZIP_NOT_FOUND);
            }
            delete _loadingZips[this._uri.path];
            this.releaseZipLoader();
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            var _loc_2:ZipProtocol = null;
            for each (_loc_2 in _loadingZips[this._uri.path])
            {
                
                _loc_2._observer.onProgress(_loc_2._uri, event.bytesLoaded, event.bytesTotal);
            }
            return;
        }// end function

    }
}
