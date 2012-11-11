package com.ankamagames.berilia.components
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MapViewer extends GraphicContainer implements FinalizableUIComponent
    {
        private var _finalized:Boolean;
        private var _showGrid:Boolean = false;
        private var _mapBitmapContainer:Sprite;
        private var _mapContainer:Sprite;
        private var _arrowContainer:Sprite;
        private var _grid:Shape;
        private var _layersContainer:Sprite;
        private var _openedMapGroupElement:MapGroupElement;
        private var _elementsGraphicRef:Dictionary;
        private var _lastMx:int;
        private var _lastMy:int;
        private var _viewRect:Rectangle;
        private var _layers:Array;
        private var _mapElements:Array;
        private var _draging:Boolean;
        private var _currentMap:Map;
        private var _avaibleMap:Array;
        private var _layersVisibility:Array;
        private var _arrowPool:Array;
        private var _arrowAllocation:Dictionary;
        private var _reverseArrowAllocation:Dictionary;
        private var _lastScaleIconUpdate:Number = -1;
        private var _enable3DMode:Boolean = false;
        public var mapWidth:Number;
        public var mapHeight:Number;
        public var origineX:int;
        public var origineY:int;
        public var maxScale:Number = 2;
        public var minScale:Number = 0.5;
        public var startScale:Number = 0.8;
        public var roundCornerRadius:uint = 0;
        public var enabledDrag:Boolean = true;
        public var autoSizeIcon:Boolean = false;
        private var zz:Number = 1;
        private var _debugCtr:Sprite;
        private var _lastMouseX:int = 0;
        private var _lastMouseY:int = 0;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MapViewer));

        public function MapViewer()
        {
            this._avaibleMap = [];
            this._arrowPool = new Array();
            this._arrowAllocation = new Dictionary();
            this._reverseArrowAllocation = new Dictionary();
            this._debugCtr = new Sprite();
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get finalized() : Boolean
        {
            return this._finalized;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._finalized = param1;
            return;
        }// end function

        public function get showGrid() : Boolean
        {
            return this._showGrid;
        }// end function

        public function set showGrid(param1:Boolean) : void
        {
            this._showGrid = param1;
            this.drawGrid();
            return;
        }// end function

        public function get visibleMaps() : Rectangle
        {
            var _loc_1:* = (-(this._mapContainer.x / this._mapContainer.scaleX + this.origineX)) / this.mapWidth;
            var _loc_2:* = (-(this._mapContainer.y / this._mapContainer.scaleY + this.origineY)) / this.mapHeight;
            var _loc_3:* = width / (this.mapWidth * this._mapContainer.scaleX) - 1;
            var _loc_4:* = height / (this.mapHeight * this._mapContainer.scaleY) - 1;
            return new Rectangle(_loc_1, _loc_2, Math.ceil(_loc_3), Math.ceil(_loc_4));
        }// end function

        public function get currentMouseMapX() : int
        {
            return this._lastMx;
        }// end function

        public function get currentMouseMapY() : int
        {
            return this._lastMy;
        }// end function

        public function get mapBounds() : Rectangle
        {
            var _loc_1:* = new Rectangle();
            _loc_1.x = Math.floor((-this.origineX) / this.mapWidth);
            _loc_1.y = Math.floor((-this.origineY) / this.mapHeight);
            _loc_1.width = Math.floor(this._mapBitmapContainer.width / this.mapWidth);
            _loc_1.height = Math.floor(this._mapBitmapContainer.height / this.mapHeight);
            return _loc_1;
        }// end function

        public function get mapPixelPosition() : Point
        {
            return new Point(this._mapContainer.x, this._mapContainer.y);
        }// end function

        public function get zoomFactor() : Number
        {
            return this._mapContainer.scaleX;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            if (this.finalized)
            {
                this.initMask();
                this.updateVisibleChunck();
                this.updateMapElements();
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            if (this.finalized)
            {
                this.initMask();
                this.updateVisibleChunck();
                this.updateMapElements();
            }
            return;
        }// end function

        public function finalize() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            destroy(this._mapBitmapContainer);
            destroy(this._mapContainer);
            destroy(this._layersContainer);
            if (this._arrowPool && this._arrowAllocation)
            {
                for each (_loc_2 in this._arrowAllocation)
                {
                    
                    this._arrowPool.push(_loc_2);
                }
                this._arrowAllocation = new Dictionary();
            }
            MapElement.removeAllElements(this);
            this._viewRect = new Rectangle();
            this._mapBitmapContainer = new Sprite();
            this._mapBitmapContainer.doubleClickEnabled = true;
            this._mapBitmapContainer.mouseChildren = false;
            this._mapBitmapContainer.mouseEnabled = false;
            this._mapContainer = new Sprite();
            this._mapContainer.doubleClickEnabled = true;
            this._arrowContainer = new Sprite();
            this._arrowContainer.mouseEnabled = false;
            this._grid = new Shape();
            this._layersContainer = new Sprite();
            this._layersContainer.doubleClickEnabled = true;
            this._elementsGraphicRef = new Dictionary();
            this._layers = [];
            this._mapElements = [];
            this.initMap();
            this.processMapInfo();
            this._finalized = true;
            this.updateVisibleChunck();
            var _loc_1:* = 0;
            while (_loc_1 < numChildren)
            {
                
                _loc_3 = getChildAt(_loc_1) as InteractiveObject;
                if (_loc_3)
                {
                    _loc_3.doubleClickEnabled = true;
                }
                _loc_1++;
            }
            getUi().iAmFinalized(this);
            return;
        }// end function

        public function addLayer(param1:String) : void
        {
            var _loc_2:* = null;
            if (!this._layers[param1])
            {
                _loc_2 = new Sprite();
                _loc_2.name = "layer_" + param1;
                _loc_2.mouseEnabled = false;
                _loc_2.doubleClickEnabled = true;
                this._layers[param1] = _loc_2;
            }
            this._layersContainer.addChild(this._layers[param1]);
            return;
        }// end function

        public function addIcon(param1:String, param2:String, param3, param4:int, param5:int, param6:Number = 1, param7:String = null, param8:Boolean = false, param9:int = -1, param10:Boolean = true) : MapIconElement
        {
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            if (param3 is String)
            {
                param3 = new Uri(param3);
            }
            if (this._layers[param1])
            {
                _loc_11 = new Texture();
                _loc_11.uri = param3;
                _loc_11.mouseChildren = false;
                _loc_11.scaleX = Math.min(2, param6);
                _loc_11.scaleY = _loc_11.scaleX;
                if (param9 != -1)
                {
                    _loc_13 = param9 >> 16 & 255;
                    _loc_14 = param9 >> 8 & 255;
                    _loc_15 = param9 >> 0 & 255;
                    _loc_16 = new ColorTransform(0.6, 0.6, 0.6, 1, _loc_13 - 80, _loc_14 - 80, _loc_15 - 80);
                    _loc_11.transform.colorTransform = _loc_16;
                }
                _loc_12 = new MapIconElement(param2, param4, param5, param1, _loc_11, param7, this);
                _loc_12.canBeGrouped = param10;
                _loc_12.follow = param8;
                this._mapElements.push(_loc_12);
                this._elementsGraphicRef[_loc_11] = _loc_12;
                return _loc_12;
            }
            return null;
        }// end function

        public function addAreaShape(param1:String, param2:String, param3:Vector.<int>, param4:uint = 0, param5:Number = 1, param6:uint = 0, param7:Number = 0.4, param8:int = 4) : MapAreaShape
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            if (this._layers[param1] && param3)
            {
                _loc_9 = MapAreaShape(MapElement.getElementById(param2, this));
                if (_loc_9)
                {
                    if (_loc_9.lineColor == param4 && _loc_9.fillColor == param6)
                    {
                        return _loc_9;
                    }
                    _loc_9.remove();
                    this._mapElements.splice(this._mapElements.indexOf(_loc_9), 1);
                }
                _loc_10 = new Texture();
                _loc_10.mouseEnabled = false;
                _loc_10.mouseChildren = false;
                _loc_11 = _loc_10.graphics;
                _loc_11.lineStyle(param8, param4, param5, true);
                _loc_11.beginFill(param6, param7);
                _loc_12 = param3.length;
                _loc_13 = 0;
                while (_loc_13 < _loc_12)
                {
                    
                    _loc_15 = param3[_loc_13];
                    _loc_16 = param3[(_loc_13 + 1)];
                    if (_loc_15 > 10000)
                    {
                        _loc_11.moveTo((_loc_15 - 11000) * this.mapWidth, (_loc_16 - 11000) * this.mapHeight);
                    }
                    else
                    {
                        _loc_11.lineTo(_loc_15 * this.mapWidth, _loc_16 * this.mapHeight);
                    }
                    _loc_13 = _loc_13 + 2;
                }
                _loc_14 = new MapAreaShape(param2, param1, _loc_10, this.origineX, this.origineY, param4, param6, this);
                this._mapElements.push(_loc_14);
                return _loc_14;
            }
            return null;
        }// end function

        public function areaShapeColorTransform(param1:MapAreaShape, param2:int, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0) : void
        {
            param1.colorTransform(param2, param3, param4, param5, param6, param7, param8, param9, param10);
            return;
        }// end function

        public function getMapElement(param1:String) : MapElement
        {
            return MapElement.getElementById(param1, this);
        }// end function

        public function getMapElementsByLayer(param1:String) : Array
        {
            var _loc_5:* = null;
            var _loc_2:* = this._mapElements.length;
            var _loc_3:* = new Array();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = this._mapElements[_loc_4];
                if (_loc_5.layer == param1)
                {
                    _loc_3.push(_loc_5);
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function removeMapElement(param1:MapElement) : void
        {
            var _loc_3:* = null;
            if (!param1)
            {
                return;
            }
            var _loc_2:* = this._mapElements.indexOf(param1);
            if (_loc_2 != -1)
            {
                _loc_3 = this._mapElements[_loc_2];
                if (param1 is MapIconElement && this._arrowAllocation[MapIconElement(param1)._texture] && this._arrowAllocation[MapIconElement(param1)._texture].parent)
                {
                    this._arrowAllocation[MapIconElement(param1)._texture].parent.removeChild(this._arrowAllocation[MapIconElement(param1)._texture]);
                    this._arrowPool.push(this._arrowAllocation[MapIconElement(param1)._texture]);
                    delete this._reverseArrowAllocation[this._arrowAllocation[MapIconElement(param1)._texture]];
                    delete this._arrowAllocation[MapIconElement(param1)._texture];
                }
                _loc_3.remove();
                this._mapElements.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function updateMapElements() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this.updateIconSize();
            this.clearLayer();
            var _loc_2:* = new Array();
            for each (_loc_1 in this._mapElements)
            {
                
                if (!_loc_2[_loc_1.x + "_" + _loc_1.y])
                {
                    _loc_2[_loc_1.x + "_" + _loc_1.y] = new Array();
                }
                _loc_2[_loc_1.x + "_" + _loc_1.y].push(_loc_1);
            }
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = 0;
                _loc_5 = null;
                for each (_loc_1 in _loc_3)
                {
                    
                    if (!this._layers[_loc_1.layer].visible)
                    {
                        continue;
                    }
                    switch(true)
                    {
                        case _loc_1 is MapIconElement:
                        {
                            _loc_6 = _loc_1 as MapIconElement;
                            _loc_6._texture.x = _loc_6.x * this.mapWidth + this.origineX + this.mapWidth / 2;
                            _loc_6._texture.y = _loc_6.y * this.mapHeight + this.origineY + this.mapHeight / 2;
                            if (_loc_3.length != 1 && _loc_6.canBeGrouped)
                            {
                                if (!_loc_5)
                                {
                                    _loc_5 = new MapGroupElement(_loc_6._texture.width * 1.5, _loc_6._texture.height * 1.5);
                                    _loc_5.x = _loc_6.x * this.mapWidth + this.origineX + this.mapWidth / 2;
                                    _loc_5.y = _loc_6.y * this.mapHeight + this.origineY + this.mapHeight / 2;
                                    this._layers[_loc_1.layer].addChild(_loc_5);
                                }
                                _loc_8 = _loc_3.length;
                                if (_loc_8 > 2)
                                {
                                    _loc_8 = 2;
                                }
                                _loc_9 = Math.min(_loc_8, _loc_4);
                                _loc_6._texture.x = 4 * _loc_9 - _loc_8 * 4 / 2;
                                _loc_6._texture.y = 4 * _loc_9 - _loc_8 * 4 / 2;
                                _loc_5.addChild(_loc_6._texture);
                            }
                            else
                            {
                                this._layers[_loc_1.layer].addChild(_loc_6._texture);
                            }
                            break;
                        }
                        case _loc_1 is MapAreaShape:
                        {
                            _loc_7 = _loc_1 as MapAreaShape;
                            this._layers[_loc_1.layer].addChild(_loc_7.shape);
                            _loc_7.shape.x = _loc_7.x;
                            _loc_7.shape.y = _loc_7.y;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            this.updateIcon();
            return;
        }// end function

        public function showLayer(param1:String, param2:Boolean = true) : void
        {
            if (this._layers[param1])
            {
                this._layers[param1].visible = param2;
            }
            return;
        }// end function

        public function moveToPixel(param1:int, param2:int, param3:Number) : void
        {
            this._mapContainer.x = param1;
            this._mapContainer.y = param2;
            this._mapContainer.scaleX = param3;
            this._mapContainer.scaleY = param3;
            this.updateVisibleChunck();
            return;
        }// end function

        public function moveTo(param1:Number, param2:Number, param3:uint = 1, param4:uint = 1, param5:Boolean = true, param6:Boolean = true) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_7:* = this.mapBounds;
            if (this.mapBounds.left > param1)
            {
                param1 = _loc_7.left;
            }
            if (_loc_7.top > param2)
            {
                param2 = _loc_7.top;
            }
            if (param5)
            {
                _loc_8 = param3 * this.mapWidth * this._mapContainer.scaleX;
                if (_loc_8 > this.width && param6)
                {
                    this._mapContainer.scaleX = this.width / (this.mapWidth * param3);
                    this._mapContainer.scaleY = this._mapContainer.scaleX;
                }
                _loc_9 = param4 * this.mapHeight * this._mapContainer.scaleY;
                if (_loc_9 > this.height && param6)
                {
                    this._mapContainer.scaleY = this.height / (this.mapHeight * param4);
                    this._mapContainer.scaleX = this._mapContainer.scaleY;
                }
                _loc_10 = (-(param1 * this.mapWidth + this.origineX)) * this._mapContainer.scaleX;
                _loc_11 = (-(param2 * this.mapHeight + this.origineY)) * this._mapContainer.scaleY;
                this._mapContainer.x = _loc_10 + (this.width - param3 * this.mapWidth * this._mapContainer.scaleX) / 2;
                this._mapContainer.y = _loc_11 + (this.height - param4 * this.mapHeight * this._mapContainer.scaleY) / 2;
            }
            else
            {
                this._mapContainer.x = (-(param1 * this.mapWidth + Number(this.origineX))) * this._mapContainer.scaleX;
                this._mapContainer.y = (-(param2 * this.mapHeight + this.origineY)) * this._mapContainer.scaleY;
            }
            if (this._mapContainer.x < param3 - this._mapBitmapContainer.width)
            {
                this._mapContainer.x = param3 - this._mapBitmapContainer.width;
            }
            if (this._mapContainer.y < param4 - this._mapBitmapContainer.height)
            {
                this._mapContainer.y = param4 - this._mapBitmapContainer.height;
            }
            if (this._mapContainer.x > 0)
            {
                this._mapContainer.x = 0;
            }
            if (this._mapContainer.y > 0)
            {
                this._mapContainer.y = 0;
            }
            this.updateVisibleChunck();
            Berilia.getInstance().handler.process(new MapMoveMessage(this));
            return;
        }// end function

        public function zoom(param1:Number, param2:Point = null) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 > this.maxScale)
            {
                param1 = this.maxScale;
            }
            if (param1 < this.minScale)
            {
                param1 = this.minScale;
            }
            if (param2)
            {
                this._mapContainer.x = this._mapContainer.x - (param2.x * param1 - param2.x * this._mapContainer.scaleX);
                this._mapContainer.y = this._mapContainer.y - (param2.y * param1 - param2.y * this._mapContainer.scaleY);
                var _loc_5:* = param1;
                this._mapContainer.scaleY = param1;
                this._mapContainer.scaleX = _loc_5;
                if (this._mapContainer.x < width - this._mapBitmapContainer.width * param1)
                {
                    this._mapContainer.x = width - this._mapBitmapContainer.width * param1;
                }
                if (this._mapContainer.y < height - this._mapBitmapContainer.height * param1)
                {
                    this._mapContainer.y = height - this._mapBitmapContainer.height * param1;
                }
                if (this._mapContainer.x > 0)
                {
                    this._mapContainer.x = 0;
                }
                if (this._mapContainer.y > 0)
                {
                    this._mapContainer.y = 0;
                }
                this.updateIconSize();
            }
            else
            {
                _loc_3 = this.visibleMaps;
                _loc_4 = new Point((_loc_3.x + _loc_3.width / 2) * this.mapWidth + this.origineX, (_loc_3.y + _loc_3.height / 2) * this.mapHeight + this.origineY);
                this.zoom(param1, _loc_4);
            }
            this.processMapInfo();
            return;
        }// end function

        public function addMap(param1:Number, param2:String, param3:uint, param4:uint, param5:uint, param6:uint) : void
        {
            this._avaibleMap.push(new Map(param1, param2, new Sprite(), param3, param4, param5, param6));
            return;
        }// end function

        public function removeAllMap() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._avaibleMap)
            {
                
                for each (_loc_2 in _loc_1.areas)
                {
                    
                    _loc_2.free(true);
                }
            }
            this._avaibleMap = [];
            return;
        }// end function

        public function getOrigineFromPos(param1:int, param2:int) : Point
        {
            return new Point((-this._mapContainer.x) / this._mapContainer.scaleX - param1 * this.mapWidth, (-this._mapContainer.y) / this._mapContainer.scaleY - param2 * this.mapHeight);
        }// end function

        override public function remove() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (!__removed)
            {
                if (this._grid)
                {
                    this._grid.cacheAsBitmap = false;
                    if (this._mapContainer.contains(this._grid))
                    {
                        this._mapContainer.removeChild(this._grid);
                    }
                }
                this.removeAllMap();
                for each (_loc_1 in MapElement.getOwnerElements(this))
                {
                    
                    _loc_1.remove();
                }
                for (_loc_2 in this._elementsGraphicRef)
                {
                    
                    delete this._elementsGraphicRef[_loc_2];
                }
                this._mapElements = null;
                this._elementsGraphicRef = null;
                MapElement._elementRef = new Dictionary(true);
                EnterFrameDispatcher.removeEventListener(this.onMapEnterFrame);
            }
            super.remove();
            return;
        }// end function

        private function updateIcon() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = undefined;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_16:* = NaN;
            var _loc_1:* = new Rectangle(0, 0, 1, 1);
            var _loc_4:* = this.visibleMaps;
            var _loc_5:* = new Point(Math.floor(_loc_4.x + _loc_4.width / 2), Math.floor(_loc_4.y + _loc_4.height / 2));
            var _loc_6:* = _loc_4.width / 2;
            var _loc_7:* = this.roundCornerRadius > width / 3;
            for each (_loc_8 in this._mapElements)
            {
                
                _loc_3 = _loc_8 as MapIconElement;
                if (!_loc_3)
                {
                    continue;
                }
                _loc_1.x = _loc_3.x;
                _loc_1.y = _loc_3.y;
                _loc_2 = _loc_3._texture;
                if (!_loc_2)
                {
                    continue;
                }
                _loc_2.visible = this._layers[_loc_3.layer].visible != false && _loc_4.intersects(_loc_1);
                if (_loc_2.visible && !_loc_2.finalized)
                {
                    _loc_2.finalize();
                }
                if (!_loc_3.follow)
                {
                    continue;
                }
                _loc_14 = Math.floor(Math.sqrt(Math.pow(_loc_5.x - _loc_3.x, 2) + Math.pow(_loc_5.y - _loc_3.y, 2)));
                if (_loc_2.visible && this._arrowAllocation[_loc_2] && _loc_14 < _loc_6)
                {
                    this._arrowContainer.removeChild(this._arrowAllocation[_loc_2]);
                    this._arrowPool.push(this._arrowAllocation[_loc_2]);
                    _loc_3.boundsRef = null;
                    delete this._reverseArrowAllocation[this._arrowAllocation[_loc_2]];
                    delete this._arrowAllocation[_loc_2];
                    continue;
                }
                if (_loc_3.follow && (!_loc_2.parent || _loc_14 >= _loc_6))
                {
                    _loc_15 = this.getIconArrow(_loc_2);
                    _loc_15.visible = this._layers[_loc_3.layer].visible;
                    this._arrowContainer.addChild(_loc_15);
                    this._elementsGraphicRef[_loc_15] = _loc_3;
                    _loc_3.boundsRef = _loc_15;
                }
            }
            _loc_10 = Math.atan2(0, (-width) / 2);
            _loc_11 = Math.atan2(width / 2, 0) + _loc_10;
            for (_loc_13 in this._arrowAllocation)
            {
                
                _loc_9 = this._arrowAllocation[_loc_13];
                _loc_3 = this._elementsGraphicRef[_loc_13];
                _loc_16 = Math.atan2(-_loc_3.y + _loc_5.y, -_loc_3.x + _loc_5.x);
                _loc_9.x = Math.cos(_loc_10 + _loc_16) * width / 2;
                _loc_9.y = Math.sin(_loc_10 + _loc_16) * height / 2;
                _loc_9.rotation = _loc_16 * (180 / Math.PI);
                if (_loc_7)
                {
                    _loc_9.x = _loc_9.x + width / 2;
                    _loc_9.y = _loc_9.y + height / 2;
                    continue;
                }
                _loc_11 = _loc_9.y / _loc_9.x;
                _loc_16 = _loc_16 + Math.PI;
                if (_loc_16 < Math.PI / 4 || _loc_16 > Math.PI * 7 / 4)
                {
                    _loc_12 = width / 2 * _loc_11 + height / 2;
                    if (_loc_12 > 0 && _loc_12 < height)
                    {
                        _loc_9.x = width;
                        _loc_9.y = _loc_12;
                        continue;
                    }
                    continue;
                }
                if (_loc_16 < Math.PI * 3 / 4)
                {
                    _loc_12 = height / 2 / _loc_11 + width / 2;
                    if (_loc_12 > 0 && _loc_12 < width)
                    {
                        _loc_9.x = _loc_12;
                        _loc_9.y = height;
                    }
                    continue;
                }
                if (_loc_16 < Math.PI * 5 / 4)
                {
                    _loc_12 = (-width) / 2 * _loc_11 + height / 2;
                    if (_loc_12 > 0 && _loc_12 < height)
                    {
                        _loc_9.x = 0;
                        _loc_9.y = _loc_12;
                        continue;
                    }
                    continue;
                }
                _loc_12 = (-height) / 2 / _loc_11 + width / 2;
                if (_loc_12 > 0 && _loc_12 < width)
                {
                    _loc_9.x = _loc_12;
                    _loc_9.y = 0;
                    continue;
                }
            }
            return;
        }// end function

        private function getIconArrow(param1:Texture) : Texture
        {
            var _loc_2:* = null;
            if (this._arrowAllocation[param1])
            {
                return this._arrowAllocation[param1];
            }
            if (this._arrowPool.length)
            {
                this._arrowAllocation[param1] = this._arrowPool.pop();
            }
            else
            {
                _loc_2 = new Texture();
                _loc_2.uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path") + "icons/assets.swf|arrow0");
                _loc_2.mouseEnabled = true;
                _loc_2.finalize();
                this._arrowAllocation[param1] = _loc_2;
            }
            this._reverseArrowAllocation[this._arrowAllocation[param1]] = param1;
            Texture(this._arrowAllocation[param1]).transform.colorTransform = param1.transform.colorTransform;
            return this._arrowAllocation[param1];
        }// end function

        private function processMapInfo() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this._avaibleMap.length)
            {
                return;
            }
            this._lastScaleIconUpdate = -1;
            var _loc_2:* = 10000;
            for each (_loc_4 in this._avaibleMap)
            {
                
                _loc_3 = Math.abs(_loc_4.zoom - this._mapContainer.scaleX);
                if (_loc_3 < _loc_2)
                {
                    _loc_1 = _loc_4;
                    _loc_2 = _loc_3;
                }
            }
            if (!this._currentMap || _loc_1 != this._currentMap)
            {
                if (this._currentMap)
                {
                    for each (_loc_5 in this._currentMap.areas)
                    {
                        
                        _loc_5.free();
                    }
                }
                this._currentMap = _loc_1;
                this._mapBitmapContainer.graphics.beginFill(0, 0);
                this._mapBitmapContainer.graphics.drawRect(0, 0, this._currentMap.initialWidth, this._currentMap.initialHeight);
                this._mapBitmapContainer.graphics.endFill();
                this._mapBitmapContainer.addChild(this._currentMap.container);
                this._viewRect.width = width;
                this._viewRect.height = height;
            }
            this.updateVisibleChunck();
            return;
        }// end function

        private function updateVisibleChunck() : void
        {
            var _loc_3:* = null;
            if (!this._currentMap || !this._currentMap.areas)
            {
                return;
            }
            this.updateIcon();
            var _loc_1:* = [];
            var _loc_2:* = 100;
            this._viewRect.x = (-this._mapContainer.x) / this._mapContainer.scaleX - _loc_2;
            this._viewRect.y = (-this._mapContainer.y) / this._mapContainer.scaleY - _loc_2;
            this._viewRect.width = width / this._mapContainer.scaleX + _loc_2 * 2;
            this._viewRect.height = height / this._mapContainer.scaleY + _loc_2 * 2;
            for each (_loc_3 in this._currentMap.areas)
            {
                
                if (this._viewRect.intersects(_loc_3))
                {
                    if (!_loc_3.isUsed)
                    {
                        _loc_3.parent.container.addChild(_loc_3.getBitmap());
                    }
                    continue;
                }
                if (_loc_3.isUsed)
                {
                    _loc_3.free();
                }
            }
            return;
        }// end function

        private function initMask() : void
        {
            if (this._mapContainer.mask)
            {
                this._mapContainer.mask.parent.removeChild(this._mapContainer.mask);
            }
            var _loc_1:* = new Sprite();
            _loc_1.doubleClickEnabled = true;
            _loc_1.graphics.beginFill(7798784, 0.3);
            if (!this.roundCornerRadius)
            {
                _loc_1.graphics.drawRect(0, 0, width, height);
            }
            else
            {
                _loc_1.graphics.drawRoundRectComplex(0, 0, width, height, this.roundCornerRadius, this.roundCornerRadius, this.roundCornerRadius, this.roundCornerRadius);
            }
            addChild(_loc_1);
            this._mapContainer.mask = _loc_1;
            return;
        }// end function

        private function initMap() : void
        {
            var _loc_1:* = null;
            this._mapContainer = new Sprite();
            this.initMask();
            this._mapContainer.addChild(this._mapBitmapContainer);
            this._grid = new Shape();
            this.drawGrid();
            this._mapContainer.addChild(this._grid);
            this._layersContainer = new Sprite();
            this._mapContainer.addChild(this._layersContainer);
            this._layersContainer.mouseEnabled = false;
            this.zoom(this.startScale);
            if (this._enable3DMode)
            {
                _loc_1 = new Sprite();
                _loc_1.addChild(this._mapContainer);
                _loc_1.rotationX = -30;
                _loc_1.doubleClickEnabled = true;
                addChild(_loc_1);
            }
            else
            {
                addChild(this._mapContainer);
            }
            addChild(this._arrowContainer);
            this._mapElements = new Array();
            this._layers = new Array();
            this._elementsGraphicRef = new Dictionary(true);
            return;
        }// end function

        private function drawGrid() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_1:* = this.origineX % this.mapWidth;
            var _loc_2:* = this.origineY % this.mapHeight;
            if (!this._showGrid)
            {
                this._grid.graphics.clear();
            }
            else
            {
                this._grid.cacheAsBitmap = false;
                this._grid.graphics.lineStyle(1, 7829367, 0.5);
                _loc_4 = this._mapBitmapContainer.width / this.mapWidth;
                _loc_3 = 0;
                while (_loc_3 < _loc_4)
                {
                    
                    this._grid.graphics.moveTo(_loc_3 * this.mapWidth + _loc_1, 0);
                    this._grid.graphics.lineTo(_loc_3 * this.mapWidth + _loc_1, this._mapBitmapContainer.height);
                    _loc_3 = _loc_3 + 1;
                }
                _loc_5 = this._mapBitmapContainer.height / this.mapHeight;
                _loc_3 = 0;
                while (_loc_3 < _loc_5)
                {
                    
                    this._grid.graphics.moveTo(0, _loc_3 * this.mapHeight + _loc_2);
                    this._grid.graphics.lineTo(this._mapBitmapContainer.width, _loc_3 * this.mapHeight + _loc_2);
                    _loc_3 = _loc_3 + 1;
                }
                this._grid.cacheAsBitmap = true;
            }
            return;
        }// end function

        private function clearLayer(param1:DisplayObjectContainer = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_3 in this._layers)
            {
                
                if (!param1 || param1 == _loc_3)
                {
                    while (_loc_3.numChildren)
                    {
                        
                        _loc_2 = _loc_3.removeChildAt(0);
                        if (_loc_2 is MapGroupElement)
                        {
                            MapGroupElement(_loc_2).remove();
                        }
                    }
                }
            }
            return;
        }// end function

        private function updateIconSize() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (!this.autoSizeIcon || this._lastScaleIconUpdate == this._mapContainer.scaleX)
            {
                return;
            }
            this._lastScaleIconUpdate = this._mapContainer.scaleX;
            for each (_loc_2 in this._mapElements)
            {
                
                _loc_1 = _loc_2 as MapIconElement;
                if (!_loc_1 || !_loc_1.canBeAutoSize)
                {
                    continue;
                }
                var _loc_5:* = 0.75 + 1 / this._mapContainer.scaleX;
                _loc_1._texture.scaleY = 0.75 + 1 / this._mapContainer.scaleX;
                _loc_1._texture.scaleX = _loc_5;
            }
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            switch(true)
            {
                case param1 is MouseOverMessage:
                {
                    _loc_2 = param1 as MouseOverMessage;
                    if (_loc_2.target == this || _loc_2.target.parent == this || _loc_2.target.parent != this._arrowContainer && _loc_2.target.parent.parent == this)
                    {
                        if (!EnterFrameDispatcher.hasEventListener(this.onMapEnterFrame))
                        {
                            EnterFrameDispatcher.addEventListener(this.onMapEnterFrame, "mapMouse");
                        }
                        return false;
                    }
                    if (_loc_2.target is MapGroupElement || _loc_2.target.parent is MapGroupElement && this._openedMapGroupElement != _loc_2.target.parent)
                    {
                        if (_loc_2.target is MapGroupElement)
                        {
                            this._openedMapGroupElement = MapGroupElement(_loc_2.target);
                        }
                        else
                        {
                            this._openedMapGroupElement = MapGroupElement(_loc_2.target.parent);
                        }
                        if (!this._openedMapGroupElement.opened)
                        {
                            this._openedMapGroupElement.parent.addChild(this._openedMapGroupElement);
                            this._openedMapGroupElement.open();
                        }
                        if (this._openedMapGroupElement.icons.length == 1)
                        {
                            this._openedMapGroupElement.close();
                            Berilia.getInstance().handler.process(new MapElementRollOverMessage(this, this._elementsGraphicRef[this._openedMapGroupElement.icons[0]]));
                            this._openedMapGroupElement = null;
                        }
                    }
                    else if (this._elementsGraphicRef[_loc_2.target])
                    {
                        Berilia.getInstance().handler.process(new MapElementRollOverMessage(this, this._elementsGraphicRef[_loc_2.target]));
                    }
                    else if (this._reverseArrowAllocation[_loc_2.target] && this._elementsGraphicRef[this._reverseArrowAllocation[_loc_2.target]])
                    {
                        Berilia.getInstance().handler.process(new MapElementRollOverMessage(this, this._elementsGraphicRef[this._reverseArrowAllocation[_loc_2.target]]));
                    }
                    break;
                }
                case param1 is MouseOutMessage:
                {
                    _loc_3 = param1 as MouseOutMessage;
                    if (_loc_3.target == this || _loc_3.target.parent == this || _loc_3.target.parent != this._arrowContainer && _loc_3.target.parent.parent == this)
                    {
                        if (!this._draging && EnterFrameDispatcher.hasEventListener(this.onMapEnterFrame))
                        {
                            EnterFrameDispatcher.removeEventListener(this.onMapEnterFrame);
                        }
                        return false;
                    }
                    if (_loc_3.mouseEvent.relatedObject && _loc_3.mouseEvent.relatedObject.parent != this._openedMapGroupElement && _loc_3.mouseEvent.relatedObject != this._openedMapGroupElement && this._openedMapGroupElement)
                    {
                        this._openedMapGroupElement.close();
                        this._openedMapGroupElement = null;
                    }
                    if (this._elementsGraphicRef[_loc_3.target])
                    {
                        Berilia.getInstance().handler.process(new MapElementRollOutMessage(this, this._elementsGraphicRef[_loc_3.target]));
                    }
                    else if (this._reverseArrowAllocation[_loc_3.target] && this._elementsGraphicRef[this._reverseArrowAllocation[_loc_3.target]])
                    {
                        Berilia.getInstance().handler.process(new MapElementRollOutMessage(this, this._elementsGraphicRef[this._reverseArrowAllocation[_loc_3.target]]));
                    }
                    break;
                }
                case param1 is MouseDownMessage:
                {
                    if (!this.enabledDrag)
                    {
                        return false;
                    }
                    if (!this._enable3DMode)
                    {
                        this._mapContainer.startDrag(false, new Rectangle(width - this._mapBitmapContainer.width * this._mapContainer.scaleX, height - this._mapBitmapContainer.height * this._mapContainer.scaleY, this._mapBitmapContainer.width * this._mapContainer.scaleX - width, this._mapBitmapContainer.height * this._mapContainer.scaleY - height));
                    }
                    this._draging = true;
                    return false;
                }
                case param1 is MouseDoubleClickMessage:
                {
                    _loc_4 = param1 as MouseDoubleClickMessage;
                    if (this._reverseArrowAllocation[_loc_4.target])
                    {
                        _loc_9 = this._elementsGraphicRef[this._reverseArrowAllocation[_loc_4.target]];
                        this.moveTo(_loc_9.x, _loc_9.y);
                    }
                    break;
                }
                case param1 is MouseReleaseOutsideMessage:
                case param1 is MouseUpMessage:
                {
                    if (!this._enable3DMode)
                    {
                        this._mapContainer.stopDrag();
                    }
                    this._draging = false;
                    this._lastMouseX = 0;
                    this.updateVisibleChunck();
                    Berilia.getInstance().handler.process(new MapMoveMessage(this));
                    return false;
                }
                case param1 is MouseWheelMessage:
                {
                    _loc_5 = param1 as MouseWheelMessage;
                    _loc_6 = this._mapContainer.scaleX + (_loc_5.mouseEvent.delta > 0 ? (1) : (-1)) * 0.2;
                    _loc_7 = new Point(_loc_5.mouseEvent.localX, _loc_5.mouseEvent.localY);
                    switch(true)
                    {
                        case _loc_5.mouseEvent.target.parent is MapGroupElement:
                        {
                            _loc_7.x = _loc_5.mouseEvent.target.parent.x;
                            _loc_7.y = _loc_5.mouseEvent.target.parent.y;
                            break;
                        }
                        case _loc_5.mouseEvent.target is MapGroupElement:
                        case _loc_5.mouseEvent.target is Texture:
                        {
                            _loc_7.x = _loc_5.mouseEvent.target.x;
                            _loc_7.y = _loc_5.mouseEvent.target.y;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    this.zoom(_loc_6, _loc_7);
                    this.processMapInfo();
                    Berilia.getInstance().handler.process(new MapMoveMessage(this));
                    return true;
                }
                case param1 is MouseRightClickMessage:
                {
                    _loc_8 = param1 as MouseRightClickMessage;
                    if (this._elementsGraphicRef[_loc_8.target])
                    {
                        Berilia.getInstance().handler.process(new MapElementRightClickMessage(this, this._elementsGraphicRef[_loc_8.target]));
                    }
                    else if (this._reverseArrowAllocation[_loc_8.target] && this._elementsGraphicRef[this._reverseArrowAllocation[_loc_8.target]])
                    {
                        Berilia.getInstance().handler.process(new MapElementRightClickMessage(this, this._elementsGraphicRef[this._reverseArrowAllocation[_loc_8.target]]));
                    }
                    return false;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function onMapEnterFrame(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this._draging)
            {
                if (this._enable3DMode && this._lastMouseX)
                {
                    this._mapContainer.x = this._mapContainer.x - (StageShareManager.mouseX - this._lastMouseX);
                    this._mapContainer.y = this._mapContainer.y - (StageShareManager.mouseY - this._lastMouseY);
                }
                this.updateVisibleChunck();
                this._lastMouseX = StageShareManager.mouseX;
                this._lastMouseY = StageShareManager.mouseY;
            }
            var _loc_2:* = this.mouseX;
            var _loc_3:* = this.mouseY;
            if (_loc_2 > 0 && _loc_2 < __width && _loc_3 > 0 && _loc_3 < __height)
            {
                _loc_4 = Math.floor((this._mapBitmapContainer.mouseX - this.origineX) / this.mapWidth);
                _loc_5 = Math.floor((this._mapBitmapContainer.mouseY - this.origineY) / this.mapHeight);
                if (!this._openedMapGroupElement && (_loc_4 != this._lastMx || _loc_5 != this._lastMy))
                {
                    this._lastMx = _loc_4;
                    this._lastMy = _loc_5;
                    Berilia.getInstance().handler.process(new MapRollOverMessage(this, _loc_4, _loc_5));
                }
            }
            return;
        }// end function

    }
}
