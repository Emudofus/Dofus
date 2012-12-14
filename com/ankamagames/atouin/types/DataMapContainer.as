package com.ankamagames.atouin.types
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.elements.subtypes.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.events.*;
    import flash.display.*;
    import flash.utils.*;

    public class DataMapContainer extends Object
    {
        private var _spMap:Sprite;
        private var _aLayers:Array;
        private var _aCell:Array;
        private var _map:Map;
        private var _animatedElement:Array;
        private var _allowAnimatedGfx:Boolean;
        private var _temporaryEnable:Boolean = true;
        public var layerDepth:Array;
        public var id:int;
        public var rendered:Boolean = false;
        private static var _aInteractiveCell:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DataMapContainer));

        public function DataMapContainer(param1:Map)
        {
            if (!this._spMap)
            {
                this._spMap = new Sprite();
                this._aLayers = new Array();
                _aInteractiveCell = new Array();
            }
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onOptionChange);
            this.id = param1.id;
            this.layerDepth = new Array();
            this._aCell = new Array();
            this._map = param1;
            this._animatedElement = new Array();
            this._allowAnimatedGfx = Atouin.getInstance().options.allowAnimatedGfx;
            return;
        }// end function

        public function removeContainer() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this._aCell.length)
            {
                
                _loc_3 = this._aCell[_loc_5];
                if (!_loc_3)
                {
                }
                else
                {
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3.listSprites.length)
                    {
                        
                        if (!(_loc_3.listSprites[_loc_4] is Sprite))
                        {
                        }
                        else
                        {
                            _loc_1 = _loc_3.listSprites[_loc_4];
                            if (_loc_1)
                            {
                                _loc_1.cacheAsBitmap = false;
                                _loc_2 = Sprite(_loc_1.parent);
                                if (_loc_2)
                                {
                                    _loc_2.removeChild(_loc_1);
                                    delete _loc_3.listSprites[_loc_4];
                                    if (!_loc_2.numChildren)
                                    {
                                        _loc_2.parent.removeChild(_loc_2);
                                    }
                                }
                            }
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    delete this._aCell[_loc_5];
                }
                _loc_5 = _loc_5 + 1;
            }
            Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onOptionChange);
            return;
        }// end function

        public function getCellReference(param1:uint) : CellReference
        {
            if (!this._aCell[param1])
            {
                this._aCell[param1] = new CellReference(param1);
            }
            return this._aCell[param1];
        }// end function

        public function isRegisteredCell(param1:uint) : Boolean
        {
            return this._aCell[param1] != null;
        }// end function

        public function getCell() : Array
        {
            return this._aCell;
        }// end function

        public function getLayer(param1:int) : LayerContainer
        {
            if (!this._aLayers[param1])
            {
                this._aLayers[param1] = new LayerContainer(param1);
            }
            return this._aLayers[param1];
        }// end function

        public function clean(param1:Boolean = false) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!param1)
            {
                _loc_6 = VisibleCellDetection.detectCell(false, this._map, WorldPoint.fromMapId(this.id), Atouin.getInstance().options.frustum, MapDisplayManager.getInstance().currentMapPoint).cell;
            }
            else
            {
                _loc_6 = new Array();
                _loc_5 = 0;
                while (_loc_5 < this._aCell.length)
                {
                    
                    _loc_6[_loc_5] = _loc_5;
                    _loc_5 = _loc_5 + 1;
                }
            }
            for (_loc_7 in _loc_6)
            {
                
                _loc_4 = this._aCell[_loc_7];
                if (!_loc_4)
                {
                    continue;
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_4.listSprites.length)
                {
                    
                    _loc_2 = _loc_4.listSprites[_loc_5];
                    if (_loc_2)
                    {
                        _loc_2.cacheAsBitmap = false;
                        _loc_3 = Sprite(_loc_2.parent);
                        _loc_3.removeChild(_loc_2);
                        delete _loc_4.listSprites[_loc_5];
                        if (!_loc_3.numChildren)
                        {
                            _loc_3.parent.removeChild(_loc_3);
                        }
                    }
                    _loc_5 = _loc_5 + 1;
                }
                delete this._aCell[_loc_7];
            }
            _loc_8 = WorldPoint.fromMapId(this._map.id);
            WorldPoint.fromMapId(this._map.id).x = _loc_8.x - MapDisplayManager.getInstance().currentMapPoint.x;
            _loc_8.y = _loc_8.y - MapDisplayManager.getInstance().currentMapPoint.y;
            return Math.abs(_loc_8.x) > 1 || Math.abs(_loc_8.y) > 1;
        }// end function

        public function get mapContainer() : Sprite
        {
            return this._spMap;
        }// end function

        public function get dataMap() : Map
        {
            return this._map;
        }// end function

        public function addAnimatedElement(param1:WorldEntitySprite, param2:EntityGraphicalElementData) : void
        {
            var _loc_3:* = {element:param1, data:param2};
            this._animatedElement.push(_loc_3);
            this.updateAnimatedElement(_loc_3);
            return;
        }// end function

        public function setTemporaryAnimatedElementState(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._temporaryEnable = param1;
            for each (_loc_2 in this._animatedElement)
            {
                
                this.updateAnimatedElement(_loc_2);
            }
            return;
        }// end function

        public function get x() : Number
        {
            return this._spMap.x;
        }// end function

        public function get y() : Number
        {
            return this._spMap.y;
        }// end function

        public function set x(param1:Number) : void
        {
            this._spMap.x = param1;
            return;
        }// end function

        public function set y(param1:Number) : void
        {
            this._spMap.y = param1;
            return;
        }// end function

        public function get scaleX() : Number
        {
            return this._spMap.scaleX;
        }// end function

        public function get scaleY() : Number
        {
            return this._spMap.scaleY;
        }// end function

        public function set scaleX(param1:Number) : void
        {
            this._spMap.scaleX = param1;
            return;
        }// end function

        public function set scaleY(param1:Number) : void
        {
            this._spMap.scaleX = param1;
            return;
        }// end function

        public function addChild(param1:DisplayObject) : DisplayObject
        {
            return this._spMap.addChild(param1);
        }// end function

        public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            return this._spMap.addChildAt(param1, param2);
        }// end function

        public function getChildIndex(param1:DisplayObject) : int
        {
            return this._spMap.getChildIndex(param1);
        }// end function

        public function contains(param1:DisplayObject) : Boolean
        {
            return this._spMap.contains(param1);
        }// end function

        public function getChildByName(param1:String) : DisplayObject
        {
            return this._spMap.getChildByName(param1);
        }// end function

        public function removeChild(param1:DisplayObject) : DisplayObject
        {
            if (param1.parent && param1.parent == this._spMap)
            {
                return this._spMap.removeChild(param1);
            }
            return null;
        }// end function

        private function updateAnimatedElement(param1:Object) : void
        {
            var _loc_2:* = param1.element;
            var _loc_3:* = param1.data;
            var _loc_4:* = this._temporaryEnable && this._allowAnimatedGfx;
            if (this._temporaryEnable && this._allowAnimatedGfx && _loc_3.playAnimation)
            {
                if (_loc_3.maxDelay > 0)
                {
                    AnimatedElementManager.removeAnimatedElement(_loc_2);
                    AnimatedElementManager.addAnimatedElement(_loc_2, _loc_3.minDelay * 1000, _loc_3.maxDelay * 1000);
                    if (_loc_3.playAnimStatic)
                    {
                        _loc_2.setAnimation("AnimStatique");
                    }
                }
                else if (_loc_2.getAnimation() != "AnimStart")
                {
                    _loc_2.setAnimation("AnimStart");
                }
                else
                {
                    _loc_2.restartAnimation();
                }
            }
            else
            {
                AnimatedElementManager.removeAnimatedElement(_loc_2);
                if (_loc_3.playAnimation)
                {
                    if (_loc_2.hasAnimation("AnimStatique"))
                    {
                        _loc_2.setAnimation("AnimStatique");
                    }
                    else
                    {
                        _loc_2.stopAnimation();
                    }
                }
                else
                {
                    _loc_2.stopAnimation();
                }
            }
            return;
        }// end function

        private function onEntityRendered(event:TiphonEvent) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._animatedElement)
            {
                
                if (_loc_2.element == event.sprite)
                {
                    event.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityRendered);
                    this.updateAnimatedElement(_loc_2);
                    break;
                }
            }
            event.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityRendered);
            return;
        }// end function

        private function onOptionChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = null;
            if (event.propertyName == "allowAnimatedGfx")
            {
                this._allowAnimatedGfx = event.propertyValue;
                for each (_loc_2 in this._animatedElement)
                {
                    
                    this.updateAnimatedElement(_loc_2);
                }
            }
            return;
        }// end function

        public static function get interactiveCell() : Array
        {
            return _aInteractiveCell;
        }// end function

    }
}
