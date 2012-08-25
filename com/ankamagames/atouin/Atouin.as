package com.ankamagames.atouin
{
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.resources.adapters.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.errors.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.pathfinding.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Atouin extends Object
    {
        private var _worldContainer:DisplayObjectContainer;
        private var _overlayContainer:Sprite;
        private var _spMapContainer:Sprite;
        private var _spGfxontainer:Sprite;
        private var _spChgMapContainer:Sprite;
        private var _worldMask:Shape;
        private var _currentZoom:Number = 1;
        private var _zoomPosX:int;
        private var _zoomPosY:int;
        private var _movementListeners:Array;
        private var _handler:MessageHandler;
        private var _aSprites:Array;
        private var _aoOptions:AtouinOptions;
        private var _cursorUpdateSprite:Sprite;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Atouin));
        private static var _self:Atouin;

        public function Atouin()
        {
            if (_self)
            {
                throw new AtouinError("Atouin is a singleton class. Please acces it through getInstance()");
            }
            AdapterFactory.addAdapter("ele", ElementsAdapter);
            AdapterFactory.addAdapter("dlm", MapsAdapter);
            this._cursorUpdateSprite = new Sprite();
            this._cursorUpdateSprite.graphics.beginFill(65280, 0);
            this._cursorUpdateSprite.graphics.drawRect(0, 0, 6, 6);
            this._cursorUpdateSprite.graphics.endFill();
            this._cursorUpdateSprite.useHandCursor = true;
            return;
        }// end function

        public function get movementListeners() : Array
        {
            return this._movementListeners;
        }// end function

        public function get worldContainer() : DisplayObjectContainer
        {
            return this._spMapContainer;
        }// end function

        public function get selectionContainer() : DisplayObjectContainer
        {
            if (this._spMapContainer == null || this._spMapContainer.numChildren <= 1)
            {
                return null;
            }
            return this._spMapContainer.getChildAt(1) as DisplayObjectContainer;
        }// end function

        public function get chgMapContainer() : DisplayObjectContainer
        {
            return this._spChgMapContainer;
        }// end function

        public function get gfxContainer() : DisplayObjectContainer
        {
            return this._spGfxontainer;
        }// end function

        public function get overlayContainer() : DisplayObjectContainer
        {
            return this._overlayContainer;
        }// end function

        public function get handler() : MessageHandler
        {
            return this._handler;
        }// end function

        public function set handler(param1:MessageHandler) : void
        {
            this._handler = param1;
            return;
        }// end function

        public function get options() : AtouinOptions
        {
            return this._aoOptions;
        }// end function

        public function get currentZoom() : Number
        {
            return this._currentZoom;
        }// end function

        public function set currentZoom(param1:Number) : void
        {
            this._currentZoom = param1;
            return;
        }// end function

        public function get cellOverEnabled() : Boolean
        {
            return InteractiveCellManager.getInstance().cellOverEnabled;
        }// end function

        public function set cellOverEnabled(param1:Boolean) : void
        {
            InteractiveCellManager.getInstance().cellOverEnabled = param1;
            return;
        }// end function

        public function get rootContainer() : DisplayObjectContainer
        {
            return this._worldContainer;
        }// end function

        public function get worldIsVisible() : Boolean
        {
            return this._worldContainer.contains(this._spMapContainer);
        }// end function

        public function setDisplayOptions(param1:AtouinOptions) : void
        {
            this._aoOptions = param1;
            this._worldContainer = param1.container;
            this._handler = param1.handler;
            var _loc_2:uint = 0;
            while (_loc_2 < this._worldContainer.numChildren)
            {
                
                this._worldContainer.removeChildAt(_loc_2);
                _loc_2 = _loc_2 + 1;
            }
            this._overlayContainer = new Sprite();
            this._spMapContainer = new Sprite();
            this._spChgMapContainer = new Sprite();
            this._spGfxontainer = new Sprite();
            this._worldContainer.mouseEnabled = false;
            this._spMapContainer.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutMapContainer);
            this._spMapContainer.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverMapContainer);
            this._spMapContainer.tabChildren = false;
            this._spMapContainer.mouseEnabled = false;
            this._spChgMapContainer.tabChildren = false;
            this._spChgMapContainer.mouseEnabled = false;
            this._spGfxontainer.tabChildren = false;
            this._spGfxontainer.mouseEnabled = false;
            this._spGfxontainer.mouseChildren = false;
            this._overlayContainer.tabChildren = false;
            this._overlayContainer.mouseEnabled = false;
            this._worldContainer.addChild(this._spMapContainer);
            this._worldContainer.addChild(this._spChgMapContainer);
            this._worldContainer.addChild(this._spGfxontainer);
            this._worldContainer.addChild(this._overlayContainer);
            FrustumManager.getInstance().init(this._spChgMapContainer);
            this._worldMask = new Shape();
            this._worldMask.graphics.beginFill(0);
            var _loc_3:* = StageShareManager.startWidth;
            var _loc_4:* = StageShareManager.startHeight;
            this._worldMask.graphics.drawRect(-2000, -2000, 4000 + _loc_3, 4000 + _loc_4);
            this._worldMask.graphics.drawRect(0, 0, _loc_3, _loc_4);
            this._worldMask.graphics.endFill();
            DisplayObjectContainer(this._worldContainer.parent).addChild(this._worldMask);
            this.setFrustrum(param1.frustum);
            this.init();
            return;
        }// end function

        public function onRollOverMapContainer(event:Event) : void
        {
            var _loc_2:* = new MapContainerRollOverMessage();
            Atouin.getInstance().handler.process(_loc_2);
            return;
        }// end function

        private function onRollOutMapContainer(event:Event) : void
        {
            var _loc_2:* = new MapContainerRollOutMessage();
            Atouin.getInstance().handler.process(_loc_2);
            return;
        }// end function

        public function updateCursor() : void
        {
            this._cursorUpdateSprite.x = StageShareManager.stage.mouseX - 3;
            this._cursorUpdateSprite.y = StageShareManager.stage.mouseY - 3;
            StageShareManager.stage.addChild(this._cursorUpdateSprite);
            EnterFrameDispatcher.addEventListener(this.removeUpdateCursorSprite, "UpdateCursorSprite", 50);
            return;
        }// end function

        public function showWorld(param1:Boolean) : void
        {
            if (param1)
            {
                this._worldContainer.addChild(this._spMapContainer);
                this._worldContainer.addChild(this._spChgMapContainer);
                this._worldContainer.addChild(this._spGfxontainer);
                this._worldContainer.addChild(this._overlayContainer);
            }
            else
            {
                if (this._spMapContainer.parent)
                {
                    this._worldContainer.removeChild(this._spMapContainer);
                }
                if (this._spChgMapContainer.parent)
                {
                    this._worldContainer.removeChild(this._spChgMapContainer);
                }
                if (this._spGfxontainer.parent)
                {
                    this._worldContainer.removeChild(this._spGfxontainer);
                }
                if (this._overlayContainer.parent)
                {
                    this._worldContainer.removeChild(this._overlayContainer);
                }
            }
            return;
        }// end function

        public function setFrustrum(param1:Frustum) : void
        {
            if (!this._aoOptions)
            {
                _log.error("Please call setDisplayOptions once before calling setFrustrum");
                return;
            }
            this._aoOptions.frustum = param1;
            this.worldContainer.scaleX = this._aoOptions.frustum.scale;
            this.worldContainer.scaleY = this._aoOptions.frustum.scale;
            this.worldContainer.x = this._aoOptions.frustum.x;
            this.worldContainer.y = this._aoOptions.frustum.y;
            this.gfxContainer.scaleX = this._aoOptions.frustum.scale;
            this.gfxContainer.scaleY = this._aoOptions.frustum.scale;
            this.gfxContainer.x = this._aoOptions.frustum.x;
            this.gfxContainer.y = this._aoOptions.frustum.y;
            this.overlayContainer.x = this._aoOptions.frustum.x;
            this.overlayContainer.y = this._aoOptions.frustum.y;
            this.overlayContainer.scaleX = this._aoOptions.frustum.scale;
            this.overlayContainer.scaleY = this._aoOptions.frustum.scale;
            FrustumManager.getInstance().frustum = param1;
            return;
        }// end function

        public function initPreDisplay(param1:WorldPoint) : void
        {
            if (param1 && MapDisplayManager.getInstance() && MapDisplayManager.getInstance().currentMapPoint && MapDisplayManager.getInstance().currentMapPoint.mapId == param1.mapId)
            {
                return;
            }
            MapDisplayManager.getInstance().capture();
            return;
        }// end function

        public function display(param1:WorldPoint, param2:ByteArray = null) : uint
        {
            return MapDisplayManager.getInstance().display(param1, false, param2);
        }// end function

        public function getEntity(param1:int) : IEntity
        {
            return EntitiesManager.getInstance().getEntity(param1);
        }// end function

        public function getEntityOnCell(param1:uint, param2 = null) : IEntity
        {
            return EntitiesManager.getInstance().getEntityOnCell(param1, param2);
        }// end function

        public function clearEntities() : void
        {
            EntitiesManager.getInstance().clearEntities();
            return;
        }// end function

        public function reset() : void
        {
            InteractiveCellManager.getInstance().clean();
            MapDisplayManager.getInstance().reset();
            EntitiesManager.getInstance().clearEntities();
            this.cancelZoom();
            this.showWorld(false);
            return;
        }// end function

        public function displayGrid(param1:Boolean) : void
        {
            InteractiveCellManager.getInstance().show(param1 || this.options.alwaysShowGrid);
            return;
        }// end function

        public function getIdentifiedElement(param1:uint) : InteractiveObject
        {
            return MapDisplayManager.getInstance().getIdentifiedElement(param1);
        }// end function

        public function getIdentifiedElementPosition(param1:uint) : MapPoint
        {
            return MapDisplayManager.getInstance().getIdentifiedElementPosition(param1);
        }// end function

        public function addListener(param1:ISoundPositionListener) : void
        {
            if (this._movementListeners == null)
            {
                this._movementListeners = new Array();
            }
            this._movementListeners.push(param1);
            return;
        }// end function

        public function removeListener(param1:ISoundPositionListener) : void
        {
            var _loc_2:* = Atouin.getInstance()._movementListeners.indexOf(param1);
            if (_loc_2)
            {
                Atouin.getInstance()._movementListeners.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function zoom(param1:Number, param2:int = 0, param3:int = 0) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            if (param1 == 1)
            {
                this._worldContainer.scaleX = 1;
                this._worldContainer.scaleY = 1;
                this._worldContainer.x = 0;
                this._worldContainer.y = 0;
                this._currentZoom = 1;
                MapDisplayManager.getInstance().cacheAsBitmapEnabled(true);
            }
            else
            {
                if (param1 < 1)
                {
                    param1 = 1;
                }
                else if (param1 > AtouinConstants.MAX_ZOOM)
                {
                    param1 = AtouinConstants.MAX_ZOOM;
                }
                _loc_4 = this._currentZoom;
                this._currentZoom = param1;
                if (_loc_4 == this._currentZoom)
                {
                    return;
                }
                if (this._currentZoom != 1)
                {
                    MapDisplayManager.getInstance().cacheAsBitmapEnabled(false);
                }
                this._worldContainer.scaleX = this._currentZoom;
                this._worldContainer.scaleY = this._currentZoom;
                if (param2)
                {
                    this._zoomPosX = param2;
                }
                else
                {
                    param2 = this._zoomPosX;
                }
                if (param3)
                {
                    this._zoomPosY = param3;
                }
                else
                {
                    param3 = this._zoomPosY;
                }
                _loc_5 = param2 * this._currentZoom;
                _loc_6 = param3 * this._currentZoom;
                this._worldContainer.x = 608 - _loc_5;
                this._worldContainer.y = 470 - _loc_6;
                if (this._worldContainer.x > 0)
                {
                    this._worldContainer.x = 0;
                }
                else if (this._worldContainer.x < 1276 - 1276 * this._currentZoom)
                {
                    this._worldContainer.x = 1276 - 1276 * this._currentZoom;
                }
                if (this._worldContainer.y > 0)
                {
                    this._worldContainer.y = 0;
                }
                else if (this._worldContainer.y < 876 - 876 * this._currentZoom)
                {
                    this._worldContainer.y = 876 - 876 * this._currentZoom;
                }
            }
            return;
        }// end function

        public function cancelZoom() : void
        {
            if (this._currentZoom != 1)
            {
                this.zoom(1);
            }
            return;
        }// end function

        private function removeUpdateCursorSprite(event:Event) : void
        {
            EnterFrameDispatcher.removeEventListener(this.removeUpdateCursorSprite);
            if (this._cursorUpdateSprite.parent)
            {
                this._cursorUpdateSprite.parent.removeChild(this._cursorUpdateSprite);
            }
            return;
        }// end function

        private function init() : void
        {
            var _loc_1:IResourceLoader = null;
            this._aSprites = new Array();
            if (!Elements.getInstance().parsed)
            {
                _loc_1 = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
                _loc_1.addEventListener(ResourceErrorEvent.ERROR, this.onElementsError);
                _loc_1.load(new Uri(Atouin.getInstance().options.elementsIndexPath));
            }
            Pathfinding.init(AtouinConstants.PATHFINDER_MIN_X, AtouinConstants.PATHFINDER_MAX_X, AtouinConstants.PATHFINDER_MIN_Y, AtouinConstants.PATHFINDER_MAX_Y);
            return;
        }// end function

        private function onElementsError(event:ResourceErrorEvent) : void
        {
            return;
        }// end function

        public static function getInstance() : Atouin
        {
            if (!_self)
            {
                _self = new Atouin;
            }
            return _self;
        }// end function

    }
}
