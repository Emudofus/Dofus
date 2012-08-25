package com.ankamagames.jerakine.resources.loaders
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;
    import flash.utils.*;

    public class AbstractRessourceLoader extends EventDispatcher implements IResourceObserver
    {
        protected var _cache:ICache;
        protected var _completed:Boolean;
        protected var _filesLoaded:uint = 0;
        protected var _filesTotal:uint = 0;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractRessourceLoader));
        public static var MEMORY_TEST:Dictionary = new Dictionary(true);
        static const RES_CACHE_PREFIX:String = "RES_";

        public function AbstractRessourceLoader()
        {
            return;
        }// end function

        protected function checkCache(param1:Uri) : Boolean
        {
            var _loc_2:String = null;
            var _loc_3:CacheableResource = null;
            if (param1.protocol == "pak" || param1.fileType != "swf" || !param1.subPath || param1.subPath.length == 0)
            {
                _loc_2 = RES_CACHE_PREFIX + param1.toSum();
            }
            else
            {
                _loc_2 = RES_CACHE_PREFIX + new Uri(param1.path).toSum();
            }
            if (this._cache && this._cache.contains(_loc_2))
            {
                _loc_3 = this._cache.peek(_loc_2);
                this.dispatchSuccess(param1, _loc_3.resourceType, _loc_3.resource);
                return true;
            }
            return false;
        }// end function

        protected function dispatchSuccess(param1:Uri, param2:uint, param3) : void
        {
            var _loc_4:String = null;
            var _loc_5:CacheableResource = null;
            var _loc_6:ResourceLoadedEvent = null;
            var _loc_7:ResourceLoaderProgressEvent = null;
            if (param1.fileType != "swf" || !param1.subPath || param1.subPath.length == 0)
            {
                _loc_4 = RES_CACHE_PREFIX + param1.toSum();
            }
            else
            {
                _loc_4 = RES_CACHE_PREFIX + new Uri(param1.path).toSum();
            }
            if (this._cache && !this._cache.contains(_loc_4))
            {
                _loc_5 = new CacheableResource(param2, param3);
                this._cache.store(_loc_4, _loc_5);
            }
            var _loc_8:String = this;
            var _loc_9:* = this._filesLoaded + 1;
            _loc_8._filesLoaded = _loc_9;
            if (hasEventListener(ResourceLoadedEvent.LOADED))
            {
                _loc_6 = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
                _loc_6.uri = param1;
                _loc_6.resourceType = param2;
                _loc_6.resource = param3;
                dispatchEvent(_loc_6);
            }
            if (hasEventListener(ResourceLoaderProgressEvent.LOADER_PROGRESS))
            {
                _loc_7 = new ResourceLoaderProgressEvent(ResourceLoaderProgressEvent.LOADER_PROGRESS);
                _loc_7.uri = param1;
                _loc_7.filesTotal = this._filesTotal;
                _loc_7.filesLoaded = this._filesLoaded;
                dispatchEvent(_loc_7);
            }
            if (this._filesLoaded == this._filesTotal)
            {
                this.dispatchComplete();
            }
            return;
        }// end function

        protected function dispatchFailure(param1:Uri, param2:String, param3:uint) : void
        {
            var _loc_4:ResourceErrorEvent = null;
            var _loc_5:String = this;
            var _loc_6:* = this._filesLoaded + 1;
            _loc_5._filesLoaded = _loc_6;
            if (hasEventListener(ResourceErrorEvent.ERROR))
            {
                _loc_4 = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
                _loc_4.uri = param1;
                _loc_4.errorMsg = param2;
                _loc_4.errorCode = param3;
                dispatchEvent(_loc_4);
            }
            else
            {
                _log.error("[Error code " + param3.toString(16) + "] Unable to load resource " + param1 + ": " + param2);
            }
            if (this._filesLoaded == this._filesTotal)
            {
                this.dispatchComplete();
            }
            return;
        }// end function

        private function dispatchComplete() : void
        {
            var _loc_1:ResourceLoaderProgressEvent = null;
            if (!this._completed)
            {
                this._completed = true;
                _loc_1 = new ResourceLoaderProgressEvent(ResourceLoaderProgressEvent.LOADER_COMPLETE);
                _loc_1.filesTotal = this._filesTotal;
                _loc_1.filesLoaded = this._filesLoaded;
                dispatchEvent(_loc_1);
            }
            return;
        }// end function

        public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            MEMORY_TEST[param3] = 1;
            this.dispatchSuccess(param1, param2, param3);
            return;
        }// end function

        public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            this.dispatchFailure(param1, param2, param3);
            return;
        }// end function

        public function onProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            var _loc_4:* = new ResourceProgressEvent(ResourceProgressEvent.PROGRESS);
            new ResourceProgressEvent(ResourceProgressEvent.PROGRESS).uri = param1;
            _loc_4.bytesLoaded = param2;
            _loc_4.bytesTotal = param3;
            dispatchEvent(_loc_4);
            return;
        }// end function

    }
}
