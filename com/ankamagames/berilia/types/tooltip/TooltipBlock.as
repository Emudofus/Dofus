package com.ankamagames.berilia.types.tooltip
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.berilia.types.data.ChunkData;
   import flash.events.Event;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class TooltipBlock extends EventDispatcher
   {
      
      public function TooltipBlock() {
         this._log = Log.getLogger(getQualifiedClassName(TooltipBlock));
         this.chunks = new Array();
         super();
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
      }
      
      private static const _chunckCache:Dictionary = new Dictionary();
      
      private static const _cache:Cache = Cache.create(50,new LruGarbageCollector(),getQualifiedClassName(TooltipBlock));
      
      protected var _log:Logger;
      
      private var _loader:IResourceLoader;
      
      private var _loadedChunk:uint = 0;
      
      private var _totalChunk:uint = 0;
      
      private var _chunksUri:Array;
      
      private var chunks:Array;
      
      public var onAllChunkLoadedCallback:Function;
      
      public var contentGetter:Function;
      
      public function get loadedChunk() : uint {
         return this._loadedChunk;
      }
      
      public function get totalChunk() : uint {
         return this._totalChunk;
      }
      
      public function initChunk(chunksList:Array) : void {
         var chunk:ChunkData = null;
         var chunkCache:String = null;
         this._chunksUri = chunksList;
         this._totalChunk = chunksList.length;
         this._loadedChunk = 0;
         var i:uint = 0;
         while(i < this._totalChunk)
         {
            chunk = chunksList[i];
            chunkCache = _chunckCache[chunk.uri.path];
            if(chunkCache)
            {
               this.chunks[chunk.name] = chunkCache;
               this._chunksUri.splice(i,1);
               i--;
               this._totalChunk--;
            }
            else
            {
               chunk.uri.tag = chunk.name;
            }
            i++;
         }
      }
      
      public function init() : void {
         var i:uint = 0;
         this._totalChunk = this._chunksUri.length;
         if(this._totalChunk)
         {
            this._loadedChunk = 0;
            i = 0;
            while(i < this._totalChunk)
            {
               this._loader.load(ChunkData(this._chunksUri[i]).uri);
               i++;
            }
         }
         else
         {
            this.onAllChunkLoaded();
         }
      }
      
      public function getChunk(name:String) : TooltipChunk {
         var data:String = this.chunks[name];
         return new TooltipChunk(data);
      }
      
      public function get content() : String {
         if(this.contentGetter != null)
         {
            return this.contentGetter();
         }
         return "[Abstract tooltip]";
      }
      
      protected function onAllChunkLoaded() : void {
         if(this.onAllChunkLoadedCallback != null)
         {
            this.onAllChunkLoadedCallback();
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onLoaded(e:ResourceLoadedEvent) : void {
         this._loadedChunk++;
         _chunckCache[e.uri.path] = e.resource;
         this.chunks[e.uri.tag] = e.resource;
         if(this._loadedChunk == this._totalChunk)
         {
            this.onAllChunkLoaded();
         }
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void {
         this._loadedChunk++;
         if(this._loadedChunk == this._totalChunk)
         {
            this.onAllChunkLoaded();
         }
         this.chunks[e.uri.tag] = new TooltipChunk("[loading error on " + e.uri.tag + "]");
      }
   }
}
