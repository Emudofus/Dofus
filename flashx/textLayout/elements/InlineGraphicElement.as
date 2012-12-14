package flashx.textLayout.elements
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.engine.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    final public class InlineGraphicElement extends FlowLeafElement
    {
        private var _source:Object;
        private var _graphic:DisplayObject;
        private var _placeholderGraphic:Sprite;
        private var _elementWidth:Number;
        private var _elementHeight:Number;
        private var _graphicStatus:Object;
        private var okToUpdateHeightAndWidth:Boolean;
        private var _width:Object;
        private var _height:Object;
        private var _measuredWidth:Number;
        private var _measuredHeight:Number;
        private var _float:Object;
        private var _effectiveFloat:String;
        private static const graphicElementText:String = String.fromCharCode(ContentElement.GRAPHIC_ELEMENT);
        private static const LOAD_INITIATED:String = "loadInitiated";
        private static const OPEN_RECEIVED:String = "openReceived";
        private static const LOAD_COMPLETE:String = "loadComplete";
        private static const EMBED_LOADED:String = "embedLoaded";
        private static const DISPLAY_OBJECT:String = "displayObject";
        private static const NULL_GRAPHIC:String = "nullGraphic";
        private static var isMac:Boolean = Capabilities.os.search("Mac OS") > -1;
        static const heightPropertyDefinition:Property = Property.NewNumberOrPercentOrEnumProperty("height", FormatValue.AUTO, false, null, 0, 32000, "0%", "1000000%", FormatValue.AUTO);
        static const widthPropertyDefinition:Property = Property.NewNumberOrPercentOrEnumProperty("width", FormatValue.AUTO, false, null, 0, 32000, "0%", "1000000%", FormatValue.AUTO);
        static const rotationPropertyDefinition:Property = Property.NewEnumStringProperty("rotation", TextRotation.ROTATE_0, false, null, TextRotation.ROTATE_0, TextRotation.ROTATE_90, TextRotation.ROTATE_180, TextRotation.ROTATE_270);
        static const floatPropertyDefinition:Property = Property.NewEnumStringProperty("float", Float.NONE, false, null, Float.NONE, Float.LEFT, Float.RIGHT, Float.START, Float.END);

        public function InlineGraphicElement(param1:String = "")
        {
            this.okToUpdateHeightAndWidth = false;
            this._measuredWidth = 0;
            this._measuredHeight = 0;
            this.internalSetWidth(undefined);
            this.internalSetHeight(undefined);
            this._graphicStatus = InlineGraphicElementStatus.LOAD_PENDING;
            setTextLength(1);
            _text = param1 == "" ? (graphicElementText) : (param1);
            return;
        }// end function

        override function createContentElement() : void
        {
            if (_blockElement)
            {
                return;
            }
            var _loc_1:* = new GraphicElement();
            _blockElement = _loc_1;
            this.updateContentElement();
            super.createContentElement();
            return;
        }// end function

        private function updateContentElement() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_1:* = _blockElement as GraphicElement;
            if (!this._placeholderGraphic)
            {
                this._placeholderGraphic = new Sprite();
            }
            _loc_1.graphic = this._placeholderGraphic;
            if (this.effectiveFloat != Float.NONE)
            {
                if (_loc_1.elementHeight != 0)
                {
                    _loc_1.elementHeight = 0;
                }
                if (_loc_1.elementWidth != 0)
                {
                    _loc_1.elementWidth = 0;
                }
            }
            else
            {
                _loc_2 = this.elementHeightWithMarginsAndPadding();
                if (_loc_1.elementHeight != _loc_2)
                {
                    _loc_1.elementHeight = _loc_2;
                }
                _loc_3 = this.elementWidthWithMarginsAndPadding();
                if (_loc_1.elementWidth != _loc_3)
                {
                    _loc_1.elementWidth = _loc_3;
                }
            }
            return;
        }// end function

        override public function get computedFormat() : ITextLayoutFormat
        {
            var _loc_1:* = _computedFormat == null;
            if (_loc_1 && _blockElement)
            {
                this.updateContentElement();
            }
            return _computedFormat;
        }// end function

        function elementWidthWithMarginsAndPadding() : Number
        {
            var _loc_1:* = getTextFlow();
            if (!_loc_1)
            {
                return this.elementWidth;
            }
            var _loc_2:* = _loc_1.computedFormat.blockProgression == BlockProgression.RL ? (getEffectivePaddingTop() + getEffectivePaddingBottom()) : (getEffectivePaddingLeft() + getEffectivePaddingRight());
            return this.elementWidth + _loc_2;
        }// end function

        function elementHeightWithMarginsAndPadding() : Number
        {
            var _loc_1:* = getTextFlow();
            if (!_loc_1)
            {
                return this.elementWidth;
            }
            var _loc_2:* = _loc_1.computedFormat.blockProgression == BlockProgression.RL ? (getEffectivePaddingLeft() + getEffectivePaddingRight()) : (getEffectivePaddingTop() + getEffectivePaddingBottom());
            return this.elementHeight + _loc_2;
        }// end function

        public function get graphic() : DisplayObject
        {
            return this._graphic;
        }// end function

        private function setGraphic(param1:DisplayObject) : void
        {
            this._graphic = param1;
            return;
        }// end function

        function get placeholderGraphic() : Sprite
        {
            return this._placeholderGraphic;
        }// end function

        function get elementWidth() : Number
        {
            return this._elementWidth;
        }// end function

        function set elementWidth(param1:Number) : void
        {
            this._elementWidth = param1;
            if (_blockElement)
            {
                (_blockElement as GraphicElement).elementWidth = this.effectiveFloat != Float.NONE ? (0) : (this.elementWidthWithMarginsAndPadding());
            }
            modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength, true, false);
            return;
        }// end function

        function get elementHeight() : Number
        {
            return this._elementHeight;
        }// end function

        function set elementHeight(param1:Number) : void
        {
            this._elementHeight = param1;
            if (_blockElement)
            {
                (_blockElement as GraphicElement).elementHeight = this.effectiveFloat != Float.NONE ? (0) : (this.elementHeightWithMarginsAndPadding());
            }
            modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength, true, false);
            return;
        }// end function

        public function get status() : String
        {
            switch(this._graphicStatus)
            {
                case LOAD_INITIATED:
                case OPEN_RECEIVED:
                {
                    return InlineGraphicElementStatus.LOADING;
                }
                case LOAD_COMPLETE:
                case EMBED_LOADED:
                case DISPLAY_OBJECT:
                case NULL_GRAPHIC:
                {
                    return InlineGraphicElementStatus.READY;
                }
                case InlineGraphicElementStatus.LOAD_PENDING:
                case InlineGraphicElementStatus.SIZE_PENDING:
                {
                    return String(this._graphicStatus);
                }
                default:
                {
                    break;
                }
            }
            return InlineGraphicElementStatus.ERROR;
        }// end function

        private function changeGraphicStatus(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = this.status;
            this._graphicStatus = param1;
            var _loc_3:* = this.status;
            if (_loc_2 != _loc_3 || param1 is ErrorEvent)
            {
                _loc_4 = getTextFlow();
                if (_loc_4)
                {
                    if (_loc_3 == InlineGraphicElementStatus.SIZE_PENDING)
                    {
                        _loc_4.processAutoSizeImageLoaded(this);
                    }
                    _loc_4.dispatchEvent(new StatusChangeEvent(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, false, false, this, _loc_3, param1 as ErrorEvent));
                }
            }
            return;
        }// end function

        public function get width()
        {
            return this._width;
        }// end function

        public function set width(param1) : void
        {
            this.internalSetWidth(param1);
            modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength);
            return;
        }// end function

        public function get measuredWidth() : Number
        {
            return this._measuredWidth;
        }// end function

        public function get actualWidth() : Number
        {
            return this.elementWidth;
        }// end function

        private function widthIsComputed() : Boolean
        {
            return this.internalWidth is String;
        }// end function

        private function get internalWidth() : Object
        {
            return this._width === undefined ? (widthPropertyDefinition.defaultValue) : (this._width);
        }// end function

        private function computeWidth() : Number
        {
            var _loc_1:* = NaN;
            if (this.internalWidth == FormatValue.AUTO)
            {
                if (this.internalHeight == FormatValue.AUTO)
                {
                    return this._measuredWidth;
                }
                if (this._measuredHeight == 0 || this._measuredWidth == 0)
                {
                    return 0;
                }
                _loc_1 = this.heightIsComputed() ? (this.computeHeight()) : (Number(this.internalHeight));
                return _loc_1 / this._measuredHeight * this._measuredWidth;
            }
            return widthPropertyDefinition.computeActualPropertyValue(this.internalWidth, this._measuredWidth);
        }// end function

        private function internalSetWidth(param1) : void
        {
            this._width = widthPropertyDefinition.setHelper(this.width, param1);
            this.elementWidth = this.widthIsComputed() ? (0) : (Number(this.internalWidth));
            if (this.okToUpdateHeightAndWidth && this.graphic)
            {
                if (this.widthIsComputed())
                {
                    this.elementWidth = this.computeWidth();
                }
                this.graphic.width = this.elementWidth;
                if (this.internalHeight == FormatValue.AUTO)
                {
                    this.elementHeight = this.computeHeight();
                    this.graphic.height = this.elementHeight;
                }
            }
            return;
        }// end function

        public function get height()
        {
            return this._height;
        }// end function

        public function set height(param1) : void
        {
            this.internalSetHeight(param1);
            modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength);
            return;
        }// end function

        private function get internalHeight() : Object
        {
            return this._height === undefined ? (heightPropertyDefinition.defaultValue) : (this._height);
        }// end function

        function get computedFloat()
        {
            if (this._float === undefined)
            {
                return floatPropertyDefinition.defaultValue;
            }
            return this._float;
        }// end function

        function get effectiveFloat()
        {
            return this._effectiveFloat ? (this._effectiveFloat) : (this.computedFloat);
        }// end function

        function setEffectiveFloat(param1:String) : void
        {
            if (this._effectiveFloat != param1)
            {
                this._effectiveFloat = param1;
                if (_blockElement)
                {
                    this.updateContentElement();
                }
            }
            return;
        }// end function

        public function get float()
        {
            return this._float;
        }// end function

        public function set float(param1)
        {
            param1 = floatPropertyDefinition.setHelper(this.float, param1) as String;
            if (this._float != param1)
            {
                this._float = param1;
                if (_blockElement)
                {
                    this.updateContentElement();
                }
                modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength);
            }
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            return this._measuredHeight;
        }// end function

        public function get actualHeight() : Number
        {
            return this.elementHeight;
        }// end function

        private function heightIsComputed() : Boolean
        {
            return this.internalHeight is String;
        }// end function

        private function computeHeight() : Number
        {
            var _loc_1:* = NaN;
            if (this.internalHeight == FormatValue.AUTO)
            {
                if (this.internalWidth == FormatValue.AUTO)
                {
                    return this._measuredHeight;
                }
                if (this._measuredHeight == 0 || this._measuredWidth == 0)
                {
                    return 0;
                }
                _loc_1 = this.widthIsComputed() ? (this.computeWidth()) : (Number(this.internalWidth));
                return _loc_1 / this._measuredWidth * this._measuredHeight;
            }
            return heightPropertyDefinition.computeActualPropertyValue(this.internalHeight, this._measuredHeight);
        }// end function

        private function internalSetHeight(param1) : void
        {
            this._height = heightPropertyDefinition.setHelper(this.height, param1);
            this.elementHeight = this.heightIsComputed() ? (0) : (Number(this.internalHeight));
            if (this.okToUpdateHeightAndWidth && this.graphic != null)
            {
                if (this.heightIsComputed())
                {
                    this.elementHeight = this.computeHeight();
                }
                this.graphic.height = this.elementHeight;
                if (this.internalWidth == FormatValue.AUTO)
                {
                    this.elementWidth = this.computeWidth();
                    this.graphic.width = this.elementWidth;
                }
            }
            return;
        }// end function

        private function loadCompleteHandler(event:Event) : void
        {
            this.removeDefaultLoadHandlers(this.graphic as Loader);
            this.okToUpdateHeightAndWidth = true;
            var _loc_2:* = this.graphic;
            this._measuredWidth = _loc_2.width;
            this._measuredHeight = _loc_2.height;
            if (!this.widthIsComputed())
            {
                _loc_2.width = this.elementWidth;
            }
            if (!this.heightIsComputed())
            {
                _loc_2.height = this.elementHeight;
            }
            if (event is IOErrorEvent)
            {
                this.changeGraphicStatus(event);
            }
            else if (this.widthIsComputed() || this.heightIsComputed())
            {
                _loc_2.visible = false;
                this.changeGraphicStatus(InlineGraphicElementStatus.SIZE_PENDING);
            }
            else
            {
                this.changeGraphicStatus(LOAD_COMPLETE);
            }
            return;
        }// end function

        private function openHandler(event:Event) : void
        {
            this.changeGraphicStatus(OPEN_RECEIVED);
            return;
        }// end function

        private function addDefaultLoadHandlers(param1:Loader) : void
        {
            var _loc_2:* = param1.contentLoaderInfo;
            _loc_2.addEventListener(Event.OPEN, this.openHandler, false, 0, true);
            _loc_2.addEventListener(Event.COMPLETE, this.loadCompleteHandler, false, 0, true);
            _loc_2.addEventListener(IOErrorEvent.IO_ERROR, this.loadCompleteHandler, false, 0, true);
            return;
        }// end function

        private function removeDefaultLoadHandlers(param1:Loader) : void
        {
            param1.contentLoaderInfo.removeEventListener(Event.OPEN, this.openHandler);
            param1.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadCompleteHandler);
            param1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadCompleteHandler);
            return;
        }// end function

        public function get source() : Object
        {
            return this._source;
        }// end function

        public function set source(param1:Object) : void
        {
            this.stop(true);
            this._source = param1;
            this.changeGraphicStatus(InlineGraphicElementStatus.LOAD_PENDING);
            modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength);
            return;
        }// end function

        override function applyDelayedElementUpdate(param1:TextFlow, param2:Boolean, param3:Boolean) : void
        {
            var source:Object;
            var elem:DisplayObject;
            var inlineGraphicResolver:Function;
            var loader:Loader;
            var myPattern:RegExp;
            var src:String;
            var pictURLReq:URLRequest;
            var cls:Class;
            var textFlow:* = param1;
            var okToUnloadGraphics:* = param2;
            var hasController:* = param3;
            if (textFlow != this.getTextFlow())
            {
                hasController;
            }
            if (this._graphicStatus == InlineGraphicElementStatus.LOAD_PENDING)
            {
                if (hasController)
                {
                    source = this._source;
                    if (source is String)
                    {
                        inlineGraphicResolver = textFlow.configuration.inlineGraphicResolverFunction;
                        if (inlineGraphicResolver != null)
                        {
                            source = this.inlineGraphicResolver(this);
                        }
                    }
                    if (source is String || source is URLRequest)
                    {
                        this.okToUpdateHeightAndWidth = false;
                        loader = new Loader();
                        try
                        {
                            this.addDefaultLoadHandlers(loader);
                            if (source is String)
                            {
                                myPattern = /\\\"""\\/g;
                                src = source as String;
                                src = src.replace(myPattern, "/");
                                if (isMac)
                                {
                                    pictURLReq = new URLRequest(encodeURI(src));
                                }
                                else
                                {
                                    pictURLReq = new URLRequest(src);
                                }
                                loader.load(pictURLReq);
                            }
                            else
                            {
                                loader.load(URLRequest(source));
                            }
                            this.setGraphic(loader);
                            this.changeGraphicStatus(LOAD_INITIATED);
                        }
                        catch (e:Error)
                        {
                            removeDefaultLoadHandlers(loader);
                            elem = new Shape();
                            changeGraphicStatus(NULL_GRAPHIC);
                        }
                    }
                    else if (source is Class)
                    {
                        cls = source as Class;
                        elem = DisplayObject(new cls);
                        this.changeGraphicStatus(EMBED_LOADED);
                    }
                    else if (source is DisplayObject)
                    {
                        elem = DisplayObject(source);
                        this.changeGraphicStatus(DISPLAY_OBJECT);
                    }
                    else
                    {
                        elem = new Shape();
                        this.changeGraphicStatus(NULL_GRAPHIC);
                    }
                    if (this._graphicStatus != LOAD_INITIATED)
                    {
                        this.okToUpdateHeightAndWidth = true;
                        this._measuredWidth = elem ? (elem.width) : (0);
                        this._measuredHeight = elem ? (elem.height) : (0);
                        if (this.widthIsComputed())
                        {
                            if (elem)
                            {
                                var _loc_5:* = this.computeWidth();
                                this.elementWidth = this.computeWidth();
                                elem.width = _loc_5;
                            }
                            else
                            {
                                this.elementWidth = 0;
                            }
                        }
                        else
                        {
                            elem.width = Number(this.width);
                        }
                        if (this.heightIsComputed())
                        {
                            if (elem)
                            {
                                var _loc_5:* = this.computeHeight();
                                this.elementHeight = this.computeHeight();
                                elem.height = _loc_5;
                            }
                            else
                            {
                                this.elementHeight = 0;
                            }
                        }
                        else
                        {
                            elem.height = Number(this.height);
                        }
                        this.setGraphic(elem);
                    }
                }
            }
            else
            {
                if (this._graphicStatus == InlineGraphicElementStatus.SIZE_PENDING)
                {
                    this.updateAutoSizes();
                    this.graphic.visible = true;
                    this.changeGraphicStatus(LOAD_COMPLETE);
                }
                if (!hasController)
                {
                    this.stop(okToUnloadGraphics);
                }
            }
            return;
        }// end function

        override function updateForMustUseComposer(param1:TextFlow) : Boolean
        {
            this.applyDelayedElementUpdate(param1, false, true);
            return this.status != InlineGraphicElementStatus.READY;
        }// end function

        private function updateAutoSizes() : void
        {
            if (this.widthIsComputed())
            {
                this.elementWidth = this.computeWidth();
                this.graphic.width = this.elementWidth;
            }
            if (this.heightIsComputed())
            {
                this.elementHeight = this.computeHeight();
                this.graphic.height = this.elementHeight;
            }
            return;
        }// end function

        function stop(param1:Boolean) : Boolean
        {
            var loader:Loader;
            var okToUnloadGraphics:* = param1;
            if (this._graphicStatus == OPEN_RECEIVED || this._graphicStatus == LOAD_INITIATED)
            {
                loader = this.graphic as Loader;
                try
                {
                    loader.close();
                }
                catch (e:Error)
                {
                }
                this.removeDefaultLoadHandlers(loader);
            }
            if (this._graphicStatus != DISPLAY_OBJECT)
            {
                if (okToUnloadGraphics)
                {
                    recursiveShutDownGraphic(this.graphic);
                    this.setGraphic(null);
                }
                if (this.widthIsComputed())
                {
                    this.elementWidth = 0;
                }
                if (this.heightIsComputed())
                {
                    this.elementHeight = 0;
                }
                this.changeGraphicStatus(InlineGraphicElementStatus.LOAD_PENDING);
            }
            return true;
        }// end function

        override function getEffectiveFontSize() : Number
        {
            if (this.effectiveFloat != Float.NONE)
            {
                return 0;
            }
            var _loc_1:* = super.getEffectiveFontSize();
            return Math.max(_loc_1, this.elementHeightWithMarginsAndPadding());
        }// end function

        override function getEffectiveLineHeight(param1:String) : Number
        {
            if (this.effectiveFloat != Float.NONE)
            {
                return 0;
            }
            return super.getEffectiveLineHeight(param1);
        }// end function

        function getTypographicAscent(param1:TextLine) : Number
        {
            var _loc_3:* = null;
            if (this.effectiveFloat != Float.NONE)
            {
                return 0;
            }
            var _loc_2:* = this.elementHeightWithMarginsAndPadding();
            if (this._computedFormat.dominantBaseline != FormatValue.AUTO)
            {
                _loc_3 = this._computedFormat.dominantBaseline;
            }
            else
            {
                _loc_3 = this.getParagraph().getEffectiveDominantBaseline();
            }
            var _loc_4:* = _blockElement ? (_blockElement.elementFormat) : (computeElementFormat());
            var _loc_5:* = (_blockElement ? (_blockElement.elementFormat) : (computeElementFormat())).alignmentBaseline == TextBaseline.USE_DOMINANT_BASELINE ? (_loc_3) : (_loc_4.alignmentBaseline);
            var _loc_6:* = 0;
            if (_loc_3 == TextBaseline.IDEOGRAPHIC_CENTER)
            {
                _loc_6 = _loc_6 + _loc_2 / 2;
            }
            else if (_loc_3 == TextBaseline.IDEOGRAPHIC_BOTTOM || _loc_3 == TextBaseline.DESCENT || _loc_3 == TextBaseline.ROMAN)
            {
                _loc_6 = _loc_6 + _loc_2;
            }
            _loc_6 = _loc_6 + (param1.getBaselinePosition(TextBaseline.ROMAN) - param1.getBaselinePosition(_loc_5));
            _loc_6 = _loc_6 + _loc_4.baselineShift;
            return _loc_6;
        }// end function

        override function getCSSInlineBox(param1:String, param2:TextLine, param3:ParagraphElement = null, param4:ISWFContext = null) : Rectangle
        {
            if (this.effectiveFloat != Float.NONE)
            {
                return null;
            }
            var _loc_5:* = new Rectangle();
            new Rectangle().top = -this.getTypographicAscent(param2);
            _loc_5.height = this.elementHeightWithMarginsAndPadding();
            _loc_5.width = this.elementWidth;
            return _loc_5;
        }// end function

        override function updateIMEAdornments(param1:TextLine, param2:String, param3:String) : void
        {
            if (this.effectiveFloat == Float.NONE)
            {
                super.updateIMEAdornments(param1, param2, param3);
            }
            return;
        }// end function

        override function updateAdornments(param1:TextLine, param2:String) : int
        {
            if (this.effectiveFloat == Float.NONE)
            {
                return super.updateAdornments(param1, param2);
            }
            return 0;
        }// end function

        override public function shallowCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            if (param2 == -1)
            {
                param2 = textLength;
            }
            var _loc_3:* = super.shallowCopy(param1, param2) as InlineGraphicElement;
            _loc_3.source = this.source;
            _loc_3.width = this.width;
            _loc_3.height = this.height;
            _loc_3.float = this.float;
            return _loc_3;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "img";
        }// end function

        override function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void
        {
            if (param2 == ModelChange.ELEMENT_ADDED)
            {
                param1.incGraphicObjectCount();
            }
            else if (param2 == ModelChange.ELEMENT_REMOVAL)
            {
                param1.decGraphicObjectCount();
            }
            if (this.status != InlineGraphicElementStatus.READY || param2 == ModelChange.ELEMENT_REMOVAL)
            {
                param1.appendOneElementForUpdate(this);
            }
            return;
        }// end function

        override function calculateStrikeThrough(param1:TextLine, param2:String, param3:FontMetrics) : Number
        {
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            if (!this.graphic || this.status != InlineGraphicElementStatus.READY)
            {
                return super.calculateStrikeThrough(param1, param2, param3);
            }
            var _loc_4:* = 0;
            var _loc_5:* = this._placeholderGraphic.parent;
            if (this._placeholderGraphic.parent)
            {
                if (param2 != BlockProgression.RL)
                {
                    _loc_4 = this.placeholderGraphic.parent.y + (this.elementHeight / 2 + Number(getEffectivePaddingTop()));
                }
                else
                {
                    _loc_6 = getEffectivePaddingRight();
                    _loc_7 = param1.userData as TextFlowLine;
                    _loc_8 = this.getAbsoluteStart() - _loc_7.absoluteStart;
                    if (param1.getAtomTextRotation(_loc_8) != TextRotation.ROTATE_0)
                    {
                        _loc_4 = this._placeholderGraphic.parent.x - (this.elementHeight / 2 + _loc_6);
                    }
                    else
                    {
                        _loc_4 = this._placeholderGraphic.parent.x - (this.elementWidth / 2 + _loc_6);
                    }
                }
            }
            return param2 == BlockProgression.TB ? (_loc_4) : (-_loc_4);
        }// end function

        override function calculateUnderlineOffset(param1:Number, param2:String, param3:FontMetrics, param4:TextLine) : Number
        {
            if (!this.graphic || this.status != InlineGraphicElementStatus.READY)
            {
                return super.calculateUnderlineOffset(param1, param2, param3, param4);
            }
            var _loc_5:* = this.getParagraph();
            var _loc_6:* = 0;
            var _loc_7:* = this._placeholderGraphic.parent;
            if (this._placeholderGraphic.parent)
            {
                if (param2 == BlockProgression.TB)
                {
                    _loc_6 = _loc_7.y + this.elementHeightWithMarginsAndPadding();
                }
                else
                {
                    if (_loc_5.computedFormat.locale.toLowerCase().indexOf("zh") == 0)
                    {
                        _loc_6 = _loc_7.x - this.elementHeightWithMarginsAndPadding();
                        _loc_6 = _loc_6 - (param3.underlineOffset + param3.underlineThickness / 2);
                        return _loc_6;
                    }
                    _loc_6 = _loc_7.x - getEffectivePaddingLeft();
                }
            }
            _loc_6 = _loc_6 + (param3.underlineOffset + param3.underlineThickness / 2);
            var _loc_8:* = _loc_5.getEffectiveJustificationRule();
            if (_loc_5.getEffectiveJustificationRule() == JustificationRule.EAST_ASIAN)
            {
                _loc_6 = _loc_6 + 1;
            }
            return _loc_6;
        }// end function

        private static function recursiveShutDownGraphic(param1:DisplayObject) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (param1 is Loader)
            {
                Loader(param1).unloadAndStop();
            }
            else if (param1)
            {
                _loc_2 = param1 as DisplayObjectContainer;
                if (_loc_2)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2.numChildren)
                    {
                        
                        recursiveShutDownGraphic(_loc_2.getChildAt(_loc_3));
                        _loc_3++;
                    }
                }
                if (param1 is MovieClip)
                {
                    MovieClip(param1).stop();
                }
            }
            return;
        }// end function

    }
}
