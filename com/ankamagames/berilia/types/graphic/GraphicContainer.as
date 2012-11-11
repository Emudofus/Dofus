package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import gs.*;
    import gs.easing.*;

    public class GraphicContainer extends Sprite implements UIComponent, IRectangle, Poolable, IDragAndDropHandler, ICustomUnicNameGetter
    {
        protected var __width:uint;
        protected var __widthReal:uint;
        protected var __height:uint;
        protected var __heightReal:uint;
        protected var __removed:Boolean;
        protected var _bgColor:int = -1;
        protected var _bgAlpha:Number = 1;
        protected var _borderColor:int = -1;
        protected var _bgCornerRadius:uint = 0;
        protected var _aStrata:Array;
        private var _scale:Number = 1;
        private var _sLinkedTo:String;
        private var _bDynamicPosition:Boolean;
        private var _bDisabled:Boolean;
        private var _bSoftDisabled:Boolean;
        private var _bGreyedOut:Boolean;
        private var _shadow:DropShadowFilter;
        private var _luminosity:Number = 1;
        private var _nMouseX:int;
        private var _nMouseY:int;
        private var _nStartWidth:int;
        private var _nStartHeight:int;
        private var _nLastWidth:int;
        private var _nLastHeight:int;
        private var _shResizeBorder:Shape;
        private var _bUseSimpleResize:Boolean = true;
        private var _uiRootContainer:UiRootContainer;
        private var _dropValidatorFunction:Function;
        private var _processDropFunction:Function;
        private var _removeDropSourceFunction:Function;
        private var _startSlideTime:int;
        private var _timeSlide:int;
        private var _slideBaseX:int;
        private var _slideBaseY:int;
        private var _slideWidth:int;
        private var _slideHeight:int;
        public var minSize:GraphicSize;
        public var maxSize:GraphicSize;
        private var _customName:String;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicContainer));

        public function GraphicContainer()
        {
            this._dropValidatorFunction = this.defaultDropValidatorFunction;
            this._processDropFunction = this.defaultProcessDropFunction;
            this._removeDropSourceFunction = this.defaultRemoveDropSourceFunction;
            this._aStrata = new Array();
            focusRect = false;
            this.mouseEnabled = false;
            FpsManager.getInstance().watchObject(this);
            doubleClickEnabled = true;
            return;
        }// end function

        public function get customUnicName() : String
        {
            if (!this._customName)
            {
                if (this.getUi())
                {
                    this._customName = this.getUi().name + "::" + name;
                }
            }
            return this._customName;
        }// end function

        public function set dropValidator(param1:Function) : void
        {
            this._dropValidatorFunction = param1;
            return;
        }// end function

        public function get dropValidator() : Function
        {
            return this._dropValidatorFunction;
        }// end function

        public function set removeDropSource(param1:Function) : void
        {
            this._removeDropSourceFunction = param1;
            return;
        }// end function

        public function get removeDropSource() : Function
        {
            return this._removeDropSourceFunction;
        }// end function

        public function set processDrop(param1:Function) : void
        {
            this._processDropFunction = param1;
            return;
        }// end function

        public function get processDrop() : Function
        {
            return this._processDropFunction;
        }// end function

        public function focus() : void
        {
            FocusHandler.getInstance().setFocus(this);
            return;
        }// end function

        public function get scale() : Number
        {
            return this._scale;
        }// end function

        public function set scale(param1:Number) : void
        {
            this.__width = this.__widthReal * (1 - param1);
            this.__height = this.__heightReal * (1 - param1);
            scaleX = param1;
            scaleY = param1;
            this._scale = param1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            var _loc_3:* = null;
            if (param1 < 1)
            {
                this.__width = 1;
            }
            else
            {
                this.__width = param1;
            }
            if (this._bgColor != -1)
            {
                this.bgColor = this._bgColor;
            }
            this.__widthReal = this.__width;
            var _loc_2:* = this.getUi();
            if (_loc_2)
            {
                _loc_3 = _loc_2.getElementById(name);
                if (_loc_3 && _loc_2.ready)
                {
                    _loc_3.size.setX(param1, _loc_3.size.xUnit);
                }
                _loc_2.updateLinkedUi();
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            var _loc_3:* = null;
            if (param1 < 1)
            {
                this.__height = 1;
            }
            else
            {
                this.__height = param1;
            }
            if (this._bgColor != -1)
            {
                this.bgColor = this._bgColor;
            }
            this.__heightReal = this.__height;
            var _loc_2:* = this.getUi();
            if (_loc_2)
            {
                _loc_3 = _loc_2.getElementById(name);
                if (_loc_3 && _loc_2.ready)
                {
                    _loc_3.size.setY(param1, _loc_3.size.yUnit);
                }
                _loc_2.updateLinkedUi();
            }
            return;
        }// end function

        override public function get width() : Number
        {
            if (isNaN(this.__width) || !this.__width)
            {
                return this.getBounds(this).width * scaleX;
            }
            return this.__width * scaleX;
        }// end function

        override public function get height() : Number
        {
            if (isNaN(this.__height) || !this.__height)
            {
                return this.getBounds(this).height * scaleY;
            }
            return this.__height * scaleY;
        }// end function

        public function get contentWidth() : Number
        {
            return super.width;
        }// end function

        public function get contentHeight() : Number
        {
            return super.height;
        }// end function

        override public function set x(param1:Number) : void
        {
            var _loc_3:* = null;
            super.x = param1;
            var _loc_2:* = this.getUi();
            if (_loc_2)
            {
                _loc_3 = _loc_2.getElementById(name);
                if (_loc_3 && _loc_2.ready)
                {
                    _loc_3.location.setOffsetX(param1);
                }
                _loc_2.updateLinkedUi();
            }
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            var _loc_3:* = null;
            super.y = param1;
            var _loc_2:* = this.getUi();
            if (_loc_2)
            {
                _loc_3 = _loc_2.getElementById(name);
                if (_loc_3 && _loc_2.ready)
                {
                    _loc_3.location.setOffsetY(param1);
                }
                _loc_2.updateLinkedUi();
            }
            return;
        }// end function

        public function get anchorY() : Number
        {
            var _loc_2:* = null;
            var _loc_1:* = this.getUi();
            if (_loc_1)
            {
                _loc_2 = _loc_1.getElementById(name);
                if (_loc_2 && _loc_1.ready)
                {
                    return _loc_2.location.getOffsetY();
                }
            }
            return NaN;
        }// end function

        public function get anchorX() : Number
        {
            var _loc_2:* = null;
            var _loc_1:* = this.getUi();
            if (_loc_1)
            {
                _loc_2 = _loc_1.getElementById(name);
                if (_loc_2 && _loc_1.ready)
                {
                    return _loc_2.location.getOffsetX();
                }
            }
            return NaN;
        }// end function

        public function set bgColor(param1:int) : void
        {
            this._bgColor = param1;
            graphics.clear();
            if (this.bgColor == -1 || !this.width || !this.height)
            {
                return;
            }
            if (this._borderColor != -1)
            {
                graphics.lineStyle(1, this._borderColor);
            }
            graphics.beginFill(param1, this._bgAlpha);
            if (!this._bgCornerRadius)
            {
                graphics.drawRect(0, 0, this.width, this.height);
            }
            else
            {
                graphics.drawRoundRect(0, 0, this.width, this.height, this._bgCornerRadius, this._bgCornerRadius);
            }
            graphics.endFill();
            return;
        }// end function

        public function get bgColor() : int
        {
            return this._bgColor;
        }// end function

        public function set bgAlpha(param1:Number) : void
        {
            this._bgAlpha = param1;
            this.bgColor = this.bgColor;
            return;
        }// end function

        public function get bgAlpha() : Number
        {
            return this._bgAlpha;
        }// end function

        public function set borderColor(param1:int) : void
        {
            this._borderColor = param1;
            this.bgColor = this.bgColor;
            return;
        }// end function

        public function get borderColor() : int
        {
            return this._borderColor;
        }// end function

        public function set bgCornerRadius(param1:uint) : void
        {
            this._bgCornerRadius = param1;
            this.bgColor = this.bgColor;
            return;
        }// end function

        public function get bgCornerRadius() : uint
        {
            return this._bgCornerRadius;
        }// end function

        public function set luminosity(param1:Number) : void
        {
            this._luminosity = param1;
            return;
        }// end function

        public function get luminosity() : Number
        {
            return this._luminosity;
        }// end function

        public function set linkedTo(param1:String) : void
        {
            this._sLinkedTo = param1;
            return;
        }// end function

        public function get linkedTo() : String
        {
            return this._sLinkedTo;
        }// end function

        public function set shadowColor(param1:int) : void
        {
            if (Berilia.getInstance().options.uiShadows)
            {
                if (param1 >= 0)
                {
                    this._shadow = new DropShadowFilter(3, 90, param1, 1, 10, 10, 0.61, BitmapFilterQuality.HIGH);
                    filters = [this._shadow];
                }
                else if (param1 == -1 && this._shadow)
                {
                    this._shadow = null;
                    filters = [];
                }
            }
            return;
        }// end function

        public function get shadowColor() : int
        {
            return this._shadow ? (this._shadow.color) : (-1);
        }// end function

        public function get topParent() : DisplayObject
        {
            return this.getTopParent(this);
        }// end function

        public function setAdvancedGlow(param1:uint, param2:Number = 1, param3:Number = 6, param4:Number = 6, param5:Number = 2) : void
        {
            return;
        }// end function

        public function clearFilters() : void
        {
            filters = [];
            return;
        }// end function

        public function getStrata(param1:uint) : Sprite
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._aStrata[param1] != null)
            {
                return this._aStrata[param1];
            }
            this._aStrata[param1] = new Sprite();
            this._aStrata[param1].name = "strata_" + param1;
            this._aStrata[param1].mouseEnabled = false;
            this._aStrata[param1].doubleClickEnabled = true;
            _loc_2 = 0;
            _loc_3 = 0;
            while (_loc_3 < this._aStrata.length)
            {
                
                if (this._aStrata[_loc_3] != null)
                {
                    addChildAt(this._aStrata[_loc_3], _loc_2++);
                }
                _loc_3 = _loc_3 + 1;
            }
            return this._aStrata[param1];
        }// end function

        public function set dynamicPosition(param1:Boolean) : void
        {
            this._bDynamicPosition = param1;
            return;
        }// end function

        public function get dynamicPosition() : Boolean
        {
            return this._bDynamicPosition;
        }// end function

        public function set disabled(param1:Boolean) : void
        {
            if (param1)
            {
                transform.colorTransform = new ColorTransform(0.6, 0.6, 0.6, 1);
                this.HandCursor = false;
                this.mouseEnabled = false;
                mouseChildren = false;
            }
            else
            {
                if (!this.greyedOut)
                {
                    transform.colorTransform = new ColorTransform(1, 1, 1, 1);
                }
                this.HandCursor = true;
                this.mouseEnabled = true;
                mouseChildren = true;
            }
            this._bDisabled = param1;
            return;
        }// end function

        public function get disabled() : Boolean
        {
            return this._bDisabled;
        }// end function

        public function set softDisabled(param1:Boolean) : void
        {
            if (this._bSoftDisabled != param1)
            {
                if (param1)
                {
                    transform.colorTransform = new ColorTransform(0.6, 0.6, 0.6, 1);
                }
                else
                {
                    transform.colorTransform = new ColorTransform(1, 1, 1, 1);
                }
            }
            this._bSoftDisabled = param1;
            return;
        }// end function

        public function get softDisabled() : Boolean
        {
            return this._bSoftDisabled;
        }// end function

        public function set greyedOut(param1:Boolean) : void
        {
            if (this._bGreyedOut != param1)
            {
                if (param1)
                {
                    transform.colorTransform = new ColorTransform(0.6, 0.6, 0.6, 1);
                }
                else if (!this.disabled)
                {
                    transform.colorTransform = new ColorTransform(1, 1, 1, 1);
                }
            }
            this._bGreyedOut = param1;
            return;
        }// end function

        public function get greyedOut() : Boolean
        {
            return this._bGreyedOut;
        }// end function

        public function get depths() : Array
        {
            var _loc_1:* = new Array();
            var _loc_2:* = this;
            while (_loc_2.getParent() != null)
            {
                
                _loc_1.unshift(_loc_2.getParent());
                _loc_2 = _loc_2.getParent();
            }
            return _loc_1;
        }// end function

        public function set HandCursor(param1:Boolean) : void
        {
            this.buttonMode = param1;
            this.mouseChildren = !param1;
            return;
        }// end function

        override public function set mouseEnabled(param1:Boolean) : void
        {
            var _loc_2:* = null;
            super.mouseEnabled = param1;
            for each (_loc_2 in this._aStrata)
            {
                
                _loc_2.mouseEnabled = param1;
            }
            return;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this.canProcessMessage(param1))
            {
                return true;
            }
            if (param1 is MouseClickMessage && this._sLinkedTo)
            {
                _loc_2 = this.getUi();
                if (_loc_2 != null)
                {
                    _loc_3 = new MouseClickMessage(_loc_2.getElement(this._sLinkedTo), MouseClickMessage(param1).mouseEvent);
                    _loc_2.getElement(this._sLinkedTo).process(_loc_3);
                }
            }
            return false;
        }// end function

        override public function stopDrag() : void
        {
            super.stopDrag();
            this.x = x;
            this.y = y;
            return;
        }// end function

        public function getStageRect() : Rectangle
        {
            return this.getRect(stage);
        }// end function

        public function remove() : void
        {
            var _loc_1:* = this.getUi();
            if (_loc_1)
            {
                _loc_1.deleteId(name);
            }
            this.destroy(this);
            SecureCenter.destroy(this);
            if (parent)
            {
                parent.removeChild(this);
            }
            this.__removed = true;
            return;
        }// end function

        public function addContent(param1:GraphicContainer, param2:int = -1) : GraphicContainer
        {
            if (param2 == -1)
            {
                this.getStrata(0).addChild(param1);
            }
            else
            {
                this.getStrata(0).addChildAt(param1, param2);
            }
            return param1;
        }// end function

        public function removeFromParent() : void
        {
            if (parent)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        public function getParent() : GraphicContainer
        {
            if (this.parent == null || this is UiRootContainer)
            {
                return null;
            }
            var _loc_1:* = DisplayObjectContainer(this.parent);
            while (!(_loc_1 is GraphicContainer))
            {
                
                _loc_1 = DisplayObjectContainer(_loc_1.parent);
            }
            return GraphicContainer(_loc_1);
        }// end function

        public function getUi() : UiRootContainer
        {
            if (this._uiRootContainer)
            {
                return this._uiRootContainer;
            }
            if (this.parent == null)
            {
                return null;
            }
            var _loc_1:* = Sprite(this.parent);
            while (!(_loc_1 is UiRootContainer) && _loc_1 != null)
            {
                
                if (_loc_1.parent is Sprite)
                {
                    _loc_1 = Sprite(_loc_1.parent);
                    continue;
                }
                _loc_1 = null;
            }
            if (_loc_1 == null)
            {
                return null;
            }
            this._uiRootContainer = UiRootContainer(_loc_1);
            return UiRootContainer(_loc_1);
        }// end function

        public function getTopParent(param1:DisplayObject) : DisplayObject
        {
            if (param1.parent != null)
            {
                return this.getTopParent(param1.parent);
            }
            return param1;
        }// end function

        public function startResize() : void
        {
            this._nMouseX = StageShareManager.mouseX;
            this._nMouseY = StageShareManager.mouseY;
            this._nStartWidth = this.width;
            this._nStartHeight = this.height;
            if (this._bUseSimpleResize)
            {
                this._shResizeBorder = new Shape();
                addChild(this._shResizeBorder);
            }
            this.getUi().removeFromRenderList(name);
            EnterFrameDispatcher.addEventListener(this.onEnterFrame, "GraphicContainer");
            return;
        }// end function

        public function endResize() : void
        {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            if (this._bUseSimpleResize)
            {
                this.getUi().render();
                if (super.contains(this._shResizeBorder))
                {
                    removeChild(this._shResizeBorder);
                }
            }
            return;
        }// end function

        public function slide(param1:int, param2:int, param3:int) : void
        {
            TweenLite.to(this, param3 / 1000, {x:param1, y:param2, ease:Strong.easeOut});
            return;
        }// end function

        private function defaultDropValidatorFunction(param1, param2, param3) : Boolean
        {
            var _loc_4:* = this;
            do
            {
                
                _loc_4 = _loc_4.parent;
            }while (!(_loc_4 is IDragAndDropHandler) && _loc_4.parent)
            if (_loc_4 is IDragAndDropHandler)
            {
                return (_loc_4 as IDragAndDropHandler).dropValidator(param1, param2, param3);
            }
            return false;
        }// end function

        private function defaultProcessDropFunction(param1, param2, param3) : void
        {
            var _loc_4:* = this;
            do
            {
                
                _loc_4 = _loc_4.parent;
            }while (!(_loc_4 is IDragAndDropHandler) && _loc_4.parent)
            if (_loc_4 is IDragAndDropHandler)
            {
                (_loc_4 as IDragAndDropHandler).processDrop(param1, param2, param3);
            }
            return;
        }// end function

        private function defaultRemoveDropSourceFunction(param1) : void
        {
            var _loc_2:* = this;
            do
            {
                
                _loc_2 = _loc_2.parent;
            }while (!(_loc_2 is IDragAndDropHandler) && _loc_2.parent)
            if (_loc_2 is IDragAndDropHandler)
            {
                (_loc_2 as IDragAndDropHandler).removeDropSource(param1);
            }
            return;
        }// end function

        override public function localToGlobal(param1:Point) : Point
        {
            var _loc_2:* = this;
            var _loc_3:* = param1;
            while (_loc_2 && _loc_2.parent)
            {
                
                _loc_3.x = _loc_3.x + _loc_2.parent.x;
                _loc_3.y = _loc_3.y + _loc_2.parent.y;
                _loc_2 = _loc_2.parent;
            }
            return _loc_3;
        }// end function

        protected function destroy(param1:DisplayObjectContainer) : void
        {
            var _loc_2:* = null;
            if (!param1 || param1 is MovieClip && MovieClip(param1).totalFrames > 1)
            {
                return;
            }
            var _loc_3:* = 0;
            var _loc_4:* = param1.numChildren;
            while (param1.numChildren)
            {
                
                _loc_2 = param1.removeChildAt(0);
                if (_loc_2 is TiphonSprite)
                {
                    (_loc_2 as TiphonSprite).destroy();
                    continue;
                }
                if (_loc_2 is GraphicContainer)
                {
                    (_loc_2 as GraphicContainer).remove();
                }
                if (_loc_2 is DisplayObjectContainer)
                {
                    this.destroy(_loc_2 as DisplayObjectContainer);
                }
            }
            return;
        }// end function

        public function free() : void
        {
            this.__width = 0;
            this.__widthReal = 0;
            this.__height = 0;
            this.__heightReal = 0;
            this.__removed = false;
            this._bgColor = -1;
            this._bgAlpha = 1;
            this.minSize = null;
            this.maxSize = null;
            this._scale = 1;
            this._sLinkedTo = null;
            this._bDisabled = false;
            this._shadow = null;
            this._luminosity = 1;
            this._bgCornerRadius = 0;
            this._nMouseX = 0;
            this._nMouseY = 0;
            this._nStartWidth = 0;
            this._nStartHeight = 0;
            this._nLastWidth = 0;
            this._nLastHeight = 0;
            this._shResizeBorder = null;
            this._bUseSimpleResize = false;
            this._uiRootContainer = null;
            return;
        }// end function

        override public function contains(param1:DisplayObject) : Boolean
        {
            return super.contains(param1);
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var e:* = event;
            var w:* = this._nStartWidth + StageShareManager.mouseX - this._nMouseX;
            var h:* = this._nStartHeight + StageShareManager.mouseY - this._nMouseY;
            if (this.minSize != null)
            {
                if (!isNaN(this.minSize.x) && w < this.minSize.x)
                {
                    w = this.minSize.x;
                }
                if (!isNaN(this.minSize.y) && h < this.minSize.y)
                {
                    h = this.minSize.y;
                }
            }
            if (this.maxSize != null)
            {
                if (!isNaN(this.maxSize.x) && w > this.maxSize.x)
                {
                    w = this.maxSize.x;
                }
                if (!isNaN(this.maxSize.y) && h > this.maxSize.y)
                {
                    h = this.maxSize.y;
                }
            }
            this.width = w;
            this.height = h;
            if (this._nLastWidth != this.width || this._nLastHeight != this.height)
            {
                if (this._bUseSimpleResize)
                {
                    this._shResizeBorder.graphics.clear();
                    this._shResizeBorder.graphics.beginFill(16777215, 0.05);
                    this._shResizeBorder.graphics.lineStyle(1, 0, 0.2);
                    this._shResizeBorder.graphics.drawRect(0, 0, this.width, this.height);
                    this._shResizeBorder.graphics.endFill();
                }
                else
                {
                    try
                    {
                        this.getUi().render();
                    }
                    catch (err:Error)
                    {
                    }
                }
                this._nLastWidth = this.width;
                this._nLastHeight = this.height;
            }
            return;
        }// end function

        protected function canProcessMessage(param1:Message) : Boolean
        {
            if (this._bSoftDisabled)
            {
                if (!(param1 is ItemRollOutMessage || param1 is ItemRollOverMessage || param1 is MouseOverMessage || param1 is MouseOutMessage))
                {
                    return false;
                }
            }
            return true;
        }// end function

    }
}
