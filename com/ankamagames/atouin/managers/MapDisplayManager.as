package com.ankamagames.atouin.managers
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.*;
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.resources.adapters.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.types.events.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.atouin.utils.map.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MapDisplayManager extends Object
    {
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
        private var matrix:Matrix;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MapDisplayManager));
        private static var _self:MapDisplayManager;

        public function MapDisplayManager()
        {
            this._mapFileCache = new Cache(20, new LruGarbageCollector());
            this.matrix = new Matrix();
            if (_self)
            {
                throw new SingletonError();
            }
            this.init();
            return;
        }// end function

        public function get isDefaultMap() : Boolean
        {
            return this._isDefaultMap;
        }// end function

        public function get renderer() : MapRenderer
        {
            return this._renderer;
        }// end function

        public function get currentRenderId() : uint
        {
            return this._currentRenderId;
        }// end function

        public function fromMap(param1:Map, param2:ByteArray = null) : uint
        {
            this._currentMap = WorldPoint.fromMapId(param1.id);
            var _loc_3:* = new RenderRequest(this._currentMap, false, param2);
            this._renderRequestStack.push(_loc_3);
            this._currentRenderId = _loc_3.renderId;
            Atouin.getInstance().showWorld(true);
            this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
            Atouin.getInstance().options.groundCacheMode = 0;
            var _loc_4:* = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
            new ResourceLoadedEvent(ResourceLoadedEvent.LOADED).resource = param1;
            this.onMapLoaded(_loc_4);
            return this._currentRenderId;
        }// end function

        public function display(param1:WorldPoint, param2:Boolean = false, param3:ByteArray = null) : uint
        {
            var _loc_4:* = new RenderRequest(param1, param2, param3);
            _log.debug("Ask render map " + param1.mapId + ", renderRequestID: " + _loc_4.renderId);
            this._renderRequestStack.push(_loc_4);
            this.checkForRender();
            return _loc_4.renderId;
        }// end function

        public function isBoundingBox(param1:int) : Boolean
        {
            if (MapRenderer.boundingBoxElements[param1])
            {
                return true;
            }
            return false;
        }// end function

        public function cacheAsBitmapEnabled(param1:Boolean) : void
        {
            var _loc_2:* = MapRenderer.cachedAsBitmapElement;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2[_loc_4].cacheAsBitmap = param1;
                _loc_4++;
            }
            return;
        }// end function

        public function get currentMapPoint() : WorldPoint
        {
            return this._currentMap;
        }// end function

        public function get currentMapRendered() : Boolean
        {
            return this._currentMapRendered;
        }// end function

        public function getDataMapContainer() : DataMapContainer
        {
            return this._currentDataMap;
        }// end function

        public function activeIdentifiedElements(param1:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._renderer.identifiedElements;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_3.sprite.mouseEnabled = param1;
            }
            return;
        }// end function

        public function unloadMap() : void
        {
            this._renderer.unload();
            return;
        }// end function

        public function capture() : void
        {
            var _loc_1:* = null;
            if (Atouin.getInstance().options.tweentInterMap || Atouin.getInstance().options.hideInterMap)
            {
                if (this._screenshotData == null)
                {
                    this._screenshotData = new BitmapData(StageShareManager.startWidth, StageShareManager.startHeight, true, 0);
                    this._screenshot = new Bitmap(this._screenshotData);
                    this._screenshot.smoothing = true;
                }
                _loc_1 = Atouin.getInstance().rootContainer;
                this.matrix.identity();
                this.matrix.scale(_loc_1.scaleX, _loc_1.scaleY);
                this.matrix.translate(_loc_1.x, _loc_1.y);
                this._screenshotData.draw(_loc_1, this.matrix, null, null, null, true);
                if (AirScanner.isStreamingVersion())
                {
                    this._screenshot.filters = [new BlurFilter()];
                }
                _loc_1.addChild(this._screenshot);
            }
            return;
        }// end function

        public function getIdentifiedEntityElement(param1:uint) : TiphonSprite
        {
            if (this._renderer && this._renderer.identifiedElements && this._renderer.identifiedElements[param1])
            {
                if (this._renderer.identifiedElements[param1].sprite is TiphonSprite)
                {
                    return this._renderer.identifiedElements[param1].sprite as TiphonSprite;
                }
            }
            return null;
        }// end function

        public function getIdentifiedElement(param1:uint) : InteractiveObject
        {
            if (this._renderer && this._renderer.identifiedElements && this._renderer.identifiedElements[param1])
            {
                return this._renderer.identifiedElements[param1].sprite;
            }
            return null;
        }// end function

        public function getIdentifiedElementPosition(param1:uint) : MapPoint
        {
            if (this._renderer && this._renderer.identifiedElements && this._renderer.identifiedElements[param1])
            {
                return this._renderer.identifiedElements[param1].position;
            }
            return null;
        }// end function

        public function reset() : void
        {
            this.unloadMap();
            this._currentMap = null;
            return;
        }// end function

        public function hideBackgroundForTacticMode(param1:Boolean) : void
        {
            this._renderer.modeTactic(param1);
            return;
        }// end function

        private function init() : void
        {
            this._renderRequestStack = [];
            this._renderer = new MapRenderer(Atouin.getInstance().worldContainer, Elements.getInstance());
            this._renderer.addEventListener(RenderMapEvent.GFX_LOADING_START, this.logGfxLoadTime, false, 0, true);
            this._renderer.addEventListener(RenderMapEvent.GFX_LOADING_END, this.logGfxLoadTime, false, 0, true);
            this._renderer.addEventListener(RenderMapEvent.MAP_RENDER_START, this.mapRendered, false, 0, true);
            this._renderer.addEventListener(RenderMapEvent.MAP_RENDER_END, this.mapRendered, false, 0, true);
            this._renderer.addEventListener(ProgressEvent.PROGRESS, this.mapRenderProgress, false, 0, true);
            AdapterFactory.addAdapter("dlm", MapsAdapter);
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onMapLoaded, false, 0, true);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onMapFailed, false, 0, true);
            return;
        }// end function

        private function mapDisplayed() : void
        {
            this._currentMapRendered = true;
            InteractiveCellManager.getInstance().updateInteractiveCell(this._currentDataMap);
            this._renderRequestStack.shift();
            var _loc_1:* = new MapsLoadingCompleteMessage(this._currentMap, MapDisplayManager.getInstance().getDataMapContainer().dataMap);
            _loc_1.renderRequestId = this._currentRenderId;
            Atouin.getInstance().handler.process(_loc_1);
            this.checkForRender();
            return;
        }// end function

        private function checkForRender() : void
        {
            var _loc_5:* = null;
            if (!this._currentMapRendered)
            {
                return;
            }
            if (this._renderRequestStack.length == 0)
            {
                return;
            }
            var _loc_1:* = RenderRequest(this._renderRequestStack[0]);
            var _loc_2:* = _loc_1.map;
            var _loc_3:* = _loc_1.forceReloadWithoutCache;
            Atouin.getInstance().showWorld(true);
            this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
            if (!_loc_3 && this._currentMap && this._currentMap.mapId == _loc_2.mapId && !Atouin.getInstance().options.reloadLoadedMap)
            {
                this._renderRequestStack.shift();
                _log.debug("Map " + _loc_2.mapId + " is the same, renderRequestID: " + _loc_1.renderId);
                _loc_5 = new MapsLoadingCompleteMessage(this._currentMap, MapDisplayManager.getInstance().getDataMapContainer().dataMap);
                Atouin.getInstance().handler.process(_loc_5);
                _loc_5.renderRequestId = _loc_1.renderId;
                this.checkForRender();
                return;
            }
            this._currentMapRendered = false;
            this._lastMap = this._currentMap;
            this._currentMap = _loc_2;
            this._currentRenderId = _loc_1.renderId;
            this._forceReloadWithoutCache = _loc_3;
            var _loc_4:* = new MapsLoadingStartedMessage();
            Atouin.getInstance().handler.process(_loc_4);
            this._nMapLoadStart = getTimer();
            this._loader.cancel();
            this._loader.load(new Uri(getMapUriFromId(_loc_2.mapId)), null);
            return;
        }// end function

        private function onMapLoaded(event:ResourceLoadedEvent) : void
        {
            var e:* = event;
            var request:* = RenderRequest(this._renderRequestStack[0]);
            this._nMapLoadEnd = getTimer();
            var map:* = new Map();
            if (e.resource is Map)
            {
                map = e.resource;
            }
            else
            {
                try
                {
                    map.fromRaw(e.resource, request.decryptionKey);
                }
                catch (e:Error)
                {
                    _log.fatal("Exception sur le parsing du fichier de map :\n" + e.getStackTrace());
                    map = new DefaultMap();
                }
            }
            this._isDefaultMap = map is DefaultMap;
            this.unloadMap();
            DataMapProvider.getInstance().resetUpdatedCell();
            DataMapProvider.getInstance().resetSpecialEffects();
            this._currentDataMap = new DataMapContainer(map);
            MEMORY_LOG[DataMapContainer] = 1;
            this._renderer.render(this._currentDataMap, this._forceReloadWithoutCache, request.renderId);
            FrustumManager.getInstance().updateMap();
            return;
        }// end function

        private function onMapFailed(event:ResourceErrorEvent) : void
        {
            _log.error("Impossible de charger la map " + event.uri);
            this._currentMapRendered = true;
            this._renderRequestStack.shift();
            this.checkForRender();
            var _loc_2:* = new MapLoadingFailedMessage();
            _loc_2.id = this._currentMap.mapId;
            _loc_2.errorReason = MapLoadingFailedMessage.NO_FILE;
            Atouin.getInstance().handler.process(_loc_2);
            return;
        }// end function

        private function logGfxLoadTime(event:Event) : void
        {
            if (event.type == RenderMapEvent.GFX_LOADING_START)
            {
                this._nGfxLoadStart = getTimer();
            }
            if (event.type == RenderMapEvent.GFX_LOADING_END)
            {
                this._nGfxLoadEnd = getTimer();
            }
            return;
        }// end function

        private function tweenInterMap(event:Event) : void
        {
            this._screenshot.alpha = this._screenshot.alpha - this._screenshot.alpha / 3;
            if (this._screenshot.alpha < 0.01)
            {
                Atouin.getInstance().worldContainer.cacheAsBitmap = false;
                this.removeScreenShot();
                EnterFrameDispatcher.removeEventListener(this.tweenInterMap);
            }
            return;
        }// end function

        private function mapRenderProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = new MapRenderProgressMessage(event.bytesLoaded / event.bytesTotal * 100);
            _loc_2.id = this._currentMap.mapId;
            _loc_2.renderRequestId = this._currentRenderId;
            Atouin.getInstance().handler.process(_loc_2);
            return;
        }// end function

        private function mapRendered(event:RenderMapEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (event.type == RenderMapEvent.MAP_RENDER_START)
            {
                this._nRenderMapStart = getTimer();
            }
            if (event.type == RenderMapEvent.MAP_RENDER_END)
            {
                this.mapDisplayed();
                this._nRenderMapEnd = getTimer();
                _loc_2 = this._nRenderMapEnd - this._nMapLoadStart;
                _loc_3 = this._nMapLoadEnd - this._nMapLoadStart;
                _loc_4 = this._nGfxLoadEnd - this._nGfxLoadStart;
                _loc_5 = new MapLoadedMessage();
                _loc_5.dataLoadingTime = _loc_3;
                _loc_5.gfxLoadingTime = _loc_4;
                _loc_5.renderingTime = this._nRenderMapEnd - this._nRenderMapStart;
                _loc_5.globalRenderingTime = _loc_2;
                _log.info("map rendered [total : " + _loc_2 + "ms, " + (_loc_2 < 100 ? (" " + (_loc_2 < 10 ? (" ") : (""))) : ("")) + "map load : " + _loc_3 + "ms, " + (_loc_3 < 100 ? (" " + (_loc_3 < 10 ? (" ") : (""))) : ("")) + "gfx load : " + _loc_4 + "ms, " + (_loc_4 < 100 ? (" " + (_loc_4 < 10 ? (" ") : (""))) : ("")) + "render : " + (this._nRenderMapEnd - this._nRenderMapStart) + "ms] file : " + (this._currentMap ? (this._currentMap.mapId.toString()) : ("???")) + ".dlm" + (this._isDefaultMap ? (" (/!\\ DEFAULT MAP) ") : ("")) + " / renderRequestID #" + this._currentRenderId);
                if (this._screenshot && this._screenshot.parent)
                {
                    if (Atouin.getInstance().options.tweentInterMap)
                    {
                        Atouin.getInstance().worldContainer.cacheAsBitmap = true;
                        EnterFrameDispatcher.addEventListener(this.tweenInterMap, "tweentInterMap");
                    }
                    else
                    {
                        this.removeScreenShot();
                    }
                }
                _loc_5.id = this._currentMap.mapId;
                Atouin.getInstance().handler.process(_loc_5);
            }
            return;
        }// end function

        private function removeScreenShot() : void
        {
            this._screenshot.parent.removeChild(this._screenshot);
            this._screenshotData.fillRect(new Rectangle(0, 0, this._screenshotData.width, this._screenshotData.height), 4278190080);
            return;
        }// end function

        public static function getInstance() : MapDisplayManager
        {
            if (!_self)
            {
                _self = new MapDisplayManager;
            }
            return _self;
        }// end function

    }
}

