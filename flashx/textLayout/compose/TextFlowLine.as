package flashx.textLayout.compose
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    final public class TextFlowLine extends Object implements IVerticalJustificationLine
    {
        private var _absoluteStart:int;
        private var _textLength:int;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _height:Number = 0;
        private var _outerTargetWidth:Number = 0;
        private var _boundsLeftTW:int = 2;
        private var _boundsRightTW:int = 1;
        private var _para:ParagraphElement;
        private var _controller:ContainerController;
        private var _columnIndex:int;
        private var _adornCount:int = 0;
        private var _flags:uint;
        private var _ascent:Number;
        private var _descent:Number;
        private var _targetWidth:Number;
        private var _lineOffset:Number;
        private var _lineExtent:Number;
        private var _accumulatedLineExtent:Number;
        private var _accumulatedMinimumStart:Number;
        private var _numberLinePosition:int;
        private static var _selectionBlockCache:Dictionary = new Dictionary(true);
        private static const VALIDITY_MASK:uint = 7;
        private static const ALIGNMENT_SHIFT:uint = 3;
        private static const ALIGNMENT_MASK:uint = 24;
        private static const NUMBERLINE_MASK:uint = 32;
        private static const GRAPHICELEMENT_MASK:uint = 64;
        private static const _validities:Array = [TextLineValidity.INVALID, TextLineValidity.POSSIBLY_INVALID, TextLineValidity.STATIC, TextLineValidity.VALID, FlowDamageType.GEOMETRY];
        private static const _alignments:Array = [TextAlign.LEFT, TextAlign.CENTER, TextAlign.RIGHT];
        private static var numberLineFactory:NumberLineFactory;
        private static const localZeroPoint:Point = new Point(0, 0);
        private static const localOnePoint:Point = new Point(1, 0);
        private static const rlLocalOnePoint:Point = new Point(0, 1);

        public function TextFlowLine(param1:TextLine, param2:ParagraphElement, param3:Number = 0, param4:Number = 0, param5:int = 0, param6:int = 0)
        {
            this.initialize(param2, param3, param4, param5, param6, param1);
            return;
        }// end function

        function initialize(param1:ParagraphElement, param2:Number = 0, param3:Number = 0, param4:int = 0, param5:int = 0, param6:TextLine = null) : void
        {
            this._para = param1;
            this._outerTargetWidth = param2;
            this._absoluteStart = param4;
            this._textLength = param5;
            this._adornCount = 0;
            this._lineExtent = 0;
            this._accumulatedLineExtent = 0;
            this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
            this._flags = 0;
            this._controller = null;
            if (param6)
            {
                param6.userData = this;
                this._targetWidth = param6.specifiedWidth;
                this._ascent = param6.ascent;
                this._descent = param6.descent;
                this._lineOffset = param3;
                this.setValidity(param6.validity);
                this.setFlag(param6.hasGraphicElement ? (GRAPHICELEMENT_MASK) : (0), GRAPHICELEMENT_MASK);
            }
            else
            {
                this.setValidity(TextLineValidity.INVALID);
            }
            return;
        }// end function

        private function setFlag(param1:uint, param2:uint) : void
        {
            this._flags = this._flags & ~param2 | param1;
            return;
        }// end function

        private function getFlag(param1:uint) : uint
        {
            return this._flags & param1;
        }// end function

        function get heightTW() : int
        {
            return Twips.to(this._height);
        }// end function

        function get outerTargetWidthTW() : int
        {
            return Twips.to(this._outerTargetWidth);
        }// end function

        function get ascentTW() : int
        {
            return Twips.to(this._ascent);
        }// end function

        function get targetWidthTW() : int
        {
            return Twips.to(this._targetWidth);
        }// end function

        function get textHeightTW() : int
        {
            return Twips.to(this.textHeight);
        }// end function

        function get lineOffsetTW() : int
        {
            return Twips.to(this._lineOffset);
        }// end function

        function get lineExtentTW() : int
        {
            return Twips.to(this._lineExtent);
        }// end function

        function get hasGraphicElement() : Boolean
        {
            return this.getFlag(GRAPHICELEMENT_MASK) != 0;
        }// end function

        function get hasNumberLine() : Boolean
        {
            return this.getFlag(NUMBERLINE_MASK) != 0;
        }// end function

        function get numberLinePosition() : Number
        {
            return Twips.from(this._numberLinePosition);
        }// end function

        function set numberLinePosition(param1:Number) : void
        {
            this._numberLinePosition = Twips.to(param1);
            return;
        }// end function

        public function get textHeight() : Number
        {
            return this._ascent + this._descent;
        }// end function

        public function get x() : Number
        {
            return this._x;
        }// end function

        public function set x(param1:Number) : void
        {
            this._x = param1;
            this._boundsLeftTW = 2;
            this._boundsRightTW = 1;
            return;
        }// end function

        function get xTW() : int
        {
            return Twips.to(this._x);
        }// end function

        public function get y() : Number
        {
            return this._y;
        }// end function

        function get yTW() : int
        {
            return Twips.to(this._y);
        }// end function

        public function set y(param1:Number) : void
        {
            this._y = param1;
            this._boundsLeftTW = 2;
            this._boundsRightTW = 1;
            return;
        }// end function

        function setXYAndHeight(param1:Number, param2:Number, param3:Number) : void
        {
            this._x = param1;
            this._y = param2;
            this._height = param3;
            this._boundsLeftTW = 2;
            this._boundsRightTW = 1;
            return;
        }// end function

        public function get location() : int
        {
            var _loc_1:* = 0;
            if (this._para)
            {
                _loc_1 = this._absoluteStart - this._para.getAbsoluteStart();
                if (_loc_1 == 0)
                {
                    return this._textLength == this._para.textLength ? (TextFlowLineLocation.ONLY) : (TextFlowLineLocation.FIRST);
                }
                if (_loc_1 + this.textLength == this._para.textLength)
                {
                    return TextFlowLineLocation.LAST;
                }
            }
            return TextFlowLineLocation.MIDDLE;
        }// end function

        public function get controller() : ContainerController
        {
            return this._controller;
        }// end function

        public function get columnIndex() : int
        {
            return this._columnIndex;
        }// end function

        function setController(param1:ContainerController, param2:int) : void
        {
            this._controller = param1 as ContainerController;
            this._columnIndex = param2;
            return;
        }// end function

        public function get height() : Number
        {
            return this._height;
        }// end function

        public function get ascent() : Number
        {
            return this._ascent;
        }// end function

        public function get descent() : Number
        {
            return this._descent;
        }// end function

        public function get lineOffset() : Number
        {
            return this._lineOffset;
        }// end function

        public function get paragraph() : ParagraphElement
        {
            return this._para;
        }// end function

        public function get absoluteStart() : int
        {
            return this._absoluteStart;
        }// end function

        function setAbsoluteStart(param1:int) : void
        {
            this._absoluteStart = param1;
            return;
        }// end function

        public function get textLength() : int
        {
            return this._textLength;
        }// end function

        function setTextLength(param1:int) : void
        {
            this._textLength = param1;
            this.damage(TextLineValidity.INVALID);
            return;
        }// end function

        public function get spaceBefore() : Number
        {
            return this.location & TextFlowLineLocation.FIRST ? (this._para.computedFormat.paragraphSpaceBefore) : (0);
        }// end function

        public function get spaceAfter() : Number
        {
            return this.location & TextFlowLineLocation.LAST ? (this._para.computedFormat.paragraphSpaceAfter) : (0);
        }// end function

        function get outerTargetWidth() : Number
        {
            return this._outerTargetWidth;
        }// end function

        function set outerTargetWidth(param1:Number) : void
        {
            this._outerTargetWidth = param1;
            return;
        }// end function

        function get targetWidth() : Number
        {
            return this._targetWidth;
        }// end function

        public function getBounds() : Rectangle
        {
            var _loc_1:* = this.getTextLine(true);
            if (!_loc_1)
            {
                return new Rectangle();
            }
            var _loc_2:* = this.paragraph.getAncestorWithContainer().computedFormat.blockProgression;
            var _loc_3:* = this.x;
            var _loc_4:* = this.createShapeY(_loc_2);
            if (_loc_2 == BlockProgression.TB)
            {
                _loc_4 = _loc_4 + (this.descent - _loc_1.height);
            }
            return new Rectangle(_loc_3, _loc_4, _loc_1.width, _loc_1.height);
        }// end function

        private function setValidity(param1:String) : void
        {
            this.setFlag(_validities.indexOf(param1), VALIDITY_MASK);
            return;
        }// end function

        public function get validity() : String
        {
            return _validities[this.getFlag(VALIDITY_MASK)];
        }// end function

        public function get unjustifiedTextWidth() : Number
        {
            var _loc_1:* = this.getTextLine(true);
            return _loc_1.unjustifiedTextWidth + (this._outerTargetWidth - this.targetWidth);
        }// end function

        function get lineExtent() : Number
        {
            return this._lineExtent;
        }// end function

        function set lineExtent(param1:Number) : void
        {
            this._lineExtent = param1;
            return;
        }// end function

        function get accumulatedLineExtent() : Number
        {
            return this._accumulatedLineExtent;
        }// end function

        function set accumulatedLineExtent(param1:Number) : void
        {
            this._accumulatedLineExtent = param1;
            return;
        }// end function

        function get accumulatedMinimumStart() : Number
        {
            return this._accumulatedMinimumStart;
        }// end function

        function set accumulatedMinimumStart(param1:Number) : void
        {
            this._accumulatedMinimumStart = param1;
            return;
        }// end function

        function get alignment() : String
        {
            return _alignments[this.getFlag(ALIGNMENT_MASK) >> ALIGNMENT_SHIFT];
        }// end function

        function set alignment(param1:String) : void
        {
            this.setFlag(_alignments.indexOf(param1) << ALIGNMENT_SHIFT, ALIGNMENT_MASK);
            return;
        }// end function

        function isDamaged() : Boolean
        {
            return this.validity != TextLineValidity.VALID;
        }// end function

        function clearDamage() : void
        {
            this.setValidity(TextLineValidity.VALID);
            return;
        }// end function

        function damage(param1:String) : void
        {
            var _loc_2:* = this.validity;
            if (_loc_2 == param1 || _loc_2 == TextLineValidity.INVALID)
            {
                return;
            }
            this.setValidity(param1);
            return;
        }// end function

        function isLineVisible(param1:String, param2:int, param3:int, param4:int, param5:int) : Boolean
        {
            if (param1 == BlockProgression.RL)
            {
                return this._boundsRightTW >= param2 && this._boundsLeftTW < param2 + param4;
            }
            return this._boundsRightTW >= param3 && this._boundsLeftTW < param3 + param5;
        }// end function

        function cacheLineBounds(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) : void
        {
            if (param1 == BlockProgression.RL)
            {
                this._boundsLeftTW = Twips.to(param2);
                this._boundsRightTW = Twips.to(param2 + param4);
            }
            else
            {
                this._boundsLeftTW = Twips.to(param3);
                this._boundsRightTW = Twips.to(param3 + param5);
            }
            return;
        }// end function

        function hasLineBounds() : Boolean
        {
            return this._boundsLeftTW <= this._boundsRightTW;
        }// end function

        public function get textLineExists() : Boolean
        {
            return this.peekTextLine() != null;
        }// end function

        function peekTextLine() : TextLine
        {
            var _loc_1:* = null;
            if (!this.paragraph)
            {
                return null;
            }
            var _loc_2:* = this.paragraph.peekTextBlock();
            if (_loc_2)
            {
                _loc_1 = _loc_2.firstLine;
                while (_loc_1)
                {
                    
                    if (_loc_1.userData == this)
                    {
                        return _loc_1;
                    }
                    _loc_1 = _loc_1.nextLine;
                }
            }
            return null;
        }// end function

        public function getTextLine(param1:Boolean = false) : TextLine
        {
            var _loc_2:* = this.peekTextLine();
            if (_loc_2 && _loc_2.validity == FlowDamageType.GEOMETRY)
            {
                this.createShape(this.paragraph.getTextFlow().computedFormat.blockProgression, _loc_2);
            }
            else if (!_loc_2 || _loc_2.validity == TextLineValidity.INVALID && param1)
            {
                if (this.isDamaged() && this.validity != FlowDamageType.GEOMETRY)
                {
                    return null;
                }
                _loc_2 = this.getTextLineInternal();
            }
            return _loc_2;
        }// end function

        private function getTextLineInternal() : TextLine
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = this.paragraph.getAbsoluteStart();
            var _loc_2:* = this.paragraph.getTextBlock();
            var _loc_3:* = _loc_2.firstLine;
            var _loc_4:* = this.paragraph.getTextFlow().flowComposer;
            var _loc_5:* = this.paragraph.getTextFlow().flowComposer.findLineIndexAtPosition(_loc_1);
            var _loc_6:* = null;
            do
            {
                
                _loc_8 = _loc_4.getLineAt(_loc_5);
                if (_loc_3 != null && _loc_3.validity == TextLineValidity.VALID && (_loc_8 != this || _loc_3.userData == _loc_8))
                {
                    _loc_7 = _loc_3;
                    _loc_3 = _loc_3.nextLine;
                }
                else
                {
                    _loc_7 = _loc_8.recreateTextLine(_loc_2, _loc_6);
                    _loc_3 = null;
                }
                _loc_6 = _loc_7;
                _loc_5++;
            }while (_loc_8 != this)
            return _loc_7;
        }// end function

        function recreateTextLine(param1:TextBlock, param2:TextLine) : TextLine
        {
            var _loc_3:* = null;
            var _loc_8:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_4:* = this._para.getTextFlow();
            var _loc_5:* = this._para.getTextFlow().computedFormat.blockProgression;
            var _loc_6:* = _loc_4.flowComposer;
            var _loc_7:* = _loc_4.flowComposer.swfContext ? (_loc_6.swfContext) : (BaseCompose.globalSWFContext);
            var _loc_9:* = this._lineOffset;
            if (this.hasNumberLine)
            {
                _loc_10 = this._lineOffset - this._para.computedFormat.textIndent;
                _loc_8 = TextFlowLine.createNumberLine(this._para.getParentByType(ListItemElement) as ListItemElement, this._para, _loc_6.swfContext, _loc_10);
                if (_loc_8)
                {
                    if (getNumberLineListStylePosition(_loc_8) == ListStylePosition.INSIDE)
                    {
                        _loc_9 = _loc_9 + getNumberLineInsideLineWidth(_loc_8);
                    }
                }
            }
            _loc_3 = TextLineRecycler.getLineForReuse();
            if (_loc_3)
            {
                _loc_3 = _loc_7.callInContext(param1["recreateTextLine"], param1, [_loc_3, param2, this._targetWidth, _loc_9, true]);
            }
            else
            {
                _loc_3 = _loc_7.callInContext(param1.createTextLine, param1, [param2, this._targetWidth, _loc_9, true]);
            }
            _loc_3.x = this.x;
            _loc_3.y = this.createShapeY(_loc_5);
            _loc_3.doubleClickEnabled = true;
            _loc_3.userData = this;
            if (this._adornCount > 0)
            {
                _loc_11 = this._para.getAbsoluteStart();
                _loc_12 = this._para.findLeaf(this.absoluteStart - _loc_11);
                _loc_13 = _loc_12.getAbsoluteStart();
                if (_loc_8)
                {
                    _loc_14 = this._para.getParentByType(ListItemElement) as ListItemElement;
                    TextFlowLine.initializeNumberLinePosition(_loc_8, _loc_14, this._para, _loc_3.textWidth);
                }
                this.createAdornments(this._para.getAncestorWithContainer().computedFormat.blockProgression, _loc_12, _loc_13, _loc_3, _loc_8);
                if (_loc_8 && getNumberLineListStylePosition(_loc_8) == ListStylePosition.OUTSIDE)
                {
                    if (_loc_5 == BlockProgression.TB)
                    {
                        _loc_8.x = this.numberLinePosition;
                    }
                    else
                    {
                        _loc_8.y = this.numberLinePosition;
                    }
                }
            }
            return _loc_3;
        }// end function

        function createShape(param1:String, param2:TextLine) : void
        {
            var _loc_3:* = this.x;
            param2.x = _loc_3;
            var _loc_4:* = this.createShapeY(param1);
            param2.y = _loc_4;
            return;
        }// end function

        private function createShapeY(param1:String) : Number
        {
            return param1 == BlockProgression.RL ? (this.y) : (this.y + this._ascent);
        }// end function

        function createAdornments(param1:String, param2:FlowLeafElement, param3:int, param4:TextLine, param5:TextLine) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = undefined;
            var _loc_6:* = this._absoluteStart + this._textLength;
            this._adornCount = 0;
            if (param5)
            {
                var _loc_10:* = this;
                var _loc_11:* = this._adornCount + 1;
                _loc_10._adornCount = _loc_11;
                this.setFlag(NUMBERLINE_MASK, NUMBERLINE_MASK);
                param4.addChild(param5);
                if (getNumberLineBackground(param5) != null)
                {
                    _loc_7 = param2.getTextFlow().getBackgroundManager();
                    if (_loc_7)
                    {
                        _loc_7.addNumberLine(param4, param5);
                    }
                }
            }
            else
            {
                this.setFlag(0, NUMBERLINE_MASK);
            }
            while (true)
            {
                
                this._adornCount = this._adornCount + param2.updateAdornments(param4, param1);
                _loc_8 = param2.format;
                _loc_9 = _loc_8 ? (_loc_8.getStyle("imeStatus")) : (undefined);
                if (_loc_9)
                {
                    param2.updateIMEAdornments(param4, param1, _loc_9 as String);
                }
                param3 = param3 + param2.textLength;
                if (param3 >= _loc_6)
                {
                    break;
                }
                param2 = param2.getNextLeaf(this._para);
            }
            return;
        }// end function

        function getLineLeading(param1:String, param2:FlowLeafElement, param3:int) : Number
        {
            var _loc_6:* = NaN;
            var _loc_4:* = this._absoluteStart + this._textLength;
            var _loc_5:* = 0;
            while (true)
            {
                
                _loc_6 = param2.getEffectiveLineHeight(param1);
                if (!_loc_6 && param2.textLength == this.textLength)
                {
                    _loc_6 = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(param2.computedFormat.lineHeight, param2.computedFormat.fontSize);
                }
                _loc_5 = Math.max(_loc_5, _loc_6);
                param3 = param3 + param2.textLength;
                if (param3 >= _loc_4)
                {
                    break;
                }
                param2 = param2.getNextLeaf(this._para);
            }
            return _loc_5;
        }// end function

        function getLineTypographicAscent(param1:FlowLeafElement, param2:int, param3:TextLine) : Number
        {
            return getTextLineTypographicAscent(param3 ? (param3) : (this.getTextLine()), param1, param2, this.absoluteStart + this.textLength);
        }// end function

        function getCSSLineBox(param1:String, param2:FlowLeafElement, param3:int, param4:ISWFContext, param5:ITextLayoutFormat = null, param6:TextLine = null) : Rectangle
        {
            var lineBox:Rectangle;
            var para:ParagraphElement;
            var ef:ElementFormat;
            var metrics:FontMetrics;
            var bp:* = param1;
            var elem:* = param2;
            var elemStart:* = param3;
            var swfContext:* = param4;
            var effectiveListMarkerFormat:* = param5;
            var numberLine:* = param6;
            var addToLineBox:* = function (param1:Rectangle) : void
            {
                if (param1)
                {
                    lineBox = lineBox ? (lineBox.union(param1)) : (param1);
                }
                return;
            }// end function
            ;
            var endPos:* = this._absoluteStart + this._textLength;
            var textLine:* = this.getTextLine();
            while (true)
            {
                
                this.addToLineBox(elem.getCSSInlineBox(bp, textLine, this._para, swfContext));
                elemStart = elemStart + elem.textLength;
                if (elemStart >= endPos)
                {
                    break;
                }
                elem = elem.getNextLeaf(this._para);
            }
            if (effectiveListMarkerFormat && numberLine)
            {
                para;
                ef = FlowLeafElement.computeElementFormatHelper(effectiveListMarkerFormat, para, swfContext);
                metrics = swfContext ? (swfContext.callInContext(ef.getFontMetrics, ef, null, true)) : (ef.getFontMetrics());
                this.addToLineBox(FlowLeafElement.getCSSInlineBoxHelper(effectiveListMarkerFormat, metrics, numberLine, para));
            }
            return lineBox;
        }// end function

        private function isTextlineSubsetOfSpan(param1:FlowLeafElement) : Boolean
        {
            var _loc_2:* = param1.getAbsoluteStart();
            var _loc_3:* = _loc_2 + param1.textLength;
            var _loc_4:* = this.absoluteStart;
            var _loc_5:* = this.absoluteStart + this._textLength;
            return _loc_2 <= _loc_4 && _loc_3 >= _loc_5;
        }// end function

        private function getSelectionShapesCacheEntry(param1:int, param2:int, param3:TextFlowLine, param4:TextFlowLine, param5:String) : SelectionCache
        {
            var _loc_12:* = null;
            if (this.isDamaged())
            {
                return null;
            }
            var _loc_6:* = this._para.getAbsoluteStart();
            if (param1 == param2 && _loc_6 + param1 == this.absoluteStart)
            {
                if (this.absoluteStart != (this._para.getTextFlow().textLength - 1))
                {
                    return null;
                }
                param2++;
            }
            var _loc_7:* = _selectionBlockCache[this];
            if (_selectionBlockCache[this] && _loc_7.begIdx == param1 && _loc_7.endIdx == param2)
            {
                return _loc_7;
            }
            var _loc_8:* = new Array();
            var _loc_9:* = new Array();
            if (_loc_7 == null)
            {
                _loc_7 = new SelectionCache();
                _selectionBlockCache[this] = _loc_7;
            }
            else
            {
                _loc_7.clear();
            }
            _loc_7.begIdx = param1;
            _loc_7.endIdx = param2;
            var _loc_10:* = this.getTextLine();
            var _loc_11:* = this.getRomanSelectionHeightAndVerticalAdjustment(param3, param4);
            this.calculateSelectionBounds(_loc_10, _loc_8, param1, param2, param5, _loc_11);
            for each (_loc_12 in _loc_8)
            {
                
                _loc_7.pushSelectionBlock(_loc_12);
            }
            return _loc_7;
        }// end function

        function calculateSelectionBounds(param1:TextLine, param2:Array, param3:int, param4:int, param5:String, param6:Array) : void
        {
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_25:* = NaN;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = null;
            var _loc_31:* = 0;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = 0;
            var _loc_36:* = 0;
            var _loc_7:* = this._para.computedFormat.direction;
            var _loc_8:* = this._para.getAbsoluteStart();
            var _loc_9:* = param3;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = new Array();
            var _loc_13:* = null;
            var _loc_14:* = null;
            while (_loc_9 < param4)
            {
                
                _loc_10 = this._para.findLeaf(_loc_9);
                if (_loc_10.textLength == 0)
                {
                    _loc_9++;
                    continue;
                }
                else if (_loc_10 is InlineGraphicElement && (_loc_10 as InlineGraphicElement).computedFloat != Float.NONE)
                {
                    if (_loc_13 == null)
                    {
                        _loc_13 = new Array();
                    }
                    _loc_17 = _loc_10 as InlineGraphicElement;
                    _loc_18 = this.controller.getFloatAtPosition(_loc_8 + _loc_9);
                    if (_loc_18)
                    {
                        _loc_19 = new Rectangle(_loc_18.x - param1.x, _loc_18.y - param1.y, _loc_17.elementWidth, _loc_17.elementHeight);
                        _loc_13.push(_loc_19);
                    }
                    _loc_9++;
                    continue;
                }
                _loc_15 = _loc_10.textLength + _loc_10.getElementRelativeStart(this._para) - _loc_9;
                _loc_16 = _loc_15 + _loc_9 > param4 ? (param4) : (_loc_15 + _loc_9);
                if (param5 != BlockProgression.RL || param1.getAtomTextRotation(param1.getAtomIndexAtCharIndex(_loc_9)) != TextRotation.ROTATE_0)
                {
                    _loc_20 = this.makeSelectionBlocks(param1, _loc_9, _loc_16, _loc_8, param5, _loc_7, param6);
                    _loc_21 = 0;
                    while (_loc_21 < _loc_20.length)
                    {
                        
                        _loc_12.push(_loc_20[_loc_21]);
                        _loc_21++;
                    }
                }
                else
                {
                    _loc_22 = _loc_10.getParentByType(TCYElement);
                    _loc_23 = _loc_22.parentRelativeEnd;
                    _loc_24 = _loc_22.getParentByType(SubParagraphGroupElementBase) as SubParagraphGroupElementBase;
                    while (_loc_24)
                    {
                        
                        _loc_23 = _loc_23 + _loc_24.parentRelativeStart;
                        _loc_24 = _loc_24.getParentByType(SubParagraphGroupElementBase) as SubParagraphGroupElementBase;
                    }
                    _loc_25 = 0;
                    _loc_26 = param4 < _loc_23 ? (param4) : (_loc_23);
                    _loc_27 = new Array();
                    while (_loc_9 < _loc_26)
                    {
                        
                        _loc_10 = this._para.findLeaf(_loc_9);
                        _loc_15 = _loc_10.textLength + _loc_10.getElementRelativeStart(this._para) - _loc_9;
                        _loc_16 = _loc_15 + _loc_9 > param4 ? (param4) : (_loc_15 + _loc_9);
                        _loc_28 = this.makeSelectionBlocks(param1, _loc_9, _loc_16, _loc_8, param5, _loc_7, param6);
                        _loc_29 = 0;
                        while (_loc_29 < _loc_28.length)
                        {
                            
                            _loc_30 = _loc_28[_loc_29];
                            if (_loc_30.height > _loc_25)
                            {
                                _loc_25 = _loc_30.height;
                            }
                            _loc_27.push(_loc_30);
                            _loc_29++;
                        }
                        _loc_9 = _loc_16;
                    }
                    if (!_loc_14)
                    {
                        _loc_14 = new Array();
                    }
                    this.normalizeRects(_loc_27, _loc_14, _loc_25, BlockProgression.TB, _loc_7);
                    continue;
                }
                _loc_9 = _loc_16;
            }
            if (_loc_12.length > 0 && _loc_8 + param3 == this.absoluteStart && _loc_8 + param4 == this.absoluteStart + this.textLength)
            {
                _loc_10 = this._para.findLeaf(param3);
                if (_loc_10.getAbsoluteStart() + _loc_10.textLength < this.absoluteStart + this.textLength && _loc_16 >= 2)
                {
                    _loc_31 = this._para.getCharCodeAtPosition((_loc_16 - 1));
                    if (_loc_31 != SpanElement.kParagraphTerminator.charCodeAt(0) && CharacterUtil.isWhitespace(_loc_31))
                    {
                        _loc_32 = this.makeSelectionBlocks(param1, (_loc_16 - 1), (_loc_16 - 1), _loc_8, param5, _loc_7, param6);
                        _loc_33 = this.makeSelectionBlocks(param1, (_loc_16 - 1), (_loc_16 - 1), _loc_8, param5, _loc_7, param6)[(_loc_32.length - 1)];
                        _loc_34 = _loc_12[(_loc_12.length - 1)] as Rectangle;
                        if (param5 != BlockProgression.RL)
                        {
                            if (_loc_34.width == _loc_33.width)
                            {
                                _loc_12.pop();
                            }
                            else
                            {
                                _loc_34.width = _loc_34.width - _loc_33.width;
                                if (_loc_7 == Direction.RTL)
                                {
                                    _loc_34.left = _loc_34.left - _loc_33.width;
                                }
                            }
                        }
                        else if (_loc_34.height == _loc_33.height)
                        {
                            _loc_12.pop();
                        }
                        else
                        {
                            _loc_34.height = _loc_34.height - _loc_33.height;
                            if (_loc_7 == Direction.RTL)
                            {
                                _loc_34.top = _loc_34.top + _loc_33.height;
                            }
                        }
                    }
                }
            }
            this.normalizeRects(_loc_12, param2, _loc_11, param5, _loc_7);
            if (_loc_14 && _loc_14.length > 0)
            {
                _loc_35 = 0;
                while (_loc_35 < _loc_14.length)
                {
                    
                    param2.push(_loc_14[_loc_35]);
                    _loc_35++;
                }
            }
            if (_loc_13)
            {
                _loc_36 = 0;
                while (_loc_36 < _loc_13.length)
                {
                    
                    param2.push(_loc_13[_loc_36]);
                    _loc_36++;
                }
            }
            return;
        }// end function

        private function createSelectionShapes(param1:Shape, param2:SelectionFormat, param3:DisplayObject, param4:int, param5:int, param6:TextFlowLine, param7:TextFlowLine) : void
        {
            var _loc_11:* = null;
            var _loc_13:* = null;
            var _loc_8:* = this._para.getAncestorWithContainer();
            var _loc_9:* = this._para.getAncestorWithContainer().computedFormat.blockProgression;
            var _loc_10:* = this.getSelectionShapesCacheEntry(param4, param5, param6, param7, _loc_9);
            if (!this.getSelectionShapesCacheEntry(param4, param5, param6, param7, _loc_9))
            {
                return;
            }
            var _loc_12:* = param2.rangeColor;
            if (this._para && this._para.getTextFlow())
            {
                _loc_13 = this._para.getTextFlow().interactionManager;
                if (_loc_13 && _loc_13.anchorPosition == _loc_13.activePosition)
                {
                    _loc_12 = param2.pointColor;
                }
            }
            for each (_loc_11 in _loc_10.selectionBlocks)
            {
                
                _loc_11 = _loc_11.clone();
                this.convertLineRectToContainer(_loc_11, true);
                createSelectionRect(param1, _loc_12, _loc_11.x, _loc_11.y, _loc_11.width, _loc_11.height);
            }
            return;
        }// end function

        function getRomanSelectionHeightAndVerticalAdjustment(param1:TextFlowLine, param2:TextFlowLine) : Array
        {
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (ParagraphElement.useUpLeadingDirection(this._para.getEffectiveLeadingModel()))
            {
                _loc_3 = Math.max(this.height, this.textHeight);
            }
            else
            {
                _loc_5 = !param1 || param1.controller != this.controller || param1.columnIndex != this.columnIndex;
                _loc_6 = !param2 || param2.controller != this.controller || param2.columnIndex != this.columnIndex || param2.paragraph.getEffectiveLeadingModel() == LeadingModel.ROMAN_UP;
                if (_loc_6)
                {
                    if (!_loc_5)
                    {
                        _loc_3 = this.textHeight;
                    }
                    else
                    {
                        _loc_3 = Math.max(this.height, this.textHeight);
                    }
                }
                else if (!_loc_5)
                {
                    _loc_3 = Math.max(param2.height, this.textHeight);
                    _loc_4 = _loc_3 - this.textHeight;
                }
                else
                {
                    _loc_7 = this._descent - Math.max(this.height, this.textHeight);
                    _loc_8 = Math.max(param2.height, this.textHeight) - this._ascent;
                    _loc_3 = _loc_8 - _loc_7;
                    _loc_4 = _loc_8 - this._descent;
                }
            }
            if (!param1 || param1.columnIndex != this.columnIndex || param1.controller != this.controller)
            {
                _loc_3 = _loc_3 + this.descent;
                _loc_4 = Math.floor(this.descent / 2);
            }
            return [_loc_3, _loc_4];
        }// end function

        private function makeSelectionBlocks(param1:TextLine, param2:int, param3:int, param4:int, param5:String, param6:String, param7:Array) : Array
        {
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = false;
            var _loc_24:* = false;
            var _loc_25:* = null;
            var _loc_26:* = false;
            var _loc_27:* = null;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_8:* = new Array();
            var _loc_9:* = new Rectangle();
            var _loc_10:* = this._para.findLeaf(param2);
            var _loc_11:* = this._para.findLeaf(param2).getComputedFontMetrics().emBox;
            if (!param1)
            {
                param1 = this.getTextLine(true);
            }
            var _loc_12:* = param1.getAtomIndexAtCharIndex(param2);
            var _loc_13:* = this.adjustEndElementForBidi(param1, param2, param3, _loc_12, param6);
            if (param6 == Direction.RTL && param1.getAtomBidiLevel(_loc_13) % 2 != 0)
            {
                if (_loc_13 == 0 && param2 < (param3 - 1))
                {
                    _loc_8 = this.makeSelectionBlocks(param1, param2, (param3 - 1), param4, param5, param6, param7);
                    _loc_16 = this.makeSelectionBlocks(param1, (param3 - 1), (param3 - 1), param4, param5, param6, param7);
                    _loc_17 = 0;
                    while (_loc_17 < _loc_16.length)
                    {
                        
                        _loc_8.push(_loc_16[_loc_17]);
                        _loc_17++;
                    }
                    return _loc_8;
                }
            }
            var _loc_14:* = _loc_12 != -1 ? (this.isAtomBidi(param1, _loc_12, param6)) : (false);
            var _loc_15:* = _loc_13 != -1 ? (this.isAtomBidi(param1, _loc_13, param6)) : (false);
            if (_loc_14 || _loc_15)
            {
                _loc_18 = param2;
                _loc_19 = param2 != param3 ? (1) : (0);
                _loc_20 = _loc_12;
                _loc_21 = _loc_12;
                _loc_22 = _loc_12;
                _loc_23 = _loc_14;
                do
                {
                    
                    _loc_18 = _loc_18 + _loc_19;
                    _loc_22 = param1.getAtomIndexAtCharIndex(_loc_18);
                    _loc_24 = _loc_22 != -1 ? (this.isAtomBidi(param1, _loc_22, param6)) : (false);
                    if (_loc_22 != -1 && _loc_24 != _loc_23)
                    {
                        _loc_9 = this.makeBlock(param1, _loc_18, _loc_20, _loc_21, _loc_11, param5, param6, param7);
                        _loc_8.push(_loc_9);
                        _loc_20 = _loc_22;
                        _loc_21 = _loc_22;
                        _loc_23 = _loc_24;
                        continue;
                    }
                    if (_loc_18 == param3)
                    {
                        _loc_9 = this.makeBlock(param1, _loc_18, _loc_20, _loc_21, _loc_11, param5, param6, param7);
                        _loc_8.push(_loc_9);
                    }
                    _loc_21 = _loc_22;
                }while (_loc_18 < param3)
            }
            else
            {
                _loc_25 = _loc_10 as InlineGraphicElement;
                if (!_loc_25 || _loc_25.effectiveFloat == Float.NONE || param2 == param3)
                {
                    _loc_9 = this.makeBlock(param1, param2, _loc_12, _loc_13, _loc_11, param5, param6, param7);
                    if (_loc_25 && _loc_25.elementWidthWithMarginsAndPadding() != _loc_25.elementWidth)
                    {
                        _loc_26 = _loc_25.getTextFlow().computedFormat.blockProgression == BlockProgression.RL;
                        _loc_27 = _loc_25.computedFormat;
                        if (_loc_26)
                        {
                            _loc_28 = _loc_25.getEffectivePaddingTop();
                            _loc_9.top = _loc_9.top + _loc_28;
                            _loc_29 = _loc_25.getEffectivePaddingBottom();
                            _loc_9.bottom = _loc_9.bottom - _loc_29;
                        }
                        else
                        {
                            _loc_30 = _loc_25.getEffectivePaddingLeft();
                            _loc_9.left = _loc_9.left + _loc_30;
                            _loc_31 = _loc_25.getEffectivePaddingRight();
                            _loc_9.right = _loc_9.right - _loc_31;
                        }
                    }
                }
                else
                {
                    _loc_9 = _loc_25.graphic.getBounds(param1);
                }
                _loc_8.push(_loc_9);
            }
            return _loc_8;
        }// end function

        private function makeBlock(param1:TextLine, param2:int, param3:int, param4:int, param5:Rectangle, param6:String, param7:String, param8:Array) : Rectangle
        {
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_9:* = new Rectangle();
            var _loc_10:* = new Point(0, 0);
            if (param3 > param4)
            {
                _loc_17 = param4;
                param4 = param3;
                param3 = _loc_17;
            }
            if (!param1)
            {
                param1 = this.getTextLine(true);
            }
            var _loc_11:* = param1.getAtomBounds(param3);
            var _loc_12:* = param1.getAtomBounds(param4);
            var _loc_13:* = this._para.getEffectiveJustificationRule();
            if (param6 == BlockProgression.RL && param1.getAtomTextRotation(param3) != TextRotation.ROTATE_0)
            {
                _loc_10.y = _loc_11.y;
                _loc_9.height = param3 != param4 ? (_loc_12.bottom - _loc_11.top) : (_loc_11.height);
                if (_loc_13 == JustificationRule.EAST_ASIAN)
                {
                    _loc_9.width = _loc_11.width;
                }
                else
                {
                    _loc_9.width = param8[0];
                    _loc_10.x = _loc_10.x - param8[1];
                }
            }
            else
            {
                _loc_10.x = Math.min(_loc_11.x, _loc_12.x);
                if (param6 == BlockProgression.RL)
                {
                    _loc_10.y = _loc_11.y + param5.width / 2;
                }
                if (_loc_13 != JustificationRule.EAST_ASIAN)
                {
                    _loc_9.height = param8[0];
                    if (param6 == BlockProgression.RL)
                    {
                        _loc_10.x = _loc_10.x - param8[1];
                    }
                    else
                    {
                        _loc_10.y = _loc_10.y + param8[1];
                    }
                    _loc_9.width = param3 != param4 ? (Math.abs(_loc_12.right - _loc_11.left)) : (_loc_11.width);
                }
                else
                {
                    _loc_9.height = _loc_11.height;
                    _loc_9.width = param3 != param4 ? (Math.abs(_loc_12.right - _loc_11.left)) : (_loc_11.width);
                }
            }
            _loc_9.x = _loc_10.x;
            _loc_9.y = _loc_10.y;
            if (param6 == BlockProgression.RL)
            {
                if (param1.getAtomTextRotation(param3) != TextRotation.ROTATE_0)
                {
                    _loc_9.x = _loc_9.x - param1.descent;
                }
                else
                {
                    _loc_9.y = _loc_9.y - _loc_9.height / 2;
                }
            }
            else
            {
                _loc_9.y = _loc_9.y + (param1.descent - _loc_9.height);
            }
            var _loc_14:* = param1.userData as TextFlowLine;
            var _loc_15:* = this._para.findLeaf(param2);
            if (!this._para.findLeaf(param2))
            {
                if (param2 < 0)
                {
                    _loc_15 = this._para.getFirstLeaf();
                }
                else if (param2 >= this._para.textLength)
                {
                    _loc_15 = this._para.getLastLeaf();
                }
                _loc_16 = _loc_15 ? (_loc_15.computedFormat.textRotation) : (TextRotation.ROTATE_0);
            }
            else
            {
                _loc_16 = _loc_15.computedFormat.textRotation;
            }
            if (_loc_16 == TextRotation.ROTATE_180 || _loc_16 == TextRotation.ROTATE_90)
            {
                if (param6 != BlockProgression.RL)
                {
                    _loc_9.y = _loc_9.y + _loc_9.height / 2;
                }
                else if (_loc_15.getParentByType(TCYElement) == null)
                {
                    if (_loc_16 == TextRotation.ROTATE_90)
                    {
                        _loc_9.x = _loc_9.x - _loc_9.width;
                    }
                    else
                    {
                        _loc_9.x = _loc_9.x - _loc_9.width * 0.75;
                    }
                }
                else if (_loc_16 == TextRotation.ROTATE_90)
                {
                    _loc_9.y = _loc_9.y + _loc_9.height;
                }
                else
                {
                    _loc_9.y = _loc_9.y + _loc_9.height * 0.75;
                }
            }
            return _loc_9;
        }// end function

        function convertLineRectToContainer(param1:Rectangle, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = this.getTextLine();
            param1.x = param1.x + _loc_3.x;
            param1.y = param1.y + _loc_3.y;
            if (param2)
            {
                _loc_4 = this._para.getTextFlow();
                _loc_5 = this.controller.columnState.getColumnAt(this.columnIndex);
                constrainRectToColumn(_loc_4, param1, _loc_5, this.controller.horizontalScrollPosition, this.controller.verticalScrollPosition, this.controller.compositionWidth, this.controller.compositionHeight);
            }
            return;
        }// end function

        function hiliteBlockSelection(param1:Shape, param2:SelectionFormat, param3:DisplayObject, param4:int, param5:int, param6:TextFlowLine, param7:TextFlowLine) : void
        {
            if (this.isDamaged() || !this._controller)
            {
                return;
            }
            var _loc_8:* = this.peekTextLine();
            if (!this.peekTextLine() || !_loc_8.parent)
            {
                return;
            }
            var _loc_9:* = this._para.getAbsoluteStart();
            param4 = param4 - _loc_9;
            param5 = param5 - _loc_9;
            this.createSelectionShapes(param1, param2, param3, param4, param5, param6, param7);
            return;
        }// end function

        function hilitePointSelection(param1:SelectionFormat, param2:int, param3:DisplayObject, param4:TextFlowLine, param5:TextFlowLine) : void
        {
            var _loc_6:* = this.computePointSelectionRectangle(param2, param3, param4, param5, true);
            if (this.computePointSelectionRectangle(param2, param3, param4, param5, true))
            {
                this._controller.drawPointSelection(param1, _loc_6.x, _loc_6.y, _loc_6.width, _loc_6.height);
            }
            return;
        }// end function

        function computePointSelectionRectangle(param1:int, param2:DisplayObject, param3:TextFlowLine, param4:TextFlowLine, param5:Boolean) : Rectangle
        {
            var _loc_19:* = NaN;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = null;
            if (this.isDamaged() || !this._controller)
            {
                return null;
            }
            var _loc_6:* = this.peekTextLine();
            if (!this.peekTextLine() || !_loc_6.parent)
            {
                return null;
            }
            param1 = param1 - this._para.getAbsoluteStart();
            _loc_6 = this.getTextLine(true);
            var _loc_7:* = param1;
            var _loc_8:* = _loc_6.getAtomIndexAtCharIndex(param1);
            var _loc_9:* = false;
            var _loc_10:* = false;
            var _loc_11:* = this._para.getAncestorWithContainer();
            var _loc_12:* = this._para.getAncestorWithContainer().computedFormat.blockProgression;
            var _loc_13:* = this._para.computedFormat.direction;
            if (_loc_12 == BlockProgression.RL)
            {
                if (param1 == 0)
                {
                    if (_loc_6.getAtomTextRotation(0) == TextRotation.ROTATE_0)
                    {
                        _loc_10 = true;
                    }
                }
                else
                {
                    _loc_20 = _loc_6.getAtomIndexAtCharIndex((param1 - 1));
                    if (_loc_20 != -1)
                    {
                        if (_loc_6.getAtomTextRotation(_loc_8) == TextRotation.ROTATE_0 && _loc_6.getAtomTextRotation(_loc_20) != TextRotation.ROTATE_0)
                        {
                            _loc_8 = _loc_20;
                            param1 = param1 - 1;
                            _loc_9 = true;
                        }
                        else if (_loc_6.getAtomTextRotation(_loc_20) == TextRotation.ROTATE_0)
                        {
                            _loc_8 = _loc_20;
                            param1 = param1 - 1;
                            _loc_9 = true;
                        }
                    }
                }
            }
            var _loc_14:* = this.getRomanSelectionHeightAndVerticalAdjustment(param3, param4);
            var _loc_15:* = this.makeSelectionBlocks(_loc_6, param1, _loc_7, this._para.getAbsoluteStart(), _loc_12, _loc_13, _loc_14);
            var _loc_16:* = this.makeSelectionBlocks(_loc_6, param1, _loc_7, this._para.getAbsoluteStart(), _loc_12, _loc_13, _loc_14)[0];
            this.convertLineRectToContainer(_loc_16, param5);
            var _loc_17:* = _loc_13 == Direction.RTL;
            if (_loc_13 == Direction.RTL && _loc_6.getAtomBidiLevel(_loc_8) % 2 == 0 || !_loc_17 && _loc_6.getAtomBidiLevel(_loc_8) % 2 != 0)
            {
                _loc_17 = !_loc_17;
            }
            var _loc_18:* = param2.localToGlobal(localZeroPoint);
            if (_loc_12 == BlockProgression.RL && _loc_6.getAtomTextRotation(_loc_8) != TextRotation.ROTATE_0)
            {
                _loc_21 = param2.localToGlobal(rlLocalOnePoint);
                _loc_19 = _loc_18.y - _loc_21.y;
                _loc_19 = _loc_19 == 0 ? (1) : (Math.abs(1 / _loc_19));
                if (!_loc_17)
                {
                    setRectangleValues(_loc_16, _loc_16.x, !_loc_9 ? (_loc_16.y) : (_loc_16.y + _loc_16.height), _loc_16.width, _loc_19);
                }
                else
                {
                    setRectangleValues(_loc_16, _loc_16.x, !_loc_9 ? (_loc_16.y + _loc_16.height) : (_loc_16.y), _loc_16.width, _loc_19);
                }
            }
            else
            {
                _loc_22 = param2.localToGlobal(localOnePoint);
                _loc_19 = _loc_18.x - _loc_22.x;
                _loc_19 = _loc_19 == 0 ? (1) : (Math.abs(1 / _loc_19));
                if (!_loc_17)
                {
                    setRectangleValues(_loc_16, !_loc_9 ? (_loc_16.x) : (_loc_16.x + _loc_16.width), _loc_16.y, _loc_19, _loc_16.height);
                }
                else
                {
                    setRectangleValues(_loc_16, !_loc_9 ? (_loc_16.x + _loc_16.width) : (_loc_16.x), _loc_16.y, _loc_19, _loc_16.height);
                }
            }
            return _loc_16;
        }// end function

        function selectionWillIntersectScrollRect(param1:Rectangle, param2:int, param3:int, param4:TextFlowLine, param5:TextFlowLine) : int
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_6:* = this._para.getAncestorWithContainer();
            var _loc_7:* = this._para.getAncestorWithContainer().computedFormat.blockProgression;
            var _loc_8:* = this.getTextLine(true);
            if (param2 == param3)
            {
                _loc_9 = this.computePointSelectionRectangle(param2, DisplayObject(this.controller.container), param4, param5, false);
                if (_loc_9)
                {
                    if (param1.containsRect(_loc_9))
                    {
                        return 2;
                    }
                    if (param1.intersects(_loc_9))
                    {
                        return 1;
                    }
                }
            }
            else
            {
                _loc_10 = this._para.getAbsoluteStart();
                _loc_11 = this.getSelectionShapesCacheEntry(param2 - _loc_10, param3 - _loc_10, param4, param5, _loc_7);
                if (_loc_11)
                {
                    for each (_loc_12 in _loc_11.selectionBlocks)
                    {
                        
                        _loc_12 = _loc_12.clone();
                        _loc_12.clone().x = _loc_12.x + _loc_8.x;
                        _loc_12.y = _loc_12.y + _loc_8.y;
                        if (param1.intersects(_loc_12))
                        {
                            if (_loc_7 == BlockProgression.RL)
                            {
                                if (_loc_12.left >= param1.left && _loc_12.right <= param1.right)
                                {
                                    return 2;
                                }
                            }
                            else if (_loc_12.top >= param1.top && _loc_12.bottom <= param1.bottom)
                            {
                                return 2;
                            }
                            return 1;
                        }
                    }
                }
            }
            return 0;
        }// end function

        private function normalizeRects(param1:Array, param2:Array, param3:Number, param4:String, param5:String) : void
        {
            var _loc_8:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            while (_loc_7 < param1.length)
            {
                
                _loc_8 = param1[_loc_7++];
                if (param4 == BlockProgression.RL)
                {
                    if (_loc_8.width < param3)
                    {
                        _loc_8.width = param3;
                    }
                }
                else if (_loc_8.height < param3)
                {
                    _loc_8.height = param3;
                }
                if (_loc_6 == null)
                {
                    _loc_6 = _loc_8;
                }
                else if (param4 == BlockProgression.RL)
                {
                    if (_loc_6.y < _loc_8.y && _loc_6.y + _loc_6.height >= _loc_8.top && _loc_6.x == _loc_8.x)
                    {
                        _loc_6.height = _loc_6.height + _loc_8.height;
                    }
                    else if (_loc_8.y < _loc_6.y && _loc_6.y <= _loc_8.bottom && _loc_6.x == _loc_8.x)
                    {
                        _loc_6.height = _loc_6.height + _loc_8.height;
                        _loc_6.y = _loc_8.y;
                    }
                    else
                    {
                        param2.push(_loc_6);
                        _loc_6 = _loc_8;
                    }
                }
                else if (_loc_6.x < _loc_8.x && _loc_6.x + _loc_6.width >= _loc_8.left && _loc_6.y == _loc_8.y)
                {
                    _loc_6.width = _loc_6.width + _loc_8.width;
                }
                else if (_loc_8.x < _loc_6.x && _loc_6.x <= _loc_8.right && _loc_6.y == _loc_8.y)
                {
                    _loc_6.width = _loc_6.width + _loc_8.width;
                    _loc_6.x = _loc_8.x;
                }
                else
                {
                    param2.push(_loc_6);
                    _loc_6 = _loc_8;
                }
                if (_loc_7 == param1.length)
                {
                    param2.push(_loc_6);
                }
            }
            return;
        }// end function

        private function adjustEndElementForBidi(param1:TextLine, param2:int, param3:int, param4:int, param5:String) : int
        {
            var _loc_6:* = param4;
            if (param3 != param2)
            {
                if ((param5 == Direction.LTR && param1.getAtomBidiLevel(param4) % 2 != 0 || param5 == Direction.RTL && param1.getAtomBidiLevel(param4) % 2 == 0) && param1.getAtomTextRotation(param4) != TextRotation.ROTATE_0)
                {
                    _loc_6 = param1.getAtomIndexAtCharIndex(param3);
                }
                else
                {
                    _loc_6 = param1.getAtomIndexAtCharIndex((param3 - 1));
                }
            }
            if (_loc_6 == -1 && param3 > 0)
            {
                return this.adjustEndElementForBidi(param1, param2, (param3 - 1), param4, param5);
            }
            return _loc_6;
        }// end function

        private function isAtomBidi(param1:TextLine, param2:int, param3:String) : Boolean
        {
            if (!param1)
            {
                param1 = this.getTextLine(true);
            }
            return param1.getAtomBidiLevel(param2) % 2 != 0 && param3 == Direction.LTR || param1.getAtomBidiLevel(param2) % 2 == 0 && param3 == Direction.RTL;
        }// end function

        function get adornCount() : int
        {
            return this._adornCount;
        }// end function

        static function initializeNumberLinePosition(param1:TextLine, param2:ListItemElement, param3:ParagraphElement, param4:Number) : void
        {
            var _loc_5:* = param2.computedListMarkerFormat();
            var _loc_6:* = param3.computedFormat;
            var _loc_7:* = _loc_5.paragraphEndIndent === undefined || param2.computedFormat.listStylePosition == ListStylePosition.INSIDE ? (0) : (_loc_5.paragraphEndIndent == FormatValue.INHERIT ? (_loc_6.paragraphEndIndent) : (_loc_5.paragraphEndIndent));
            TextFlowLine.setListEndIndent(param1, _loc_7);
            if (param2.computedFormat.listStylePosition == ListStylePosition.OUTSIDE)
            {
                var _loc_10:* = 0;
                param1.y = 0;
                param1.x = _loc_10;
                return;
            }
            var _loc_8:* = param3.getTextFlow().computedFormat.blockProgression;
            var _loc_9:* = TextFlowLine.getNumberLineInsideLineWidth(param1);
            if (_loc_8 == BlockProgression.TB)
            {
                if (_loc_6.direction == Direction.LTR)
                {
                    param1.x = -_loc_9;
                }
                else
                {
                    param1.x = param4 + _loc_9 - param1.textWidth;
                }
                param1.y = 0;
            }
            else
            {
                if (_loc_6.direction == Direction.LTR)
                {
                    param1.y = -_loc_9;
                }
                else
                {
                    param1.y = param4 + _loc_9 - param1.textWidth;
                }
                param1.x = 0;
            }
            return;
        }// end function

        static function createNumberLine(param1:ListItemElement, param2:ParagraphElement, param3:ISWFContext, param4:Number) : TextLine
        {
            var highestParentLinkLinkElement:LinkElement;
            var key:String;
            var rslt:Array;
            var numberLine:TextLine;
            var leaf:FlowLeafElement;
            var val:*;
            var listItemElement:* = param1;
            var curParaElement:* = param2;
            var swfContext:* = param3;
            var totalStartIndent:* = param4;
            if (numberLineFactory == null)
            {
                numberLineFactory = new NumberLineFactory();
                numberLineFactory.compositionBounds = new Rectangle(0, 0, NaN, NaN);
            }
            numberLineFactory.swfContext = swfContext;
            var listMarkerFormat:* = listItemElement.computedListMarkerFormat();
            numberLineFactory.listStylePosition = listItemElement.computedFormat.listStylePosition;
            var listElement:* = listItemElement.parent as ListElement;
            var paragraphFormat:* = new TextLayoutFormat(curParaElement.computedFormat);
            var boxStartIndent:* = paragraphFormat.direction == Direction.LTR ? (listElement.getEffectivePaddingLeft()) : (listElement.getEffectivePaddingRight());
            paragraphFormat.apply(listMarkerFormat);
            paragraphFormat.textIndent = paragraphFormat.textIndent + totalStartIndent;
            if (numberLineFactory.listStylePosition == ListStylePosition.OUTSIDE)
            {
                paragraphFormat.textIndent = paragraphFormat.textIndent - boxStartIndent;
            }
            numberLineFactory.paragraphFormat = paragraphFormat;
            numberLineFactory.textFlowFormat = curParaElement.getTextFlow().computedFormat;
            var firstLeaf:* = curParaElement.getFirstLeaf();
            var parentLink:* = firstLeaf.getParentByType(LinkElement) as LinkElement;
            var linkStateArray:Array;
            while (parentLink)
            {
                
                highestParentLinkLinkElement = parentLink;
                linkStateArray.push(parentLink.linkState);
                parentLink.chgLinkState(LinkState.SUPPRESSED);
                parentLink = parentLink.getParentByType(LinkElement) as LinkElement;
            }
            var spanFormat:* = new TextLayoutFormat(firstLeaf.computedFormat);
            parentLink = firstLeaf.getParentByType(LinkElement) as LinkElement;
            while (parentLink)
            {
                
                linkStateArray.push(parentLink.linkState);
                parentLink.chgLinkState(linkStateArray.shift());
                parentLink = parentLink.getParentByType(LinkElement) as LinkElement;
            }
            if (highestParentLinkLinkElement)
            {
                leaf = highestParentLinkLinkElement.getFirstLeaf();
                while (leaf)
                {
                    
                    leaf = leaf.getNextLeaf(highestParentLinkLinkElement);
                }
            }
            var markerFormat:* = new TextLayoutFormat(spanFormat);
            TextLayoutFormat.resetModifiedNoninheritedStyles(markerFormat);
            var holderStyles:* = (listMarkerFormat as TextLayoutFormat).getStyles();
            var _loc_6:* = 0;
            var _loc_7:* = holderStyles;
            while (_loc_7 in _loc_6)
            {
                
                key = _loc_7[_loc_6];
                if (TextLayoutFormat.description[key] !== undefined)
                {
                    val = holderStyles[key];
                    markerFormat[key] = val !== FormatValue.INHERIT ? (val) : (spanFormat[key]);
                }
            }
            numberLineFactory.markerFormat = markerFormat;
            numberLineFactory.text = listElement.computeListItemText(listItemElement, listMarkerFormat);
            rslt;
            numberLineFactory.createTextLines(function (param1:DisplayObject) : void
            {
                rslt.push(param1);
                return;
            }// end function
            );
            numberLine = rslt[0] as TextLine;
            if (numberLine)
            {
                numberLine.mouseEnabled = false;
                numberLine.mouseChildren = false;
                setNumberLineBackground(numberLine, numberLineFactory.backgroundManager);
            }
            numberLineFactory.clearBackgroundManager();
            return numberLine;
        }// end function

        static function getTextLineTypographicAscent(param1:TextLine, param2:FlowLeafElement, param3:int, param4:int) : Number
        {
            var _loc_5:* = param1.getBaselinePosition(TextBaseline.ROMAN) - param1.getBaselinePosition(TextBaseline.ASCENT);
            if (param1.hasGraphicElement)
            {
                while (true)
                {
                    
                    if (param2 is InlineGraphicElement)
                    {
                        _loc_5 = Math.max(_loc_5, InlineGraphicElement(param2).getTypographicAscent(param1));
                    }
                    param3 = param3 + param2.textLength;
                    if (param3 >= param4)
                    {
                        break;
                    }
                    param2 = param2.getNextLeaf();
                }
            }
            return _loc_5;
        }// end function

        private static function createSelectionRect(param1:Shape, param2:uint, param3:Number, param4:Number, param5:Number, param6:Number) : DisplayObject
        {
            param1.graphics.beginFill(param2);
            var _loc_7:* = new Vector.<int>;
            var _loc_8:* = new Vector.<Number>;
            _loc_7.push(GraphicsPathCommand.MOVE_TO);
            _loc_8.push(param3);
            _loc_8.push(param4);
            _loc_7.push(GraphicsPathCommand.LINE_TO);
            _loc_8.push(param3 + param5);
            _loc_8.push(param4);
            _loc_7.push(GraphicsPathCommand.LINE_TO);
            _loc_8.push(param3 + param5);
            _loc_8.push(param4 + param6);
            _loc_7.push(GraphicsPathCommand.LINE_TO);
            _loc_8.push(param3);
            _loc_8.push(param4 + param6);
            _loc_7.push(GraphicsPathCommand.LINE_TO);
            _loc_8.push(param3);
            _loc_8.push(param4);
            param1.graphics.drawPath(_loc_7, _loc_8, GraphicsPathWinding.NON_ZERO);
            return param1;
        }// end function

        static function constrainRectToColumn(param1:TextFlow, param2:Rectangle, param3:Rectangle, param4:Number, param5:Number, param6:Number, param7:Number) : void
        {
            if (param1.computedFormat.lineBreak == LineBreak.EXPLICIT)
            {
                return;
            }
            var _loc_8:* = param1.computedFormat.blockProgression;
            var _loc_9:* = param1.computedFormat.direction;
            if (_loc_8 == BlockProgression.TB && !isNaN(param6))
            {
                if (_loc_9 == Direction.LTR)
                {
                    if (param2.left > param3.x + param3.width + param4)
                    {
                        param2.left = param3.x + param3.width + param4;
                    }
                    if (param2.right > param3.x + param3.width + param4)
                    {
                        param2.right = param3.x + param3.width + param4;
                    }
                }
                else
                {
                    if (param2.right < param3.x + param4)
                    {
                        param2.right = param3.x + param4;
                    }
                    if (param2.left < param3.x + param4)
                    {
                        param2.left = param3.x + param4;
                    }
                }
            }
            else if (_loc_8 == BlockProgression.RL && !isNaN(param7))
            {
                if (_loc_9 == Direction.LTR)
                {
                    if (param2.top > param3.y + param3.height + param5)
                    {
                        param2.top = param3.y + param3.height + param5;
                    }
                    if (param2.bottom > param3.y + param3.height + param5)
                    {
                        param2.bottom = param3.y + param3.height + param5;
                    }
                }
                else
                {
                    if (param2.bottom < param3.y + param5)
                    {
                        param2.bottom = param3.y + param5;
                    }
                    if (param2.top < param3.y + param5)
                    {
                        param2.top = param3.y + param5;
                    }
                }
            }
            return;
        }// end function

        private static function setRectangleValues(param1:Rectangle, param2:Number, param3:Number, param4:Number, param5:Number) : void
        {
            param1.x = param2;
            param1.y = param3;
            param1.width = param4;
            param1.height = param5;
            return;
        }// end function

        static function findNumberLine(param1:TextLine) : TextLine
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < param1.numChildren)
            {
                
                _loc_3 = param1.getChildAt(_loc_2) as TextLine;
                if (_loc_3 && _loc_3.userData is NumberLineUserData)
                {
                    break;
                }
                _loc_2++;
            }
            return _loc_3;
        }// end function

        static function getNumberLineListStylePosition(param1:TextLine) : String
        {
            return (param1.userData as NumberLineUserData).listStylePosition;
        }// end function

        static function getNumberLineInsideLineWidth(param1:TextLine) : Number
        {
            return (param1.userData as NumberLineUserData).insideLineWidth;
        }// end function

        static function getNumberLineSpanFormat(param1:TextLine) : ITextLayoutFormat
        {
            return (param1.userData as NumberLineUserData).spanFormat;
        }// end function

        static function getNumberLineParagraphDirection(param1:TextLine) : String
        {
            return (param1.userData as NumberLineUserData).paragraphDirection;
        }// end function

        static function setListEndIndent(param1:TextLine, param2:Number) : void
        {
            (param1.userData as NumberLineUserData).listEndIndent = param2;
            return;
        }// end function

        static function getListEndIndent(param1:TextLine) : Number
        {
            return (param1.userData as NumberLineUserData).listEndIndent;
        }// end function

        static function setNumberLineBackground(param1:TextLine, param2:BackgroundManager) : void
        {
            (param1.userData as NumberLineUserData).backgroundManager = param2;
            return;
        }// end function

        static function getNumberLineBackground(param1:TextLine) : BackgroundManager
        {
            return (param1.userData as NumberLineUserData).backgroundManager;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.display.*;

import flash.geom.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.compose.*;

import flashx.textLayout.container.*;

import flashx.textLayout.edit.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.utils.*;

final class SelectionCache extends Object
{
    private var _begIdx:int = -1;
    private var _endIdx:int = -1;
    private var _selectionBlocks:Array = null;

    function SelectionCache()
    {
        return;
    }// end function

    public function get begIdx() : int
    {
        return this._begIdx;
    }// end function

    public function set begIdx(param1:int) : void
    {
        this._begIdx = param1;
        return;
    }// end function

    public function get endIdx() : int
    {
        return this._endIdx;
    }// end function

    public function set endIdx(param1:int) : void
    {
        this._endIdx = param1;
        return;
    }// end function

    public function pushSelectionBlock(param1:Rectangle) : void
    {
        if (!this._selectionBlocks)
        {
            this._selectionBlocks = new Array();
        }
        this._selectionBlocks.push(param1.clone());
        return;
    }// end function

    public function get selectionBlocks() : Array
    {
        return this._selectionBlocks;
    }// end function

    public function clear() : void
    {
        this._selectionBlocks = null;
        this._begIdx = -1;
        this._endIdx = -1;
        return;
    }// end function

}


import __AS3__.vec.*;

import flash.display.*;

import flash.geom.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.compose.*;

import flashx.textLayout.container.*;

import flashx.textLayout.edit.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.utils.*;

class NumberLineFactory extends StringTextLineFactory
{
    private var _listStylePosition:String;
    private var _markerFormat:ITextLayoutFormat;
    private var _backgroundManager:BackgroundManager;

    function NumberLineFactory()
    {
        return;
    }// end function

    public function get listStylePosition() : String
    {
        return this._listStylePosition;
    }// end function

    public function set listStylePosition(param1:String) : void
    {
        this._listStylePosition = param1;
        return;
    }// end function

    public function get markerFormat() : ITextLayoutFormat
    {
        return this._markerFormat;
    }// end function

    public function set markerFormat(param1:ITextLayoutFormat) : void
    {
        this._markerFormat = param1;
        spanFormat = param1;
        return;
    }// end function

    public function get backgroundManager() : BackgroundManager
    {
        return this._backgroundManager;
    }// end function

    public function clearBackgroundManager() : void
    {
        this._backgroundManager = null;
        return;
    }// end function

    override protected function callbackWithTextLines(param1:Function, param2:Number, param3:Number) : void
    {
        var _loc_4:* = null;
        var _loc_5:* = null;
        for each (_loc_4 in _factoryComposer._lines)
        {
            
            _loc_4.userData = new NumberLineUserData(this.listStylePosition, calculateInsideNumberLineWidth(_loc_4, textFlowFormat.blockProgression), this._markerFormat, paragraphFormat.direction);
            _loc_5 = _loc_4.textBlock;
            if (_loc_5)
            {
                _loc_5.releaseLines(_loc_5.firstLine, _loc_5.lastLine);
            }
            _loc_4.x = _loc_4.x + param2;
            _loc_4.y = _loc_4.y + param3;
            _loc_4.validity = TextLineValidity.STATIC;
            this.param1(_loc_4);
        }
        return;
    }// end function

    override function processBackgroundColors(param1:TextFlow, param2:Function, param3:Number, param4:Number, param5:Number, param6:Number)
    {
        this._backgroundManager = param1.backgroundManager;
        param1.clearBackgroundManager();
        return;
    }// end function

    static function calculateInsideNumberLineWidth(param1:TextLine, param2:String) : Number
    {
        var _loc_6:* = null;
        var _loc_3:* = Number.MAX_VALUE;
        var _loc_4:* = Number.MIN_VALUE;
        var _loc_5:* = 0;
        if (param2 == BlockProgression.TB)
        {
            while (_loc_5 < param1.atomCount)
            {
                
                if (param1.getAtomTextBlockBeginIndex(_loc_5) != (param1.rawTextLength - 1))
                {
                    _loc_6 = param1.getAtomBounds(_loc_5);
                    _loc_3 = Math.min(_loc_3, _loc_6.x);
                    _loc_4 = Math.max(_loc_4, _loc_6.right);
                }
                _loc_5++;
            }
        }
        else
        {
            while (_loc_5 < param1.atomCount)
            {
                
                if (param1.getAtomTextBlockBeginIndex(_loc_5) != (param1.rawTextLength - 1))
                {
                    _loc_6 = param1.getAtomBounds(_loc_5);
                    _loc_3 = Math.min(_loc_3, _loc_6.top);
                    _loc_4 = Math.max(_loc_4, _loc_6.bottom);
                }
                _loc_5++;
            }
        }
        return _loc_4 > _loc_3 ? (_loc_4 - _loc_3) : (0);
    }// end function

}

