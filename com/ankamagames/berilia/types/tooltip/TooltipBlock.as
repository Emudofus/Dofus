package com.ankamagames.berilia.types.tooltip
{
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import flash.events.*;
    import flash.utils.*;

    public class TooltipBlock extends EventDispatcher
    {
        protected var _log:Logger;
        private var _loader:IResourceLoader;
        private var _loadedChunk:uint = 0;
        private var _totalChunk:uint = 0;
        private var _chunksUri:Array;
        private var chunks:Array;
        public var onAllChunkLoadedCallback:Function;
        public var contentGetter:Function;
        private static const _chunckCache:Dictionary = new Dictionary();
        private static const _cache:Cache = Cache.create(50, new LruGarbageCollector(), getQualifiedClassName(TooltipBlock));

        public function TooltipBlock()
        {
            this._log = Log.getLogger(getQualifiedClassName());
            this.chunks = new Array();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            return;
        }// end function

        public function get loadedChunk() : uint
        {
            return this._loadedChunk;
        }// end function

        public function get totalChunk() : uint
        {
            return this._totalChunk;
        }// end function

        public function initChunk(param1:Array) : void
        {
            var _loc_2:ChunkData = null;
            var _loc_4:String = null;
            this._chunksUri = param1;
            this._totalChunk = param1.length;
            this._loadedChunk = 0;
            var _loc_3:uint = 0;
            while (_loc_3 < this._totalChunk)
            {
                
                _loc_2 = param1[_loc_3];
                _loc_4 = _chunckCache[_loc_2.uri.path];
                if (_loc_4)
                {
                    this.chunks[_loc_2.name] = _loc_4;
                    this._chunksUri.splice(_loc_3, 1);
                    _loc_3 = _loc_3 - 1;
                    var _loc_5:String = this;
                    var _loc_6:* = this._totalChunk - 1;
                    _loc_5._totalChunk = _loc_6;
                }
                else
                {
                    _loc_2.uri.tag = _loc_2.name;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:uint = 0;
            this._totalChunk = this._chunksUri.length;
            if (this._totalChunk)
            {
                this._loadedChunk = 0;
                _loc_1 = 0;
                while (_loc_1 < this._totalChunk)
                {
                    
                    this._loader.load(ChunkData(this._chunksUri[_loc_1]).uri);
                    _loc_1 = _loc_1 + 1;
                }
            }
            else
            {
                this.onAllChunkLoaded();
            }
            return;
        }// end function

        public function getChunk(param1:String) : TooltipChunk
        {
            var _loc_2:* = this.chunks[param1];
            return new TooltipChunk(_loc_2);
        }// end function

        public function get content() : String
        {
            if (this.contentGetter != null)
            {
                return this.contentGetter();
            }
            return "[Abstract tooltip]";
        }// end function

        protected function onAllChunkLoaded() : void
        {
            if (this.onAllChunkLoadedCallback != null)
            {
                this.onAllChunkLoadedCallback();
            }
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function onLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:String = this;
            var _loc_3:* = this._loadedChunk + 1;
            _loc_2._loadedChunk = _loc_3;
            _chunckCache[event.uri.path] = event.resource;
            this.chunks[event.uri.tag] = event.resource;
            if (this._loadedChunk == this._totalChunk)
            {
                this.onAllChunkLoaded();
            }
            return;
        }// end function

        private function onLoadError(event:ResourceErrorEvent) : void
        {
            var _loc_2:String = this;
            var _loc_3:* = this._loadedChunk + 1;
            _loc_2._loadedChunk = _loc_3;
            if (this._loadedChunk == this._totalChunk)
            {
                this.onAllChunkLoaded();
            }
            this.chunks[event.uri.tag] = new TooltipChunk("[loading error on " + event.uri.tag + "]");
            return;
        }// end function

    }
}