import com.ankamagames.atouin.*;

import com.ankamagames.atouin.data.*;

import com.ankamagames.atouin.data.elements.*;

import com.ankamagames.atouin.data.map.*;

import com.ankamagames.atouin.messages.*;

import com.ankamagames.atouin.renderers.*;

import com.ankamagames.atouin.resources.adapters.*;

import com.ankamagames.atouin.types.*;

import com.ankamagames.atouin.types.events.*;

import com.ankamagames.atouin.utils.*;

import com.ankamagames.atouin.utils.map.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.newCache.*;

import com.ankamagames.jerakine.newCache.garbage.*;

import com.ankamagames.jerakine.newCache.impl.*;

import com.ankamagames.jerakine.resources.adapters.*;

import com.ankamagames.jerakine.resources.events.*;

import com.ankamagames.jerakine.resources.loaders.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.types.positions.*;

import com.ankamagames.jerakine.utils.display.*;

import com.ankamagames.jerakine.utils.errors.*;

import com.ankamagames.jerakine.utils.system.*;

import com.ankamagames.tiphon.display.*;

import flash.display.*;

import flash.events.*;

import flash.filters.*;

import flash.geom.*;

import flash.utils.*;

class RenderRequest extends Object
{
    public var renderId:uint;
    public var map:WorldPoint;
    public var forceReloadWithoutCache:Boolean;
    public var decryptionKey:ByteArray;
    private static var RENDER_ID:uint = 0;

    function RenderRequest(param1:WorldPoint, param2:Boolean, param3:ByteArray)
    {
        this.renderId = RENDER_ID + 1;
        this.map = param1;
        this.forceReloadWithoutCache = param2;
        this.decryptionKey = param3;
        return;
    }// end function

}

