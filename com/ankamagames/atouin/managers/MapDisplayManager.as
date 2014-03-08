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
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapDisplayManager));
      
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
      
      public function fromMap(param1:Map, param2:ByteArray=null) : uint {
         this._currentMap = WorldPoint.fromMapId(param1.id);
         var _loc3_:RenderRequest = new RenderRequest(this._currentMap,false,param2);
         this._renderRequestStack.push(_loc3_);
         this._currentRenderId = _loc3_.renderId;
         Atouin.getInstance().showWorld(true);
         this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
         Atouin.getInstance().options.groundCacheMode = 0;
         var _loc4_:ResourceLoadedEvent = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
         _loc4_.resource = param1;
         this.onMapLoaded(_loc4_);
         return this._currentRenderId;
      }
      
      public function display(param1:WorldPoint, param2:Boolean=false, param3:ByteArray=null) : uint {
         var _loc4_:RenderRequest = new RenderRequest(param1,param2,param3);
         _log.debug("Ask render map " + param1.mapId + ", renderRequestID: " + _loc4_.renderId);
         this._renderRequestStack.push(_loc4_);
         this.checkForRender();
         return _loc4_.renderId;
      }
      
      public function isBoundingBox(param1:int) : Boolean {
         if(MapRenderer.boundingBoxElements[param1])
         {
            return true;
         }
         return false;
      }
      
      public function cacheAsBitmapEnabled(param1:Boolean) : void {
         var _loc2_:Array = MapRenderer.cachedAsBitmapElement;
         var _loc3_:int = _loc2_.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_].cacheAsBitmap = param1;
            _loc4_++;
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
      
      public function activeIdentifiedElements(param1:Boolean) : void {
         var _loc3_:Object = null;
         var _loc2_:Dictionary = this._renderer.identifiedElements;
         for each (_loc3_ in _loc2_)
         {
            _loc3_.sprite.mouseEnabled = param1;
         }
      }
      
      public function unloadMap() : void {
         this._renderer.unload();
      }
      
      private var matrix:Matrix;
      
      public function capture() : void {
         var _loc1_:DisplayObjectContainer = null;
         if((Atouin.getInstance().options.tweentInterMap) || (Atouin.getInstance().options.hideInterMap))
         {
            if(this._screenshotData == null)
            {
               this._screenshotData = new BitmapData(StageShareManager.startWidth,StageShareManager.startHeight,true,0);
               this._screenshot = new Bitmap(this._screenshotData);
               this._screenshot.smoothing = true;
            }
            _loc1_ = Atouin.getInstance().rootContainer;
            this.matrix.identity();
            this.matrix.scale(_loc1_.scaleX,_loc1_.scaleY);
            this.matrix.translate(_loc1_.x,_loc1_.y);
            this._screenshotData.draw(_loc1_,this.matrix,null,null,null,true);
            if(AirScanner.isStreamingVersion())
            {
               this._screenshot.filters = [new BlurFilter()];
            }
            _loc1_.addChild(this._screenshot);
         }
      }
      
      public function getIdentifiedEntityElement(param1:uint) : TiphonSprite {
         if((this._renderer) && (this._renderer.identifiedElements) && (this._renderer.identifiedElements[param1]))
         {
            if(this._renderer.identifiedElements[param1].sprite is TiphonSprite)
            {
               return this._renderer.identifiedElements[param1].sprite as TiphonSprite;
            }
         }
         return null;
      }
      
      public function getIdentifiedElement(param1:uint) : InteractiveObject {
         if((this._renderer) && (this._renderer.identifiedElements) && (this._renderer.identifiedElements[param1]))
         {
            return this._renderer.identifiedElements[param1].sprite;
         }
         return null;
      }
      
      public function getIdentifiedElementPosition(param1:uint) : MapPoint {
         if((this._renderer) && (this._renderer.identifiedElements) && (this._renderer.identifiedElements[param1]))
         {
            return this._renderer.identifiedElements[param1].position;
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
      
      public function hideBackgroundForTacticMode(param1:Boolean) : void {
         this._renderer.modeTactic(param1);
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
         var _loc1_:MapsLoadingCompleteMessage = new MapsLoadingCompleteMessage(this._currentMap,MapDisplayManager.getInstance().getDataMapContainer().dataMap);
         _loc1_.renderRequestId = this._currentRenderId;
         Atouin.getInstance().handler.process(_loc1_);
         this.checkForRender();
      }
      
      private function checkForRender() : void {
         var _loc5_:Map = null;
         var _loc6_:MapsLoadingCompleteMessage = null;
         var _loc7_:Atouin = null;
         if(!this._currentMapRendered && (this._currentMap))
         {
            return;
         }
         if(this._renderRequestStack.length == 0)
         {
            return;
         }
         var _loc1_:RenderRequest = RenderRequest(this._renderRequestStack[0]);
         var _loc2_:WorldPoint = _loc1_.map;
         var _loc3_:Boolean = _loc1_.forceReloadWithoutCache;
         Atouin.getInstance().showWorld(true);
         this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
         if(((!_loc3_) && (this._currentMap)) && (this._currentMap.mapId == _loc2_.mapId) && !Atouin.getInstance().options.reloadLoadedMap)
         {
            this._renderRequestStack.shift();
            _log.debug("Map " + _loc2_.mapId + " is the same, renderRequestID: " + _loc1_.renderId);
            _loc5_ = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            _loc6_ = new MapsLoadingCompleteMessage(this._currentMap,_loc5_);
            _loc7_ = Atouin.getInstance();
            _loc7_.handler.process(_loc6_);
            _loc6_.renderRequestId = _loc1_.renderId;
            if(!(_loc5_.zoomScale == 1) && (_loc7_.options.useInsideAutoZoom))
            {
               _loc7_.rootContainer.scaleX = _loc5_.zoomScale;
               _loc7_.rootContainer.scaleY = _loc5_.zoomScale;
               _loc7_.rootContainer.x = _loc5_.zoomOffsetX;
               _loc7_.rootContainer.y = _loc5_.zoomOffsetY;
               _loc7_.currentZoom = _loc5_.zoomScale;
            }
            this.checkForRender();
            return;
         }
         this._currentMapRendered = false;
         this._lastMap = this._currentMap;
         this._currentMap = _loc2_;
         this._currentRenderId = _loc1_.renderId;
         this._forceReloadWithoutCache = _loc3_;
         var _loc4_:MapsLoadingStartedMessage = new MapsLoadingStartedMessage();
         Atouin.getInstance().handler.process(_loc4_);
         this._nMapLoadStart = getTimer();
         this._loader.cancel();
         this._loader.load(new Uri(getMapUriFromId(_loc2_.mapId)),null);
      }
      
      private function onMapLoaded(param1:ResourceLoadedEvent) : void {
         var e:ResourceLoadedEvent = param1;
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
      
      private function onMapFailed(param1:ResourceErrorEvent) : void {
         _log.error("Impossible de charger la map " + param1.uri + " : " + param1.errorMsg);
         this._currentMapRendered = true;
         this._renderRequestStack.shift();
         this.checkForRender();
         this.signalMapLoadingFailure(MapLoadingFailedMessage.NO_FILE);
      }
      
      private function logGfxLoadTime(param1:Event) : void {
         if(param1.type == RenderMapEvent.GFX_LOADING_START)
         {
            this._nGfxLoadStart = getTimer();
         }
         if(param1.type == RenderMapEvent.GFX_LOADING_END)
         {
            this._nGfxLoadEnd = getTimer();
         }
      }
      
      private function tweenInterMap(param1:Event) : void {
         this._screenshot.alpha = this._screenshot.alpha - this._screenshot.alpha / 3;
         if(this._screenshot.alpha < 0.01)
         {
            Atouin.getInstance().worldContainer.cacheAsBitmap = false;
            this.removeScreenShot();
            EnterFrameDispatcher.removeEventListener(this.tweenInterMap);
         }
      }
      
      private function mapRenderProgress(param1:ProgressEvent) : void {
         if(!this._currentMap)
         {
            this._currentMapRendered = true;
            this.unloadMap();
            this.signalMapLoadingFailure(MapLoadingFailedMessage.CLIENT_SHUTDOWN);
            return;
         }
         var _loc2_:MapRenderProgressMessage = new MapRenderProgressMessage(param1.bytesLoaded / param1.bytesTotal * 100);
         _loc2_.id = this._currentMap.mapId;
         _loc2_.renderRequestId = this._currentRenderId;
         Atouin.getInstance().handler.process(_loc2_);
      }
      
      private function signalMapLoadingFailure(param1:uint) : void {
         var _loc2_:MapLoadingFailedMessage = new MapLoadingFailedMessage();
         if(!this._currentMap)
         {
            _loc2_.id = 0;
         }
         else
         {
            _loc2_.id = this._currentMap.mapId;
         }
         _loc2_.errorReason = param1;
         Atouin.getInstance().handler.process(_loc2_);
      }
      
      private function mapRendered(param1:RenderMapEvent) : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:* = 0;
         var _loc5_:MapLoadedMessage = null;
         if(param1.type == RenderMapEvent.MAP_RENDER_START)
         {
            this._nRenderMapStart = getTimer();
         }
         if(param1.type == RenderMapEvent.MAP_RENDER_END)
         {
            this.mapDisplayed();
            this._nRenderMapEnd = getTimer();
            _loc2_ = this._nRenderMapEnd - this._nMapLoadStart;
            _loc3_ = this._nMapLoadEnd - this._nMapLoadStart;
            _loc4_ = this._nGfxLoadEnd - this._nGfxLoadStart;
            _loc5_ = new MapLoadedMessage();
            _loc5_.dataLoadingTime = _loc3_;
            _loc5_.gfxLoadingTime = _loc4_;
            _loc5_.renderingTime = this._nRenderMapEnd - this._nRenderMapStart;
            _loc5_.globalRenderingTime = _loc2_;
            _log.info("map rendered [total : " + _loc2_ + "ms, " + (_loc2_ < 100?" " + (_loc2_ < 10?" ":""):"") + "map load : " + _loc3_ + "ms, " + (_loc3_ < 100?" " + (_loc3_ < 10?" ":""):"") + "gfx load : " + _loc4_ + "ms, " + (_loc4_ < 100?" " + (_loc4_ < 10?" ":""):"") + "render : " + (this._nRenderMapEnd - this._nRenderMapStart) + "ms] file : " + (this._currentMap?this._currentMap.mapId.toString():"???") + ".dlm" + (this._isDefaultMap?" (/!\\ DEFAULT MAP) ":"") + " / renderRequestID #" + this._currentRenderId);
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
            _loc5_.id = this._currentMap.mapId;
            Atouin.getInstance().handler.process(_loc5_);
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
   
   function RenderRequest(param1:WorldPoint, param2:Boolean, param3:ByteArray) {
      super();
      this.renderId = RENDER_ID++;
      this.map = param1;
      this.forceReloadWithoutCache = param2;
      this.decryptionKey = param3;
   }
   
   private static var RENDER_ID:uint = 0;
   
   public var renderId:uint;
   
   public var map:WorldPoint;
   
   public var forceReloadWithoutCache:Boolean;
   
   public var decryptionKey:ByteArray;
}
