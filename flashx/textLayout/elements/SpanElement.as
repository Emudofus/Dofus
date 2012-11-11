package flashx.textLayout.elements
{
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    public class SpanElement extends FlowLeafElement
    {
        static const kParagraphTerminator:String = " ";
        private static const _dblSpacePattern:RegExp = /[ ]{2,}""[ ]{2,}/g;
        private static const _newLineTabPattern:RegExp = /[	t
nr]""[	
]/g;
        private static const _tabPlaceholderPattern:RegExp = /""/g;
        private static const anyPrintChar:RegExp = /[^	t
nr ]""[^	
 ]/g;

        public function SpanElement()
        {
            return;
        }// end function

        override function createContentElement() : void
        {
            if (_blockElement)
            {
                return;
            }
            _blockElement = new TextElement(_text, null);
            super.createContentElement();
            return;
        }// end function

        override public function shallowCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            if (param2 == -1)
            {
                param2 = textLength;
            }
            var _loc_3:* = super.shallowCopy(param1, param2) as SpanElement;
            var _loc_4:* = 0;
            var _loc_5:* = 0 + textLength;
            var _loc_6:* = _loc_4 >= param1 ? (_loc_4) : (param1);
            var _loc_7:* = _loc_5 < param2 ? (_loc_5) : (param2);
            if ((_loc_5 < param2 ? (_loc_5) : (param2)) == textLength && this.hasParagraphTerminator)
            {
                _loc_7 = _loc_7 - 1;
            }
            if (_loc_6 > _loc_7)
            {
                throw RangeError(GlobalSettings.resourceStringFunction("badShallowCopyRange"));
            }
            if (_loc_6 != _loc_5 && CharacterUtil.isLowSurrogate(_text.charCodeAt(_loc_6)) || _loc_7 != 0 && CharacterUtil.isHighSurrogate(_text.charCodeAt((_loc_7 - 1))))
            {
                throw RangeError(GlobalSettings.resourceStringFunction("badSurrogatePairCopy"));
            }
            if (_loc_6 != _loc_7)
            {
                _loc_3.replaceText(0, _loc_3.textLength, _text.substring(_loc_6, _loc_7));
            }
            return _loc_3;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "span";
        }// end function

        override public function get text() : String
        {
            if (textLength == 0)
            {
                return "";
            }
            return this.hasParagraphTerminator ? (_text.substr(0, (textLength - 1))) : (_text);
        }// end function

        public function set text(param1:String) : void
        {
            this.replaceText(0, textLength, param1);
            return;
        }// end function

        override public function getText(param1:int = 0, param2:int = -1, param3:String = "\n") : String
        {
            if (param2 == -1)
            {
                param2 = textLength;
            }
            if (textLength && param2 == textLength && this.hasParagraphTerminator)
            {
                param2 = param2 - 1;
            }
            return _text ? (_text.substring(param1, param2)) : ("");
        }// end function

        public function get mxmlChildren() : Array
        {
            return [this.text];
        }// end function

        public function set mxmlChildren(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = new String();
            for each (_loc_3 in param1)
            {
                
                if (_loc_3 is String)
                {
                    _loc_2 = _loc_2 + (_loc_3 as String);
                    continue;
                }
                if (_loc_3 is Number)
                {
                    _loc_2 = _loc_2 + _loc_3.toString();
                    continue;
                }
                if (_loc_3 is BreakElement)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(8232);
                    continue;
                }
                if (_loc_3 is TabElement)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(57344);
                    continue;
                }
                if (_loc_3 != null)
                {
                    throw new TypeError(GlobalSettings.resourceStringFunction("badMXMLChildrenArgument", [getQualifiedClassName(_loc_3)]));
                }
            }
            this.replaceText(0, textLength, _loc_2);
            return;
        }// end function

        function get hasParagraphTerminator() : Boolean
        {
            var _loc_1:* = getParagraph();
            return _loc_1 && _loc_1.getLastLeaf() == this;
        }// end function

        override function applyWhiteSpaceCollapse(param1:String) : void
        {
            var _loc_2:* = this.formatForCascade;
            var _loc_3:* = _loc_2 ? (_loc_2.whiteSpaceCollapse) : (undefined);
            if (_loc_3 !== undefined && _loc_3 != FormatValue.INHERIT)
            {
                param1 = _loc_3;
            }
            var _loc_4:* = this.text;
            var _loc_5:* = this.text;
            if (!param1 || param1 == WhiteSpaceCollapse.COLLAPSE)
            {
                if (impliedElement && parent != null)
                {
                    if (_loc_5.search(anyPrintChar) == -1)
                    {
                        parent.removeChild(this);
                        return;
                    }
                }
                _loc_5 = _loc_5.replace(_newLineTabPattern, " ");
                _loc_5 = _loc_5.replace(_dblSpacePattern, " ");
            }
            _loc_5 = _loc_5.replace(_tabPlaceholderPattern, "\t");
            if (_loc_5 != _loc_4)
            {
                this.replaceText(0, textLength, _loc_5);
            }
            super.applyWhiteSpaceCollapse(param1);
            return;
        }// end function

        public function replaceText(param1:int, param2:int, param3:String) : void
        {
            if (param1 < 0 || param2 > textLength || param2 < param1)
            {
                throw RangeError(GlobalSettings.resourceStringFunction("invalidReplaceTextPositions"));
            }
            if (param1 != 0 && param1 != textLength && CharacterUtil.isLowSurrogate(_text.charCodeAt(param1)) || param2 != 0 && param2 != textLength && CharacterUtil.isHighSurrogate(_text.charCodeAt((param2 - 1))))
            {
                throw RangeError(GlobalSettings.resourceStringFunction("invalidSurrogatePairSplit"));
            }
            if (this.hasParagraphTerminator)
            {
                if (param1 == textLength)
                {
                    param1 = param1 - 1;
                }
                if (param2 == textLength)
                {
                    param2 = param2 - 1;
                }
            }
            if (param2 != param1)
            {
                modelChanged(ModelChange.TEXT_DELETED, this, param1, param2 - param1);
            }
            this.replaceTextInternal(param1, param2, param3);
            if (param3 && param3.length)
            {
                modelChanged(ModelChange.TEXT_INSERTED, this, param1, param3.length);
            }
            return;
        }// end function

        private function replaceTextInternal(param1:int, param2:int, param3:String) : void
        {
            var _loc_7:* = null;
            var _loc_4:* = param3 == null ? (0) : (param3.length);
            var _loc_5:* = param2 - param1;
            var _loc_6:* = _loc_4 - _loc_5;
            if (_blockElement)
            {
                (_blockElement as TextElement).replaceText(param1, param2, param3);
                _text = _blockElement.rawText;
            }
            else if (_text)
            {
                if (param3)
                {
                    _text = _text.slice(0, param1) + param3 + _text.slice(param2, _text.length);
                }
                else
                {
                    _text = _text.slice(0, param1) + _text.slice(param2, _text.length);
                }
            }
            else
            {
                _text = param3;
            }
            if (_loc_6 != 0)
            {
                updateLengths(getAbsoluteStart() + param1, _loc_6, true);
                deleteContainerText(param2, _loc_5);
                if (_loc_4 != 0)
                {
                    _loc_7 = getEnclosingController(param1);
                    if (_loc_7)
                    {
                        ContainerController(_loc_7).setTextLength(_loc_7.textLength + _loc_4);
                    }
                }
            }
            return;
        }// end function

        function addParaTerminator() : void
        {
            this.replaceTextInternal(textLength, textLength, SpanElement.kParagraphTerminator);
            modelChanged(ModelChange.TEXT_INSERTED, this, (textLength - 1), 1);
            return;
        }// end function

        function removeParaTerminator() : void
        {
            this.replaceTextInternal((textLength - 1), textLength, "");
            modelChanged(ModelChange.TEXT_DELETED, this, textLength > 0 ? ((textLength - 1)) : (0), 1);
            return;
        }// end function

        override public function splitAtPosition(param1:int) : FlowElement
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (param1 < 0 || param1 > textLength)
            {
                throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtPosition"));
            }
            if (param1 < textLength && CharacterUtil.isLowSurrogate(String(this.text).charCodeAt(param1)))
            {
                throw RangeError(GlobalSettings.resourceStringFunction("invalidSurrogatePairSplit"));
            }
            var _loc_2:* = new SpanElement();
            _loc_2.id = this.id;
            _loc_2.typeName = this.typeName;
            if (parent)
            {
                _loc_4 = textLength - param1;
                if (_blockElement)
                {
                    _loc_6 = parent.createContentAsGroup();
                    _loc_7 = _loc_6.getElementIndex(_blockElement);
                    _loc_6.splitTextElement(_loc_7, param1);
                    _blockElement = _loc_6.getElementAt(_loc_7);
                    _text = _blockElement.rawText;
                    _loc_3 = _loc_6.getElementAt((_loc_7 + 1)) as TextElement;
                }
                else if (param1 < textLength)
                {
                    _loc_2.text = _text.substr(param1);
                    _text = _text.substring(0, param1);
                }
                modelChanged(ModelChange.TEXT_DELETED, this, param1, _loc_4);
                _loc_2.quickInitializeForSplit(this, _loc_4, _loc_3);
                setTextLength(param1);
                parent.addChildAfterInternal(this, _loc_2);
                _loc_5 = this.getParagraph();
                _loc_5.updateTerminatorSpan(this, _loc_2);
                parent.modelChanged(ModelChange.ELEMENT_ADDED, _loc_2, _loc_2.parentRelativeStart, _loc_2.textLength);
            }
            else
            {
                _loc_2.format = format;
                if (param1 < textLength)
                {
                    _loc_2.text = String(this.text).substr(param1);
                    this.replaceText(param1, textLength, null);
                }
            }
            return _loc_2;
        }// end function

        override function normalizeRange(param1:uint, param2:uint) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.textLength == 1 && !bindableElement)
            {
                _loc_3 = getParagraph();
                if (_loc_3 && _loc_3.getLastLeaf() == this)
                {
                    _loc_4 = getPreviousLeaf(_loc_3);
                    if (_loc_4)
                    {
                        if (!TextLayoutFormat.isEqual(this.format, _loc_4.format))
                        {
                            this.format = _loc_4.format;
                        }
                    }
                }
            }
            super.normalizeRange(param1, param2);
            return;
        }// end function

        override function mergeToPreviousIfPossible() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (parent && !bindableElement)
            {
                _loc_1 = parent.getChildIndex(this);
                if (_loc_1 != 0)
                {
                    _loc_2 = parent.getChildAt((_loc_1 - 1)) as SpanElement;
                    if (!_loc_2 && this.textLength == 1 && this.hasParagraphTerminator)
                    {
                        _loc_4 = getParagraph();
                        if (_loc_4)
                        {
                            _loc_5 = getPreviousLeaf(_loc_4) as SpanElement;
                            if (_loc_5)
                            {
                                parent.removeChildAt(_loc_1);
                                return true;
                            }
                        }
                    }
                    if (_loc_2 == null)
                    {
                        return false;
                    }
                    if (this.hasActiveEventMirror())
                    {
                        return false;
                    }
                    _loc_3 = textLength == 1 && this.hasParagraphTerminator;
                    if (_loc_2.hasActiveEventMirror() && !_loc_3)
                    {
                        return false;
                    }
                    if (_loc_3 || equalStylesForMerge(_loc_2))
                    {
                        _loc_6 = _loc_2.textLength;
                        _loc_2.replaceText(_loc_6, _loc_6, this.text);
                        parent.removeChildAt(_loc_1);
                        return true;
                    }
                }
            }
            return false;
        }// end function

    }
}
