package com.ankamagames.atouin.managers
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.atouin.renderers.MapRenderer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import com.ankamagames.atouin.data.map.Map;
   import flash.utils.ByteArray;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import flash.geom.Matrix;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.filters.BlurFilter;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.types.events.RenderMapEvent;
   import flash.events.ProgressEvent;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.atouin.resources.adapters.MapsAdapter;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.atouin.utils.map.getMapUriFromId;
   import com.ankamagames.atouin.data.DefaultMap;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.atouin.messages.MapLoadingFailedMessage;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.atouin.messages.MapRenderProgressMessage;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class MapDisplayManager extends Object
   {
      
      public function MapDisplayManager() {
         this._mapFileCache = new Cache(20,new LruGarbageCollector());
         this.matrix = new Matrix();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this.init();
            return;
         }
      }
      
      public static var MEMORY_LOG:Dictionary;
      
      protected static const _log:Logger;
      
      private static var _self:MapDisplayManager;
      
      public static function getInstance() : MapDisplayManager {
         if(!_self)
         {
            _self = new MapDisplayManager();
         }
         return _self;
      }
      
      private var _currentMap:WorldPoint;
      
      private var _currentRenderId:uint;
      
      private var _isDefaultMap:Boolean;
      
      private var _lastMap:WorldPoint;
      
      private var _loader:IResourceLoader;
      
      private var _currentDataMap:DataMapContainer;
      
      private var _mapFileCache:ICache;
      
      private var _currentMapRendered:Boolean = true;
      
      private var _forceReloadWithoutCache:Boolean;
      
      private var _renderRequestStack:Array;
      
      private var _renderer:MapRenderer;
      
      private var _screenshot:Bitmap;
      
      private var _screenshotData:BitmapData;
      
      private var _nMapLoadStart:uint;
      
      private var _nMapLoadEnd:uint;
      
      private var _nGfxLoadStart:uint;
      
      private var _nGfxLoadEnd:uint;
      
      private var _nRenderMapStart:uint;
      
      private var _nRenderMapEnd:uint;
      
      public function get isDefaultMap() : Boolean {
         return this._isDefaultMap;
      }
      
      public function get renderer() : MapRenderer {
         return this._renderer;
      }
      
      public function get currentRenderId() : uint {
         return this._currentRenderId;
      }
      
      public function fromMap(map:Map, decryptionKey:ByteArray = null) : uint {
         this._currentMap = WorldPoint.fromMapId(map.id);
         var request:RenderRequest = new RenderRequest(this._currentMap,false,decryptionKey);
         this._renderRequestStack.push(request);
         this._currentRenderId = request.renderId;
         Atouin.getInstance().showWorld(true);
         this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
         Atouin.getInstance().options.groundCacheMode = 0;
         var rle:ResourceLoadedEvent = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
         rle.resource = map;
         this.onMapLoaded(rle);
         return this._currentRenderId;
      }
      
      public function display(pMap:WorldPoint, forceReloadWithoutCache:Boolean = false, decryptionKey:ByteArray = null) : uint {
         var request:RenderRequest = new RenderRequest(pMap,forceReloadWithoutCache,decryptionKey);
         _log.debug("Ask render map " + pMap.mapId + ", renderRequestID: " + request.renderId);
         this._renderRequestStack.push(request);
         this.checkForRender();
         return request.renderId;
      }
      
      public function isBoundingBox(pictoId:int) : Boolean {
         if(MapRenderer.boundingBoxElements[pictoId])
         {
            return true;
         }
         return false;
      }
      
      public function cacheAsBitmapEnabled(yes:Boolean) : void {
         var ls:Array = MapRenderer.cachedAsBitmapElement;
         var num:int = ls.length;
         var i:int = 0;
         while(i < num)
         {
            ls[i].cacheAsBitmap = yes;
            i++;
         }
      }
      
      public function get currentMapPoint() : WorldPoint {
         return this._currentMap;
      }
      
      public function get currentMapRendered() : Boolean {
         return this._currentMapRendered;
      }
      
      public function getDataMapContainer() : DataMapContainer {
         return this._currentDataMap;
      }
      
      public function activeIdentifiedElements(active:Boolean) : void {
         var ie:Object = null;
         var identifiedElements:Dictionary = this._renderer.identifiedElements;
         for each(ie in identifiedElements)
         {
            ie.sprite.mouseEnabled = active;
         }
      }
      
      public function unloadMap() : void {
         this._renderer.unload();
      }
      
      private var matrix:Matrix;
      
      public function capture() : void {
         var ctr:DisplayObjectContainer = null;
         if((Atouin.getInstance().options.tweentInterMap) || (Atouin.getInstance().options.hideInterMap))
         {
            if(this._screenshotData == null)
            {
               this._screenshotData = new BitmapData(StageShareManager.startWidth,StageShareManager.startHeight,true,0);
               this._screenshot = new Bitmap(this._screenshotData);
               this._screenshot.smoothing = true;
            }
            ctr = Atouin.getInstance().rootContainer;
            this.matrix.identity();
            this.matrix.scale(ctr.scaleX,ctr.scaleY);
            this.matrix.translate(ctr.x,ctr.y);
            this._screenshotData.draw(ctr,this.matrix,null,null,null,true);
            if(AirScanner.isStreamingVersion())
            {
               this._screenshot.filters = [new BlurFilter()];
            }
            ctr.addChild(this._screenshot);
         }
      }
      
      public function getIdentifiedEntityElement(id:uint) : TiphonSprite {
         if((this._renderer) && (this._renderer.identifiedElements) && (this._renderer.identifiedElements[id]))
         {
            if(this._renderer.identifiedElements[id].sprite is TiphonSprite)
            {
               return this._renderer.identifiedElements[id].sprite as TiphonSprite;
            }
         }
         return null;
      }
      
      public function getIdentifiedElement(id:uint) : InteractiveObject {
         if((this._renderer) && (this._renderer.identifiedElements) && (this._renderer.identifiedElements[id]))
         {
            return this._renderer.identifiedElements[id].sprite;
         }
         return null;
      }
      
      public function getIdentifiedElementPosition(id:uint) : MapPoint {
         if((this._renderer) && (this._renderer.identifiedElements) && (this._renderer.identifiedElements[id]))
         {
            return this._renderer.identifiedElements[id].position;
         }
         return null;
      }
      
      public function reset() : void {
         this.unloadMap();
         this._currentMap = null;
         this._currentMapRendered = true;
         this._lastMap = null;
         this._renderRequestStack = [];
      }
      
      public function hideBackgroundForTacticMode(yes:Boolean) : void {
         this._renderer.modeTactic(yes);
      }
      
      private function init() : void {
         this._renderRequestStack = [];
         this._renderer = new MapRenderer(Atouin.getInstance().worldContainer,Elements.getInstance());
         this._renderer.addEventListener(RenderMapEvent.GFX_LOADING_START,this.logGfxLoadTime,false,0,true);
         this._renderer.addEventListener(RenderMapEvent.GFX_LOADING_END,this.logGfxLoadTime,false,0,true);
         this._renderer.addEventListener(RenderMapEvent.MAP_RENDER_START,this.mapRendered,false,0,true);
         this._renderer.addEventListener(RenderMapEvent.MAP_RENDER_END,this.mapRendered,false,0,true);
         this._renderer.addEventListener(ProgressEvent.PROGRESS,this.mapRenderProgress,false,0,true);
         AdapterFactory.addAdapter("dlm",MapsAdapter);
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onMapLoaded,false,0,true);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onMapFailed,false,0,true);
      }
      
      private function mapDisplayed() : void {
         this._currentMapRendered = true;
         InteractiveCellManager.getInstance().updateInteractiveCell(this._currentDataMap);
         this._renderRequestStack.shift();
         var msg:MapsLoadingCompleteMessage = new MapsLoadingCompleteMessage(this._currentMap,MapDisplayManager.getInstance().getDataMapContainer().dataMap);
         msg.renderRequestId = this._currentRenderId;
         Atouin.getInstance().handler.process(msg);
         this.checkForRender();
      }
      
      private function checkForRender() : void {
         var dataMap:Map = null;
         var msg:MapsLoadingCompleteMessage = null;
         var atouin:Atouin = null;
         if((!this._currentMapRendered) && (this._currentMap))
         {
            return;
         }
         if(this._renderRequestStack.length == 0)
         {
            return;
         }
         var request:RenderRequest = RenderRequest(this._renderRequestStack[0]);
         var pMap:WorldPoint = request.map;
         var forceReloadWithoutCache:Boolean = request.forceReloadWithoutCache;
         Atouin.getInstance().showWorld(true);
         this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
         if((!forceReloadWithoutCache && this._currentMap) && (this._currentMap.mapId == pMap.mapId) && (!Atouin.getInstance().options.reloadLoadedMap))
         {
            this._renderRequestStack.shift();
            _log.debug("Map " + pMap.mapId + " is the same, renderRequestID: " + request.renderId);
            dataMap = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            msg = new MapsLoadingCompleteMessage(this._currentMap,dataMap);
            atouin = Atouin.getInstance();
            atouin.handler.process(msg);
            msg.renderRequestId = request.renderId;
            if((!(dataMap.zoomScale == 1)) && (atouin.options.useInsideAutoZoom))
            {
               atouin.rootContainer.scaleX = dataMap.zoomScale;
               atouin.rootContainer.scaleY = dataMap.zoomScale;
               atouin.rootContainer.x = dataMap.zoomOffsetX;
               atouin.rootContainer.y = dataMap.zoomOffsetY;
               atouin.currentZoom = dataMap.zoomScale;
            }
            this.checkForRender();
            return;
         }
         this._currentMapRendered = false;
         this._lastMap = this._currentMap;
         this._currentMap = pMap;
         this._currentRenderId = request.renderId;
         this._forceReloadWithoutCache = forceReloadWithoutCache;
         var msg2:MapsLoadingStartedMessage = new MapsLoadingStartedMessage();
         Atouin.getInstance().handler.process(msg2);
         this._nMapLoadStart = getTimer();
         this._loader.cancel();
         this._loader.load(new Uri(getMapUriFromId(pMap.mapId)),null);
      }
      
      private function onMapLoaded(e:ResourceLoadedEvent) : void {
         var request:RenderRequest = RenderRequest(this._renderRequestStack[0]);
         this._nMapLoadEnd = getTimer();
         var map:Map = new Map();
         if(e.resource is Map)
         {
            map = e.resource;
         }
         else
         {
            try
            {
               map.fromRaw(e.resource,request.decryptionKey);
            }
            catch(e:Error)
            {
               _log.fatal("Exception sur le parsing du fichier de map :\n" + e.getStackTrace());
               map = new DefaultMap();
            }
         }
         this._isDefaultMap = map is DefaultMap;
         this.unloadMap();
         DataMapProvider.getInstance().resetUpdatedCell();
         DataMapProvider.getInstance().resetSpecialEffects();
         if(!request)
         {
            return;
         }
         this._currentDataMap = new DataMapContainer(map);
         MEMORY_LOG[DataMapContainer] = 1;
         this._renderer.render(this._currentDataMap,this._forceReloadWithoutCache,request.renderId);
         FrustumManager.getInstance().updateMap();
      }
      
      private function onMapFailed(e:ResourceErrorEvent) : void {
         _log.error("Impossible de charger la map " + e.uri + " : " + e.errorMsg);
         this._currentMapRendered = true;
         this._renderRequestStack.shift();
         this.checkForRender();
         this.signalMapLoadingFailure(MapLoadingFailedMessage.NO_FILE);
      }
      
      private function logGfxLoadTime(e:Event) : void {
         if(e.type == RenderMapEvent.GFX_LOADING_START)
         {
            this._nGfxLoadStart = getTimer();
         }
         if(e.type == RenderMapEvent.GFX_LOADING_END)
         {
            this._nGfxLoadEnd = getTimer();
         }
      }
      
      private function tweenInterMap(e:Event) : void {
         this._screenshot.alpha = this._screenshot.alpha - this._screenshot.alpha / 3;
         if(this._screenshot.alpha < 0.01)
         {
            Atouin.getInstance().worldContainer.cacheAsBitmap = false;
            this.removeScreenShot();
            EnterFrameDispatcher.removeEventListener(this.tweenInterMap);
         }
      }
      
      private function mapRenderProgress(e:ProgressEvent) : void {
         if(!this._currentMap)
         {
            this._currentMapRendered = true;
            this.unloadMap();
            this.signalMapLoadingFailure(MapLoadingFailedMessage.CLIENT_SHUTDOWN);
            return;
         }
         var msg:MapRenderProgressMessage = new MapRenderProgressMessage(e.bytesLoaded / e.bytesTotal * 100);
         msg.id = this._currentMap.mapId;
         msg.renderRequestId = this._currentRenderId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function signalMapLoadingFailure(errorReasonId:uint) : void {
         var msg:MapLoadingFailedMessage = new MapLoadingFailedMessage();
         if(!this._currentMap)
         {
            msg.id = 0;
         }
         else
         {
            msg.id = this._currentMap.mapId;
         }
         msg.errorReason = errorReasonId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function mapRendered(e:RenderMapEvent) : void {
         var tt:uint = 0;
         var tml:uint = 0;
         var tgl:* = 0;
         var msg:MapLoadedMessage = null;
         if(e.type == RenderMapEvent.MAP_RENDER_START)
         {
            this._nRenderMapStart = getTimer();
         }
         if(e.type == RenderMapEvent.MAP_RENDER_END)
         {
            this.mapDisplayed();
            this._nRenderMapEnd = getTimer();
            tt = this._nRenderMapEnd - this._nMapLoadStart;
            tml = this._nMapLoadEnd - this._nMapLoadStart;
            tgl = this._nGfxLoadEnd - this._nGfxLoadStart;
            msg = new MapLoadedMessage();
            msg.dataLoadingTime = tml;
            msg.gfxLoadingTime = tgl;
            msg.renderingTime = this._nRenderMapEnd - this._nRenderMapStart;
            msg.globalRenderingTime = tt;
            _log.info("map rendered [total : " + tt + "ms, " + (tt < 100?" " + (tt < 10?" ":""):"") + "map load : " + tml + "ms, " + (tml < 100?" " + (tml < 10?" ":""):"") + "gfx load : " + tgl + "ms, " + (tgl < 100?" " + (tgl < 10?" ":""):"") + "render : " + (this._nRenderMapEnd - this._nRenderMapStart) + "ms] file : " + (this._currentMap?this._currentMap.mapId.toString():"???") + ".dlm" + (this._isDefaultMap?" (/!\\ DEFAULT MAP) ":"") + " / renderRequestID #" + this._currentRenderId);
            if((this._screenshot) && (this._screenshot.parent))
            {
               if(Atouin.getInstance().options.tweentInterMap)
               {
                  Atouin.getInstance().worldContainer.cacheAsBitmap = true;
                  EnterFrameDispatcher.addEventListener(this.tweenInterMap,"tweentInterMap");
               }
               else
               {
                  this.removeScreenShot();
               }
            }
            msg.id = this._currentMap.mapId;
            Atouin.getInstance().handler.process(msg);
         }
      }
      
      private function removeScreenShot() : void {
         this._screenshot.parent.removeChild(this._screenshot);
         this._screenshotData.fillRect(new Rectangle(0,0,this._screenshotData.width,this._screenshotData.height),4.27819008E9);
      }
   }
}
import com.ankamagames.jerakine.types.positions.WorldPoint;
import flash.utils.ByteArray;

class RenderRequest extends Object
{
   
   function RenderRequest(map:WorldPoint, forceReloadWithoutCache:Boolean, decryptionKey:ByteArray) {
      super();
      this.renderId = RENDER_ID++;
      this.map = map;
      this.forceReloadWithoutCache = forceReloadWithoutCache;
      this.decryptionKey = decryptionKey;
   }
   
   private static var RENDER_ID:uint = 0;
   
   public var renderId:uint;
   
   public var map:WorldPoint;
   
   public var forceReloadWithoutCache:Boolean;
   
   public var decryptionKey:ByteArray;
}
