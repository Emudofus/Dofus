package flashx.textLayout.elements
{
    import __AS3__.vec.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;
    import flashx.textLayout.utils.*;

    final public class ParagraphElement extends ParagraphFormattedElement
    {
        private var _textBlock:TextBlock;
        private var _terminatorSpan:SpanElement;
        private var _interactiveChildrenCount:int;
        private static var _defaultTabStops:Vector.<TabStop>;
        private static const defaultTabWidth:int = 48;
        private static const defaultTabCount:int = 20;

        public function ParagraphElement()
        {
            this._terminatorSpan = null;
            this._interactiveChildrenCount = 0;
            return;
        }// end function

        function get _interactiveChildrenCount() : int
        {
            return this._interactiveChildrenCount;
        }// end function

        function createTextBlock() : void
        {
            var _loc_2:* = null;
            this._textBlock = new TextBlock();
            var _loc_1:* = 0;
            while (_loc_1 < numChildren)
            {
                
                _loc_2 = getChildAt(_loc_1);
                _loc_2.createContentElement();
                _loc_1++;
            }
            this.updateTextBlock();
            return;
        }// end function

        function releaseTextBlock() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this._textBlock)
            {
                return;
            }
            if (this._textBlock.firstLine)
            {
                _loc_2 = this._textBlock.firstLine;
                while (_loc_2 != null)
                {
                    
                    if (_loc_2.numChildren != 0)
                    {
                        _loc_3 = _loc_2.userData as TextFlowLine;
                        if (_loc_3.adornCount != _loc_2.numChildren)
                        {
                            return;
                        }
                    }
                    _loc_2 = _loc_2.nextLine;
                }
                this._textBlock.releaseLines(this._textBlock.firstLine, this._textBlock.lastLine);
            }
            this._textBlock.content = null;
            var _loc_1:* = 0;
            while (_loc_1 < numChildren)
            {
                
                _loc_4 = getChildAt(_loc_1);
                _loc_4.releaseContentElement();
                _loc_1++;
            }
            this._textBlock = null;
            if (_computedFormat)
            {
                _computedFormat = null;
            }
            return;
        }// end function

        function getTextBlock() : TextBlock
        {
            if (!this._textBlock)
            {
                this.createTextBlock();
            }
            return this._textBlock;
        }// end function

        function peekTextBlock() : TextBlock
        {
            return this._textBlock;
        }// end function

        function releaseLineCreationData() : void
        {
            if (this._textBlock)
            {
                var _loc_1:* = this._textBlock;
                _loc_1.this._textBlock["releaseLineCreationData"]();
            }
            return;
        }// end function

        override function createContentAsGroup() : GroupElement
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._textBlock.content as GroupElement;
            if (!_loc_1)
            {
                _loc_2 = this._textBlock.content;
                _loc_1 = new GroupElement();
                this._textBlock.content = _loc_1;
                if (_loc_2)
                {
                    _loc_3 = new Vector.<ContentElement>;
                    _loc_3.push(_loc_2);
                    _loc_1.replaceElements(0, 0, _loc_3);
                }
                if (this._textBlock.firstLine && textLength)
                {
                    _loc_4 = getTextFlow();
                    if (_loc_4)
                    {
                        _loc_4.damage(getAbsoluteStart(), textLength, TextLineValidity.INVALID, false);
                    }
                }
            }
            return _loc_1;
        }// end function

        override function removeBlockElement(param1:FlowElement, param2:ContentElement) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (numChildren == 1)
            {
                if (param2 is GroupElement)
                {
                    GroupElement(this._textBlock.content).replaceElements(0, 1, null);
                }
                this._textBlock.content = null;
            }
            else
            {
                _loc_3 = this.getChildIndex(param1);
                _loc_4 = GroupElement(this._textBlock.content);
                _loc_4.replaceElements(_loc_3, (_loc_3 + 1), null);
                if (numChildren == 2)
                {
                    _loc_5 = _loc_4.getElementAt(0);
                    if (!(_loc_5 is GroupElement))
                    {
                        _loc_4.replaceElements(0, 1, null);
                        this._textBlock.content = _loc_5;
                    }
                }
            }
            return;
        }// end function

        override function hasBlockElement() : Boolean
        {
            return this._textBlock != null;
        }// end function

        override function createContentElement() : void
        {
            this.createTextBlock();
            return;
        }// end function

        override function insertBlockElement(param1:FlowElement, param2:ContentElement) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (this._textBlock == null)
            {
                param1.releaseContentElement();
                this.createTextBlock();
                return;
            }
            if (numChildren == 1)
            {
                if (param2 is GroupElement)
                {
                    _loc_3 = new Vector.<ContentElement>;
                    _loc_3.push(param2);
                    _loc_4 = new GroupElement(_loc_3);
                    this._textBlock.content = _loc_4;
                }
                else
                {
                    this._textBlock.content = param2;
                }
            }
            else
            {
                _loc_4 = this.createContentAsGroup();
                _loc_5 = this.getChildIndex(param1);
                _loc_3 = new Vector.<ContentElement>;
                _loc_3.push(param2);
                _loc_4.replaceElements(_loc_5, _loc_5, _loc_3);
            }
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "p";
        }// end function

        override public function replaceChildren(param1:int, param2:int, ... args) : void
        {
            args = null;
            if (args.length == 1)
            {
                args = [param1, param2, args[0]];
            }
            else
            {
                args = [param1, param2];
                if (args.length != 0)
                {
                    args = args.concat.apply(args, args);
                }
            }
            super.replaceChildren.apply(this, args);
            this.ensureTerminatorAfterReplace();
            return;
        }// end function

        function ensureTerminatorAfterReplace() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = getLastLeaf();
            if (this._terminatorSpan != _loc_1)
            {
                if (this._terminatorSpan)
                {
                    this._terminatorSpan.removeParaTerminator();
                    this._terminatorSpan = null;
                }
                if (_loc_1)
                {
                    if (_loc_1 is SpanElement)
                    {
                        (_loc_1 as SpanElement).addParaTerminator();
                        this._terminatorSpan = _loc_1 as SpanElement;
                    }
                    else
                    {
                        _loc_2 = new SpanElement();
                        super.replaceChildren(numChildren, numChildren, _loc_2);
                        _loc_2.format = _loc_1.format;
                        _loc_2.addParaTerminator();
                        this._terminatorSpan = _loc_2;
                    }
                }
            }
            return;
        }// end function

        function updateTerminatorSpan(param1:SpanElement, param2:SpanElement) : void
        {
            if (this._terminatorSpan == param1)
            {
                this._terminatorSpan = param2;
            }
            return;
        }// end function

        override public function set mxmlChildren(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.replaceChildren(0, numChildren);
            for each (_loc_2 in param1)
            {
                
                if (_loc_2 is FlowElement)
                {
                    if (_loc_2 is SpanElement || _loc_2 is SubParagraphGroupElementBase)
                    {
                        _loc_2.bindableElement = true;
                    }
                    super.replaceChildren(numChildren, numChildren, _loc_2 as FlowElement);
                    continue;
                }
                if (_loc_2 is String)
                {
                    _loc_3 = new SpanElement();
                    _loc_3.text = String(_loc_2);
                    _loc_3.bindableElement = true;
                    super.replaceChildren(numChildren, numChildren, _loc_3);
                    continue;
                }
                if (_loc_2 != null)
                {
                    throw new TypeError(GlobalSettings.resourceStringFunction("badMXMLChildrenArgument", [getQualifiedClassName(_loc_2)]));
                }
            }
            this.ensureTerminatorAfterReplace();
            return;
        }// end function

        override public function getText(param1:int = 0, param2:int = -1, param3:String = "\n") : String
        {
            var _loc_4:* = null;
            if (param1 == 0 && (param2 == -1 || param2 >= (textLength - 1)) && this._textBlock)
            {
                if (this._textBlock.content && this._textBlock.content.rawText)
                {
                    _loc_4 = this._textBlock.content.rawText;
                    return _loc_4.substring(0, (_loc_4.length - 1));
                }
                return "";
            }
            return super.getText(param1, param2, param3);
        }// end function

        public function getNextParagraph() : ParagraphElement
        {
            var _loc_1:* = getLastLeaf().getNextLeaf();
            return _loc_1 ? (_loc_1.getParagraph()) : (null);
        }// end function

        public function getPreviousParagraph() : ParagraphElement
        {
            var _loc_1:* = getFirstLeaf().getPreviousLeaf();
            return _loc_1 ? (_loc_1.getParagraph()) : (null);
        }// end function

        public function findPreviousAtomBoundary(param1:int) : int
        {
            return this.getTextBlock().findPreviousAtomBoundary(param1);
        }// end function

        public function findNextAtomBoundary(param1:int) : int
        {
            return this.getTextBlock().findNextAtomBoundary(param1);
        }// end function

        override public function getCharAtPosition(param1:int) : String
        {
            return this.getTextBlock().content.rawText.charAt(param1);
        }// end function

        public function findPreviousWordBoundary(param1:int) : int
        {
            if (param1 == 0)
            {
                return 0;
            }
            var _loc_2:* = getCharCodeAtPosition((param1 - 1));
            if (CharacterUtil.isWhitespace(_loc_2))
            {
                while (CharacterUtil.isWhitespace(_loc_2) && (param1 - 1) > 0)
                {
                    
                    param1 = param1 - 1;
                    _loc_2 = getCharCodeAtPosition((param1 - 1));
                }
                return param1;
            }
            return this.getTextBlock().findPreviousWordBoundary(param1);
        }// end function

        public function findNextWordBoundary(param1:int) : int
        {
            if (param1 == textLength)
            {
                return textLength;
            }
            var _loc_2:* = getCharCodeAtPosition(param1);
            if (CharacterUtil.isWhitespace(_loc_2))
            {
                while (CharacterUtil.isWhitespace(_loc_2) && param1 < (textLength - 1))
                {
                    
                    param1++;
                    _loc_2 = getCharCodeAtPosition(param1);
                }
                return param1;
            }
            return this.getTextBlock().findNextWordBoundary(param1);
        }// end function

        private function updateTextBlock() : void
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_1:* = getAncestorWithContainer();
            if (!_loc_1)
            {
                return;
            }
            var _loc_2:* = _loc_1 ? (_loc_1.computedFormat) : (TextLayoutFormat.defaultFormat);
            if (this.computedFormat.textAlign == TextAlign.JUSTIFY)
            {
                _loc_3 = _computedFormat.textAlignLast == TextAlign.JUSTIFY ? (LineJustification.ALL_INCLUDING_LAST) : (LineJustification.ALL_BUT_LAST);
                if (_loc_2.lineBreak == LineBreak.EXPLICIT)
                {
                    _loc_3 = LineJustification.UNJUSTIFIED;
                }
            }
            else
            {
                _loc_3 = LineJustification.UNJUSTIFIED;
            }
            var _loc_4:* = this.getEffectiveJustificationStyle();
            var _loc_5:* = this.getEffectiveJustificationRule();
            if (this.getEffectiveJustificationRule() == JustificationRule.SPACE)
            {
                _loc_6 = new SpaceJustifier(_computedFormat.locale, _loc_3, false);
                _loc_6.letterSpacing = _computedFormat.textJustify == TextJustify.DISTRIBUTE ? (true) : (false);
                if (Configuration.playerEnablesArgoFeatures)
                {
                    _loc_7 = Property.toNumberIfPercent(_computedFormat.wordSpacing.minimumSpacing) / 100;
                    _loc_8 = Property.toNumberIfPercent(_computedFormat.wordSpacing.maximumSpacing) / 100;
                    _loc_9 = Property.toNumberIfPercent(_computedFormat.wordSpacing.optimumSpacing) / 100;
                    _loc_6["minimumSpacing"] = Math.min(_loc_7, _loc_6["minimumSpacing"]);
                    _loc_6["maximumSpacing"] = Math.max(_loc_8, _loc_6["maximumSpacing"]);
                    _loc_6["optimumSpacing"] = _loc_9;
                    _loc_6["minimumSpacing"] = _loc_7;
                    _loc_6["maximumSpacing"] = _loc_8;
                }
                this._textBlock.textJustifier = _loc_6;
                this._textBlock.baselineZero = getLeadingBasis(this.getEffectiveLeadingModel());
            }
            else
            {
                _loc_10 = new EastAsianJustifier(_computedFormat.locale, _loc_3, _loc_4);
                if (Configuration.versionIsAtLeast(10, 3) && _loc_10.hasOwnProperty("composeTrailingIdeographicSpaces"))
                {
                    _loc_10.composeTrailingIdeographicSpaces = true;
                }
                this._textBlock.textJustifier = _loc_10 as EastAsianJustifier;
                this._textBlock.baselineZero = getLeadingBasis(this.getEffectiveLeadingModel());
            }
            this._textBlock.bidiLevel = _computedFormat.direction == Direction.LTR ? (0) : (1);
            this._textBlock.lineRotation = _loc_2.blockProgression == BlockProgression.RL ? (TextRotation.ROTATE_90) : (TextRotation.ROTATE_0);
            if (_computedFormat.tabStops && _computedFormat.tabStops.length != 0)
            {
                _loc_11 = new Vector.<TabStop>;
                for each (_loc_12 in _computedFormat.tabStops)
                {
                    
                    _loc_13 = _loc_12.decimalAlignmentToken == null ? ("") : (_loc_12.decimalAlignmentToken);
                    _loc_14 = _loc_12.alignment == null ? (TabAlignment.START) : (_loc_12.alignment);
                    _loc_15 = new TabStop(_loc_14, Number(_loc_12.position), _loc_13);
                    if (_loc_12.decimalAlignmentToken != null)
                    {
                        _loc_16 = "x" + _loc_15.decimalAlignmentToken;
                    }
                    _loc_11.push(_loc_15);
                }
                this._textBlock.tabStops = _loc_11;
            }
            else if (GlobalSettings.enableDefaultTabStops && !Configuration.playerEnablesArgoFeatures)
            {
                if (_defaultTabStops == null)
                {
                    initializeDefaultTabStops();
                }
                this._textBlock.tabStops = _defaultTabStops;
            }
            else
            {
                this._textBlock.tabStops = null;
            }
            return;
        }// end function

        override public function get computedFormat() : ITextLayoutFormat
        {
            if (!_computedFormat)
            {
                if (this._textBlock)
                {
                    this.updateTextBlock();
                }
            }
            return _computedFormat;
        }// end function

        override function canOwnFlowElement(param1:FlowElement) : Boolean
        {
            return param1 is FlowLeafElement || param1 is SubParagraphGroupElementBase;
        }// end function

        override function normalizeRange(param1:uint, param2:uint) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_3:* = findChildIndexAtPosition(param1);
            if (_loc_3 != -1 && _loc_3 < numChildren)
            {
                _loc_4 = getChildAt(_loc_3);
                param1 = param1 - _loc_4.parentRelativeStart;
                while (true)
                {
                    
                    _loc_5 = _loc_4.parentRelativeStart + _loc_4.textLength;
                    _loc_4.normalizeRange(param1, param2 - _loc_4.parentRelativeStart);
                    _loc_6 = _loc_4.parentRelativeStart + _loc_4.textLength;
                    param2 = param2 + (_loc_6 - _loc_5);
                    if (_loc_4.textLength == 0 && !_loc_4.bindableElement)
                    {
                        this.replaceChildren(_loc_3, (_loc_3 + 1));
                    }
                    else if (_loc_4.mergeToPreviousIfPossible())
                    {
                        _loc_7 = this.getChildAt((_loc_3 - 1));
                        _loc_7.normalizeRange(0, _loc_7.textLength);
                    }
                    else
                    {
                        _loc_3++;
                    }
                    if (_loc_3 == numChildren)
                    {
                        if (_loc_3 != 0)
                        {
                            _loc_8 = this.getChildAt((_loc_3 - 1));
                            if (_loc_8 is SubParagraphGroupElementBase && _loc_8.textLength == 1 && !_loc_8.bindableElement)
                            {
                                this.replaceChildren((_loc_3 - 1), _loc_3);
                            }
                        }
                        break;
                    }
                    _loc_4 = getChildAt(_loc_3);
                    if (_loc_4.parentRelativeStart > param2)
                    {
                        break;
                    }
                    param1 = 0;
                }
            }
            if (numChildren == 0 || textLength == 0)
            {
                _loc_9 = new SpanElement();
                this.replaceChildren(0, 0, _loc_9);
                _loc_9.normalizeRange(0, _loc_9.textLength);
            }
            return;
        }// end function

        function getEffectiveLeadingModel() : String
        {
            return this.computedFormat.leadingModel == LeadingModel.AUTO ? (LocaleUtil.leadingModel(this.computedFormat.locale)) : (this.computedFormat.leadingModel);
        }// end function

        function getEffectiveDominantBaseline() : String
        {
            return this.computedFormat.dominantBaseline == FormatValue.AUTO ? (LocaleUtil.dominantBaseline(this.computedFormat.locale)) : (this.computedFormat.dominantBaseline);
        }// end function

        function getEffectiveJustificationRule() : String
        {
            return this.computedFormat.justificationRule == FormatValue.AUTO ? (LocaleUtil.justificationRule(this.computedFormat.locale)) : (this.computedFormat.justificationRule);
        }// end function

        function getEffectiveJustificationStyle() : String
        {
            return this.computedFormat.justificationStyle == FormatValue.AUTO ? (LocaleUtil.justificationStyle(this.computedFormat.locale)) : (this.computedFormat.justificationStyle);
        }// end function

        function incInteractiveChildrenCount() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._interactiveChildrenCount + 1;
            _loc_1._interactiveChildrenCount = _loc_2;
            return;
        }// end function

        function decInteractiveChildrenCount() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._interactiveChildrenCount - 1;
            _loc_1._interactiveChildrenCount = _loc_2;
            return;
        }// end function

        function hasInteractiveChildren() : Boolean
        {
            return this._interactiveChildrenCount != 0;
        }// end function

        private static function initializeDefaultTabStops() : void
        {
            _defaultTabStops = new Vector.<TabStop>(defaultTabCount, true);
            var _loc_1:* = 0;
            while (_loc_1 < defaultTabCount)
            {
                
                _defaultTabStops[_loc_1] = new TabStop(TextAlign.START, defaultTabWidth * _loc_1);
                _loc_1++;
            }
            return;
        }// end function

        static function getLeadingBasis(param1:String) : String
        {
            switch(param1)
            {
                case LeadingModel.ASCENT_DESCENT_UP:
                case LeadingModel.APPROXIMATE_TEXT_FIELD:
                case LeadingModel.BOX:
                case LeadingModel.ROMAN_UP:
                default:
                {
                    return TextBaseline.ROMAN;
                }
                case LeadingModel.IDEOGRAPHIC_TOP_DOWN:
                case LeadingModel.IDEOGRAPHIC_CENTER_UP:
                {
                    return TextBaseline.IDEOGRAPHIC_TOP;
                }
                case LeadingModel.IDEOGRAPHIC_CENTER_DOWN:
                case :
                {
                    return TextBaseline.IDEOGRAPHIC_CENTER;
                    break;
                }
            }
        }// end function

        static function useUpLeadingDirection(param1:String) : Boolean
        {
            switch(param1)
            {
                case LeadingModel.ASCENT_DESCENT_UP:
                case LeadingModel.APPROXIMATE_TEXT_FIELD:
                case LeadingModel.BOX:
                case LeadingModel.ROMAN_UP:
                case LeadingModel.IDEOGRAPHIC_TOP_UP:
                case LeadingModel.IDEOGRAPHIC_CENTER_UP:
                default:
                {
                    return true;
                }
                case LeadingModel.IDEOGRAPHIC_CENTER_DOWN:
                case :
                {
                    return false;
                    break;
                }
            }
        }// end function

    }
}
