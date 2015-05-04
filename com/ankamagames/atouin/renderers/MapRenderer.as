package com.ankamagames.atouin.renderers
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Point;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import flash.display.Sprite;
   import flash.display.Shape;
   import flash.utils.Timer;
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import flash.system.ApplicationDomain;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.atouin.data.map.Fixture;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.AnimatedElementManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.atouin.managers.DataGroundMapManager;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.enums.GroundCache;
   import com.ankamagames.atouin.data.elements.subtypes.AnimatedGraphicalElementData;
   import flash.system.LoaderContext;
   import com.ankamagames.atouin.types.events.RenderMapEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import flash.display.DisplayObject;
   import com.ankamagames.tiphon.display.RasterizedAnimation;
   import com.ankamagames.atouin.types.LayerContainer;
   import com.ankamagames.atouin.types.CellReference;
   import flash.geom.Rectangle;
   import com.ankamagames.atouin.types.ICellContainer;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.Layer;
   import flash.geom.ColorTransform;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.atouin.types.BitmapCellContainer;
   import com.ankamagames.atouin.types.CellContainer;
   import com.ankamagames.atouin.types.InteractiveCell;
   import com.ankamagames.atouin.data.map.CellData;
   import flash.utils.getTimer;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.elements.subtypes.EntityGraphicalElementData;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.atouin.types.WorldEntitySprite;
   import com.ankamagames.atouin.data.elements.subtypes.ParticlesGraphicalElementData;
   import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
   import com.ankamagames.jerakine.types.ASwf;
   import flash.display.MovieClip;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.jerakine.utils.display.MovieClipUtils;
   import com.ankamagames.atouin.types.MapGfxBitmap;
   import com.ankamagames.atouin.data.elements.subtypes.BoundingBoxGraphicalElementData;
   import flash.display.InteractiveObject;
   import com.ankamagames.atouin.data.elements.subtypes.BlendedGraphicalElementData;
   import com.ankamagames.jerakine.script.ScriptExec;
   import com.ankamagames.sweevo.runners.EmitterRunner;
   import com.ankamagames.atouin.types.SpriteWrapper;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.data.XmlConfig;
   
   public class MapRenderer extends EventDispatcher
   {
      
      public function MapRenderer(param1:DisplayObjectContainer, param2:Elements)
      {
         var _loc4_:* = undefined;
         this._bitmapsGfx = [];
         this._swfGfx = [];
         this._swfApplicationDomain = new Array();
         this._hideForeground = Atouin.getInstance().options.hideForeground;
         this._downloadTimer = new Timer(2500);
         this.colorTransform = new ColorTransform();
         this._m = new Matrix();
         this._srcRect = new Rectangle();
         this._destPoint = new Point();
         this._clTrans = new ColorTransform();
         super();
         this._container = param1;
         if(isNaN(_groundGlobalScaleRatio))
         {
            _loc4_ = XmlConfig.getInstance().getEntry("config.gfx.world.scaleRatio");
            _groundGlobalScaleRatio = _loc4_ == null?1:parseFloat(_loc4_);
         }
         if(_bitmapOffsetPoint == null)
         {
            _bitmapOffsetPoint = StageShareManager.stage.localToGlobal(new Point(this._container.x,this._container.y));
         }
         this._elements = param2;
         this._icm = InteractiveCellManager.getInstance();
         this._gfxPath = Atouin.getInstance().options.elementsPath;
         this._gfxSubPathJpg = Atouin.getInstance().options.jpgSubPath;
         this._gfxSubPathPng = Atouin.getInstance().options.pngSubPath;
         this._particlesPath = Atouin.getInstance().options.particlesScriptsPath;
         this._extension = Atouin.getInstance().options.mapPictoExtension;
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(1,8947848);
         _loc3_.graphics.beginFill(2236962);
         _loc3_.graphics.drawRect(0,0,600,10);
         _loc3_.x = 0;
         _loc3_.y = 0;
         this._downloadProgressBar = new Shape();
         this._downloadProgressBar.graphics.beginFill(10077440);
         this._downloadProgressBar.graphics.drawRect(0,0,597,7);
         this._downloadProgressBar.graphics.endFill();
         this._downloadProgressBar.x = 2;
         this._downloadProgressBar.y = 2;
         this._progressBarCtr = new Sprite();
         this._progressBarCtr.addChild(_loc3_);
         this._progressBarCtr.addChild(this._downloadProgressBar);
         this._progressBarCtr.x = (StageShareManager.startWidth - this._progressBarCtr.width) / 2;
         this._progressBarCtr.y = (StageShareManager.startHeight - this._progressBarCtr.height) / 2;
         this._gfxLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._gfxLoader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded,false,0,true);
         this._gfxLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onBitmapGfxLoaded,false,0,true);
         this._gfxLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError,false,0,true);
         this._swfLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._swfLoader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded,false,0,true);
         this._swfLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onSwfGfxLoaded,false,0,true);
         this._swfLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError,false,0,true);
         this._downloadTimer.addEventListener(TimerEvent.TIMER,this.onDownloadTimer);
      }
      
      public static var MEMORY_LOG_1:Dictionary = new Dictionary(true);
      
      public static var MEMORY_LOG_2:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapRenderer));
      
      public static var cachedAsBitmapElement:Array = new Array();
      
      public static var boundingBoxElements:Array;
      
      private static var _bitmapOffsetPoint:Point;
      
      private static var _groundGlobalScaleRatio:Number;
      
      public var useDefautState:Boolean;
      
      public function get gfxMemorySize() : uint
      {
         return this._gfxMemorySize;
      }
      
      private var _container:DisplayObjectContainer;
      
      private var _elements:Elements;
      
      private var _gfxLoader:IResourceLoader;
      
      private var _swfLoader:IResourceLoader;
      
      private var _map:Map;
      
      private var _useSmooth:Boolean;
      
      private var _cacheRef:Array;
      
      private var _bitmapsGfx:Array;
      
      private var _swfGfx:Array;
      
      private var _swfApplicationDomain:Array;
      
      private var _dataMapContainer:DataMapContainer;
      
      private var _icm:InteractiveCellManager;
      
      private var _hideForeground:Boolean;
      
      private var _identifiedElements:Dictionary;
      
      private var _gfxPath:String;
      
      private var _gfxSubPathJpg:String;
      
      private var _gfxSubPathPng:String;
      
      private var _particlesPath:String;
      
      private var _hasSwfGxf:Boolean;
      
      private var _hasBitmapGxf:Boolean;
      
      private var _loadedGfxListCount:uint = 0;
      
      private var _pictoAsBitmap:Boolean;
      
      private var _mapLoaded:Boolean = true;
      
      private var _groundLayerCtrIndex:int;
      
      private var _hasGroundJPG:Boolean = false;
      
      private var _skipGroundCache:Boolean = false;
      
      private var _forceReloadWithoutCache:Boolean = false;
      
      private var _groundIsLoaded:Boolean = false;
      
      private var _mapIsReady:Boolean = false;
      
      private var _allowAnimatedGfx:Boolean;
      
      private var _debugLayer:Boolean;
      
      private var _allowParticlesFx:Boolean;
      
      private var _gfxMemorySize:uint = 0;
      
      private var _renderId:uint = 0;
      
      private var _extension:String;
      
      private var _renderFixture:Boolean = true;
      
      private var _renderBackgroundColor:Boolean = true;
      
      private var _progressBarCtr:Sprite;
      
      private var _downloadProgressBar:Shape;
      
      private var _downloadTimer:Timer;
      
      private var _fileToLoad:uint;
      
      private var _fileLoaded:uint;
      
      private var _cancelRender:Boolean;
      
      private var _bitmapForegroundContainer:Bitmap;
      
      private var _layersData:Array;
      
      private var _tacticModeActivated:Boolean = false;
      
      public function get identifiedElements() : Dictionary
      {
         return this._identifiedElements;
      }
      
      public function initRenderContainer(param1:DisplayObjectContainer) : void
      {
         this._container = param1;
      }
      
      public function render(param1:DataMapContainer, param2:Boolean = false, param3:uint = 0, param4:Boolean = true) : void
      {
         var _loc12_:Uri = null;
         var _loc13_:* = false;
         var _loc14_:NormalGraphicalElementData = null;
         var _loc15_:ApplicationDomain = null;
         var _loc16_:GraphicalElementData = null;
         var _loc17_:Fixture = null;
         var _loc18_:* = 0;
         this._cancelRender = false;
         this._renderFixture = param4;
         this._renderBackgroundColor = param4;
         this._downloadTimer.reset();
         this._gfxMemorySize = 0;
         this._fileLoaded = 0;
         this._renderId = param3;
         Atouin.getInstance().cancelZoom();
         AnimatedElementManager.reset();
         boundingBoxElements = new Array();
         this._allowAnimatedGfx = Atouin.getInstance().options.allowAnimatedGfx;
         this._debugLayer = Atouin.getInstance().options.debugLayer;
         this._allowParticlesFx = Atouin.getInstance().options.allowParticlesFx;
         var _loc5_:* = !this._mapLoaded;
         this._mapLoaded = false;
         this._groundIsLoaded = false;
         this._mapIsReady = false;
         this._map = param1.dataMap;
         this._downloadProgressBar.scaleX = 0;
         this._forceReloadWithoutCache = param2;
         var _loc6_:int = AirScanner.isStreamingVersion()?0:Atouin.getInstance().options.groundCacheMode;
         if(param2)
         {
            this._skipGroundCache = true;
            this._hasGroundJPG = false;
         }
         else
         {
            this._skipGroundCache = DataGroundMapManager.mapsCurrentlyRendered() > AtouinConstants.MAX_GROUND_CACHE_MEMORY || _loc6_ == 0;
            this._map.groundCacheCurrentlyUsed = _loc6_;
            if((_loc6_) && !this._skipGroundCache)
            {
               _loc18_ = DataGroundMapManager.loadGroundMap(this._map,this.groundMapLoaded,this.groundMapNotLoaded);
               if(_loc18_ == GroundCache.GROUND_CACHE_AVAILABLE)
               {
                  this._hasGroundJPG = true;
               }
               else if(_loc18_ == GroundCache.GROUND_CACHE_NOT_AVAILABLE)
               {
                  this._hasGroundJPG = false;
               }
               else if(_loc18_ == GroundCache.GROUND_CACHE_ERROR)
               {
                  this._hasGroundJPG = false;
                  _loc6_ = 0;
                  Atouin.getInstance().options.groundCacheMode = 0;
               }
               else if(_loc18_ == GroundCache.GROUND_CACHE_SKIP)
               {
                  this._skipGroundCache = true;
                  this._hasGroundJPG = false;
               }
               
               
               
            }
            else
            {
               this._hasGroundJPG = false;
            }
         }
         if(this._hasGroundJPG)
         {
            Atouin.getInstance().worldContainer.visible = false;
         }
         this._cacheRef = new Array();
         var _loc7_:Array = new Array();
         var _loc8_:Array = new Array();
         this._useSmooth = Atouin.getInstance().options.useSmooth;
         this._dataMapContainer = param1;
         this._identifiedElements = new Dictionary(true);
         this._loadedGfxListCount = 0;
         this._hasSwfGxf = false;
         this._hasBitmapGxf = false;
         var _loc9_:Array = new Array();
         var _loc10_:Array = new Array();
         var _loc11_:Array = this._map.getGfxList(this._hasGroundJPG);
         for each(_loc16_ in _loc11_)
         {
            if(_loc16_ is NormalGraphicalElementData)
            {
               _loc14_ = _loc16_ as NormalGraphicalElementData;
               if(_loc14_ is AnimatedGraphicalElementData)
               {
                  _loc15_ = new ApplicationDomain();
                  _loc12_ = new Uri(this._gfxPath + "/swf/" + _loc14_.gfxId + ".swf");
                  _loc12_.loaderContext = new LoaderContext(false,_loc15_);
                  AirScanner.allowByteCodeExecution(_loc12_.loaderContext,true);
                  _loc10_.push(_loc12_);
                  this._hasSwfGxf = true;
                  _loc12_.tag = _loc14_.gfxId;
                  this._cacheRef[_loc14_.gfxId] = "RES_" + _loc12_.toSum();
                  this._swfApplicationDomain[_loc14_.gfxId] = _loc15_;
               }
               else if(this._bitmapsGfx[_loc14_.gfxId])
               {
                  _loc7_[_loc14_.gfxId] = this._bitmapsGfx[_loc14_.gfxId];
               }
               else
               {
                  _loc13_ = Elements.getInstance().isJpg(_loc14_.gfxId);
                  _loc12_ = new Uri(this._gfxPath + "/" + (_loc13_?this._gfxSubPathJpg:this._gfxSubPathPng) + "/" + _loc14_.gfxId + "." + (_loc13_?"jpg":this._extension));
                  _loc9_.push(_loc12_);
                  this._hasBitmapGxf = true;
                  _loc12_.tag = _loc14_.gfxId;
                  this._cacheRef[_loc14_.gfxId] = "RES_" + _loc12_.toSum();
               }
               
            }
         }
         if(!this._hasGroundJPG && (param4))
         {
            for each(_loc17_ in this._map.backgroundFixtures)
            {
               if(this._bitmapsGfx[_loc17_.fixtureId])
               {
                  _loc7_[_loc17_.fixtureId] = this._bitmapsGfx[_loc17_.fixtureId];
               }
               else
               {
                  _loc13_ = Elements.getInstance().isJpg(_loc17_.fixtureId);
                  _loc12_ = new Uri(this._gfxPath + "/" + (_loc13_?this._gfxSubPathJpg:this._gfxSubPathPng) + "/" + _loc17_.fixtureId + "." + (_loc13_?"jpg":this._extension));
                  _loc12_.tag = _loc17_.fixtureId;
                  _loc9_.push(_loc12_);
                  this._hasBitmapGxf = true;
                  this._cacheRef[_loc17_.fixtureId] = "RES_" + _loc12_.toSum();
               }
            }
         }
         if(param4)
         {
            for each(_loc17_ in this._map.foregroundFixtures)
            {
               if(this._bitmapsGfx[_loc17_.fixtureId])
               {
                  _loc7_[_loc17_.fixtureId] = this._bitmapsGfx[_loc17_.fixtureId];
               }
               else
               {
                  _loc13_ = Elements.getInstance().isJpg(_loc17_.fixtureId);
                  _loc12_ = new Uri(this._gfxPath + "/" + (_loc13_?this._gfxSubPathJpg:this._gfxSubPathPng) + "/" + _loc17_.fixtureId + "." + (_loc13_?"jpg":this._extension));
                  _loc12_.tag = _loc17_.fixtureId;
                  _loc9_.push(_loc12_);
                  this._hasBitmapGxf = true;
                  this._cacheRef[_loc17_.fixtureId] = "RES_" + _loc12_.toSum();
               }
            }
         }
         dispatchEvent(new RenderMapEvent(RenderMapEvent.GFX_LOADING_START,false,false,this._map.id,this._renderId));
         this._bitmapsGfx = _loc7_;
         this._swfGfx = new Array();
         if(_loc5_)
         {
            this._gfxLoader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded);
            this._gfxLoader.removeEventListener(ResourceLoadedEvent.LOADED,this.onBitmapGfxLoaded);
            this._gfxLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
            this._swfLoader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded);
            this._swfLoader.removeEventListener(ResourceLoadedEvent.LOADED,this.onSwfGfxLoaded);
            this._swfLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
            this._gfxLoader.cancel();
            this._swfLoader.cancel();
            this._gfxLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._gfxLoader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded,false,0,true);
            this._gfxLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onBitmapGfxLoaded,false,0,true);
            this._gfxLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError,false,0,true);
            this._swfLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._swfLoader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded,false,0,true);
            this._swfLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onSwfGfxLoaded,false,0,true);
            this._swfLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError,false,0,true);
         }
         this._fileToLoad = _loc9_.length + _loc10_.length;
         this._gfxLoader.load(_loc9_);
         this._swfLoader.load(_loc10_,null,AdvancedSwfAdapter);
         this._downloadTimer.start();
         if(_loc9_.length == 0 && _loc10_.length == 0)
         {
            this.onAllGfxLoaded(null);
         }
      }
      
      public function unload() : void
      {
         var _loc1_:DisplayObject = null;
         this._cancelRender = true;
         this._mapLoaded = true;
         this._gfxLoader.cancel();
         this._swfLoader.cancel();
         this._fileToLoad = 0;
         this._fileLoaded = 0;
         RasterizedAnimation.optimize(1);
         AnimatedElementManager.reset();
         while(cachedAsBitmapElement.length)
         {
            cachedAsBitmapElement.shift().cacheAsBitmap = false;
         }
         this._map = null;
         if(this._dataMapContainer)
         {
            this._dataMapContainer.removeContainer();
         }
         while(this._container.numChildren)
         {
            _loc1_ = this._container.removeChildAt(0);
            if(_loc1_ is Bitmap && (Bitmap(_loc1_).bitmapData))
            {
               Bitmap(_loc1_).bitmapData.dispose();
            }
            _loc1_ = null;
         }
      }
      
      public function modeTactic(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:* = 0;
         if((param1) && !(this._container.opaqueBackground == 0))
         {
            this._container.opaqueBackground = 0;
         }
         else if(!param1 && (this._map))
         {
            if(this._renderBackgroundColor)
            {
               this._container.opaqueBackground = this._map.backgroundColor;
            }
         }
         
         this._tacticModeActivated = param1;
         if((!param1) && (this._layersData) && this._layersData.length > 0)
         {
            for each(_loc2_ in this._layersData)
            {
               _loc2_.data.visible = true;
            }
            this._layersData = null;
         }
         else if((param1) && (this._groundIsLoaded))
         {
            this._layersData = new Array();
            _loc2_ = new Object();
            _loc2_.data = this._container.getChildAt(0);
            _loc2_.index = 0;
            this._layersData.push(_loc2_);
            _loc2_.data.visible = false;
         }
         else if(param1)
         {
            this._layersData = new Array();
            while(!(this._container.getChildAt(_loc4_) is LayerContainer))
            {
               _loc2_ = new Object();
               _loc3_ = this._container.getChildAt(_loc4_);
               _loc2_.data = _loc3_;
               _loc2_.index = _loc4_;
               this._layersData.push(_loc2_);
               _loc3_.visible = false;
               _loc4_++;
            }
         }
         
         
         if((param1) && !(this._bitmapForegroundContainer == null))
         {
            this._bitmapForegroundContainer.visible = false;
         }
         else if(!param1 && !(this._bitmapForegroundContainer == null))
         {
            this._bitmapForegroundContainer.visible = true;
         }
         
      }
      
      public function isCellUnderFixture(param1:uint) : Boolean
      {
         var _loc2_:CellReference = this._dataMapContainer.getCellReference(param1);
         return this._bitmapForegroundContainer.bitmapData.hitTest(new Point(this._bitmapForegroundContainer.x,this._bitmapForegroundContainer.y),255,new Rectangle(_loc2_.x,_loc2_.y,AtouinConstants.CELL_WIDTH,AtouinConstants.CELL_HEIGHT));
      }
      
      private function makeMap() : void
      {
         var layerCtr:DisplayObjectContainer = null;
         var cellInteractionCtr:DisplayObjectContainer = null;
         var groundLayerCtr:Bitmap = null;
         var cellCtr:ICellContainer = null;
         var cellPnt:Point = null;
         var cellDisabled:Boolean = false;
         var hideFg:Boolean = false;
         var skipLayer:Boolean = false;
         var groundLayer:Boolean = false;
         var i:uint = 0;
         var nbCell:uint = 0;
         var cell:Cell = null;
         var layer:Layer = null;
         var endCell:Cell = null;
         var t:ColorTransform = null;
         var reelBmpDt:BitmapData = null;
         var m:Matrix = null;
         var tmp:Bitmap = null;
         var tsJpeg:uint = 0;
         this._downloadTimer.stop();
         if(this._progressBarCtr.parent)
         {
            this._progressBarCtr.parent.removeChild(this._progressBarCtr);
         }
         this._pictoAsBitmap = Atouin.getInstance().options.useCacheAsBitmap;
         groundLayerCtr = new Bitmap(new BitmapData(StageShareManager.startWidth * _groundGlobalScaleRatio,StageShareManager.startHeight * _groundGlobalScaleRatio,!this._renderBackgroundColor,this._renderBackgroundColor?this._map.backgroundColor:0),"auto",true);
         groundLayerCtr.x = groundLayerCtr.x - _bitmapOffsetPoint.x;
         var aInteractiveCell:Array = new Array();
         dispatchEvent(new RenderMapEvent(RenderMapEvent.MAP_RENDER_START,false,false,this._map.id,this._renderId));
         if(!this._hasGroundJPG)
         {
            this.renderFixture(this._map.backgroundFixtures,groundLayerCtr);
         }
         InteractiveCellManager.getInstance().initManager();
         EntitiesManager.getInstance().initManager();
         if(this._renderBackgroundColor)
         {
            this._container.opaqueBackground = this._map.backgroundColor;
         }
         var layerId:uint = 0;
         var groundOnly:Boolean = OptionManager.getOptionManager("atouin").groundOnly;
         var lastCellId:int = 0;
         var currentCellId:uint = 0;
         for each(layer in this._map.layers)
         {
            layerId = layer.layerId;
            if(layer.layerId != Layer.LAYER_GROUND)
            {
               layerCtr = this._dataMapContainer.getLayer(layerId);
            }
            else
            {
               layerCtr = null;
            }
            groundLayer = layerCtr == null;
            hideFg = (layerId) && (this._hideForeground);
            skipLayer = groundOnly;
            if(layer.cellsCount != 0)
            {
               if((layer.cells[layer.cells.length - 1] as Cell).cellId != AtouinConstants.MAP_CELLS_COUNT - 1)
               {
                  endCell = new Cell(layer);
                  endCell.cellId = AtouinConstants.MAP_CELLS_COUNT - 1;
                  endCell.elementsCount = 0;
                  endCell.elements = [];
                  layer.cells.push(endCell);
               }
               i = 0;
               nbCell = layer.cells.length;
               while(i < nbCell)
               {
                  cell = layer.cells[i];
                  currentCellId = cell.cellId;
                  if(layerId == Layer.LAYER_GROUND)
                  {
                     if(currentCellId - lastCellId > 1)
                     {
                        currentCellId = lastCellId + 1;
                        cell = null;
                     }
                     else
                     {
                        i++;
                     }
                  }
                  else
                  {
                     i++;
                  }
                  if(groundLayer)
                  {
                     cellCtr = new BitmapCellContainer(currentCellId);
                  }
                  else
                  {
                     cellCtr = new CellContainer(currentCellId);
                  }
                  cellCtr.layerId = layerId;
                  cellCtr.mouseEnabled = false;
                  if(cell)
                  {
                     cellPnt = cell.pixelCoords;
                     cellCtr.x = cellCtr.startX = int(Math.round(cellPnt.x)) * (cellCtr is CellContainer?_groundGlobalScaleRatio:1);
                     cellCtr.y = cellCtr.startY = int(Math.round(cellPnt.y)) * (cellCtr is CellContainer?_groundGlobalScaleRatio:1);
                     if(!skipLayer)
                     {
                        if(!this._hasGroundJPG || !groundLayer)
                        {
                           cellDisabled = this.addCellBitmapsElements(cell,cellCtr,hideFg,groundLayer);
                        }
                     }
                  }
                  else
                  {
                     cellDisabled = false;
                     cellPnt = Cell.cellPixelCoords(currentCellId);
                     cellCtr.x = cellCtr.startX = cellPnt.x;
                     cellCtr.y = cellCtr.startY = cellPnt.y;
                  }
                  if(!groundLayer)
                  {
                     layerCtr.addChild(cellCtr as DisplayObject);
                  }
                  else if(!this._hasGroundJPG && (groundLayer))
                  {
                     this.drawGround(groundLayerCtr,cellCtr as BitmapCellContainer);
                  }
                  
                  this._dataMapContainer.getCellReference(currentCellId).addSprite(cellCtr as DisplayObject);
                  this._dataMapContainer.getCellReference(currentCellId).x = cellCtr.x;
                  this._dataMapContainer.getCellReference(currentCellId).y = cellCtr.y;
                  this._dataMapContainer.getCellReference(currentCellId).isDisabled = cellDisabled;
                  if(layerId == Layer.LAYER_DECOR)
                  {
                     this._dataMapContainer.getCellReference(currentCellId).heightestDecor = cellCtr as Sprite;
                  }
                  if(!aInteractiveCell[currentCellId] && !(layerId == Layer.LAYER_ADDITIONAL_DECOR))
                  {
                     aInteractiveCell[currentCellId] = true;
                     cellInteractionCtr = this._icm.getCell(currentCellId);
                     cellInteractionCtr.y = cellCtr.y - (this._tacticModeActivated?0:this._map.cells[currentCellId].floor);
                     cellInteractionCtr.x = cellCtr.x;
                     if(!this._dataMapContainer.getChildByName(currentCellId.toString()))
                     {
                        DataMapContainer.interactiveCell[currentCellId] = new InteractiveCell(currentCellId,cellInteractionCtr,cellCtr.x,cellCtr.y - (this._tacticModeActivated?0:this._map.cells[currentCellId].floor));
                     }
                     this._dataMapContainer.getCellReference(currentCellId).elevation = cellCtr.y - (this._tacticModeActivated?0:this._map.cells[currentCellId].floor);
                     this._dataMapContainer.getCellReference(currentCellId).mov = CellData(this._map.cells[currentCellId]).mov;
                  }
                  lastCellId = currentCellId;
               }
               if(!groundLayer)
               {
                  layerCtr.mouseEnabled = false;
               }
               if(this._debugLayer)
               {
                  t = new ColorTransform();
                  t.color = Math.random() * 16777215;
                  layerCtr.transform.colorTransform = t;
               }
               if(!groundLayer)
               {
                  layerCtr.scaleX = layerCtr.scaleY = 1 / _groundGlobalScaleRatio;
                  this._container.addChild(layerCtr);
               }
               else if(!this._hasGroundJPG && (groundLayer))
               {
                  reelBmpDt = new BitmapData(AtouinConstants.RESOLUTION_HIGH_QUALITY.x,AtouinConstants.RESOLUTION_HIGH_QUALITY.y,!this._renderBackgroundColor,this._renderBackgroundColor?this._map.backgroundColor:0);
                  m = new Matrix();
                  m.scale(1 / _groundGlobalScaleRatio,1 / _groundGlobalScaleRatio);
                  reelBmpDt.lock();
                  reelBmpDt.draw(groundLayerCtr.bitmapData,m,null,null,null,true);
                  reelBmpDt.unlock();
                  tmp = new Bitmap(reelBmpDt,"auto",true);
                  tmp.x = -_bitmapOffsetPoint.x;
                  this._container.addChild(tmp);
               }
               
               if(!this._skipGroundCache && !this._hasGroundJPG && layerId == Layer.LAYER_GROUND)
               {
                  try
                  {
                     tsJpeg = getTimer();
                     DataGroundMapManager.saveGroundMap(groundLayerCtr.bitmapData,this._map);
                     _log.info("Temps d\'encodage jpeg : " + (getTimer() - tsJpeg)) + " ms";
                  }
                  catch(e:Error)
                  {
                     _log.fatal("Impossible de sauvegarder le sol de la map " + _map.id + " sous forme JPEG");
                     _log.fatal(e.getStackTrace());
                     continue;
                  }
               }
            }
         }
         this._bitmapForegroundContainer = new Bitmap(new BitmapData(StageShareManager.startWidth,StageShareManager.startHeight,true,this._map.backgroundColor),"auto",true);
         this._bitmapForegroundContainer.x = -_bitmapOffsetPoint.x;
         this.renderFixture(this._map.foregroundFixtures,this._bitmapForegroundContainer);
         this._bitmapForegroundContainer.visible = !this._tacticModeActivated;
         this._container.addChild(this._bitmapForegroundContainer);
         if(!this._hasGroundJPG)
         {
            groundLayerCtr.cacheAsBitmap = true;
         }
         var selectionContainer:Sprite = new Sprite();
         this._container.addChild(selectionContainer);
         selectionContainer.mouseEnabled = false;
         selectionContainer.mouseChildren = false;
         if(!this._hasGroundJPG || (this._groundIsLoaded))
         {
            dispatchEvent(new RenderMapEvent(RenderMapEvent.MAP_RENDER_END,false,false,this._map.id,this._renderId));
            Atouin.getInstance().worldContainer.visible = true;
         }
         var atouin:Atouin = Atouin.getInstance();
         if(!(this._map.zoomScale == 1) && (atouin.options.useInsideAutoZoom))
         {
            atouin.rootContainer.scaleX = this._map.zoomScale;
            atouin.rootContainer.scaleY = this._map.zoomScale;
            atouin.rootContainer.x = this._map.zoomOffsetX;
            atouin.rootContainer.y = this._map.zoomOffsetY;
            atouin.currentZoom = this._map.zoomScale;
         }
         else
         {
            Atouin.getInstance().zoom(1);
         }
         this._mapIsReady = true;
      }
      
      private var colorTransform:ColorTransform;
      
      private function drawGround(param1:Bitmap, param2:BitmapCellContainer) : void
      {
         var _loc4_:Object = null;
         var _loc5_:BitmapData = null;
         var _loc6_:* = false;
         var _loc7_:* = 0;
         var _loc3_:BitmapData = param1.bitmapData;
         var _loc8_:int = param2.numChildren;
         _loc3_.lock();
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            if(!(param2.bitmaps[_loc7_] is BitmapData || param2.bitmaps[_loc7_] is Bitmap))
            {
               _log.error("Attention, un élément non bitmap tente d\'être ajouter au sol " + param2.bitmaps[_loc7_]);
            }
            else
            {
               _loc5_ = param2.bitmaps[_loc7_] is Bitmap?Bitmap(param2.bitmaps[_loc7_]).bitmapData:param2.bitmaps[_loc7_];
               _loc4_ = param2.datas[_loc7_];
               if(!(_loc5_ == null || _loc4_ == null))
               {
                  if(param2.colorTransforms[_loc7_] != null)
                  {
                     _loc6_ = true;
                     this.colorTransform.redMultiplier = param2.colorTransforms[_loc7_].red;
                     this.colorTransform.greenMultiplier = param2.colorTransforms[_loc7_].green;
                     this.colorTransform.blueMultiplier = param2.colorTransforms[_loc7_].blue;
                     this.colorTransform.alphaMultiplier = param2.colorTransforms[_loc7_].alpha;
                  }
                  else
                  {
                     _loc6_ = false;
                  }
                  this._destPoint.x = _loc4_.x + param2.x;
                  if(_groundGlobalScaleRatio != 1)
                  {
                     this._destPoint.x = this._destPoint.x * _groundGlobalScaleRatio;
                  }
                  this._destPoint.x = this._destPoint.x + _bitmapOffsetPoint.x;
                  this._destPoint.y = _loc4_.y + param2.y;
                  if(_groundGlobalScaleRatio != 1)
                  {
                     this._destPoint.y = this._destPoint.y * _groundGlobalScaleRatio;
                  }
                  this._srcRect.width = _loc5_.width;
                  this._srcRect.height = _loc5_.height;
                  if(!(_loc4_.scaleX == 1) || !(_loc4_.scaleY == 1) || (_loc6_))
                  {
                     this._m.identity();
                     this._m.scale(_loc4_.scaleX,_loc4_.scaleY);
                     this._m.translate(this._destPoint.x,this._destPoint.y);
                     _loc3_.draw(_loc5_,this._m,this.colorTransform,null,null,false);
                  }
                  else
                  {
                     _loc3_.copyPixels(_loc5_,this._srcRect,this._destPoint);
                  }
               }
            }
            _loc7_++;
         }
         _loc3_.unlock();
      }
      
      private var _m:Matrix;
      
      private var _srcRect:Rectangle;
      
      private var _destPoint:Point;
      
      private function groundMapLoaded(param1:Bitmap) : void
      {
         this._groundIsLoaded = true;
         if(this._mapIsReady)
         {
            dispatchEvent(new RenderMapEvent(RenderMapEvent.MAP_RENDER_END,false,false,this._map.id,this._renderId));
            Atouin.getInstance().worldContainer.visible = true;
         }
         if(!this._tacticModeActivated)
         {
            param1.x = param1.x - _bitmapOffsetPoint.x;
            this._container.addChildAt(param1,0);
         }
         param1.smoothing = true;
      }
      
      private function groundMapNotLoaded(param1:int) : void
      {
         var _loc2_:MapDisplayManager = null;
         if(this._map.id == param1)
         {
            _loc2_ = MapDisplayManager.getInstance();
            _loc2_.display(_loc2_.currentMapPoint,true);
         }
      }
      
      private function addCellBitmapsElements(param1:Cell, param2:ICellContainer, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         var elementDo:Object = null;
         var data:VisualData = null;
         var colors:Object = null;
         var ge:GraphicalElement = null;
         var ed:GraphicalElementData = null;
         var bounds:Rectangle = null;
         var element:BasicElement = null;
         var ged:NormalGraphicalElementData = null;
         var eed:EntityGraphicalElementData = null;
         var elementLook:TiphonEntityLook = null;
         var ts:WorldEntitySprite = null;
         var ped:ParticlesGraphicalElementData = null;
         var objectInfo:Object = null;
         var applicationDomain:ApplicationDomain = null;
         var ra:RasterizedAnimation = null;
         var renderer:DisplayObjectRenderer = null;
         var elemenForDebug:DisplayObject = null;
         var ie:Object = null;
         var namedSprite:Sprite = null;
         var elementDOC:DisplayObjectContainer = null;
         var bmp:Bitmap = null;
         var shape:Shape = null;
         var cell:Cell = param1;
         var cellCtr:ICellContainer = param2;
         var transparent:Boolean = param3;
         var ground:Boolean = param4;
         var disabled:Boolean = false;
         var mouseChildren:Boolean = false;
         var cacheAsBitmap:Boolean = true;
         var hasBlendMode:Boolean = false;
         var lsElements:Array = cell.elements;
         var nbElements:int = lsElements.length;
         var i:int = 0;
         for(;i < nbElements;i++)
         {
            data = new VisualData();
            element = lsElements[i];
            switch(element.elementType)
            {
               case ElementTypesEnum.GRAPHICAL:
                  ge = GraphicalElement(element);
                  ed = this._elements.getElementData(ge.elementId);
                  if(!ed)
                  {
                     continue;
                  }
                  switch(true)
                  {
                     case ed is NormalGraphicalElementData:
                        ged = ed as NormalGraphicalElementData;
                        if(ged is AnimatedGraphicalElementData)
                        {
                           objectInfo = this._swfGfx[ged.gfxId];
                           applicationDomain = this._swfApplicationDomain[ged.gfxId];
                           if(objectInfo == null)
                           {
                              _log.fatal("Impossible d\'afficher l\'élément " + ged.gfxId + " : instance non trouvée");
                              break;
                           }
                           if(applicationDomain.hasDefinition("FX_0"))
                           {
                              elementDo = new applicationDomain.getDefinition("FX_0")() as Sprite;
                           }
                           else if(this._map.getGfxCount(ged.gfxId) > 1)
                           {
                              if(ASwf(objectInfo).content == null)
                              {
                                 _log.fatal("Impossible d\'afficher le picto " + ged.gfxId + " (format swf), le swf est probablement compilé en AS2");
                                 continue;
                              }
                              ra = new RasterizedAnimation(ASwf(objectInfo).content as MovieClip,String(ged.gfxId));
                              ra.gotoAndStop("1");
                              ra.smoothing = true;
                              elementDo = FpsControler.controlFps(ra,uint.MAX_VALUE);
                              cacheAsBitmap = false;
                           }
                           else
                           {
                              elementDo = ASwf(objectInfo).content;
                              if(elementDo is MovieClip)
                              {
                                 if(!MovieClipUtils.isSingleFrame(elementDo as MovieClip))
                                 {
                                    cacheAsBitmap = false;
                                 }
                              }
                           }
                           
                           data.scaleX = 1;
                           data.x = data.y = 0;
                        }
                        else if(ground)
                        {
                           elementDo = this._bitmapsGfx[ged.gfxId];
                        }
                        else
                        {
                           elementDo = new MapGfxBitmap(this._bitmapsGfx[ged.gfxId],"never",this._useSmooth,ge.identifier);
                           elementDo.cacheAsBitmap = this._pictoAsBitmap;
                           if(this._pictoAsBitmap)
                           {
                              cachedAsBitmapElement.push(elementDo);
                           }
                        }
                        
                        data.x = data.x - ged.origin.x;
                        data.y = data.y - ged.origin.y;
                        if(ged.horizontalSymmetry)
                        {
                           data.scaleX = data.scaleX * -1;
                           if(ged is AnimatedGraphicalElementData)
                           {
                              data.x = data.x + ASwf(this._swfGfx[ged.gfxId]).loaderWidth;
                           }
                           else if(elementDo)
                           {
                              data.x = data.x + elementDo.width;
                           }
                           
                        }
                        if(ged is BoundingBoxGraphicalElementData)
                        {
                           data.alpha = 0;
                           boundingBoxElements[ge.identifier] = true;
                        }
                        if(elementDo is InteractiveObject)
                        {
                           (elementDo as InteractiveObject).mouseEnabled = false;
                           if(elementDo is DisplayObjectContainer)
                           {
                              (elementDo as DisplayObjectContainer).mouseChildren = false;
                           }
                        }
                        if(ed is BlendedGraphicalElementData && (elementDo.hasOwnProperty("blendMode")))
                        {
                           elementDo.blendMode = (ed as BlendedGraphicalElementData).blendMode;
                           elementDo.cacheAsBitmap = false;
                           hasBlendMode = true;
                        }
                        break;
                     case ed is EntityGraphicalElementData:
                        eed = ed as EntityGraphicalElementData;
                        elementLook = null;
                        try
                        {
                           elementLook = TiphonEntityLook.fromString(eed.entityLook);
                        }
                        catch(e:Error)
                        {
                           _log.warn("Error in the Entity Element " + ed.id + "; misconstructed look string.");
                           break;
                        }
                        ts = new WorldEntitySprite(elementLook,cell.cellId,ge.identifier);
                        ts.setDirection(0);
                        ts.mouseChildren = false;
                        ts.mouseEnabled = false;
                        ts.cacheAsBitmap = this._pictoAsBitmap;
                        if(this._pictoAsBitmap)
                        {
                           cachedAsBitmapElement.push(ts);
                        }
                        if(this.useDefautState)
                        {
                           ts.setAnimationAndDirection("AnimState0",0);
                        }
                        if(eed.horizontalSymmetry)
                        {
                           data.scaleX = data.scaleX * -1;
                        }
                        this._dataMapContainer.addAnimatedElement(ts,eed);
                        elementDo = ts;
                        break;
                     case ed is ParticlesGraphicalElementData:
                        ped = ed as ParticlesGraphicalElementData;
                        if(this._allowParticlesFx)
                        {
                           renderer = new DisplayObjectRenderer();
                           renderer.mouseChildren = false;
                           renderer.mouseEnabled = false;
                           cacheAsBitmap = false;
                           ScriptExec.exec(new Uri(this._particlesPath + ped.scriptId + ".dx"),new EmitterRunner(renderer,null),true,null);
                           elementDo = renderer as DisplayObject;
                        }
                        break;
                  }
                  if(elementDo == null)
                  {
                     _log.warn("A graphical element was missed (Element ID " + ge.elementId + "; Cell " + ge.cell.cellId + ").");
                     break;
                  }
                  if(!ge.colorMultiplicator.isOne())
                  {
                     colors = {
                        "red":ge.colorMultiplicator.red / 255,
                        "green":ge.colorMultiplicator.green / 255,
                        "blue":ge.colorMultiplicator.blue / 255,
                        "alpha":data.alpha
                     };
                  }
                  if(transparent)
                  {
                     data.alpha = 0.5;
                  }
                  if(ge.identifier > 0)
                  {
                     elemenForDebug = elementDo as DisplayObject;
                     if(!(elementDo is InteractiveObject) || elementDo is DisplayObjectContainer)
                     {
                        namedSprite = new SpriteWrapper(elementDo as DisplayObject,ge.identifier);
                        namedSprite.alpha = elementDo.alpha;
                        elementDo.alpha = 1;
                        if(colors.alpha > 0)
                        {
                           elementDo.transform.colorTransform = new ColorTransform(colors.red,colors.green,colors.blue,colors.alpha);
                        }
                        colors = null;
                        elementDo = namedSprite;
                     }
                     mouseChildren = true;
                     elementDo.cacheAsBitmap = true;
                     cachedAsBitmapElement.push(elementDo);
                     if(elementDo is DisplayObjectContainer)
                     {
                        elementDOC = elementDo as DisplayObjectContainer;
                        elementDOC.mouseChildren = false;
                     }
                     ie = new Object();
                     this._identifiedElements[ge.identifier] = ie;
                     ie.sprite = elementDo;
                     ie.position = MapPoint.fromCellId(cell.cellId);
                  }
                  data.x = data.x + Math.round(AtouinConstants.CELL_HALF_WIDTH + ge.pixelOffset.x);
                  data.y = data.y + Math.round(AtouinConstants.CELL_HALF_HEIGHT - ge.altitude * 10 + ge.pixelOffset.y);
                  break;
            }
            if(elementDo)
            {
               cellCtr.addFakeChild(elementDo,data,colors);
            }
            else
            {
               if(element.elementType != ElementTypesEnum.SOUND)
               {
                  if(this._ceilBitmapData == null)
                  {
                     this._ceilBitmapData = new BitmapData(AtouinConstants.CELL_WIDTH,AtouinConstants.CELL_HEIGHT,false,13369548);
                     shape = new Shape();
                     shape.graphics.beginFill(13369548);
                     shape.graphics.drawRect(0,0,AtouinConstants.CELL_WIDTH,AtouinConstants.CELL_HEIGHT);
                     shape.graphics.endFill();
                     this._ceilBitmapData.draw(shape);
                  }
                  bmp = new Bitmap(this._ceilBitmapData);
                  cellCtr.addFakeChild(bmp,null,null);
               }
               continue;
            }
         }
         if((this._pictoAsBitmap) && !hasBlendMode)
         {
            cellCtr.cacheAsBitmap = cacheAsBitmap;
            if(cacheAsBitmap)
            {
               cachedAsBitmapElement.push(cellCtr);
            }
         }
         else
         {
            cellCtr.cacheAsBitmap = false;
         }
         cellCtr.mouseChildren = mouseChildren;
         return disabled;
      }
      
      private var _ceilBitmapData:BitmapData;
      
      private function renderFixture(param1:Array, param2:Bitmap) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Fixture = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         if(param1 == null || param1.length == 0 || !this._renderFixture)
         {
            return;
         }
         var _loc3_:Boolean = OptionManager.getOptionManager("atouin").useSmooth;
         for each(_loc5_ in param1)
         {
            _loc4_ = this._bitmapsGfx[_loc5_.fixtureId];
            if(!_loc4_)
            {
               ErrorManager.addError("Fixture " + _loc5_.fixtureId + " file is missing ");
            }
            else
            {
               _loc6_ = _loc4_.width;
               _loc7_ = _loc4_.height;
               _loc8_ = _loc6_ * 0.5;
               _loc9_ = _loc7_ * 0.5;
               this._m.identity();
               this._m.translate(-_loc8_,-_loc9_);
               this._m.scale(_loc5_.xScale / 1000,_loc5_.yScale / 1000);
               this._m.rotate(_loc5_.rotation / 100 * Math.PI / 180);
               this._m.translate(_loc5_.offset.x + _bitmapOffsetPoint.x + _loc8_ + AtouinConstants.CELL_HALF_WIDTH,_loc5_.offset.y + AtouinConstants.CELL_HEIGHT + _loc9_);
               param2.bitmapData.lock();
               if((_loc5_.redMultiplier) || (_loc5_.greenMultiplier) || (_loc5_.blueMultiplier) || !(_loc5_.alpha == 1))
               {
                  this._clTrans.redMultiplier = _loc5_.redMultiplier / 127 + 1;
                  this._clTrans.greenMultiplier = _loc5_.greenMultiplier / 127 + 1;
                  this._clTrans.blueMultiplier = _loc5_.blueMultiplier / 127 + 1;
                  this._clTrans.alphaMultiplier = _loc5_.alpha / 255;
                  param2.bitmapData.draw(_loc4_,this._m,this._clTrans,null,null,_loc3_);
               }
               else
               {
                  param2.bitmapData.draw(_loc4_,this._m,null,null,null,_loc3_);
               }
               param2.bitmapData.unlock();
            }
         }
      }
      
      private var _clTrans:ColorTransform;
      
      public function get container() : DisplayObjectContainer
      {
         return this._container;
      }
      
      private function onAllGfxLoaded(param1:ResourceLoaderProgressEvent) : void
      {
         if(this._cancelRender)
         {
            return;
         }
         this._loadedGfxListCount++;
         if((this._hasBitmapGxf) && (this._hasSwfGxf) && !(this._loadedGfxListCount == 2))
         {
            return;
         }
         this._mapLoaded = true;
         dispatchEvent(new Event(RenderMapEvent.GFX_LOADING_END));
         this.makeMap();
      }
      
      private function onBitmapGfxLoaded(param1:ResourceLoadedEvent) : void
      {
         if(this._cancelRender)
         {
            return;
         }
         this._fileLoaded++;
         this._downloadProgressBar.scaleX = this._fileLoaded / this._fileToLoad;
         dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,this._fileLoaded,this._fileToLoad));
         this._bitmapsGfx[param1.uri.tag] = param1.resource;
         this._gfxMemorySize = this._gfxMemorySize + BitmapData(param1.resource).width * BitmapData(param1.resource).height * 4;
         MEMORY_LOG_1[param1.resource] = 1;
      }
      
      private function onSwfGfxLoaded(param1:ResourceLoadedEvent) : void
      {
         this._fileLoaded++;
         this._downloadProgressBar.scaleX = this._fileLoaded / this._fileToLoad;
         dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,this._fileLoaded,this._fileToLoad));
         this._swfGfx[param1.uri.tag] = param1.resource;
         MEMORY_LOG_2[param1.resource] = 1;
      }
      
      private function onGfxError(param1:ResourceErrorEvent) : void
      {
         _log.error("Unable to load " + param1.uri);
      }
      
      private function onDownloadTimer(param1:TimerEvent) : void
      {
         if(Atouin.getInstance().options.showProgressBar)
         {
            this._container.addChild(this._progressBarCtr);
         }
      }
   }
}
class VisualData extends Object
{
   
   function VisualData()
   {
      super();
   }
   
   public var scaleX:Number = 1;
   
   public var scaleY:Number = 1;
   
   public var x:Number = 0;
   
   public var y:Number = 0;
   
   public var width:Number = 0;
   
   public var height:Number = 0;
   
   public var alpha:Number = 1;
}
