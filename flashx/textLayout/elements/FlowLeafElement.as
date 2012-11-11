package flashx.textLayout.elements
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    public class FlowLeafElement extends FlowElement
    {
        protected var _blockElement:ContentElement;
        protected var _text:String;
        private var _hasAttachedListeners:Boolean;
        var _eventMirror:FlowElementEventDispatcher = null;

        public function FlowLeafElement()
        {
            this._hasAttachedListeners = false;
            return;
        }// end function

        override function createContentElement() : void
        {
            if (_computedFormat)
            {
                this._blockElement.elementFormat = this.computeElementFormat();
            }
            if (parent)
            {
                parent.insertBlockElement(this, this._blockElement);
            }
            return;
        }// end function

        override function releaseContentElement() : void
        {
            this._blockElement = null;
            _computedFormat = null;
            return;
        }// end function

        private function blockElementExists() : Boolean
        {
            return this._blockElement != null;
        }// end function

        function getBlockElement() : ContentElement
        {
            if (!this._blockElement)
            {
                this.createContentElement();
            }
            return this._blockElement;
        }// end function

        override function getEventMirror() : IEventDispatcher
        {
            if (!this._eventMirror)
            {
                this._eventMirror = new FlowElementEventDispatcher(this);
            }
            return this._eventMirror;
        }// end function

        override function hasActiveEventMirror() : Boolean
        {
            return this._eventMirror && this._eventMirror._listenerCount != 0;
        }// end function

        override function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void
        {
            if (param2 == ModelChange.ELEMENT_ADDED)
            {
                if (this.hasActiveEventMirror())
                {
                    param1.incInteractiveObjectCount();
                    getParagraph().incInteractiveChildrenCount();
                }
            }
            else if (param2 == ModelChange.ELEMENT_REMOVAL)
            {
                if (this.hasActiveEventMirror())
                {
                    param1.decInteractiveObjectCount();
                    getParagraph().decInteractiveChildrenCount();
                }
            }
            super.appendElementsForDelayedUpdate(param1, param2);
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        function getElementFormat() : ElementFormat
        {
            if (!this._blockElement)
            {
                this.createContentElement();
            }
            return this._blockElement.elementFormat;
        }// end function

        override function setParentAndRelativeStart(param1:FlowGroupElement, param2:int) : void
        {
            if (param1 == parent)
            {
                return;
            }
            var _loc_3:* = this._blockElement != null;
            if (this._blockElement && parent && parent.hasBlockElement())
            {
                parent.removeBlockElement(this, this._blockElement);
            }
            if (param1 && !param1.hasBlockElement() && this._blockElement)
            {
                param1.createContentElement();
            }
            super.setParentAndRelativeStart(param1, param2);
            if (parent)
            {
                if (parent.hasBlockElement())
                {
                    if (!this._blockElement)
                    {
                        this.createContentElement();
                    }
                    else if (_loc_3)
                    {
                        parent.insertBlockElement(this, this._blockElement);
                    }
                }
                else if (this._blockElement)
                {
                    this.releaseContentElement();
                }
            }
            return;
        }// end function

        function quickInitializeForSplit(param1:FlowLeafElement, param2:int, param3:TextElement) : void
        {
            setTextLength(param2);
            this._blockElement = param3;
            if (this._blockElement)
            {
                this._text = this._blockElement.text;
            }
            quickCloneTextLayoutFormat(param1);
            var _loc_4:* = param1.getTextFlow();
            if (param1.getTextFlow() == null || _loc_4.formatResolver == null)
            {
                _computedFormat = param1._computedFormat;
                if (this._blockElement)
                {
                    this._blockElement.elementFormat = param1.getElementFormat();
                }
            }
            return;
        }// end function

        public function getNextLeaf(param1:FlowGroupElement = null) : FlowLeafElement
        {
            if (!parent)
            {
                return null;
            }
            return parent.getNextLeafHelper(param1, this);
        }// end function

        public function getPreviousLeaf(param1:FlowGroupElement = null) : FlowLeafElement
        {
            if (!parent)
            {
                return null;
            }
            return parent.getPreviousLeafHelper(param1, this);
        }// end function

        override public function getCharAtPosition(param1:int) : String
        {
            return this._text ? (this._text.charAt(param1)) : ("");
        }// end function

        override function normalizeRange(param1:uint, param2:uint) : void
        {
            if (this._blockElement)
            {
            }
            return;
        }// end function

        public function getComputedFontMetrics() : FontMetrics
        {
            if (!this._blockElement)
            {
                this.createContentElement();
            }
            var _loc_1:* = this._blockElement.elementFormat;
            if (!_loc_1)
            {
                return null;
            }
            var _loc_2:* = getTextFlow();
            if (_loc_2 && _loc_2.flowComposer && _loc_2.flowComposer.swfContext)
            {
                return _loc_2.flowComposer.swfContext.callInContext(_loc_1.getFontMetrics, _loc_1, null, true);
            }
            return _loc_1.getFontMetrics();
        }// end function

        function computeElementFormat() : ElementFormat
        {
            var _loc_1:* = getTextFlow();
            return computeElementFormatHelper(_computedFormat, getParagraph(), _loc_1 && _loc_1.flowComposer ? (_loc_1.flowComposer.swfContext) : (null));
        }// end function

        override public function get computedFormat() : ITextLayoutFormat
        {
            if (!_computedFormat)
            {
                _computedFormat = doComputeTextLayoutFormat();
                if (this._blockElement)
                {
                    this._blockElement.elementFormat = this.computeElementFormat();
                }
            }
            return _computedFormat;
        }// end function

        function getEffectiveLineHeight(param1:String) : Number
        {
            if (param1 == BlockProgression.RL && parent is TCYElement)
            {
                return 0;
            }
            return TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(_computedFormat.lineHeight, this.getEffectiveFontSize());
        }// end function

        function getCSSInlineBox(param1:String, param2:TextLine, param3:ParagraphElement = null, param4:ISWFContext = null) : Rectangle
        {
            if (param1 == BlockProgression.RL && parent is TCYElement)
            {
                return null;
            }
            return getCSSInlineBoxHelper(this.computedFormat, this.getComputedFontMetrics(), param2, param3);
        }// end function

        function getEffectiveFontSize() : Number
        {
            return Number(this.computedFormat.fontSize);
        }// end function

        function getSpanBoundsOnLine(param1:TextLine, param2:String) : Array
        {
            var _loc_10:* = null;
            var _loc_3:* = TextFlowLine(param1.userData);
            var _loc_4:* = _loc_3.paragraph.getAbsoluteStart();
            var _loc_5:* = _loc_3.absoluteStart + _loc_3.textLength - _loc_4;
            var _loc_6:* = getAbsoluteStart() - _loc_4;
            var _loc_7:* = getAbsoluteStart() - _loc_4 + this.text.length;
            var _loc_8:* = Math.max(_loc_6, _loc_3.absoluteStart - _loc_4);
            if (_loc_7 >= _loc_5)
            {
                _loc_7 = _loc_5;
                _loc_10 = this.text;
                while (_loc_7 > _loc_8 && CharacterUtil.isWhitespace(_loc_10.charCodeAt(_loc_7 - _loc_6 - 1)))
                {
                    
                    _loc_7 = _loc_7 - 1;
                }
            }
            var _loc_9:* = [];
            _loc_3.calculateSelectionBounds(param1, _loc_9, _loc_8, _loc_7, param2, [_loc_3.textHeight, 0]);
            return _loc_9;
        }// end function

        function updateIMEAdornments(param1:TextLine, param2:String, param3:String) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = NaN;
            var _loc_4:* = this.getComputedFontMetrics();
            var _loc_5:* = this.getSpanBoundsOnLine(param1, param2);
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                _loc_7 = 1;
                _loc_8 = 0;
                _loc_9 = 0;
                _loc_10 = 0;
                _loc_11 = 0;
                _loc_12 = 0;
                if (param3 == IMEStatus.SELECTED_CONVERTED || param3 == IMEStatus.SELECTED_RAW)
                {
                    _loc_7 = 2;
                }
                if (param3 == IMEStatus.SELECTED_RAW || param3 == IMEStatus.NOT_SELECTED_RAW || param3 == IMEStatus.DEAD_KEY_INPUT_STATE)
                {
                    _loc_8 = 10921638;
                }
                _loc_13 = _loc_5[_loc_6] as Rectangle;
                _loc_14 = this.calculateStrikeThrough(param1, param2, _loc_4);
                _loc_15 = this.calculateUnderlineOffset(_loc_14, param2, _loc_4, param1);
                if (param2 != BlockProgression.RL)
                {
                    _loc_9 = _loc_13.topLeft.x + 1;
                    _loc_11 = _loc_13.topLeft.x + _loc_13.width - 1;
                    _loc_10 = _loc_15;
                    _loc_12 = _loc_15;
                }
                else
                {
                    _loc_17 = param1.userData as TextFlowLine;
                    _loc_18 = this.getAbsoluteStart() - _loc_17.absoluteStart;
                    _loc_10 = _loc_13.topLeft.y + 1;
                    _loc_12 = _loc_13.topLeft.y + _loc_13.height - 1;
                    if (_loc_18 < 0 || param1.atomCount <= _loc_18 || param1.getAtomTextRotation(_loc_18) != TextRotation.ROTATE_0)
                    {
                        _loc_9 = _loc_15;
                        _loc_11 = _loc_15;
                    }
                    else
                    {
                        _loc_19 = this.getParentByType(TCYElement) as TCYElement;
                        if (this.getAbsoluteStart() + this.textLength == _loc_19.getAbsoluteStart() + _loc_19.textLength)
                        {
                            _loc_20 = new Rectangle();
                            _loc_19.calculateAdornmentBounds(_loc_19, param1, param2, _loc_20);
                            _loc_21 = _loc_4.underlineOffset + _loc_4.underlineThickness / 2;
                            _loc_10 = _loc_20.top + 1;
                            _loc_12 = _loc_20.bottom - 1;
                            _loc_9 = _loc_13.bottomRight.x + _loc_21;
                            _loc_11 = _loc_13.bottomRight.x + _loc_21;
                        }
                    }
                }
                _loc_16 = new Shape();
                _loc_16.alpha = 1;
                _loc_16.graphics.beginFill(_loc_8);
                _loc_16.graphics.lineStyle(_loc_7, _loc_8, _loc_16.alpha);
                _loc_16.graphics.moveTo(_loc_9, _loc_10);
                _loc_16.graphics.lineTo(_loc_11, _loc_12);
                _loc_16.graphics.endFill();
                param1.addChild(_loc_16);
                _loc_6++;
            }
            return;
        }// end function

        function updateAdornments(param1:TextLine, param2:String) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (_computedFormat.textDecoration == TextDecoration.UNDERLINE || _computedFormat.lineThrough || _computedFormat.backgroundAlpha > 0 && _computedFormat.backgroundColor != BackgroundColor.TRANSPARENT)
            {
                _loc_3 = this.getSpanBoundsOnLine(param1, param2);
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    this.updateAdornmentsOnBounds(param1, param2, _loc_3[_loc_4]);
                    _loc_4++;
                }
                return _loc_3.length;
            }
            return 0;
        }// end function

        private function updateAdornmentsOnBounds(param1:TextLine, param2:String, param3:Rectangle) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = false;
            var _loc_16:* = null;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = null;
            var _loc_4:* = this.getComputedFontMetrics();
            var _loc_5:* = !(_computedFormat.textDecoration == TextDecoration.UNDERLINE || _computedFormat.lineThrough);
            if (_computedFormat.textDecoration == TextDecoration.UNDERLINE || _computedFormat.lineThrough)
            {
                _loc_6 = new Shape();
                _loc_6.alpha = Number(_computedFormat.textAlpha);
                _loc_7 = _loc_6.graphics;
                _loc_8 = this.calculateStrikeThrough(param1, param2, _loc_4);
                _loc_9 = this.calculateUnderlineOffset(_loc_8, param2, _loc_4, param1);
            }
            if (param2 != BlockProgression.RL)
            {
                this.addBackgroundRect(param1, _loc_4, param3, true);
                if (_computedFormat.textDecoration == TextDecoration.UNDERLINE)
                {
                    _loc_7.lineStyle(_loc_4.underlineThickness, _computedFormat.color as uint);
                    _loc_7.moveTo(param3.topLeft.x, _loc_9);
                    _loc_7.lineTo(param3.topLeft.x + param3.width, _loc_9);
                }
                if (_computedFormat.lineThrough)
                {
                    _loc_7.lineStyle(_loc_4.strikethroughThickness, _computedFormat.color as uint);
                    _loc_7.moveTo(param3.topLeft.x, _loc_8);
                    _loc_7.lineTo(param3.topLeft.x + param3.width, _loc_8);
                }
            }
            else
            {
                _loc_10 = param1.userData as TextFlowLine;
                _loc_11 = this.getAbsoluteStart() - _loc_10.absoluteStart;
                if (_loc_11 < 0 || param1.atomCount <= _loc_11 || param1.getAtomTextRotation(_loc_11) != TextRotation.ROTATE_0)
                {
                    this.addBackgroundRect(param1, _loc_4, param3, false);
                    if (_computedFormat.textDecoration == TextDecoration.UNDERLINE)
                    {
                        _loc_7.lineStyle(_loc_4.underlineThickness, _computedFormat.color as uint);
                        _loc_7.moveTo(_loc_9, param3.topLeft.y);
                        _loc_7.lineTo(_loc_9, param3.topLeft.y + param3.height);
                    }
                    if (_computedFormat.lineThrough == true)
                    {
                        _loc_7.lineStyle(_loc_4.strikethroughThickness, _computedFormat.color as uint);
                        _loc_7.moveTo(-_loc_8, param3.topLeft.y);
                        _loc_7.lineTo(-_loc_8, param3.topLeft.y + param3.height);
                    }
                }
                else
                {
                    this.addBackgroundRect(param1, _loc_4, param3, true, true);
                    if (!_loc_5)
                    {
                        _loc_12 = this.getParentByType(TCYElement) as TCYElement;
                        _loc_13 = this.getParentByType(ParagraphElement) as ParagraphElement;
                        _loc_14 = _loc_13.computedFormat.locale.toLowerCase();
                        _loc_15 = _loc_14.indexOf("zh") != 0;
                        if (this.getAbsoluteStart() + this.textLength == _loc_12.getAbsoluteStart() + _loc_12.textLength)
                        {
                            _loc_16 = new Rectangle();
                            _loc_12.calculateAdornmentBounds(_loc_12, param1, param2, _loc_16);
                            if (_computedFormat.textDecoration == TextDecoration.UNDERLINE)
                            {
                                _loc_7.lineStyle(_loc_4.underlineThickness, _computedFormat.color as uint);
                                _loc_17 = _loc_4.underlineOffset + _loc_4.underlineThickness / 2;
                                _loc_18 = _loc_15 ? (param3.right) : (param3.left);
                                if (!_loc_15)
                                {
                                    _loc_17 = -_loc_17;
                                }
                                _loc_7.moveTo(_loc_18 + _loc_17, _loc_16.top);
                                _loc_7.lineTo(_loc_18 + _loc_17, _loc_16.bottom);
                            }
                            if (_computedFormat.lineThrough == true)
                            {
                                _loc_19 = param3.bottomRight.x - _loc_16.x;
                                _loc_19 = _loc_19 / 2;
                                _loc_19 = _loc_19 + _loc_16.x;
                                _loc_7.lineStyle(_loc_4.strikethroughThickness, _computedFormat.color as uint);
                                _loc_7.moveTo(_loc_19, _loc_16.top);
                                _loc_7.lineTo(_loc_19, _loc_16.bottom);
                            }
                        }
                    }
                }
            }
            if (_loc_6)
            {
                _loc_20 = (param1.userData as TextFlowLine).peekTextLine();
                if (_loc_20 && param1 != _loc_20)
                {
                    param1 = _loc_20;
                }
                param1.addChild(_loc_6);
            }
            return;
        }// end function

        private function addBackgroundRect(param1:TextLine, param2:FontMetrics, param3:Rectangle, param4:Boolean, param5:Boolean = false) : void
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            if (_computedFormat.backgroundAlpha == 0 || _computedFormat.backgroundColor == BackgroundColor.TRANSPARENT)
            {
                return;
            }
            var _loc_6:* = this.getTextFlow();
            if (!this.getTextFlow().getBackgroundManager())
            {
                return;
            }
            var _loc_7:* = param3.clone();
            if (!param5 && (_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT || _computedFormat.baselineShift == BaselineShift.SUBSCRIPT))
            {
                _loc_10 = this.getEffectiveFontSize();
                _loc_11 = param2.strikethroughOffset + param2.strikethroughThickness / 2;
                if (_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
                {
                    _loc_12 = -3 * _loc_11;
                    _loc_9 = (-param2.superscriptOffset) * _loc_10;
                    _loc_13 = param1.getBaselinePosition(TextBaseline.DESCENT) - param1.getBaselinePosition(TextBaseline.ROMAN);
                    _loc_8 = _loc_12 + _loc_9 + _loc_13;
                    if (param4)
                    {
                        if (_loc_8 > _loc_7.height)
                        {
                            _loc_7.y = _loc_7.y - (_loc_8 - _loc_7.height);
                            _loc_7.height = _loc_8;
                        }
                    }
                    else if (_loc_8 > _loc_7.width)
                    {
                        _loc_7.width = _loc_8;
                    }
                }
                else
                {
                    _loc_14 = -_loc_11;
                    _loc_9 = param2.subscriptOffset * _loc_10;
                    _loc_15 = param1.getBaselinePosition(TextBaseline.ROMAN) - param1.getBaselinePosition(TextBaseline.ASCENT);
                    _loc_8 = _loc_15 + _loc_9 + _loc_14;
                    if (param4)
                    {
                        if (_loc_8 > _loc_7.height)
                        {
                            _loc_7.height = _loc_8;
                        }
                    }
                    else if (_loc_8 > _loc_7.width)
                    {
                        _loc_7.x = _loc_7.x - (_loc_8 - _loc_7.width);
                        _loc_7.width = _loc_8;
                    }
                }
            }
            _loc_6.backgroundManager.addRect(param1, this, _loc_7, _computedFormat.backgroundColor, _computedFormat.backgroundAlpha);
            return;
        }// end function

        function calculateStrikeThrough(param1:TextLine, param2:String, param3:FontMetrics) : Number
        {
            var _loc_4:* = 0;
            var _loc_5:* = this.getEffectiveFontSize();
            if (_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
            {
                _loc_4 = -param3.superscriptOffset * _loc_5;
            }
            else if (_computedFormat.baselineShift == BaselineShift.SUBSCRIPT)
            {
                _loc_4 = -param3.subscriptOffset * (_loc_5 / param3.subscriptScale);
            }
            else
            {
                _loc_4 = TextLayoutFormat.baselineShiftProperty.computeActualPropertyValue(_computedFormat.baselineShift, _loc_5);
            }
            var _loc_6:* = resolveDomBaseline(this.computedFormat, getParagraph());
            var _loc_7:* = this.computedFormat.alignmentBaseline;
            var _loc_8:* = param1.getBaselinePosition(_loc_6);
            if (_loc_7 != TextBaseline.USE_DOMINANT_BASELINE && _loc_7 != _loc_6)
            {
                _loc_8 = param1.getBaselinePosition(_loc_7);
            }
            var _loc_9:* = param3.strikethroughOffset;
            if (_loc_6 == TextBaseline.IDEOGRAPHIC_CENTER)
            {
                _loc_9 = 0;
            }
            else if (_loc_6 == TextBaseline.IDEOGRAPHIC_TOP || _loc_6 == TextBaseline.ASCENT)
            {
                _loc_9 = _loc_9 * -2;
                _loc_9 = _loc_9 - 2 * param3.strikethroughThickness;
            }
            else if (_loc_6 == TextBaseline.IDEOGRAPHIC_BOTTOM || _loc_6 == TextBaseline.DESCENT)
            {
                _loc_9 = _loc_9 * 2;
                _loc_9 = _loc_9 + 2 * param3.strikethroughThickness;
            }
            else
            {
                _loc_9 = _loc_9 - param3.strikethroughThickness;
            }
            _loc_9 = _loc_9 + (_loc_8 - _loc_4);
            return _loc_9;
        }// end function

        function calculateUnderlineOffset(param1:Number, param2:String, param3:FontMetrics, param4:TextLine) : Number
        {
            var _loc_7:* = null;
            var _loc_5:* = param3.underlineOffset + param3.underlineThickness;
            var _loc_6:* = param3.strikethroughOffset;
            if (param2 != BlockProgression.RL)
            {
                _loc_5 = _loc_5 + (param1 - _loc_6 + param3.underlineThickness / 2);
            }
            else
            {
                _loc_7 = this.getParagraph();
                if (_loc_7.computedFormat.locale.toLowerCase().indexOf("zh") == 0)
                {
                    _loc_5 = -_loc_5;
                    _loc_5 = _loc_5 - (param1 - _loc_6 + param3.underlineThickness * 2);
                }
                else
                {
                    _loc_5 = _loc_5 - (-_loc_5 + param1 + _loc_6 + param3.underlineThickness / 2);
                }
            }
            return _loc_5;
        }// end function

        static function resolveDomBaseline(param1:ITextLayoutFormat, param2:ParagraphElement) : String
        {
            var _loc_3:* = param1.dominantBaseline;
            if (_loc_3 == FormatValue.AUTO)
            {
                if (param1.textRotation == TextRotation.ROTATE_270)
                {
                    _loc_3 = TextBaseline.IDEOGRAPHIC_CENTER;
                }
                else if (param2 != null)
                {
                    _loc_3 = param2.getEffectiveDominantBaseline();
                }
                else
                {
                    _loc_3 = LocaleUtil.dominantBaseline(param1.locale);
                }
            }
            return _loc_3;
        }// end function

        private static function translateColor(param1:String) : Number
        {
            var _loc_2:* = NaN;
            switch(param1.toLowerCase())
            {
                case ColorName.BLACK:
                {
                    _loc_2 = 0;
                    break;
                }
                case ColorName.BLUE:
                {
                    _loc_2 = 255;
                    break;
                }
                case ColorName.GREEN:
                {
                    _loc_2 = 32768;
                    break;
                }
                case ColorName.GRAY:
                {
                    _loc_2 = 8421504;
                    break;
                }
                case ColorName.SILVER:
                {
                    _loc_2 = 12632256;
                    break;
                }
                case ColorName.LIME:
                {
                    _loc_2 = 65280;
                    break;
                }
                case ColorName.OLIVE:
                {
                    _loc_2 = 8421376;
                    break;
                }
                case ColorName.WHITE:
                {
                    _loc_2 = 16777215;
                    break;
                }
                case ColorName.YELLOW:
                {
                    _loc_2 = 16776960;
                    break;
                }
                case ColorName.MAROON:
                {
                    _loc_2 = 8388608;
                    break;
                }
                case ColorName.NAVY:
                {
                    _loc_2 = 128;
                    break;
                }
                case ColorName.RED:
                {
                    _loc_2 = 16711680;
                    break;
                }
                case ColorName.PURPLE:
                {
                    _loc_2 = 8388736;
                    break;
                }
                case ColorName.TEAL:
                {
                    _loc_2 = 32896;
                    break;
                }
                case ColorName.FUCHSIA:
                {
                    _loc_2 = 16711935;
                    break;
                }
                case ColorName.AQUA:
                {
                    _loc_2 = 65535;
                    break;
                }
                case ColorName.MAGENTA:
                {
                    _loc_2 = 16711935;
                    break;
                }
                case ColorName.CYAN:
                {
                    _loc_2 = 65535;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        static function computeElementFormatHelper(param1:ITextLayoutFormat, param2:ParagraphElement, param3:ISWFContext) : ElementFormat
        {
            var _loc_7:* = null;
            var _loc_4:* = new ElementFormat();
            new ElementFormat().alignmentBaseline = param1.alignmentBaseline;
            _loc_4.alpha = Number(param1.textAlpha);
            _loc_4.breakOpportunity = param1.breakOpportunity;
            _loc_4.color = param1.color is String ? (translateColor(param1.color)) : (uint(param1.color));
            _loc_4.dominantBaseline = resolveDomBaseline(param1, param2);
            _loc_4.digitCase = param1.digitCase;
            _loc_4.digitWidth = param1.digitWidth;
            _loc_4.ligatureLevel = param1.ligatureLevel;
            _loc_4.fontSize = Number(param1.fontSize);
            _loc_4.kerning = param1.kerning;
            _loc_4.locale = param1.locale;
            _loc_4.trackingLeft = TextLayoutFormat.trackingLeftProperty.computeActualPropertyValue(param1.trackingLeft, _loc_4.fontSize);
            _loc_4.trackingRight = TextLayoutFormat.trackingRightProperty.computeActualPropertyValue(param1.trackingRight, _loc_4.fontSize);
            _loc_4.textRotation = param1.textRotation;
            _loc_4.baselineShift = -TextLayoutFormat.baselineShiftProperty.computeActualPropertyValue(param1.baselineShift, _loc_4.fontSize);
            switch(param1.typographicCase)
            {
                case TLFTypographicCase.LOWERCASE_TO_SMALL_CAPS:
                {
                    _loc_4.typographicCase = TypographicCase.CAPS_AND_SMALL_CAPS;
                    break;
                }
                case TLFTypographicCase.CAPS_TO_SMALL_CAPS:
                {
                    _loc_4.typographicCase = TypographicCase.SMALL_CAPS;
                    break;
                }
                default:
                {
                    _loc_4.typographicCase = param1.typographicCase;
                    break;
                    break;
                }
            }
            var _loc_5:* = new FontDescription();
            new FontDescription().fontWeight = param1.fontWeight;
            _loc_5.fontPosture = param1.fontStyle;
            _loc_5.fontName = param1.fontFamily;
            _loc_5.renderingMode = param1.renderingMode;
            _loc_5.cffHinting = param1.cffHinting;
            if (GlobalSettings.resolveFontLookupFunction == null)
            {
                _loc_5.fontLookup = param1.fontLookup;
            }
            else
            {
                _loc_5.fontLookup = GlobalSettings.resolveFontLookupFunction(param3 ? (FlowComposerBase.computeBaseSWFContext(param3)) : (null), param1);
            }
            var _loc_6:* = GlobalSettings.fontMapperFunction;
            if (GlobalSettings.fontMapperFunction != null)
            {
                FlowLeafElement._loc_6(_loc_5);
            }
            _loc_4.fontDescription = _loc_5;
            if (param1.baselineShift == BaselineShift.SUPERSCRIPT || param1.baselineShift == BaselineShift.SUBSCRIPT)
            {
                if (param3)
                {
                    _loc_7 = param3.callInContext(_loc_4.getFontMetrics, _loc_4, null, true);
                }
                else
                {
                    _loc_7 = _loc_4.getFontMetrics();
                }
                if (param1.baselineShift == BaselineShift.SUPERSCRIPT)
                {
                    _loc_4.baselineShift = _loc_7.superscriptOffset * _loc_4.fontSize;
                    _loc_4.fontSize = _loc_7.superscriptScale * _loc_4.fontSize;
                }
                else
                {
                    _loc_4.baselineShift = _loc_7.subscriptOffset * _loc_4.fontSize;
                    _loc_4.fontSize = _loc_7.subscriptScale * _loc_4.fontSize;
                }
            }
            return _loc_4;
        }// end function

        static function getCSSInlineBoxHelper(param1:ITextLayoutFormat, param2:FontMetrics, param3:TextLine, param4:ParagraphElement = null) : Rectangle
        {
            var _loc_14:* = NaN;
            var _loc_5:* = param2.emBox;
            var _loc_6:* = -param2.emBox.top;
            var _loc_7:* = _loc_5.bottom;
            var _loc_8:* = _loc_5.height;
            var _loc_9:* = param1.fontSize;
            var _loc_10:* = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(param1.lineHeight, _loc_9);
            var _loc_11:* = (TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(param1.lineHeight, _loc_9) - _loc_8) / 2;
            _loc_5.top = _loc_5.top - _loc_11;
            _loc_5.bottom = _loc_5.bottom + _loc_11;
            var _loc_12:* = resolveDomBaseline(param1, param4);
            switch(_loc_12)
            {
                case TextBaseline.ASCENT:
                case TextBaseline.IDEOGRAPHIC_TOP:
                {
                    _loc_5.offset(0, _loc_6);
                    break;
                }
                case TextBaseline.IDEOGRAPHIC_CENTER:
                {
                    _loc_5.offset(0, _loc_6 - _loc_8 / 2);
                    break;
                }
                case TextBaseline.ROMAN:
                {
                    break;
                }
                case TextBaseline.DESCENT:
                case TextBaseline.IDEOGRAPHIC_BOTTOM:
                {
                    _loc_5.offset(0, -_loc_7);
                }
                default:
                {
                    break;
                }
            }
            var _loc_13:* = param1.alignmentBaseline == TextBaseline.USE_DOMINANT_BASELINE ? (_loc_12) : (param1.alignmentBaseline);
            _loc_5.offset(0, param3.getBaselinePosition(_loc_13));
            if (param1.baselineShift == BaselineShift.SUPERSCRIPT)
            {
                _loc_14 = param2.superscriptOffset * _loc_9;
            }
            else if (param1.baselineShift == BaselineShift.SUBSCRIPT)
            {
                _loc_14 = param2.subscriptOffset * _loc_9;
            }
            else
            {
                _loc_14 = -param1.baselineShift;
            }
            _loc_5.offset(0, _loc_14);
            return _loc_5;
        }// end function

    }
}
