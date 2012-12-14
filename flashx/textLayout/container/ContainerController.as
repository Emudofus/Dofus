package flashx.textLayout.container
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    public class ContainerController extends Object implements IInteractionEventHandler, ITextLayoutFormat, ISandboxSupport
    {
        private var _textFlowCache:TextFlow;
        private var _rootElement:ContainerFormattedElement;
        private var _absoluteStart:int;
        private var _textLength:int;
        private var _container:Sprite;
        private var _mouseEventManager:FlowElementMouseEventManager;
        protected var _computedFormat:TextLayoutFormat;
        private var _columnState:ColumnState;
        private var _compositionWidth:Number = 0;
        private var _compositionHeight:Number = 0;
        private var _measureWidth:Boolean;
        private var _measureHeight:Boolean;
        private var _contentLeft:Number;
        private var _contentTop:Number;
        private var _contentWidth:Number;
        private var _contentHeight:Number;
        private var _uncomposedTextLength:int;
        private var _finalParcelStart:int;
        private var _horizontalScrollPolicy:String;
        private var _verticalScrollPolicy:String;
        private var _xScroll:Number;
        private var _yScroll:Number;
        private var _minListenersAttached:Boolean = false;
        private var _allListenersAttached:Boolean = false;
        private var _selectListenersAttached:Boolean = false;
        var _mouseWheelListenerAttached:Boolean = false;
        private var _shapesInvalid:Boolean = false;
        private var _backgroundShape:Shape;
        private var _scrollTimer:Timer = null;
        protected var _hasScrollRect:Boolean;
        private var _linesInView:Array;
        private var _updateStart:int;
        private var _composedFloats:Array;
        private var _floatsInContainer:Array;
        private var _shapeChildren:Array;
        private var _format:FlowValueHolder;
        private var _containerRoot:DisplayObject;
        private var _transparentBGX:Number;
        private var _transparentBGY:Number;
        private var _transparentBGWidth:Number;
        private var _transparentBGHeight:Number;
        private var blinkTimer:Timer;
        private var blinkObject:DisplayObject;
        private var _selectionSprite:Sprite;
        private static var _containerControllerInitialFormat:ITextLayoutFormat = createContainerControllerInitialFormat();
        private static var scratchRectangle:Rectangle = new Rectangle();

        public function ContainerController(param1:Sprite, param2:Number = 100, param3:Number = 100)
        {
            this.initialize(param1, param2, param3);
            return;
        }// end function

        function get allListenersAttached() : Boolean
        {
            return this._allListenersAttached;
        }// end function

        function get hasScrollRect() : Boolean
        {
            return this._hasScrollRect;
        }// end function

        private function initialize(param1:Sprite, param2:Number, param3:Number) : void
        {
            this._container = param1;
            this._containerRoot = null;
            this._textLength = 0;
            this._absoluteStart = -1;
            this._columnState = new ColumnState(null, null, null, 0, 0);
            var _loc_4:* = 0;
            this._yScroll = 0;
            this._xScroll = _loc_4;
            var _loc_4:* = 0;
            this._contentHeight = 0;
            this._contentWidth = _loc_4;
            this._uncomposedTextLength = 0;
            this._container.doubleClickEnabled = true;
            var _loc_4:* = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue);
            this._verticalScrollPolicy = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue);
            this._horizontalScrollPolicy = _loc_4;
            this._hasScrollRect = false;
            this._shapeChildren = [];
            this._linesInView = [];
            this.setCompositionSize(param2, param3);
            this.format = _containerControllerInitialFormat;
            return;
        }// end function

        function get effectiveBlockProgression() : String
        {
            return this._rootElement ? (this._rootElement.computedFormat.blockProgression) : (BlockProgression.TB);
        }// end function

        function getContainerRoot() : DisplayObject
        {
            var x:int;
            if (this._containerRoot == null && this._container && this._container.stage)
            {
                try
                {
                    x = this._container.stage.numChildren;
                    this._containerRoot = this._container.stage;
                }
                catch (e:Error)
                {
                    _containerRoot = _container.root;
                }
            }
            return this._containerRoot;
        }// end function

        public function get flowComposer() : IFlowComposer
        {
            return this.textFlow ? (this.textFlow.flowComposer) : (null);
        }// end function

        function get shapesInvalid() : Boolean
        {
            return this._shapesInvalid;
        }// end function

        function set shapesInvalid(param1:Boolean) : void
        {
            this._shapesInvalid = param1;
            return;
        }// end function

        public function get columnState() : ColumnState
        {
            if (this._rootElement == null)
            {
                return null;
            }
            if (this._computedFormat == null)
            {
            }
            this._columnState.computeColumns();
            return this._columnState;
        }// end function

        public function get container() : Sprite
        {
            return this._container;
        }// end function

        public function get compositionWidth() : Number
        {
            return this._compositionWidth;
        }// end function

        public function get compositionHeight() : Number
        {
            return this._compositionHeight;
        }// end function

        function get measureWidth() : Boolean
        {
            return this._measureWidth;
        }// end function

        function get measureHeight() : Boolean
        {
            return this._measureHeight;
        }// end function

        public function setCompositionSize(param1:Number, param2:Number) : void
        {
            var _loc_3:* = !(this._compositionWidth == param1 || isNaN(this._compositionWidth) && isNaN(param1));
            var _loc_4:* = !(this._compositionHeight == param2 || isNaN(this._compositionHeight) && isNaN(param2));
            if (_loc_3 || _loc_4)
            {
                this._compositionHeight = param2;
                this._measureHeight = isNaN(this._compositionHeight);
                this._compositionWidth = param1;
                this._measureWidth = isNaN(this._compositionWidth);
                if (this._computedFormat)
                {
                    this.resetColumnState();
                }
                if (this.effectiveBlockProgression == BlockProgression.TB ? (_loc_3) : (_loc_4))
                {
                    if (this.textFlow && this._textLength)
                    {
                        this.textFlow.damage(this.absoluteStart, this._textLength, TextLineValidity.INVALID, false);
                    }
                }
                else
                {
                    this.invalidateContents();
                }
                this.attachTransparentBackgroundForHit(false);
            }
            return;
        }// end function

        public function get textFlow() : TextFlow
        {
            if (!this._textFlowCache && this._rootElement)
            {
                this._textFlowCache = this._rootElement.getTextFlow();
            }
            return this._textFlowCache;
        }// end function

        public function get rootElement() : ContainerFormattedElement
        {
            return this._rootElement;
        }// end function

        function setRootElement(param1:ContainerFormattedElement) : void
        {
            if (this._rootElement != param1)
            {
                if (this._mouseEventManager)
                {
                    this._mouseEventManager.stopHitTests();
                }
                if (!param1)
                {
                    this._mouseEventManager = null;
                }
                else if (!this._mouseEventManager)
                {
                    this._mouseEventManager = new FlowElementMouseEventManager(this.container, null);
                }
                this.clearCompositionResults();
                this.detachContainer();
                this._rootElement = param1;
                this._textFlowCache = null;
                this._textLength = 0;
                this._absoluteStart = -1;
                this.attachContainer();
                if (this._rootElement)
                {
                    this.formatChanged();
                }
                if (this._container && Configuration.playerEnablesSpicyFeatures)
                {
                    this._container["needsSoftKeyboard"] = this.interactionManager && this.interactionManager.editingMode == EditingMode.READ_WRITE;
                }
            }
            return;
        }// end function

        public function get interactionManager() : ISelectionManager
        {
            return this.textFlow ? (this.textFlow.interactionManager) : (null);
        }// end function

        function get uncomposedTextLength() : int
        {
            return this._uncomposedTextLength;
        }// end function

        function get finalParcelStart() : int
        {
            return this._finalParcelStart;
        }// end function

        function set finalParcelStart(param1:int) : void
        {
            this._finalParcelStart = param1;
            return;
        }// end function

        public function get absoluteStart() : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this._absoluteStart != -1)
            {
                return this._absoluteStart;
            }
            var _loc_1:* = 0;
            var _loc_2:* = this.flowComposer;
            if (_loc_2)
            {
                _loc_3 = _loc_2.getControllerIndex(this);
                if (_loc_3 != 0)
                {
                    _loc_4 = _loc_2.getControllerAt((_loc_3 - 1));
                    _loc_1 = _loc_4.absoluteStart + _loc_4.textLength;
                }
            }
            this._absoluteStart = _loc_1;
            return _loc_1;
        }// end function

        public function get textLength() : int
        {
            return this._textLength;
        }// end function

        function setTextLengthOnly(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this._textLength != param1)
            {
                this._textLength = param1;
                this._uncomposedTextLength = 0;
                if (this._absoluteStart != -1)
                {
                    _loc_2 = this.flowComposer;
                    if (_loc_2)
                    {
                        _loc_3 = _loc_2.getControllerIndex(this) + 1;
                        while (_loc_3 < this.flowComposer.numControllers)
                        {
                            
                            _loc_4 = _loc_2.getControllerAt(_loc_3++);
                            if (_loc_4._absoluteStart == -1)
                            {
                                break;
                            }
                            _loc_4._absoluteStart = -1;
                            _loc_4._uncomposedTextLength = 0;
                        }
                    }
                }
            }
            return;
        }// end function

        function setTextLength(param1:int) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = 0;
            if (this.textFlow)
            {
                _loc_3 = this.effectiveBlockProgression == BlockProgression.RL;
                _loc_4 = this.textFlow.flowComposer;
                if (param1 != 0 && _loc_4.getControllerIndex(this) == (_loc_4.numControllers - 1) && (!_loc_3 && this._verticalScrollPolicy != ScrollPolicy.OFF || _loc_3 && this._horizontalScrollPolicy != ScrollPolicy.OFF))
                {
                    _loc_5 = this.absoluteStart;
                    _loc_2 = this.textFlow.textLength - (param1 + _loc_5);
                    param1 = this.textFlow.textLength - _loc_5;
                }
            }
            this.setTextLengthOnly(param1);
            this._uncomposedTextLength = _loc_2;
            return;
        }// end function

        function updateLength(param1:int, param2:int) : void
        {
            this.setTextLengthOnly(this._textLength + param2);
            return;
        }// end function

        public function isDamaged() : Boolean
        {
            return this.flowComposer.isDamaged(this.absoluteStart + this._textLength);
        }// end function

        function formatChanged() : void
        {
            this._computedFormat = null;
            this.invalidateContents();
            return;
        }// end function

        function styleSelectorChanged() : void
        {
            this.modelChanged(ModelChange.STYLE_SELECTOR_CHANGED, this, 0, this._textLength);
            this._computedFormat = null;
            return;
        }// end function

        function modelChanged(param1:String, param2:ContainerController, param3:int, param4:int, param5:Boolean = true, param6:Boolean = true) : void
        {
            var _loc_7:* = this._rootElement.getTextFlow();
            if (this._rootElement.getTextFlow())
            {
                _loc_7.processModelChanged(param1, param2, this.absoluteStart + param3, param4, param5, param6);
            }
            return;
        }// end function

        private function gatherVisibleLines(param1:String, param2:Boolean) : void
        {
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_3:* = this._measureWidth ? (this._contentWidth) : (this._compositionWidth);
            var _loc_4:* = this._measureHeight ? (this._contentHeight) : (this._compositionHeight);
            var _loc_5:* = param1 == BlockProgression.RL ? (this._xScroll - _loc_3) : (this._xScroll);
            var _loc_6:* = this._yScroll;
            var _loc_7:* = Twips.roundTo(_loc_5);
            var _loc_8:* = Twips.roundTo(_loc_6);
            var _loc_9:* = Twips.to(_loc_3);
            var _loc_10:* = Twips.to(_loc_4);
            var _loc_11:* = this.flowComposer;
            var _loc_12:* = this.flowComposer.findLineIndexAtPosition(this.absoluteStart);
            var _loc_13:* = _loc_11.findLineIndexAtPosition(this.absoluteStart + this._textLength - 1);
            var _loc_14:* = _loc_12;
            while (_loc_14 <= _loc_13)
            {
                
                _loc_15 = _loc_11.getLineAt(_loc_14);
                if (_loc_15 == null || _loc_15.controller != this)
                {
                }
                else
                {
                    _loc_16 = this.isLineVisible(param1, _loc_7, _loc_8, _loc_9, _loc_10, _loc_15, null);
                    if (_loc_16)
                    {
                        if (param2)
                        {
                            _loc_15.createShape(param1, _loc_16);
                        }
                        this._linesInView.push(_loc_16);
                    }
                }
                _loc_14++;
            }
            this._updateStart = this.absoluteStart;
            return;
        }// end function

        function fillShapeChildren() : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            if (this._textLength == 0)
            {
                return;
            }
            var _loc_1:* = this.effectiveBlockProgression;
            if (this._linesInView.length == 0)
            {
                this.gatherVisibleLines(_loc_1, true);
            }
            var _loc_2:* = _loc_1 == BlockProgression.RL && (this._horizontalScrollPolicy == ScrollPolicy.OFF && this._verticalScrollPolicy == ScrollPolicy.OFF);
            if (_loc_2)
            {
                _loc_3 = this._measureWidth ? (this._contentWidth) : (this._compositionWidth);
                _loc_4 = this._measureHeight ? (this._contentHeight) : (this._compositionHeight);
                _loc_5 = this._xScroll - _loc_3;
                _loc_6 = this._yScroll;
                if (_loc_5 != 0 || _loc_6 != 0)
                {
                    for each (_loc_7 in this._linesInView)
                    {
                        
                        if (!_loc_7)
                        {
                            continue;
                        }
                        if (_loc_2)
                        {
                            _loc_7.x = _loc_7.x - _loc_5;
                            _loc_7.y = _loc_7.y - _loc_6;
                        }
                    }
                    this._contentLeft = this._contentLeft - _loc_5;
                    this._contentTop = this._contentTop - _loc_6;
                }
            }
            return;
        }// end function

        public function get horizontalScrollPolicy() : String
        {
            return this._horizontalScrollPolicy;
        }// end function

        public function set horizontalScrollPolicy(param1:String) : void
        {
            var _loc_2:* = ScrollPolicy.scrollPolicyPropertyDefinition.setHelper(this._horizontalScrollPolicy, param1) as String;
            if (_loc_2 != this._horizontalScrollPolicy)
            {
                this._horizontalScrollPolicy = _loc_2;
                if (this._horizontalScrollPolicy == ScrollPolicy.OFF)
                {
                    this.horizontalScrollPosition = 0;
                }
                this.formatChanged();
            }
            return;
        }// end function

        function checkScrollBounds() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = false;
            if (this.effectiveBlockProgression == BlockProgression.RL)
            {
                _loc_1 = this._contentWidth;
                _loc_2 = this.compositionWidth;
                _loc_3 = this._measureWidth;
            }
            else
            {
                _loc_1 = this._contentHeight;
                _loc_2 = this.compositionHeight;
                _loc_3 = this._measureHeight;
            }
            if (this.textFlow && this._container && !this._minListenersAttached)
            {
                _loc_4 = !_loc_3 && _loc_1 > _loc_2;
                if (_loc_4 != this._mouseWheelListenerAttached)
                {
                    if (this._mouseWheelListenerAttached)
                    {
                        this.removeMouseWheelListener();
                    }
                    else
                    {
                        this.addMouseWheelListener();
                    }
                }
            }
            return;
        }// end function

        public function get verticalScrollPolicy() : String
        {
            return this._verticalScrollPolicy;
        }// end function

        public function set verticalScrollPolicy(param1:String) : void
        {
            var _loc_2:* = ScrollPolicy.scrollPolicyPropertyDefinition.setHelper(this._verticalScrollPolicy, param1) as String;
            if (_loc_2 != this._verticalScrollPolicy)
            {
                this._verticalScrollPolicy = _loc_2;
                if (this._verticalScrollPolicy == ScrollPolicy.OFF)
                {
                    this.verticalScrollPosition = 0;
                }
                this.formatChanged();
            }
            return;
        }// end function

        public function get horizontalScrollPosition() : Number
        {
            return this._xScroll;
        }// end function

        public function set horizontalScrollPosition(param1:Number) : void
        {
            if (!this._rootElement)
            {
                return;
            }
            if (this._horizontalScrollPolicy == ScrollPolicy.OFF)
            {
                this._xScroll = 0;
                return;
            }
            var _loc_2:* = this._xScroll;
            var _loc_3:* = this.computeHorizontalScrollPosition(param1, true);
            if (_loc_3 != _loc_2)
            {
                this._shapesInvalid = true;
                this._xScroll = _loc_3;
                this.updateForScroll(ScrollEventDirection.HORIZONTAL, _loc_3 - _loc_2);
            }
            return;
        }// end function

        private function computeHorizontalScrollPosition(param1:Number, param2:Boolean) : Number
        {
            var _loc_3:* = this.effectiveBlockProgression;
            var _loc_4:* = this.contentWidth;
            var _loc_5:* = 0;
            if (_loc_4 > this._compositionWidth && !this._measureWidth)
            {
                if (_loc_3 == BlockProgression.RL)
                {
                    _loc_5 = pinValue(param1, this._contentLeft + this._compositionWidth, this._contentLeft + _loc_4);
                    if (param2 && this._uncomposedTextLength != 0 && _loc_5 != this._xScroll)
                    {
                        this._xScroll = param1;
                        if (this._xScroll > this._contentLeft + this._contentWidth)
                        {
                            this._xScroll = this._contentLeft + this._contentWidth;
                        }
                        this.flowComposer.composeToController(this.flowComposer.getControllerIndex(this));
                        _loc_5 = pinValue(param1, this._contentLeft + this._compositionWidth, this._contentLeft + this._contentWidth);
                    }
                }
                else
                {
                    _loc_5 = pinValue(param1, this._contentLeft, this._contentLeft + _loc_4 - this._compositionWidth);
                }
            }
            return _loc_5;
        }// end function

        public function get verticalScrollPosition() : Number
        {
            return this._yScroll;
        }// end function

        public function set verticalScrollPosition(param1:Number) : void
        {
            if (!this._rootElement)
            {
                return;
            }
            if (this._verticalScrollPolicy == ScrollPolicy.OFF)
            {
                this._yScroll = 0;
                return;
            }
            var _loc_2:* = this._yScroll;
            var _loc_3:* = this.computeVerticalScrollPosition(param1, true);
            if (_loc_3 != _loc_2)
            {
                this._shapesInvalid = true;
                this._yScroll = _loc_3;
                this.updateForScroll(ScrollEventDirection.VERTICAL, _loc_3 - _loc_2);
            }
            return;
        }// end function

        private function computeVerticalScrollPosition(param1:Number, param2:Boolean) : Number
        {
            var _loc_3:* = 0;
            var _loc_4:* = this.contentHeight;
            var _loc_5:* = this.effectiveBlockProgression;
            if (_loc_4 > this._compositionHeight)
            {
                _loc_3 = pinValue(param1, this._contentTop, this._contentTop + (_loc_4 - this._compositionHeight));
                if (param2 && this._uncomposedTextLength != 0 && _loc_5 == BlockProgression.TB)
                {
                    this._yScroll = param1;
                    if (this._yScroll < this._contentTop)
                    {
                        this._yScroll = this._contentTop;
                    }
                    this.flowComposer.composeToController(this.flowComposer.getControllerIndex(this));
                    _loc_3 = pinValue(param1, this._contentTop, this._contentTop + (_loc_4 - this._compositionHeight));
                }
            }
            return _loc_3;
        }// end function

        public function getContentBounds() : Rectangle
        {
            return new Rectangle(this._contentLeft, this._contentTop, this.contentWidth, this.contentHeight);
        }// end function

        function get contentLeft() : Number
        {
            return this._contentLeft;
        }// end function

        function get contentTop() : Number
        {
            return this._contentTop;
        }// end function

        function computeScaledContentMeasure(param1:Number) : Number
        {
            var _loc_2:* = this.textFlow.textLength - this._finalParcelStart;
            var _loc_3:* = _loc_2 / (_loc_2 - this._uncomposedTextLength);
            return param1 * _loc_3;
        }// end function

        function get contentHeight() : Number
        {
            if (this._uncomposedTextLength == 0 || this.effectiveBlockProgression != BlockProgression.TB)
            {
                return this._contentHeight;
            }
            return this.computeScaledContentMeasure(this._contentHeight);
        }// end function

        function get contentWidth() : Number
        {
            if (this._uncomposedTextLength == 0 || this.effectiveBlockProgression != BlockProgression.RL)
            {
                return this._contentWidth;
            }
            return this.computeScaledContentMeasure(this._contentWidth);
        }// end function

        function setContentBounds(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this._contentWidth = param3;
            this._contentHeight = param4;
            this._contentLeft = param1;
            this._contentTop = param2;
            this.checkScrollBounds();
            return;
        }// end function

        private function updateForScroll(param1:String, param2:Number) : void
        {
            this._linesInView.length = 0;
            var _loc_3:* = this.textFlow.flowComposer;
            _loc_3.updateToController(_loc_3.getControllerIndex(this));
            this.attachTransparentBackgroundForHit(false);
            if (this.textFlow.hasEventListener(TextLayoutEvent.SCROLL))
            {
                this.textFlow.dispatchEvent(new ScrollEvent(TextLayoutEvent.SCROLL, false, false, param1, param2));
            }
            return;
        }// end function

        private function get containerScrollRectLeft() : Number
        {
            var _loc_1:* = NaN;
            if (this.horizontalScrollPolicy == ScrollPolicy.OFF && this.verticalScrollPolicy == ScrollPolicy.OFF)
            {
                _loc_1 = 0;
            }
            else
            {
                _loc_1 = this.effectiveBlockProgression == BlockProgression.RL ? (this.horizontalScrollPosition - this.compositionWidth) : (this.horizontalScrollPosition);
            }
            return _loc_1;
        }// end function

        private function get containerScrollRectRight() : Number
        {
            var _loc_1:* = this.containerScrollRectLeft + this.compositionWidth;
            return _loc_1;
        }// end function

        private function get containerScrollRectTop() : Number
        {
            var _loc_1:* = NaN;
            if (this.horizontalScrollPolicy == ScrollPolicy.OFF && this.verticalScrollPolicy == ScrollPolicy.OFF)
            {
                _loc_1 = 0;
            }
            else
            {
                _loc_1 = this.verticalScrollPosition;
            }
            return _loc_1;
        }// end function

        private function get containerScrollRectBottom() : Number
        {
            var _loc_1:* = this.containerScrollRectTop + this.compositionHeight;
            return _loc_1;
        }// end function

        public function scrollToRange(param1:int, param2:int) : void
        {
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = false;
            if (!this._hasScrollRect || !this.flowComposer || this.flowComposer.getControllerAt((this.flowComposer.numControllers - 1)) != this)
            {
                return;
            }
            var _loc_3:* = this.absoluteStart;
            var _loc_4:* = Math.min(_loc_3 + this._textLength, (this.textFlow.textLength - 1));
            param1 = Math.max(_loc_3, Math.min(param1, _loc_4));
            param2 = Math.max(_loc_3, Math.min(param2, _loc_4));
            var _loc_5:* = this.effectiveBlockProgression == BlockProgression.RL;
            var _loc_6:* = Math.min(param1, param2);
            var _loc_7:* = Math.max(param1, param2);
            var _loc_8:* = this.flowComposer.findLineIndexAtPosition(_loc_6, _loc_6 == this.textFlow.textLength);
            var _loc_9:* = this.flowComposer.findLineIndexAtPosition(_loc_7, _loc_7 == this.textFlow.textLength);
            var _loc_10:* = this.containerScrollRectLeft;
            var _loc_11:* = this.containerScrollRectTop;
            var _loc_12:* = this.containerScrollRectRight;
            var _loc_13:* = this.containerScrollRectBottom;
            if (this.flowComposer.damageAbsoluteStart <= _loc_7)
            {
                _loc_7 = Math.min(_loc_6 + 100, (_loc_7 + 1));
                this.flowComposer.composeToPosition(_loc_7);
                _loc_8 = this.flowComposer.findLineIndexAtPosition(_loc_6, _loc_6 == this.textFlow.textLength);
                _loc_9 = this.flowComposer.findLineIndexAtPosition(_loc_7, _loc_7 == this.textFlow.textLength);
            }
            var _loc_14:* = this.rangeToRectangle(_loc_6, _loc_7, _loc_8, _loc_9);
            if (this.rangeToRectangle(_loc_6, _loc_7, _loc_8, _loc_9))
            {
                if (_loc_5)
                {
                    _loc_16 = _loc_14.left < _loc_10 || _loc_14.right > _loc_10;
                    if (_loc_16)
                    {
                        if (_loc_14.left < _loc_10)
                        {
                            this.horizontalScrollPosition = _loc_14.left + this._compositionWidth;
                        }
                        if (_loc_14.right > _loc_12)
                        {
                            this.horizontalScrollPosition = _loc_14.right;
                        }
                    }
                    if (_loc_14.top < _loc_11)
                    {
                        this.verticalScrollPosition = _loc_14.top;
                    }
                    if (param1 == param2)
                    {
                        _loc_14.bottom = _loc_14.bottom + 2;
                    }
                    if (_loc_14.bottom > _loc_13)
                    {
                        this.verticalScrollPosition = _loc_14.bottom - this._compositionHeight;
                    }
                }
                else
                {
                    _loc_17 = _loc_14.top > _loc_11 || _loc_14.bottom < _loc_13;
                    if (_loc_17)
                    {
                        if (_loc_14.top < _loc_11)
                        {
                            this.verticalScrollPosition = _loc_14.top;
                        }
                        if (_loc_14.bottom > _loc_13)
                        {
                            this.verticalScrollPosition = _loc_14.bottom - this._compositionHeight;
                        }
                    }
                    if (param1 == param2)
                    {
                        _loc_14.right = _loc_14.right + 2;
                    }
                    _loc_16 = _loc_14.left > _loc_10 || _loc_14.right < _loc_12;
                    if (_loc_16 && _loc_14.left < _loc_10)
                    {
                        this.horizontalScrollPosition = _loc_14.left - this._compositionWidth / 2;
                    }
                    if (_loc_16 && _loc_14.right > _loc_12)
                    {
                        this.horizontalScrollPosition = _loc_14.right - this._compositionWidth / 2;
                    }
                }
            }
            return;
        }// end function

        private function rangeToRectangle(param1:int, param2:int, param3:int, param4:int) : Rectangle
        {
            var _loc_5:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_6:* = this.effectiveBlockProgression;
            var _loc_7:* = this.textFlow.flowComposer;
            if (!this.container || !_loc_7)
            {
                return null;
            }
            if (param3 == param4)
            {
                _loc_8 = _loc_7.getLineAt(param3);
                if (_loc_8.isDamaged())
                {
                    return null;
                }
                _loc_9 = _loc_8.getTextLine(true);
                _loc_10 = _loc_8.paragraph.getAbsoluteStart();
                _loc_11 = false;
                if (_loc_6 == BlockProgression.RL)
                {
                    _loc_14 = this._rootElement.getTextFlow().findLeaf(param1);
                    _loc_11 = _loc_14.getParentByType(TCYElement) != null;
                }
                _loc_12 = _loc_9.atomCount;
                _loc_13 = 0;
                if (param1 == param2)
                {
                    _loc_12 = _loc_9.getAtomIndexAtCharIndex(param1 - _loc_10);
                    _loc_13 = _loc_12;
                }
                else
                {
                    _loc_16 = param2 - _loc_10;
                    _loc_17 = param1 - _loc_10;
                    while (_loc_17 < _loc_16)
                    {
                        
                        _loc_15 = _loc_9.getAtomIndexAtCharIndex(_loc_17);
                        if (_loc_15 < _loc_12)
                        {
                            _loc_12 = _loc_15;
                        }
                        if (_loc_15 > _loc_13)
                        {
                            _loc_13 = _loc_15;
                        }
                        _loc_17++;
                    }
                }
                _loc_5 = this.atomToRectangle(_loc_12, _loc_8, _loc_9, _loc_6, _loc_11);
                if (_loc_12 != _loc_13)
                {
                    _loc_5 = _loc_5.union(this.atomToRectangle(_loc_13, _loc_8, _loc_9, _loc_6, _loc_11));
                }
            }
            else
            {
                _loc_5 = new Rectangle(this._contentLeft, this._contentTop, this._contentWidth, this._contentHeight);
                _loc_18 = _loc_7.getLineAt(param3);
                _loc_19 = _loc_7.getLineAt(param4);
                if (_loc_6 == BlockProgression.TB)
                {
                    _loc_5.top = _loc_18.y;
                    _loc_5.bottom = _loc_19.y + _loc_19.textHeight;
                }
                else
                {
                    _loc_5.right = _loc_18.x + _loc_18.textHeight;
                    _loc_5.left = _loc_19.x;
                }
            }
            return _loc_5;
        }// end function

        private function atomToRectangle(param1:int, param2:TextFlowLine, param3:TextLine, param4:String, param5:Boolean) : Rectangle
        {
            var _loc_6:* = null;
            if (param1 > -1)
            {
                _loc_6 = param3.getAtomBounds(param1);
            }
            if (param4 == BlockProgression.RL)
            {
                if (param5)
                {
                    return new Rectangle(param2.x + _loc_6.x, param2.y + _loc_6.y, _loc_6.width, _loc_6.height);
                }
                return new Rectangle(param2.x, param2.y + _loc_6.y, param2.height, _loc_6.height);
            }
            return new Rectangle(param2.x + _loc_6.x, param2.y - param2.height + param2.ascent, _loc_6.width, param2.height + param3.descent);
        }// end function

        function resetColumnState() : void
        {
            if (this._rootElement)
            {
                this._columnState.updateInputs(this.effectiveBlockProgression, this._rootElement.computedFormat.direction, this, this._compositionWidth, this._compositionHeight);
            }
            return;
        }// end function

        public function invalidateContents() : void
        {
            if (this.textFlow)
            {
                this.textFlow.damage(this.absoluteStart, Math.min(this._textLength, 1), FlowDamageType.GEOMETRY, false);
            }
            return;
        }// end function

        function attachTransparentBackgroundForHit(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = false;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if ((this._minListenersAttached || this._mouseWheelListenerAttached) && this.attachTransparentBackground)
            {
                _loc_2 = this._container;
                if (_loc_2)
                {
                    if (param1)
                    {
                        _loc_2.graphics.clear();
                        var _loc_8:* = NaN;
                        this._transparentBGHeight = NaN;
                        this._transparentBGWidth = _loc_8;
                        this._transparentBGY = _loc_8;
                        this._transparentBGX = _loc_8;
                    }
                    else
                    {
                        _loc_3 = this._measureWidth ? (this._contentWidth) : (this._compositionWidth);
                        _loc_4 = this._measureHeight ? (this._contentHeight) : (this._compositionHeight);
                        _loc_5 = this.effectiveBlockProgression == BlockProgression.RL && this._horizontalScrollPolicy != ScrollPolicy.OFF;
                        _loc_6 = _loc_5 ? (this._xScroll - _loc_3) : (this._xScroll);
                        _loc_7 = this._yScroll;
                        if (_loc_6 != this._transparentBGX || _loc_7 != this._transparentBGY || _loc_3 != this._transparentBGWidth || _loc_4 != this._transparentBGHeight)
                        {
                            _loc_2.graphics.clear();
                            if (_loc_3 != 0 && _loc_4 != 0)
                            {
                                _loc_2.graphics.beginFill(0, 0);
                                _loc_2.graphics.drawRect(_loc_6, _loc_7, _loc_3, _loc_4);
                                _loc_2.graphics.endFill();
                            }
                            this._transparentBGX = _loc_6;
                            this._transparentBGY = _loc_7;
                            this._transparentBGWidth = _loc_3;
                            this._transparentBGHeight = _loc_4;
                        }
                    }
                }
            }
            return;
        }// end function

        function interactionManagerChanged(param1:ISelectionManager) : void
        {
            if (!param1)
            {
                this.detachContainer();
            }
            this.attachContainer();
            this.checkScrollBounds();
            if (this._mouseEventManager)
            {
                this._mouseEventManager.needsCtrlKey = this.interactionManager != null && this.interactionManager.editingMode == EditingMode.READ_WRITE;
            }
            if (this._container && Configuration.playerEnablesSpicyFeatures)
            {
                this._container["needsSoftKeyboard"] = this.interactionManager && this.interactionManager.editingMode == EditingMode.READ_WRITE;
            }
            return;
        }// end function

        function attachContainer() : void
        {
            if (!this._minListenersAttached && this.textFlow && this.textFlow.interactionManager)
            {
                this._minListenersAttached = true;
                if (this._container)
                {
                    this._container.addEventListener(FocusEvent.FOCUS_IN, this.requiredFocusInHandler);
                    this._container.addEventListener(MouseEvent.MOUSE_OVER, this.requiredMouseOverHandler);
                    this.attachTransparentBackgroundForHit(false);
                    if (this._container.stage && this._container.stage.focus == this._container)
                    {
                        this.attachAllListeners();
                    }
                }
            }
            return;
        }// end function

        function attachInteractionHandlers() : void
        {
            var _loc_1:* = this.getInteractionHandler();
            this._container.addEventListener(MouseEvent.MOUSE_DOWN, this.requiredMouseDownHandler);
            this._container.addEventListener(FocusEvent.FOCUS_OUT, this.requiredFocusOutHandler);
            this._container.addEventListener(MouseEvent.DOUBLE_CLICK, _loc_1.mouseDoubleClickHandler);
            this._container.addEventListener(Event.ACTIVATE, _loc_1.activateHandler);
            this._container.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, _loc_1.focusChangeHandler);
            this._container.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, _loc_1.focusChangeHandler);
            this._container.addEventListener(TextEvent.TEXT_INPUT, _loc_1.textInputHandler);
            this._container.addEventListener(MouseEvent.MOUSE_OUT, _loc_1.mouseOutHandler);
            this.addMouseWheelListener();
            this._container.addEventListener(Event.DEACTIVATE, _loc_1.deactivateHandler);
            this._container.addEventListener("imeStartComposition", _loc_1.imeStartCompositionHandler);
            if (this._container.contextMenu)
            {
                this._container.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, _loc_1.menuSelectHandler);
            }
            this._container.addEventListener(Event.COPY, _loc_1.editHandler);
            this._container.addEventListener(Event.SELECT_ALL, _loc_1.editHandler);
            this._container.addEventListener(Event.CUT, _loc_1.editHandler);
            this._container.addEventListener(Event.PASTE, _loc_1.editHandler);
            this._container.addEventListener(Event.CLEAR, _loc_1.editHandler);
            return;
        }// end function

        function removeInteractionHandlers() : void
        {
            var _loc_1:* = this.getInteractionHandler();
            this._container.removeEventListener(MouseEvent.MOUSE_DOWN, this.requiredMouseDownHandler);
            this._container.removeEventListener(FocusEvent.FOCUS_OUT, this.requiredFocusOutHandler);
            this._container.removeEventListener(MouseEvent.DOUBLE_CLICK, _loc_1.mouseDoubleClickHandler);
            this._container.removeEventListener(Event.ACTIVATE, _loc_1.activateHandler);
            this._container.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, _loc_1.focusChangeHandler);
            this._container.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, _loc_1.focusChangeHandler);
            this._container.removeEventListener(TextEvent.TEXT_INPUT, _loc_1.textInputHandler);
            this._container.removeEventListener(MouseEvent.MOUSE_OUT, _loc_1.mouseOutHandler);
            this.removeMouseWheelListener();
            this._container.removeEventListener(Event.DEACTIVATE, _loc_1.deactivateHandler);
            this._container.removeEventListener("imeStartComposition", _loc_1.imeStartCompositionHandler);
            if (this._container.contextMenu)
            {
                this._container.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT, _loc_1.menuSelectHandler);
            }
            this._container.removeEventListener(Event.COPY, _loc_1.editHandler);
            this._container.removeEventListener(Event.SELECT_ALL, _loc_1.editHandler);
            this._container.removeEventListener(Event.CUT, _loc_1.editHandler);
            this._container.removeEventListener(Event.PASTE, _loc_1.editHandler);
            this._container.removeEventListener(Event.CLEAR, _loc_1.editHandler);
            this.clearSelectHandlers();
            return;
        }// end function

        private function detachContainer() : void
        {
            if (this._minListenersAttached)
            {
                if (this._container)
                {
                    this._container.removeEventListener(FocusEvent.FOCUS_IN, this.requiredFocusInHandler);
                    this._container.removeEventListener(MouseEvent.MOUSE_OVER, this.requiredMouseOverHandler);
                    if (this._allListenersAttached)
                    {
                        this.removeInteractionHandlers();
                        this.removeContextMenu();
                        this.attachTransparentBackgroundForHit(true);
                        this._allListenersAttached = false;
                    }
                }
                this._minListenersAttached = false;
            }
            this.removeMouseWheelListener();
            return;
        }// end function

        private function attachAllListeners() : void
        {
            if (!this._allListenersAttached && this.textFlow && this.textFlow.interactionManager)
            {
                this._allListenersAttached = true;
                if (this._container)
                {
                    this.attachContextMenu();
                    this.attachInteractionHandlers();
                }
            }
            return;
        }// end function

        function addMouseWheelListener() : void
        {
            if (!this._mouseWheelListenerAttached)
            {
                this._container.addEventListener(MouseEvent.MOUSE_WHEEL, this.getInteractionHandler().mouseWheelHandler);
                this._mouseWheelListenerAttached = true;
            }
            return;
        }// end function

        function removeMouseWheelListener() : void
        {
            if (this._mouseWheelListenerAttached)
            {
                this._container.removeEventListener(MouseEvent.MOUSE_WHEEL, this.getInteractionHandler().mouseWheelHandler);
                this._mouseWheelListenerAttached = false;
            }
            return;
        }// end function

        function attachContextMenu() : void
        {
            this._container.contextMenu = this.createContextMenu();
            return;
        }// end function

        function removeContextMenu() : void
        {
            this._container.contextMenu = null;
            return;
        }// end function

        protected function createContextMenu() : ContextMenu
        {
            return createDefaultContextMenu();
        }// end function

        function scrollTimerHandler(event:Event) : void
        {
            var containerPoint:Point;
            var scrollChange:int;
            var mouseEvent:MouseEvent;
            var stashedScrollTimer:Timer;
            var event:* = event;
            if (!this._scrollTimer)
            {
                return;
            }
            if (this.textFlow.interactionManager == null || this.textFlow.interactionManager.activePosition < this.absoluteStart || this.textFlow.interactionManager.activePosition > this.absoluteStart + this.textLength)
            {
                event;
            }
            if (event is MouseEvent)
            {
                this._scrollTimer.stop();
                this._scrollTimer.removeEventListener(TimerEvent.TIMER, this.scrollTimerHandler);
                event.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, this.scrollTimerHandler);
                this._scrollTimer = null;
            }
            else if (!event)
            {
                this._scrollTimer.stop();
                this._scrollTimer.removeEventListener(TimerEvent.TIMER, this.scrollTimerHandler);
                if (this.getContainerRoot())
                {
                    this.getContainerRoot().removeEventListener(MouseEvent.MOUSE_UP, this.scrollTimerHandler);
                }
                this._scrollTimer = null;
            }
            else if (this._container.stage)
            {
                containerPoint = new Point(this._container.stage.mouseX, this._container.stage.mouseY);
                containerPoint = this._container.globalToLocal(containerPoint);
                scrollChange = this.autoScrollIfNecessaryInternal(containerPoint);
                if (scrollChange != 0 && this.interactionManager)
                {
                    mouseEvent = new PsuedoMouseEvent(MouseEvent.MOUSE_MOVE, false, false, this._container.stage.mouseX, this._container.stage.mouseY, this._container.stage, false, false, false, true);
                    stashedScrollTimer = this._scrollTimer;
                    try
                    {
                        this._scrollTimer = null;
                        this.interactionManager.mouseMoveHandler(mouseEvent);
                    }
                    catch (e:Error)
                    {
                        throw e;
                    }
                    finally
                    {
                        this._scrollTimer = stashedScrollTimer;
                    }
                }
            }
            return;
        }// end function

        public function autoScrollIfNecessary(param1:int, param2:int) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.flowComposer.getControllerAt((this.flowComposer.numControllers - 1)) != this)
            {
                _loc_4 = this.effectiveBlockProgression == BlockProgression.RL;
                _loc_5 = this.flowComposer.getControllerAt((this.flowComposer.numControllers - 1));
                if (_loc_4 && this._horizontalScrollPolicy == ScrollPolicy.OFF || !_loc_4 && this._verticalScrollPolicy == ScrollPolicy.OFF)
                {
                    return;
                }
                _loc_6 = _loc_5.container.getBounds(this._container.stage);
                if (_loc_4)
                {
                    if (param2 >= _loc_6.top && param2 <= _loc_6.bottom)
                    {
                        _loc_5.autoScrollIfNecessary(param1, param2);
                    }
                }
                else if (param1 >= _loc_6.left && param1 <= _loc_6.right)
                {
                    _loc_5.autoScrollIfNecessary(param1, param2);
                }
            }
            if (!this._hasScrollRect)
            {
                return;
            }
            var _loc_3:* = new Point(param1, param2);
            _loc_3 = this._container.globalToLocal(_loc_3);
            this.autoScrollIfNecessaryInternal(_loc_3);
            return;
        }// end function

        private function autoScrollIfNecessaryInternal(param1:Point) : int
        {
            var _loc_2:* = 0;
            if (param1.y - this.containerScrollRectBottom > 0)
            {
                this.verticalScrollPosition = this.verticalScrollPosition + this.textFlow.configuration.scrollDragPixels;
                _loc_2 = 1;
            }
            else if (param1.y - this.containerScrollRectTop < 0)
            {
                this.verticalScrollPosition = this.verticalScrollPosition - this.textFlow.configuration.scrollDragPixels;
                _loc_2 = -1;
            }
            if (param1.x - this.containerScrollRectRight > 0)
            {
                this.horizontalScrollPosition = this.horizontalScrollPosition + this.textFlow.configuration.scrollDragPixels;
                _loc_2 = -1;
            }
            else if (param1.x - this.containerScrollRectLeft < 0)
            {
                this.horizontalScrollPosition = this.horizontalScrollPosition - this.textFlow.configuration.scrollDragPixels;
                _loc_2 = 1;
            }
            if (_loc_2 != 0 && !this._scrollTimer)
            {
                this._scrollTimer = new Timer(this.textFlow.configuration.scrollDragDelay);
                this._scrollTimer.addEventListener(TimerEvent.TIMER, this.scrollTimerHandler, false, 0, true);
                if (this.getContainerRoot())
                {
                    this.getContainerRoot().addEventListener(MouseEvent.MOUSE_UP, this.scrollTimerHandler, false, 0, true);
                    this.beginMouseCapture();
                }
                this._scrollTimer.start();
            }
            return _loc_2;
        }// end function

        function getFirstVisibleLine() : TextFlowLine
        {
            return this._shapeChildren.length ? (this._shapeChildren[0].userData) : (null);
        }// end function

        function getLastVisibleLine() : TextFlowLine
        {
            return this._shapeChildren.length ? (this._shapeChildren[(this._shapeChildren.length - 1)].userData) : (null);
        }// end function

        public function getScrollDelta(param1:int) : Number
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_2:* = this.textFlow.flowComposer;
            if (_loc_2.numLines == 0)
            {
                return 0;
            }
            var _loc_3:* = this.getFirstVisibleLine();
            if (!_loc_3)
            {
                return 0;
            }
            var _loc_4:* = this.getLastVisibleLine();
            if (param1 > 0)
            {
                _loc_6 = _loc_2.findLineIndexAtPosition(_loc_4.absoluteStart);
                _loc_10 = _loc_4.getTextLine(true);
                if (this.effectiveBlockProgression == BlockProgression.TB)
                {
                    if (_loc_10.y + _loc_10.descent - this.containerScrollRectBottom > 2)
                    {
                        _loc_6 = _loc_6 - 1;
                    }
                }
                else if (this.containerScrollRectLeft - (_loc_10.x - _loc_10.descent) > 2)
                {
                    _loc_6 = _loc_6 - 1;
                }
                while (_loc_6 + param1 > (_loc_2.numLines - 1) && _loc_2.damageAbsoluteStart < this.textFlow.textLength)
                {
                    
                    _loc_11 = _loc_2.damageAbsoluteStart;
                    _loc_2.composeToPosition(_loc_2.damageAbsoluteStart + 1000);
                    if (_loc_2.damageAbsoluteStart == _loc_11)
                    {
                        return 0;
                    }
                }
                _loc_5 = Math.min((_loc_2.numLines - 1), _loc_6 + param1);
            }
            if (param1 < 0)
            {
                _loc_6 = _loc_2.findLineIndexAtPosition(_loc_3.absoluteStart);
                if (this.effectiveBlockProgression == BlockProgression.TB)
                {
                    if (_loc_3.y + 2 < this.containerScrollRectTop)
                    {
                        _loc_6++;
                    }
                }
                else if (_loc_3.x + _loc_3.ascent > this.containerScrollRectRight + 2)
                {
                    _loc_6++;
                }
                _loc_5 = Math.max(0, _loc_6 + param1);
            }
            var _loc_7:* = _loc_2.getLineAt(_loc_5);
            if (_loc_2.getLineAt(_loc_5).absoluteStart < this.absoluteStart)
            {
                return 0;
            }
            if (_loc_7.validity != TextLineValidity.VALID)
            {
                _loc_12 = this.textFlow.findLeaf(_loc_7.absoluteStart);
                _loc_13 = _loc_12.getParagraph();
                this.textFlow.flowComposer.composeToPosition(_loc_13.getAbsoluteStart() + _loc_13.textLength);
                _loc_7 = _loc_2.getLineAt(_loc_5);
            }
            var _loc_8:* = this.effectiveBlockProgression == BlockProgression.RL;
            if (this.effectiveBlockProgression == BlockProgression.RL)
            {
                _loc_9 = param1 < 0 ? (_loc_7.x + _loc_7.textHeight) : (_loc_7.x - _loc_7.descent + this._compositionWidth);
                return _loc_9 - this.horizontalScrollPosition;
            }
            _loc_9 = param1 < 0 ? (_loc_7.y) : (_loc_7.y + _loc_7.textHeight - this._compositionHeight);
            return _loc_9 - this.verticalScrollPosition;
        }// end function

        public function mouseOverHandler(event:MouseEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.mouseOverHandler(event);
            }
            return;
        }// end function

        function requiredMouseOverHandler(event:MouseEvent) : void
        {
            this.attachAllListeners();
            this.getInteractionHandler().mouseOverHandler(event);
            return;
        }// end function

        public function mouseOutHandler(event:MouseEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.mouseOutHandler(event);
            }
            return;
        }// end function

        public function mouseWheelHandler(event:MouseEvent) : void
        {
            if (event.isDefaultPrevented())
            {
                return;
            }
            var _loc_2:* = this.effectiveBlockProgression == BlockProgression.RL;
            if (_loc_2)
            {
                if (this.contentWidth > this._compositionWidth && !this._measureWidth)
                {
                    this.horizontalScrollPosition = this.horizontalScrollPosition + event.delta * this.textFlow.configuration.scrollMouseWheelMultiplier;
                    event.preventDefault();
                }
            }
            else if (this.contentHeight > this._compositionHeight && !this._measureHeight)
            {
                this.verticalScrollPosition = this.verticalScrollPosition - event.delta * this.textFlow.configuration.scrollMouseWheelMultiplier;
                event.preventDefault();
            }
            return;
        }// end function

        public function mouseDownHandler(event:MouseEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.mouseDownHandler(event);
                if (this.interactionManager.hasSelection())
                {
                    this.setFocus();
                }
            }
            return;
        }// end function

        function requiredMouseDownHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (!this._selectListenersAttached)
            {
                _loc_2 = this.getContainerRoot();
                if (_loc_2)
                {
                    _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, this.rootMouseMoveHandler, false, 0, true);
                    _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.rootMouseUpHandler, false, 0, true);
                    this.beginMouseCapture();
                    this._selectListenersAttached = true;
                }
            }
            this.getInteractionHandler().mouseDownHandler(event);
            return;
        }// end function

        public function mouseUpHandler(event:MouseEvent) : void
        {
            if (this.interactionManager && event && !event.isDefaultPrevented())
            {
                this.interactionManager.mouseUpHandler(event);
            }
            return;
        }// end function

        function rootMouseUpHandler(event:MouseEvent) : void
        {
            this.clearSelectHandlers();
            this.getInteractionHandler().mouseUpHandler(event);
            return;
        }// end function

        private function clearSelectHandlers() : void
        {
            if (this._selectListenersAttached)
            {
                this.getContainerRoot().removeEventListener(MouseEvent.MOUSE_MOVE, this.rootMouseMoveHandler);
                this.getContainerRoot().removeEventListener(MouseEvent.MOUSE_UP, this.rootMouseUpHandler);
                this.endMouseCapture();
                this._selectListenersAttached = false;
            }
            return;
        }// end function

        public function beginMouseCapture() : void
        {
            var _loc_1:* = this.getInteractionHandler() as ISandboxSupport;
            if (_loc_1 && _loc_1 != this)
            {
                _loc_1.beginMouseCapture();
            }
            return;
        }// end function

        public function endMouseCapture() : void
        {
            var _loc_1:* = this.getInteractionHandler() as ISandboxSupport;
            if (_loc_1 && _loc_1 != this)
            {
                _loc_1.endMouseCapture();
            }
            return;
        }// end function

        public function mouseUpSomewhere(event:Event) : void
        {
            this.rootMouseUpHandler(null);
            this.scrollTimerHandler(null);
            return;
        }// end function

        public function mouseMoveSomewhere(event:Event) : void
        {
            return;
        }// end function

        private function hitOnMyFlowExceptLastContainer(event:MouseEvent) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (event.target is TextLine)
            {
                _loc_2 = TextLine(event.target).userData as TextFlowLine;
                if (_loc_2)
                {
                    _loc_3 = _loc_2.paragraph;
                    if (_loc_3.getTextFlow() == this.textFlow)
                    {
                        return true;
                    }
                }
            }
            else if (event.target is Sprite)
            {
                _loc_4 = 0;
                while (_loc_4 < (this.textFlow.flowComposer.numControllers - 1))
                {
                    
                    if (this.textFlow.flowComposer.getControllerAt(_loc_4).container == event.target)
                    {
                        return true;
                    }
                    _loc_4++;
                }
            }
            return false;
        }// end function

        public function mouseMoveHandler(event:MouseEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                if (event.buttonDown && !this.hitOnMyFlowExceptLastContainer(event))
                {
                    this.autoScrollIfNecessary(event.stageX, event.stageY);
                }
                this.interactionManager.mouseMoveHandler(event);
            }
            return;
        }// end function

        function rootMouseMoveHandler(event:MouseEvent) : void
        {
            this.getInteractionHandler().mouseMoveHandler(event);
            return;
        }// end function

        public function mouseDoubleClickHandler(event:MouseEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.mouseDoubleClickHandler(event);
                if (this.interactionManager.hasSelection())
                {
                    this.setFocus();
                }
            }
            return;
        }// end function

        function setFocus() : void
        {
            if (this._container.stage)
            {
                this._container.stage.focus = this._container;
            }
            return;
        }// end function

        function getContainerController(param1:DisplayObject) : ContainerController
        {
            var flowComposer:IFlowComposer;
            var i:int;
            var controller:ContainerController;
            var container:* = param1;
            try
            {
                while (container)
                {
                    
                    flowComposer = this.flowComposer;
                    i;
                    while (i < flowComposer.numControllers)
                    {
                        
                        controller = flowComposer.getControllerAt(i);
                        if (controller.container == container)
                        {
                            return controller;
                        }
                        i = (i + 1);
                    }
                    container = container.parent;
                }
            }
            catch (e:Error)
            {
            }
            return null;
        }// end function

        public function focusChangeHandler(event:FocusEvent) : void
        {
            var _loc_2:* = this.getContainerController(DisplayObject(event.target));
            var _loc_3:* = this.getContainerController(event.relatedObject);
            if (_loc_3 == _loc_2)
            {
                event.preventDefault();
            }
            return;
        }// end function

        public function focusInHandler(event:FocusEvent) : void
        {
            var _loc_2:* = 0;
            if (this.interactionManager)
            {
                this.interactionManager.focusInHandler(event);
                if (this.interactionManager.editingMode == EditingMode.READ_WRITE)
                {
                    _loc_2 = this.interactionManager.focusedSelectionFormat.pointBlinkRate;
                }
            }
            this.setBlinkInterval(_loc_2);
            return;
        }// end function

        function requiredFocusInHandler(event:FocusEvent) : void
        {
            this.attachAllListeners();
            this._container.addEventListener(KeyboardEvent.KEY_DOWN, this.getInteractionHandler().keyDownHandler);
            this._container.addEventListener(KeyboardEvent.KEY_UP, this.getInteractionHandler().keyUpHandler);
            this._container.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.getInteractionHandler().keyFocusChangeHandler);
            if (Configuration.playerEnablesSpicyFeatures && Configuration.hasTouchScreen)
            {
                this._container.addEventListener("softKeyboardActivating", this.getInteractionHandler().softKeyboardActivatingHandler);
            }
            this.getInteractionHandler().focusInHandler(event);
            return;
        }// end function

        public function focusOutHandler(event:FocusEvent) : void
        {
            if (this.interactionManager)
            {
                this.interactionManager.focusOutHandler(event);
                this.setBlinkInterval(this.interactionManager.unfocusedSelectionFormat.pointBlinkRate);
            }
            else
            {
                this.setBlinkInterval(0);
            }
            return;
        }// end function

        function requiredFocusOutHandler(event:FocusEvent) : void
        {
            this._container.removeEventListener(KeyboardEvent.KEY_DOWN, this.getInteractionHandler().keyDownHandler);
            this._container.removeEventListener(KeyboardEvent.KEY_UP, this.getInteractionHandler().keyUpHandler);
            this._container.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.getInteractionHandler().keyFocusChangeHandler);
            if (Configuration.playerEnablesSpicyFeatures && Configuration.hasTouchScreen)
            {
                this._container.removeEventListener("softKeyboardActivating", this.getInteractionHandler().softKeyboardActivatingHandler);
            }
            this.getInteractionHandler().focusOutHandler(event);
            return;
        }// end function

        public function activateHandler(event:Event) : void
        {
            if (this.interactionManager)
            {
                this.interactionManager.activateHandler(event);
            }
            return;
        }// end function

        public function deactivateHandler(event:Event) : void
        {
            if (this.interactionManager)
            {
                this.interactionManager.deactivateHandler(event);
            }
            return;
        }// end function

        public function keyDownHandler(event:KeyboardEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.keyDownHandler(event);
            }
            return;
        }// end function

        public function keyUpHandler(event:KeyboardEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.keyUpHandler(event);
            }
            return;
        }// end function

        public function keyFocusChangeHandler(event:FocusEvent) : void
        {
            if (this.interactionManager)
            {
                this.interactionManager.keyFocusChangeHandler(event);
            }
            return;
        }// end function

        public function textInputHandler(event:TextEvent) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.textInputHandler(event);
            }
            return;
        }// end function

        public function softKeyboardActivatingHandler(event:Event) : void
        {
            if (this.interactionManager)
            {
                this.interactionManager.softKeyboardActivatingHandler(event);
            }
            return;
        }// end function

        public function imeStartCompositionHandler(event:IMEEvent) : void
        {
            if (this.interactionManager)
            {
                this.interactionManager.imeStartCompositionHandler(event);
            }
            return;
        }// end function

        public function menuSelectHandler(event:ContextMenuEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.interactionManager)
            {
                this.interactionManager.menuSelectHandler(event);
            }
            else
            {
                _loc_2 = this._container.contextMenu;
                if (_loc_2)
                {
                    _loc_3 = _loc_2.clipboardItems;
                    _loc_3.copy = false;
                    _loc_3.cut = false;
                    _loc_3.paste = false;
                    _loc_3.selectAll = false;
                    _loc_3.clear = false;
                }
            }
            return;
        }// end function

        public function editHandler(event:Event) : void
        {
            if (this.interactionManager && !event.isDefaultPrevented())
            {
                this.interactionManager.editHandler(event);
            }
            var _loc_2:* = this._container.contextMenu;
            if (_loc_2)
            {
                _loc_2.clipboardItems.clear = true;
                _loc_2.clipboardItems.copy = true;
                _loc_2.clipboardItems.cut = true;
                _loc_2.clipboardItems.paste = true;
                _loc_2.clipboardItems.selectAll = true;
            }
            return;
        }// end function

        public function selectRange(param1:int, param2:int) : void
        {
            if (this.interactionManager && this.interactionManager.editingMode != EditingMode.READ_ONLY)
            {
                this.interactionManager.selectRange(param1, param2);
            }
            return;
        }// end function

        private function startBlinkingCursor(param1:DisplayObject, param2:int) : void
        {
            if (!this.blinkTimer)
            {
                this.blinkTimer = new Timer(param2, 0);
            }
            this.blinkObject = param1;
            this.blinkTimer.addEventListener(TimerEvent.TIMER, this.blinkTimerHandler, false, 0, true);
            this.blinkTimer.start();
            return;
        }// end function

        protected function stopBlinkingCursor() : void
        {
            if (this.blinkTimer)
            {
                this.blinkTimer.stop();
            }
            this.blinkObject = null;
            return;
        }// end function

        private function blinkTimerHandler(event:TimerEvent) : void
        {
            this.blinkObject.alpha = this.blinkObject.alpha == 1 ? (0) : (1);
            return;
        }// end function

        protected function setBlinkInterval(param1:int) : void
        {
            var _loc_2:* = param1;
            if (_loc_2 == 0)
            {
                if (this.blinkTimer)
                {
                    this.blinkTimer.stop();
                }
                if (this.blinkObject)
                {
                    this.blinkObject.alpha = 1;
                }
            }
            else if (this.blinkTimer)
            {
                this.blinkTimer.delay = _loc_2;
                if (this.blinkObject)
                {
                    this.blinkTimer.start();
                }
            }
            return;
        }// end function

        function drawPointSelection(param1:SelectionFormat, param2:Number, param3:Number, param4:Number, param5:Number) : void
        {
            var _loc_6:* = new Shape();
            if (this._hasScrollRect)
            {
                if (this.effectiveBlockProgression == BlockProgression.TB)
                {
                    if (param2 >= this.containerScrollRectRight)
                    {
                        param2 = param2 - param4;
                    }
                }
                else if (param3 >= this.containerScrollRectBottom)
                {
                    param3 = param3 - param5;
                }
            }
            _loc_6.graphics.beginFill(param1.pointColor);
            _loc_6.graphics.drawRect(int(param2), int(param3), param4, param5);
            _loc_6.graphics.endFill();
            if (param1.pointBlinkRate != 0 && this.interactionManager.editingMode == EditingMode.READ_WRITE)
            {
                this.startBlinkingCursor(_loc_6, param1.pointBlinkRate);
            }
            this.addSelectionChild(_loc_6);
            return;
        }// end function

        function addSelectionShapes(param1:SelectionFormat, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            if (!this.interactionManager || this._textLength == 0 || param2 == -1 || param3 == -1)
            {
                return;
            }
            if (param2 != param3)
            {
                _loc_6 = this.absoluteStart;
                _loc_7 = this.absoluteStart + this.textLength;
                if (param2 < _loc_6)
                {
                    param2 = _loc_6;
                }
                else if (param2 >= _loc_7)
                {
                    return;
                }
                if (param3 > _loc_7)
                {
                    param3 = _loc_7;
                }
                else if (param3 < _loc_6)
                {
                    return;
                }
                _loc_8 = this.flowComposer.findLineIndexAtPosition(param2);
                _loc_9 = param2 == param3 ? (_loc_8) : (this.flowComposer.findLineIndexAtPosition(param3));
                if (_loc_9 >= this.flowComposer.numLines)
                {
                    _loc_9 = this.flowComposer.numLines - 1;
                }
                _loc_10 = new Shape();
                _loc_4 = _loc_8 ? (this.flowComposer.getLineAt((_loc_8 - 1))) : (null);
                _loc_11 = this.flowComposer.getLineAt(_loc_8);
                _loc_12 = _loc_8;
                while (_loc_12 <= _loc_9)
                {
                    
                    _loc_5 = _loc_12 != (this.flowComposer.numLines - 1) ? (this.flowComposer.getLineAt((_loc_12 + 1))) : (null);
                    _loc_11.hiliteBlockSelection(_loc_10, param1, this._container, param2 < _loc_11.absoluteStart ? (_loc_11.absoluteStart) : (param2), param3 > _loc_11.absoluteStart + _loc_11.textLength ? (_loc_11.absoluteStart + _loc_11.textLength) : (param3), _loc_4, _loc_5);
                    _loc_13 = _loc_11;
                    _loc_11 = _loc_5;
                    _loc_4 = _loc_13;
                    _loc_12++;
                }
                this.addSelectionChild(_loc_10);
            }
            else
            {
                _loc_14 = this.flowComposer.findLineIndexAtPosition(param2);
                if (_loc_14 == this.flowComposer.numLines)
                {
                    _loc_14 = _loc_14 - 1;
                }
                if (this.flowComposer.getLineAt(_loc_14).controller == this)
                {
                    _loc_4 = _loc_14 != 0 ? (this.flowComposer.getLineAt((_loc_14 - 1))) : (null);
                    _loc_5 = _loc_14 != (this.flowComposer.numLines - 1) ? (this.flowComposer.getLineAt((_loc_14 + 1))) : (null);
                    this.flowComposer.getLineAt(_loc_14).hilitePointSelection(param1, param2, this._container, _loc_4, _loc_5);
                }
            }
            return;
        }// end function

        function clearSelectionShapes() : void
        {
            this.stopBlinkingCursor();
            var _loc_1:* = this.getSelectionSprite(false);
            if (_loc_1 != null)
            {
                if (_loc_1.parent)
                {
                    this.removeSelectionContainer(_loc_1);
                }
                while (_loc_1.numChildren > 0)
                {
                    
                    _loc_1.removeChildAt(0);
                }
                return;
            }
            return;
        }// end function

        function addSelectionChild(param1:DisplayObject) : void
        {
            var _loc_2:* = this.getSelectionSprite(true);
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = this.interactionManager.currentSelectionFormat;
            var _loc_4:* = this.interactionManager.activePosition == this.interactionManager.anchorPosition ? (_loc_3.pointBlendMode) : (_loc_3.rangeBlendMode);
            var _loc_5:* = this.interactionManager.activePosition == this.interactionManager.anchorPosition ? (_loc_3.pointAlpha) : (_loc_3.rangeAlpha);
            if (_loc_2.blendMode != _loc_4)
            {
                _loc_2.blendMode = _loc_4;
            }
            if (_loc_2.alpha != _loc_5)
            {
                _loc_2.alpha = _loc_5;
            }
            if (_loc_2.numChildren == 0)
            {
                this.addSelectionContainer(_loc_2);
            }
            _loc_2.addChild(param1);
            return;
        }// end function

        function containsSelectionChild(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = this.getSelectionSprite(false);
            if (_loc_2 == null)
            {
                return false;
            }
            return _loc_2.contains(param1);
        }// end function

        function getBackgroundShape() : Shape
        {
            if (!this._backgroundShape)
            {
                this._backgroundShape = new Shape();
                this.addBackgroundShape(this._backgroundShape);
            }
            return this._backgroundShape;
        }// end function

        function getEffectivePaddingLeft() : Number
        {
            return this.computedFormat.paddingLeft == FormatValue.AUTO ? (0) : (this.computedFormat.paddingLeft);
        }// end function

        function getEffectivePaddingRight() : Number
        {
            return this.computedFormat.paddingRight == FormatValue.AUTO ? (0) : (this.computedFormat.paddingRight);
        }// end function

        function getEffectivePaddingTop() : Number
        {
            return this.computedFormat.paddingTop == FormatValue.AUTO ? (0) : (this.computedFormat.paddingTop);
        }// end function

        function getEffectivePaddingBottom() : Number
        {
            return this.computedFormat.paddingBottom == FormatValue.AUTO ? (0) : (this.computedFormat.paddingBottom);
        }// end function

        function getTotalPaddingLeft() : Number
        {
            return this.getEffectivePaddingLeft() + (this._rootElement ? (this._rootElement.getEffectivePaddingLeft()) : (0));
        }// end function

        function getTotalPaddingRight() : Number
        {
            return this.getEffectivePaddingRight() + (this._rootElement ? (this._rootElement.getEffectivePaddingRight()) : (0));
        }// end function

        function getTotalPaddingTop() : Number
        {
            return this.getEffectivePaddingTop() + (this._rootElement ? (this._rootElement.getEffectivePaddingTop()) : (0));
        }// end function

        function getTotalPaddingBottom() : Number
        {
            return this.getEffectivePaddingBottom() + (this._rootElement ? (this._rootElement.getEffectivePaddingBottom()) : (0));
        }// end function

        function getSelectionSprite(param1:Boolean) : DisplayObjectContainer
        {
            if (param1)
            {
                if (this._selectionSprite == null)
                {
                    this._selectionSprite = new Sprite();
                    this._selectionSprite.mouseEnabled = false;
                    this._selectionSprite.mouseChildren = false;
                }
            }
            return this._selectionSprite;
        }// end function

        protected function get attachTransparentBackground() : Boolean
        {
            return true;
        }// end function

        function clearCompositionResults() : void
        {
            var _loc_1:* = null;
            this.setTextLength(0);
            for each (_loc_1 in this._shapeChildren)
            {
                
                this.removeTextLine(_loc_1);
            }
            this._shapeChildren.length = 0;
            this._linesInView.length = 0;
            if (this._floatsInContainer)
            {
                this._floatsInContainer.length = 0;
            }
            if (this._composedFloats)
            {
                this._composedFloats.length = 0;
            }
            return;
        }// end function

        function updateCompositionShapes() : void
        {
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            if (!this.shapesInvalid)
            {
                return;
            }
            var _loc_1:* = this._yScroll;
            if (this.verticalScrollPolicy != ScrollPolicy.OFF && !this._measureHeight)
            {
                this._yScroll = this.computeVerticalScrollPosition(this._yScroll, false);
            }
            var _loc_2:* = this._xScroll;
            if (this.horizontalScrollPolicy != ScrollPolicy.OFF && !this._measureWidth)
            {
                this._xScroll = this.computeHorizontalScrollPosition(this._xScroll, false);
            }
            var _loc_3:* = _loc_1 != this._yScroll || _loc_2 != this._xScroll;
            if (_loc_3)
            {
                this._linesInView.length = 0;
            }
            this.fillShapeChildren();
            var _loc_4:* = this._linesInView;
            var _loc_5:* = this.getFirstTextLineChildIndex();
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (this._updateStart > this.absoluteStart && _loc_4.length > 0)
            {
                _loc_13 = _loc_4[0];
                _loc_14 = TextFlowLine(_loc_13.userData);
                _loc_15 = this.flowComposer.findLineAtPosition((_loc_14.absoluteStart - 1));
                _loc_16 = _loc_15.peekTextLine();
                _loc_7 = this._shapeChildren.indexOf(_loc_16);
                if (_loc_7 >= 0)
                {
                    _loc_7++;
                    _loc_5 = _loc_5 + _loc_7;
                }
                else
                {
                    _loc_7 = 0;
                }
            }
            var _loc_8:* = _loc_7;
            while (_loc_6 != _loc_4.length)
            {
                
                _loc_17 = _loc_4[_loc_6];
                if (_loc_17 == this._shapeChildren[_loc_8])
                {
                    _loc_5++;
                    _loc_6++;
                    _loc_8++;
                    continue;
                }
                _loc_18 = this._shapeChildren.indexOf(_loc_17);
                if (_loc_18 == -1)
                {
                    this.addTextLine(_loc_17, _loc_5++);
                    _loc_6++;
                    continue;
                }
                this.removeAndRecycleTextLines(_loc_8, _loc_18);
                _loc_8 = _loc_18;
            }
            this.removeAndRecycleTextLines(_loc_8, this._shapeChildren.length);
            if (_loc_7 > 0)
            {
                this._shapeChildren.length = _loc_7;
                this._shapeChildren = this._shapeChildren.concat(this._linesInView);
                this._linesInView.length = 0;
            }
            else
            {
                this._linesInView = this._shapeChildren;
                this._linesInView.length = 0;
                this._shapeChildren = _loc_4;
            }
            if (this._floatsInContainer && this._floatsInContainer.length > 0 || this._composedFloats && this._composedFloats.length > 0)
            {
                this.updateGraphics(this._updateStart);
            }
            this.shapesInvalid = false;
            this.updateVisibleRectangle();
            var _loc_9:* = this.textFlow;
            var _loc_10:* = this.interactionManager != null && this.interactionManager.editingMode == EditingMode.READ_WRITE;
            var _loc_11:* = this.getFirstVisibleLine();
            var _loc_12:* = this.getLastVisibleLine();
            scratchRectangle.left = this._contentLeft;
            scratchRectangle.top = this._contentTop;
            scratchRectangle.width = this._contentWidth;
            scratchRectangle.height = this._contentHeight;
            this._mouseEventManager.updateHitTests(this.effectiveBlockProgression == BlockProgression.RL && this._hasScrollRect ? (this._contentWidth) : (0), scratchRectangle, _loc_9, _loc_11 ? (_loc_11.absoluteStart) : (this._absoluteStart), _loc_12 ? (_loc_12.absoluteStart + _loc_12.textLength - 1) : (this._absoluteStart), _loc_10);
            this._updateStart = this._rootElement.textLength;
            if (this._measureWidth || this._measureHeight)
            {
                this.attachTransparentBackgroundForHit(false);
            }
            if (_loc_9.backgroundManager)
            {
                _loc_9.backgroundManager.onUpdateComplete(this);
            }
            if (_loc_3 && _loc_9.hasEventListener(TextLayoutEvent.SCROLL))
            {
                if (_loc_1 != this._yScroll)
                {
                    _loc_9.dispatchEvent(new ScrollEvent(TextLayoutEvent.SCROLL, false, false, ScrollEventDirection.VERTICAL, this._yScroll - _loc_1));
                }
                if (_loc_2 != this._xScroll)
                {
                    _loc_9.dispatchEvent(new ScrollEvent(TextLayoutEvent.SCROLL, false, false, ScrollEventDirection.HORIZONTAL, this._xScroll - _loc_2));
                }
            }
            if (_loc_9.hasEventListener(UpdateCompleteEvent.UPDATE_COMPLETE))
            {
                _loc_9.dispatchEvent(new UpdateCompleteEvent(UpdateCompleteEvent.UPDATE_COMPLETE, false, false, _loc_9, this));
            }
            return;
        }// end function

        function updateGraphics(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_25:* = false;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = null;
            var _loc_3:* = [];
            var _loc_6:* = this.getFirstVisibleLine();
            var _loc_7:* = this.getLastVisibleLine();
            var _loc_8:* = _loc_6 ? (_loc_6.absoluteStart) : (this.absoluteStart);
            var _loc_9:* = _loc_7 ? (_loc_7.absoluteStart + _loc_7.textLength) : (this.absoluteStart + this.textLength);
            var _loc_10:* = this.flowComposer.findLineAtPosition(_loc_9);
            var _loc_11:* = this.flowComposer.findLineAtPosition(_loc_9) ? (_loc_10.absoluteStart + _loc_10.textLength) : (this.absoluteStart + this.textLength);
            _loc_11 = Math.min(_loc_11, this.absoluteStart + this.textLength);
            _loc_11 = Math.min(_loc_11, _loc_9 + 2000);
            _loc_11 = Math.min(_loc_11, this.flowComposer.damageAbsoluteStart);
            var _loc_12:* = this.effectiveBlockProgression;
            var _loc_13:* = this._measureWidth ? (this._contentWidth) : (this._compositionWidth);
            var _loc_14:* = this._measureHeight ? (this._contentHeight) : (this._compositionHeight);
            var _loc_15:* = _loc_12 == BlockProgression.RL ? (this._xScroll - _loc_13) : (this._xScroll);
            var _loc_16:* = this._yScroll;
            var _loc_17:* = this.findFloatIndexAtOrAfter(param1);
            var _loc_18:* = 0;
            var _loc_19:* = this.getFirstTextLineChildIndex();
            if (_loc_17 > 0)
            {
                _loc_4 = this._composedFloats[(_loc_17 - 1)];
                _loc_18 = this._floatsInContainer.indexOf(_loc_4.graphic);
                while (_loc_18 == -1 && _loc_17 > 0)
                {
                    
                    _loc_17 = _loc_17 - 1;
                    _loc_4 = this._composedFloats[(_loc_17 - 1)];
                    if (_loc_4 != null)
                    {
                        _loc_18 = this._floatsInContainer.indexOf(_loc_4.graphic);
                    }
                }
                _loc_18++;
                _loc_23 = 0;
                while (_loc_23 < _loc_17)
                {
                    
                    if (this._composedFloats[_loc_23].absolutePosition >= this.absoluteStart)
                    {
                        _loc_3.push(this._composedFloats[_loc_23].graphic);
                    }
                    _loc_23++;
                }
            }
            var _loc_20:* = _loc_18;
            if (!this._floatsInContainer)
            {
                this._floatsInContainer = [];
            }
            var _loc_21:* = this._floatsInContainer.length;
            var _loc_22:* = this._composedFloats.length;
            while (_loc_17 < _loc_22)
            {
                
                _loc_4 = this._composedFloats[_loc_17];
                _loc_5 = _loc_4.graphic;
                _loc_24 = _loc_4.parent;
                if (!_loc_5)
                {
                    _loc_25 = false;
                }
                else if (_loc_4.floatType == Float.NONE)
                {
                    _loc_25 = _loc_4.absolutePosition >= _loc_8 && _loc_4.absolutePosition < _loc_9;
                }
                else
                {
                    _loc_25 = this.floatIsVisible(_loc_12, _loc_15, _loc_16, _loc_13, _loc_14, _loc_4) && _loc_4.absolutePosition < _loc_11 && _loc_4.absolutePosition >= this.absoluteStart;
                }
                if (!_loc_25)
                {
                    if (_loc_4.absolutePosition >= _loc_11)
                    {
                        break;
                    }
                    _loc_17++;
                    continue;
                }
                if (_loc_3.indexOf(_loc_5) < 0)
                {
                    _loc_3.push(_loc_5);
                }
                if (_loc_4.floatType == Float.NONE)
                {
                    _loc_27 = _loc_24 as TextLine;
                    if (_loc_27)
                    {
                        _loc_28 = _loc_27.userData as TextFlowLine;
                        if (!_loc_28 || _loc_4.absolutePosition < _loc_28.absoluteStart || _loc_4.absolutePosition >= _loc_28.absoluteStart + _loc_28.textLength || _loc_27.parent == null || _loc_27.validity == TextLineValidity.INVALID)
                        {
                            _loc_28 = this.flowComposer.findLineAtPosition(_loc_4.absolutePosition);
                            _loc_29 = 0;
                            while (_loc_29 < this._shapeChildren.length)
                            {
                                
                                if ((this._shapeChildren[_loc_29] as TextLine).userData == _loc_28)
                                {
                                    break;
                                }
                                _loc_29++;
                            }
                            _loc_24 = _loc_29 < this._shapeChildren.length ? (this._shapeChildren[_loc_29]) : (null);
                        }
                    }
                }
                _loc_2 = _loc_5.parent;
                if (_loc_18 < _loc_21 && _loc_4.parent == this._container && _loc_2 && _loc_2.parent == this._container && _loc_5 == this._floatsInContainer[_loc_18])
                {
                    if (_loc_4.matrix)
                    {
                        _loc_2.transform.matrix = _loc_4.matrix;
                    }
                    else
                    {
                        _loc_2.x = 0;
                        _loc_2.y = 0;
                    }
                    _loc_2.alpha = _loc_4.alpha;
                    _loc_2.x = _loc_2.x + _loc_4.x;
                    _loc_2.y = _loc_2.y + _loc_4.y;
                    _loc_17++;
                    _loc_18++;
                    continue;
                }
                _loc_26 = this._floatsInContainer.indexOf(_loc_5);
                if (_loc_26 > _loc_18 && _loc_24 == this._container)
                {
                    _loc_30 = this._floatsInContainer[_loc_18++];
                    if (_loc_30.parent)
                    {
                        this.removeInlineGraphicElement(this._container, _loc_30.parent);
                    }
                    continue;
                }
                if (_loc_18 < _loc_21 && _loc_5 == this._floatsInContainer[_loc_18])
                {
                    _loc_18++;
                }
                _loc_2 = new Sprite();
                if (_loc_4.matrix)
                {
                    _loc_2.transform.matrix = _loc_4.matrix;
                }
                _loc_2.alpha = _loc_4.alpha;
                _loc_2.x = _loc_2.x + _loc_4.x;
                _loc_2.y = _loc_2.y + _loc_4.y;
                _loc_2.addChild(_loc_5);
                if (_loc_24 == this._container)
                {
                    _loc_19 = Math.min(_loc_19, this._container.numChildren);
                    this.addInlineGraphicElement(this._container, _loc_2, _loc_19++);
                }
                else
                {
                    this.addInlineGraphicElement(_loc_24, _loc_2, 0);
                }
                _loc_17++;
            }
            while (_loc_18 < this._floatsInContainer.length)
            {
                
                _loc_5 = this._floatsInContainer[_loc_18++];
                if (_loc_5.parent)
                {
                    this.removeInlineGraphicElement(this._container, _loc_5.parent);
                }
            }
            this._floatsInContainer = _loc_3;
            return;
        }// end function

        private function floatIsVisible(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:FloatCompositionData) : Boolean
        {
            var _loc_7:* = this.textFlow.findLeaf(param6.absolutePosition) as InlineGraphicElement;
            return param6.y + _loc_7.elementHeight >= param3 && param6.y <= param3 + param5 && (param1 == BlockProgression.TB ? (param6.x + _loc_7.elementWidth >= param2) : (param6.x <= param2 + param4));
        }// end function

        private function releaseLinesInBlock(param1:TextBlock) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1.firstLine;
            while (_loc_2 && _loc_2.parent == null)
            {
                
                _loc_2 = _loc_2.nextLine;
            }
            if (!_loc_2 && param1.firstLine)
            {
                _loc_4 = param1.firstLine.userData as TextFlowLine;
                if (_loc_4)
                {
                    _loc_3 = _loc_4.paragraph;
                }
                param1.releaseLines(param1.firstLine, param1.lastLine);
                if (_loc_3)
                {
                    _loc_3.releaseTextBlock();
                }
            }
            return;
        }// end function

        private function removeAndRecycleTextLines(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_3:* = this.textFlow.backgroundManager;
            var _loc_6:* = param1;
            while (_loc_6 < param2)
            {
                
                _loc_4 = this._shapeChildren[_loc_6];
                this.removeTextLine(_loc_4);
                if (_loc_4.textBlock != _loc_5)
                {
                    if (_loc_5)
                    {
                        this.releaseLinesInBlock(_loc_5);
                    }
                    _loc_5 = _loc_4.textBlock;
                }
                _loc_6++;
            }
            if (_loc_5)
            {
                this.releaseLinesInBlock(_loc_5);
            }
            if (TextLineRecycler.textLineRecyclerEnabled)
            {
                while (_loc_1 < param2)
                {
                    
                    _loc_4 = this._shapeChildren[param1++];
                    if (!_loc_4.parent)
                    {
                        if (_loc_4.userData == null)
                        {
                            TextLineRecycler.addLineForReuse(_loc_4);
                            if (_loc_3)
                            {
                                _loc_3.removeLineFromCache(_loc_4);
                            }
                            continue;
                        }
                        _loc_7 = _loc_4.userData as TextFlowLine;
                        if (_loc_7 && _loc_7.controller != this)
                        {
                            continue;
                        }
                        if (_loc_4.validity == TextLineValidity.INVALID || _loc_4.nextLine == null && _loc_4.previousLine == null && (!_loc_4.textBlock || _loc_4.textBlock.firstLine != _loc_4))
                        {
                            _loc_4.userData = null;
                            TextLineRecycler.addLineForReuse(_loc_4);
                            if (_loc_3)
                            {
                                _loc_3.removeLineFromCache(_loc_4);
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        protected function getFirstTextLineChildIndex() : int
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this._container.numChildren)
            {
                
                if (this._container.getChildAt(_loc_1) is TextLine)
                {
                    break;
                }
                _loc_1++;
            }
            return _loc_1;
        }// end function

        protected function addTextLine(param1:TextLine, param2:int) : void
        {
            this._container.addChildAt(param1, param2);
            return;
        }// end function

        protected function removeTextLine(param1:TextLine) : void
        {
            if (this._container.contains(param1))
            {
                this._container.removeChild(param1);
            }
            return;
        }// end function

        protected function addBackgroundShape(param1:Shape) : void
        {
            this._container.addChildAt(this._backgroundShape, this.getFirstTextLineChildIndex());
            return;
        }// end function

        protected function removeBackgroundShape(param1:Shape) : void
        {
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        protected function addSelectionContainer(param1:DisplayObjectContainer) : void
        {
            if (param1.blendMode == BlendMode.NORMAL && param1.alpha == 1)
            {
                this._container.addChildAt(param1, this.getFirstTextLineChildIndex());
            }
            else
            {
                this._container.addChild(param1);
            }
            return;
        }// end function

        protected function removeSelectionContainer(param1:DisplayObjectContainer) : void
        {
            param1.parent.removeChild(param1);
            return;
        }// end function

        protected function addInlineGraphicElement(param1:DisplayObjectContainer, param2:DisplayObject, param3:int) : void
        {
            param1.addChildAt(param2, param3);
            return;
        }// end function

        protected function removeInlineGraphicElement(param1:DisplayObjectContainer, param2:DisplayObject) : void
        {
            if (param2.parent == param1)
            {
                param1.removeChild(param2);
            }
            return;
        }// end function

        function get textLines() : Array
        {
            return this._shapeChildren;
        }// end function

        protected function updateVisibleRectangle() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (this.horizontalScrollPolicy == ScrollPolicy.OFF && this.verticalScrollPolicy == ScrollPolicy.OFF)
            {
                if (this._hasScrollRect)
                {
                    this._container.scrollRect = null;
                    this._hasScrollRect = false;
                }
            }
            else
            {
                _loc_1 = this._contentLeft + this.contentWidth;
                _loc_2 = this._contentTop + this.contentHeight;
                if (this._measureWidth)
                {
                    _loc_3 = this.contentWidth;
                    _loc_4 = this._contentLeft + _loc_3;
                }
                else
                {
                    _loc_3 = this._compositionWidth;
                    _loc_4 = _loc_3;
                }
                if (this._measureHeight)
                {
                    _loc_5 = this.contentHeight;
                    _loc_6 = this._contentTop + _loc_5;
                }
                else
                {
                    _loc_5 = this._compositionHeight;
                    _loc_6 = _loc_5;
                }
                _loc_7 = this.effectiveBlockProgression == BlockProgression.RL ? (-_loc_3) : (0);
                _loc_8 = this.horizontalScrollPosition + _loc_7;
                _loc_9 = this.verticalScrollPosition;
                if (this.textLength == 0 || _loc_8 == 0 && _loc_9 == 0 && this._contentLeft >= _loc_7 && this._contentTop >= 0 && _loc_1 <= _loc_4 && _loc_2 <= _loc_6)
                {
                    if (this._hasScrollRect)
                    {
                        this._container.scrollRect = null;
                        this._hasScrollRect = false;
                    }
                }
                else
                {
                    _loc_10 = this._container.scrollRect;
                    if (!_loc_10 || _loc_10.x != _loc_8 || _loc_10.y != _loc_9 || _loc_10.width != _loc_3 || _loc_10.height != _loc_5)
                    {
                        this._container.scrollRect = new Rectangle(_loc_8, _loc_9, _loc_3, _loc_5);
                        this._hasScrollRect = true;
                    }
                }
            }
            this.attachTransparentBackgroundForHit(false);
            return;
        }// end function

        public function get color()
        {
            return this._format ? (this._format.color) : (undefined);
        }// end function

        public function set color(param1) : void
        {
            this.writableTextLayoutFormat().color = param1;
            this.formatChanged();
            return;
        }// end function

        public function get backgroundColor()
        {
            return this._format ? (this._format.backgroundColor) : (undefined);
        }// end function

        public function set backgroundColor(param1) : void
        {
            this.writableTextLayoutFormat().backgroundColor = param1;
            this.formatChanged();
            return;
        }// end function

        public function get lineThrough()
        {
            return this._format ? (this._format.lineThrough) : (undefined);
        }// end function

        public function set lineThrough(param1) : void
        {
            this.writableTextLayoutFormat().lineThrough = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textAlpha()
        {
            return this._format ? (this._format.textAlpha) : (undefined);
        }// end function

        public function set textAlpha(param1) : void
        {
            this.writableTextLayoutFormat().textAlpha = param1;
            this.formatChanged();
            return;
        }// end function

        public function get backgroundAlpha()
        {
            return this._format ? (this._format.backgroundAlpha) : (undefined);
        }// end function

        public function set backgroundAlpha(param1) : void
        {
            this.writableTextLayoutFormat().backgroundAlpha = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontSize()
        {
            return this._format ? (this._format.fontSize) : (undefined);
        }// end function

        public function set fontSize(param1) : void
        {
            this.writableTextLayoutFormat().fontSize = param1;
            this.formatChanged();
            return;
        }// end function

        public function get baselineShift()
        {
            return this._format ? (this._format.baselineShift) : (undefined);
        }// end function

        public function set baselineShift(param1) : void
        {
            this.writableTextLayoutFormat().baselineShift = param1;
            this.formatChanged();
            return;
        }// end function

        public function get trackingLeft()
        {
            return this._format ? (this._format.trackingLeft) : (undefined);
        }// end function

        public function set trackingLeft(param1) : void
        {
            this.writableTextLayoutFormat().trackingLeft = param1;
            this.formatChanged();
            return;
        }// end function

        public function get trackingRight()
        {
            return this._format ? (this._format.trackingRight) : (undefined);
        }// end function

        public function set trackingRight(param1) : void
        {
            this.writableTextLayoutFormat().trackingRight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get lineHeight()
        {
            return this._format ? (this._format.lineHeight) : (undefined);
        }// end function

        public function set lineHeight(param1) : void
        {
            this.writableTextLayoutFormat().lineHeight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get breakOpportunity()
        {
            return this._format ? (this._format.breakOpportunity) : (undefined);
        }// end function

        public function set breakOpportunity(param1) : void
        {
            this.writableTextLayoutFormat().breakOpportunity = param1;
            this.formatChanged();
            return;
        }// end function

        public function get digitCase()
        {
            return this._format ? (this._format.digitCase) : (undefined);
        }// end function

        public function set digitCase(param1) : void
        {
            this.writableTextLayoutFormat().digitCase = param1;
            this.formatChanged();
            return;
        }// end function

        public function get digitWidth()
        {
            return this._format ? (this._format.digitWidth) : (undefined);
        }// end function

        public function set digitWidth(param1) : void
        {
            this.writableTextLayoutFormat().digitWidth = param1;
            this.formatChanged();
            return;
        }// end function

        public function get dominantBaseline()
        {
            return this._format ? (this._format.dominantBaseline) : (undefined);
        }// end function

        public function set dominantBaseline(param1) : void
        {
            this.writableTextLayoutFormat().dominantBaseline = param1;
            this.formatChanged();
            return;
        }// end function

        public function get kerning()
        {
            return this._format ? (this._format.kerning) : (undefined);
        }// end function

        public function set kerning(param1) : void
        {
            this.writableTextLayoutFormat().kerning = param1;
            this.formatChanged();
            return;
        }// end function

        public function get ligatureLevel()
        {
            return this._format ? (this._format.ligatureLevel) : (undefined);
        }// end function

        public function set ligatureLevel(param1) : void
        {
            this.writableTextLayoutFormat().ligatureLevel = param1;
            this.formatChanged();
            return;
        }// end function

        public function get alignmentBaseline()
        {
            return this._format ? (this._format.alignmentBaseline) : (undefined);
        }// end function

        public function set alignmentBaseline(param1) : void
        {
            this.writableTextLayoutFormat().alignmentBaseline = param1;
            this.formatChanged();
            return;
        }// end function

        public function get locale()
        {
            return this._format ? (this._format.locale) : (undefined);
        }// end function

        public function set locale(param1) : void
        {
            this.writableTextLayoutFormat().locale = param1;
            this.formatChanged();
            return;
        }// end function

        public function get typographicCase()
        {
            return this._format ? (this._format.typographicCase) : (undefined);
        }// end function

        public function set typographicCase(param1) : void
        {
            this.writableTextLayoutFormat().typographicCase = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontFamily()
        {
            return this._format ? (this._format.fontFamily) : (undefined);
        }// end function

        public function set fontFamily(param1) : void
        {
            this.writableTextLayoutFormat().fontFamily = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textDecoration()
        {
            return this._format ? (this._format.textDecoration) : (undefined);
        }// end function

        public function set textDecoration(param1) : void
        {
            this.writableTextLayoutFormat().textDecoration = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontWeight()
        {
            return this._format ? (this._format.fontWeight) : (undefined);
        }// end function

        public function set fontWeight(param1) : void
        {
            this.writableTextLayoutFormat().fontWeight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontStyle()
        {
            return this._format ? (this._format.fontStyle) : (undefined);
        }// end function

        public function set fontStyle(param1) : void
        {
            this.writableTextLayoutFormat().fontStyle = param1;
            this.formatChanged();
            return;
        }// end function

        public function get whiteSpaceCollapse()
        {
            return this._format ? (this._format.whiteSpaceCollapse) : (undefined);
        }// end function

        public function set whiteSpaceCollapse(param1) : void
        {
            this.writableTextLayoutFormat().whiteSpaceCollapse = param1;
            this.formatChanged();
            return;
        }// end function

        public function get renderingMode()
        {
            return this._format ? (this._format.renderingMode) : (undefined);
        }// end function

        public function set renderingMode(param1) : void
        {
            this.writableTextLayoutFormat().renderingMode = param1;
            this.formatChanged();
            return;
        }// end function

        public function get cffHinting()
        {
            return this._format ? (this._format.cffHinting) : (undefined);
        }// end function

        public function set cffHinting(param1) : void
        {
            this.writableTextLayoutFormat().cffHinting = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontLookup()
        {
            return this._format ? (this._format.fontLookup) : (undefined);
        }// end function

        public function set fontLookup(param1) : void
        {
            this.writableTextLayoutFormat().fontLookup = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textRotation()
        {
            return this._format ? (this._format.textRotation) : (undefined);
        }// end function

        public function set textRotation(param1) : void
        {
            this.writableTextLayoutFormat().textRotation = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textIndent()
        {
            return this._format ? (this._format.textIndent) : (undefined);
        }// end function

        public function set textIndent(param1) : void
        {
            this.writableTextLayoutFormat().textIndent = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphStartIndent()
        {
            return this._format ? (this._format.paragraphStartIndent) : (undefined);
        }// end function

        public function set paragraphStartIndent(param1) : void
        {
            this.writableTextLayoutFormat().paragraphStartIndent = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphEndIndent()
        {
            return this._format ? (this._format.paragraphEndIndent) : (undefined);
        }// end function

        public function set paragraphEndIndent(param1) : void
        {
            this.writableTextLayoutFormat().paragraphEndIndent = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphSpaceBefore()
        {
            return this._format ? (this._format.paragraphSpaceBefore) : (undefined);
        }// end function

        public function set paragraphSpaceBefore(param1) : void
        {
            this.writableTextLayoutFormat().paragraphSpaceBefore = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphSpaceAfter()
        {
            return this._format ? (this._format.paragraphSpaceAfter) : (undefined);
        }// end function

        public function set paragraphSpaceAfter(param1) : void
        {
            this.writableTextLayoutFormat().paragraphSpaceAfter = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textAlign()
        {
            return this._format ? (this._format.textAlign) : (undefined);
        }// end function

        public function set textAlign(param1) : void
        {
            this.writableTextLayoutFormat().textAlign = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textAlignLast()
        {
            return this._format ? (this._format.textAlignLast) : (undefined);
        }// end function

        public function set textAlignLast(param1) : void
        {
            this.writableTextLayoutFormat().textAlignLast = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textJustify()
        {
            return this._format ? (this._format.textJustify) : (undefined);
        }// end function

        public function set textJustify(param1) : void
        {
            this.writableTextLayoutFormat().textJustify = param1;
            this.formatChanged();
            return;
        }// end function

        public function get justificationRule()
        {
            return this._format ? (this._format.justificationRule) : (undefined);
        }// end function

        public function set justificationRule(param1) : void
        {
            this.writableTextLayoutFormat().justificationRule = param1;
            this.formatChanged();
            return;
        }// end function

        public function get justificationStyle()
        {
            return this._format ? (this._format.justificationStyle) : (undefined);
        }// end function

        public function set justificationStyle(param1) : void
        {
            this.writableTextLayoutFormat().justificationStyle = param1;
            this.formatChanged();
            return;
        }// end function

        public function get direction()
        {
            return this._format ? (this._format.direction) : (undefined);
        }// end function

        public function set direction(param1) : void
        {
            this.writableTextLayoutFormat().direction = param1;
            this.formatChanged();
            return;
        }// end function

        public function get wordSpacing()
        {
            return this._format ? (this._format.wordSpacing) : (undefined);
        }// end function

        public function set wordSpacing(param1) : void
        {
            this.writableTextLayoutFormat().wordSpacing = param1;
            this.formatChanged();
            return;
        }// end function

        public function get tabStops()
        {
            return this._format ? (this._format.tabStops) : (undefined);
        }// end function

        public function set tabStops(param1) : void
        {
            this.writableTextLayoutFormat().tabStops = param1;
            this.formatChanged();
            return;
        }// end function

        public function get leadingModel()
        {
            return this._format ? (this._format.leadingModel) : (undefined);
        }// end function

        public function set leadingModel(param1) : void
        {
            this.writableTextLayoutFormat().leadingModel = param1;
            this.formatChanged();
            return;
        }// end function

        public function get columnGap()
        {
            return this._format ? (this._format.columnGap) : (undefined);
        }// end function

        public function set columnGap(param1) : void
        {
            this.writableTextLayoutFormat().columnGap = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingLeft()
        {
            return this._format ? (this._format.paddingLeft) : (undefined);
        }// end function

        public function set paddingLeft(param1) : void
        {
            this.writableTextLayoutFormat().paddingLeft = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingTop()
        {
            return this._format ? (this._format.paddingTop) : (undefined);
        }// end function

        public function set paddingTop(param1) : void
        {
            this.writableTextLayoutFormat().paddingTop = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingRight()
        {
            return this._format ? (this._format.paddingRight) : (undefined);
        }// end function

        public function set paddingRight(param1) : void
        {
            this.writableTextLayoutFormat().paddingRight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingBottom()
        {
            return this._format ? (this._format.paddingBottom) : (undefined);
        }// end function

        public function set paddingBottom(param1) : void
        {
            this.writableTextLayoutFormat().paddingBottom = param1;
            this.formatChanged();
            return;
        }// end function

        public function get columnCount()
        {
            return this._format ? (this._format.columnCount) : (undefined);
        }// end function

        public function set columnCount(param1) : void
        {
            this.writableTextLayoutFormat().columnCount = param1;
            this.formatChanged();
            return;
        }// end function

        public function get columnWidth()
        {
            return this._format ? (this._format.columnWidth) : (undefined);
        }// end function

        public function set columnWidth(param1) : void
        {
            this.writableTextLayoutFormat().columnWidth = param1;
            this.formatChanged();
            return;
        }// end function

        public function get firstBaselineOffset()
        {
            return this._format ? (this._format.firstBaselineOffset) : (undefined);
        }// end function

        public function set firstBaselineOffset(param1) : void
        {
            this.writableTextLayoutFormat().firstBaselineOffset = param1;
            this.formatChanged();
            return;
        }// end function

        public function get verticalAlign()
        {
            return this._format ? (this._format.verticalAlign) : (undefined);
        }// end function

        public function set verticalAlign(param1) : void
        {
            this.writableTextLayoutFormat().verticalAlign = param1;
            this.formatChanged();
            return;
        }// end function

        public function get blockProgression()
        {
            return this._format ? (this._format.blockProgression) : (undefined);
        }// end function

        public function set blockProgression(param1) : void
        {
            this.writableTextLayoutFormat().blockProgression = param1;
            this.formatChanged();
            return;
        }// end function

        public function get lineBreak()
        {
            return this._format ? (this._format.lineBreak) : (undefined);
        }// end function

        public function set lineBreak(param1) : void
        {
            this.writableTextLayoutFormat().lineBreak = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listStyleType()
        {
            return this._format ? (this._format.listStyleType) : (undefined);
        }// end function

        public function set listStyleType(param1) : void
        {
            this.writableTextLayoutFormat().listStyleType = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listStylePosition()
        {
            return this._format ? (this._format.listStylePosition) : (undefined);
        }// end function

        public function set listStylePosition(param1) : void
        {
            this.writableTextLayoutFormat().listStylePosition = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listAutoPadding()
        {
            return this._format ? (this._format.listAutoPadding) : (undefined);
        }// end function

        public function set listAutoPadding(param1) : void
        {
            this.writableTextLayoutFormat().listAutoPadding = param1;
            this.formatChanged();
            return;
        }// end function

        public function get clearFloats()
        {
            return this._format ? (this._format.clearFloats) : (undefined);
        }// end function

        public function set clearFloats(param1) : void
        {
            this.writableTextLayoutFormat().clearFloats = param1;
            this.formatChanged();
            return;
        }// end function

        public function get styleName()
        {
            return this._format ? (this._format.styleName) : (undefined);
        }// end function

        public function set styleName(param1) : void
        {
            this.writableTextLayoutFormat().styleName = param1;
            this.styleSelectorChanged();
            return;
        }// end function

        public function get linkNormalFormat()
        {
            return this._format ? (this._format.linkNormalFormat) : (undefined);
        }// end function

        public function set linkNormalFormat(param1) : void
        {
            this.writableTextLayoutFormat().linkNormalFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get linkActiveFormat()
        {
            return this._format ? (this._format.linkActiveFormat) : (undefined);
        }// end function

        public function set linkActiveFormat(param1) : void
        {
            this.writableTextLayoutFormat().linkActiveFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get linkHoverFormat()
        {
            return this._format ? (this._format.linkHoverFormat) : (undefined);
        }// end function

        public function set linkHoverFormat(param1) : void
        {
            this.writableTextLayoutFormat().linkHoverFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listMarkerFormat()
        {
            return this._format ? (this._format.listMarkerFormat) : (undefined);
        }// end function

        public function set listMarkerFormat(param1) : void
        {
            this.writableTextLayoutFormat().listMarkerFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get userStyles() : Object
        {
            return this._format ? (this._format.userStyles) : (null);
        }// end function

        public function set userStyles(param1:Object) : void
        {
            var _loc_2:* = null;
            for (_loc_2 in this.userStyles)
            {
                
                this.setStyle(_loc_2, undefined);
            }
            for (_loc_2 in param1)
            {
                
                this.setStyle(_loc_2, param1[_loc_2]);
            }
            return;
        }// end function

        public function get coreStyles() : Object
        {
            return this._format ? (this._format.coreStyles) : (null);
        }// end function

        public function get styles() : Object
        {
            return this._format ? (this._format.styles) : (null);
        }// end function

        public function get format() : ITextLayoutFormat
        {
            return this._format;
        }// end function

        public function set format(param1:ITextLayoutFormat) : void
        {
            if (param1 == this._format)
            {
                return;
            }
            var _loc_2:* = this.styleName;
            if (param1 == null)
            {
                this._format.clearStyles();
            }
            else
            {
                this.writableTextLayoutFormat().copy(param1);
            }
            this.formatChanged();
            if (_loc_2 != this.styleName)
            {
                this.styleSelectorChanged();
            }
            return;
        }// end function

        private function writableTextLayoutFormat() : FlowValueHolder
        {
            if (this._format == null)
            {
                this._format = new FlowValueHolder();
            }
            return this._format;
        }// end function

        public function getStyle(param1:String)
        {
            if (TextLayoutFormat.description.hasOwnProperty(param1))
            {
                return this.computedFormat.getStyle(param1);
            }
            var _loc_2:* = this._rootElement.getTextFlow();
            if (!_loc_2 || !_loc_2.formatResolver)
            {
                return this.computedFormat.getStyle(param1);
            }
            return this.getUserStyleWorker(param1);
        }// end function

        function getUserStyleWorker(param1:String)
        {
            var _loc_2:* = this._format.getStyle(param1);
            if (_loc_2 !== undefined)
            {
                return _loc_2;
            }
            var _loc_3:* = this._rootElement ? (this._rootElement.getTextFlow()) : (null);
            if (_loc_3 && _loc_3.formatResolver)
            {
                _loc_2 = _loc_3.formatResolver.resolveUserFormat(this, param1);
                if (_loc_2 !== undefined)
                {
                    return _loc_2;
                }
            }
            return this._rootElement ? (this._rootElement.getUserStyleWorker(param1)) : (undefined);
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            if (TextLayoutFormat.description[param1])
            {
                this[param1] = param2;
            }
            else
            {
                this.writableTextLayoutFormat().setStyle(param1, param2);
                this.formatChanged();
            }
            return;
        }// end function

        public function clearStyle(param1:String) : void
        {
            this.setStyle(param1, undefined);
            return;
        }// end function

        public function get computedFormat() : ITextLayoutFormat
        {
            var _loc_1:* = null;
            if (!this._computedFormat)
            {
                _loc_1 = this._rootElement ? (TextLayoutFormat(this._rootElement.computedFormat)) : (null);
                this._computedFormat = FlowElement.createTextLayoutFormatPrototype(this.formatForCascade, _loc_1);
                this.resetColumnState();
            }
            return this._computedFormat;
        }// end function

        function get formatForCascade() : ITextLayoutFormat
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._rootElement)
            {
                _loc_1 = this._rootElement.getTextFlow();
                if (_loc_1)
                {
                    _loc_2 = _loc_1.getTextLayoutFormatStyle(this);
                    if (_loc_2)
                    {
                        _loc_3 = this._format;
                        if (_loc_3 == null)
                        {
                            return _loc_2;
                        }
                        _loc_4 = new TextLayoutFormat(_loc_2);
                        _loc_4.apply(_loc_3);
                        return _loc_4;
                    }
                }
            }
            return this._format;
        }// end function

        function isLineVisible(param1:String, param2:int, param3:int, param4:int, param5:int, param6:TextFlowLine, param7:TextLine) : TextLine
        {
            var _loc_8:* = null;
            if (!param6.hasLineBounds())
            {
                if (!param7)
                {
                    param7 = param6.getTextLine(true);
                }
                param6.createShape(param1, param7);
                if (param7.numChildren == 0)
                {
                    if (param1 == BlockProgression.TB)
                    {
                        param6.cacheLineBounds(param1, param7.x, param7.y - param7.ascent, param7.textWidth, param7.textHeight);
                    }
                    else
                    {
                        param6.cacheLineBounds(param1, param7.x - param7.descent, param7.y, param7.textHeight, param7.textWidth);
                    }
                }
                else
                {
                    _loc_8 = this.getPlacedTextLineBounds(param7);
                    if (param7.hasGraphicElement)
                    {
                        _loc_8 = this.computeLineBoundsWithGraphics(param6, param7, _loc_8);
                    }
                    param6.cacheLineBounds(param1, _loc_8.x, _loc_8.y, _loc_8.width, _loc_8.height);
                }
            }
            if ((param1 == BlockProgression.TB ? (this._measureHeight) : (this._measureWidth)) || param6.isLineVisible(param1, param2, param3, param4, param5))
            {
                return param7 ? (param7) : (param6.getTextLine(true));
            }
            return null;
        }// end function

        private function computeLineBoundsWithGraphics(param1:TextFlowLine, param2:TextLine, param3:Rectangle) : Rectangle
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (this._composedFloats)
            {
                _loc_4 = this.findFloatIndexAtOrAfter(param1.absoluteStart);
                _loc_5 = this.findFloatIndexAtOrAfter(param1.absoluteStart + param1.textLength);
                _loc_6 = new Rectangle();
                _loc_7 = new Point();
                while (_loc_4 < _loc_5)
                {
                    
                    _loc_8 = this._composedFloats[_loc_4];
                    if (_loc_8.floatType == Float.NONE)
                    {
                        _loc_9 = this.textFlow.findLeaf(_loc_8.absolutePosition) as InlineGraphicElement;
                        _loc_10 = _loc_9.placeholderGraphic.parent;
                        if (_loc_10)
                        {
                            _loc_6.x = param2.x + _loc_10.x;
                            _loc_6.y = param2.y + _loc_10.y;
                            _loc_6.width = _loc_9.elementWidth;
                            _loc_6.height = _loc_9.elementHeight;
                            param3 = param3.union(_loc_6);
                        }
                    }
                    _loc_4++;
                }
            }
            return param3;
        }// end function

        function getPlacedTextLineBounds(param1:TextLine) : Rectangle
        {
            var _loc_2:* = null;
            _loc_2 = param1.getBounds(param1);
            _loc_2.x = _loc_2.x + param1.x;
            _loc_2.y = _loc_2.y + param1.y;
            return _loc_2;
        }// end function

        function addComposedLine(param1:TextLine) : void
        {
            this._linesInView.push(param1);
            return;
        }// end function

        function get composedLines() : Array
        {
            if (!this._linesInView)
            {
                this._linesInView = [];
            }
            return this._linesInView;
        }// end function

        function clearComposedLines(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            for each (_loc_3 in this._linesInView)
            {
                
                _loc_4 = _loc_3.userData as TextFlowLine;
                if (_loc_4.absoluteStart >= param1)
                {
                    break;
                }
                _loc_2++;
            }
            this._linesInView.length = _loc_2;
            this._updateStart = Math.min(this._updateStart, param1);
            return;
        }// end function

        function get numFloats() : int
        {
            return this._composedFloats ? (this._composedFloats.length) : (0);
        }// end function

        function getFloatAt(param1:int) : FloatCompositionData
        {
            return this._composedFloats[param1];
        }// end function

        function getFloatAtPosition(param1:int) : FloatCompositionData
        {
            if (!this._composedFloats)
            {
                return null;
            }
            var _loc_2:* = this.findFloatIndexAtOrAfter(param1);
            return _loc_2 < this._composedFloats.length ? (this._composedFloats[_loc_2]) : (null);
        }// end function

        function addFloatAt(param1:int, param2:DisplayObject, param3:String, param4:Number, param5:Number, param6:Number, param7:Matrix, param8:Number, param9:Number, param10:int, param11:DisplayObjectContainer) : void
        {
            var _loc_13:* = 0;
            if (!this._composedFloats)
            {
                this._composedFloats = [];
            }
            var _loc_12:* = new FloatCompositionData(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            if (this._composedFloats.length > 0 && this._composedFloats[(this._composedFloats.length - 1)] < param1)
            {
                this._composedFloats.push(_loc_12);
            }
            else
            {
                _loc_13 = this.findFloatIndexAtOrAfter(param1);
                this._composedFloats.splice(_loc_13, 0, _loc_12);
            }
            return;
        }// end function

        function clearFloatsAt(param1:int) : void
        {
            if (this._composedFloats)
            {
                if (param1 == this.absoluteStart)
                {
                    this._composedFloats.length = 0;
                }
                else
                {
                    this._composedFloats.length = this.findFloatIndexAtOrAfter(param1);
                }
            }
            return;
        }// end function

        function findFloatIndexAfter(param1:int) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._composedFloats.length && this._composedFloats[_loc_2].absolutePosition <= param1)
            {
                
                _loc_2++;
            }
            return _loc_2;
        }// end function

        function findFloatIndexAtOrAfter(param1:int) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._composedFloats.length && this._composedFloats[_loc_2].absolutePosition < param1)
            {
                
                _loc_2++;
            }
            return _loc_2;
        }// end function

        function getInteractionHandler() : IInteractionEventHandler
        {
            return this;
        }// end function

        private static function pinValue(param1:Number, param2:Number, param3:Number) : Number
        {
            return Math.min(Math.max(param1, param2), param3);
        }// end function

        static function createDefaultContextMenu() : ContextMenu
        {
            var _loc_1:* = new ContextMenu();
            _loc_1.clipboardMenu = true;
            _loc_1.clipboardItems.clear = true;
            _loc_1.clipboardItems.copy = true;
            _loc_1.clipboardItems.cut = true;
            _loc_1.clipboardItems.paste = true;
            _loc_1.clipboardItems.selectAll = true;
            return _loc_1;
        }// end function

        private static function createContainerControllerInitialFormat() : ITextLayoutFormat
        {
            var _loc_1:* = new TextLayoutFormat();
            _loc_1.columnCount = FormatValue.INHERIT;
            _loc_1.columnGap = FormatValue.INHERIT;
            _loc_1.columnWidth = FormatValue.INHERIT;
            _loc_1.verticalAlign = FormatValue.INHERIT;
            return _loc_1;
        }// end function

        public static function get containerControllerInitialFormat() : ITextLayoutFormat
        {
            return _containerControllerInitialFormat;
        }// end function

        public static function set containerControllerInitialFormat(param1:ITextLayoutFormat) : void
        {
            _containerControllerInitialFormat = param1;
            return;
        }// end function

    }
}

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.text.engine.*;

import flash.ui.*;

import flash.utils.*;

import flashx.textLayout.compose.*;

import flashx.textLayout.container.*;

import flashx.textLayout.edit.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.events.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.utils.*;

class PsuedoMouseEvent extends MouseEvent
{

    function PsuedoMouseEvent(param1:String, param2:Boolean = true, param3:Boolean = false, param4:Number = NaN, param5:Number = NaN, param6:InteractiveObject = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false)
    {
        super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        return;
    }// end function

    override public function get currentTarget() : Object
    {
        return relatedObject;
    }// end function

    override public function get target() : Object
    {
        return relatedObject;
    }// end function

}

