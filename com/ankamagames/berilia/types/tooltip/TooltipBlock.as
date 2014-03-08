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
      
      public function initChunk(param1:Array) : void {
         var _loc2_:ChunkData = null;
         var _loc4_:String = null;
         this._chunksUri = param1;
         this._totalChunk = param1.length;
         this._loadedChunk = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < this._totalChunk)
         {
            _loc2_ = param1[_loc3_];
            _loc4_ = _chunckCache[_loc2_.uri.path];
            if(_loc4_)
            {
               this.chunks[_loc2_.name] = _loc4_;
               this._chunksUri.splice(_loc3_,1);
               _loc3_--;
               this._totalChunk--;
            }
            else
            {
               _loc2_.uri.tag = _loc2_.name;
            }
            _loc3_++;
         }
      }
      
      public function init() : void {
         var _loc1_:uint = 0;
         this._totalChunk = this._chunksUri.length;
         if(this._totalChunk)
         {
            this._loadedChunk = 0;
            _loc1_ = 0;
            while(_loc1_ < this._totalChunk)
            {
               this._loader.load(ChunkData(this._chunksUri[_loc1_]).uri);
               _loc1_++;
            }
         }
         else
         {
            this.onAllChunkLoaded();
         }
      }
      
      public function getChunk(param1:String) : TooltipChunk {
         var _loc2_:String = this.chunks[param1];
         return new TooltipChunk(_loc2_);
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
      
      private function onLoaded(param1:ResourceLoadedEvent) : void {
         this._loadedChunk++;
         _chunckCache[param1.uri.path] = param1.resource;
         this.chunks[param1.uri.tag] = param1.resource;
         if(this._loadedChunk == this._totalChunk)
         {
            this.onAllChunkLoaded();
         }
      }
      
      private function onLoadError(param1:ResourceErrorEvent) : void {
         this._loadedChunk++;
         if(this._loadedChunk == this._totalChunk)
         {
            this.onAllChunkLoaded();
         }
         this.chunks[param1.uri.tag] = new TooltipChunk("[loading error on " + param1.uri.tag + "]");
      }
   }
}
