package flashx.textLayout.edit
{
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class ElementRange extends Object
    {
        private var _absoluteStart:int;
        private var _absoluteEnd:int;
        private var _firstLeaf:FlowLeafElement;
        private var _lastLeaf:FlowLeafElement;
        private var _firstParagraph:ParagraphElement;
        private var _lastParagraph:ParagraphElement;
        private var _textFlow:TextFlow;

        public function ElementRange()
        {
            return;
        }// end function

        public function get absoluteStart() : int
        {
            return this._absoluteStart;
        }// end function

        public function set absoluteStart(param1:int) : void
        {
            this._absoluteStart = param1;
            return;
        }// end function

        public function get absoluteEnd() : int
        {
            return this._absoluteEnd;
        }// end function

        public function set absoluteEnd(param1:int) : void
        {
            this._absoluteEnd = param1;
            return;
        }// end function

        public function get firstLeaf() : FlowLeafElement
        {
            return this._firstLeaf;
        }// end function

        public function set firstLeaf(param1:FlowLeafElement) : void
        {
            this._firstLeaf = param1;
            return;
        }// end function

        public function get lastLeaf() : FlowLeafElement
        {
            return this._lastLeaf;
        }// end function

        public function set lastLeaf(param1:FlowLeafElement) : void
        {
            this._lastLeaf = param1;
            return;
        }// end function

        public function get firstParagraph() : ParagraphElement
        {
            return this._firstParagraph;
        }// end function

        public function set firstParagraph(param1:ParagraphElement) : void
        {
            this._firstParagraph = param1;
            return;
        }// end function

        public function get lastParagraph() : ParagraphElement
        {
            return this._lastParagraph;
        }// end function

        public function set lastParagraph(param1:ParagraphElement) : void
        {
            this._lastParagraph = param1;
            return;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._textFlow;
        }// end function

        public function set textFlow(param1:TextFlow) : void
        {
            this._textFlow = param1;
            return;
        }// end function

        public function get containerFormat() : ITextLayoutFormat
        {
            var _loc_1:* = null;
            var _loc_3:* = 0;
            var _loc_2:* = this._textFlow.flowComposer;
            if (_loc_2)
            {
                _loc_3 = _loc_2.findControllerIndexAtPosition(this.absoluteStart);
                if (_loc_3 != -1)
                {
                    _loc_1 = _loc_2.getControllerAt(_loc_3);
                }
            }
            return _loc_1 ? (_loc_1.computedFormat) : (this._textFlow.computedFormat);
        }// end function

        public function get paragraphFormat() : ITextLayoutFormat
        {
            return this.firstParagraph.computedFormat;
        }// end function

        public function get characterFormat() : ITextLayoutFormat
        {
            return this.firstLeaf.computedFormat;
        }// end function

        public function getCommonCharacterFormat() : TextLayoutFormat
        {
            var _loc_1:* = this.firstLeaf;
            var _loc_2:* = new TextLayoutFormat(_loc_1.computedFormat);
            while (true)
            {
                
                if (_loc_1 == this.lastLeaf)
                {
                    break;
                }
                _loc_1 = _loc_1.getNextLeaf();
                _loc_2.removeClashing(_loc_1.computedFormat);
            }
            return Property.extractInCategory(TextLayoutFormat, TextLayoutFormat.description, _loc_2, Category.CHARACTER, false) as TextLayoutFormat;
        }// end function

        public function getCommonParagraphFormat() : TextLayoutFormat
        {
            var _loc_1:* = this.firstParagraph;
            var _loc_2:* = new TextLayoutFormat(_loc_1.computedFormat);
            while (true)
            {
                
                if (_loc_1 == this.lastParagraph)
                {
                    break;
                }
                _loc_1 = this._textFlow.findAbsoluteParagraph(_loc_1.getAbsoluteStart() + _loc_1.textLength);
                _loc_2.removeClashing(_loc_1.computedFormat);
            }
            return Property.extractInCategory(TextLayoutFormat, TextLayoutFormat.description, _loc_2, Category.PARAGRAPH, false) as TextLayoutFormat;
        }// end function

        public function getCommonContainerFormat() : TextLayoutFormat
        {
            var _loc_1:* = this._textFlow.flowComposer;
            if (!_loc_1)
            {
                return null;
            }
            var _loc_2:* = _loc_1.findControllerIndexAtPosition(this.absoluteStart);
            if (_loc_2 == -1)
            {
                return null;
            }
            var _loc_3:* = _loc_1.getControllerAt(_loc_2);
            var _loc_4:* = new TextLayoutFormat(_loc_3.computedFormat);
            while (_loc_3.absoluteStart + _loc_3.textLength < this.absoluteEnd)
            {
                
                _loc_2++;
                if (_loc_2 == _loc_1.numControllers)
                {
                    break;
                }
                _loc_3 = _loc_1.getControllerAt(_loc_2);
                _loc_4.removeClashing(_loc_3.computedFormat);
            }
            return Property.extractInCategory(TextLayoutFormat, TextLayoutFormat.description, _loc_4, Category.CONTAINER, false) as TextLayoutFormat;
        }// end function

        public static function createElementRange(param1:TextFlow, param2:int, param3:int) : ElementRange
        {
            var _loc_4:* = new ElementRange;
            if (param2 == param3)
            {
                var _loc_5:* = param2;
                _loc_4.absoluteEnd = param2;
                _loc_4.absoluteStart = _loc_5;
                _loc_4.firstLeaf = param1.findLeaf(_loc_4.absoluteStart);
                _loc_4.firstParagraph = _loc_4.firstLeaf.getParagraph();
                adjustForLeanLeft(_loc_4);
                _loc_4.lastLeaf = _loc_4.firstLeaf;
                _loc_4.lastParagraph = _loc_4.firstParagraph;
            }
            else
            {
                if (param2 < param3)
                {
                    _loc_4.absoluteStart = param2;
                    _loc_4.absoluteEnd = param3;
                }
                else
                {
                    _loc_4.absoluteStart = param3;
                    _loc_4.absoluteEnd = param2;
                }
                _loc_4.firstLeaf = param1.findLeaf(_loc_4.absoluteStart);
                _loc_4.lastLeaf = param1.findLeaf(_loc_4.absoluteEnd);
                if (_loc_4.lastLeaf == null && _loc_4.absoluteEnd == param1.textLength || _loc_4.absoluteEnd == _loc_4.lastLeaf.getAbsoluteStart())
                {
                    _loc_4.lastLeaf = param1.findLeaf((_loc_4.absoluteEnd - 1));
                }
                _loc_4.firstParagraph = _loc_4.firstLeaf.getParagraph();
                _loc_4.lastParagraph = _loc_4.lastLeaf.getParagraph();
                if (_loc_4.absoluteEnd == _loc_4.lastParagraph.getAbsoluteStart() + _loc_4.lastParagraph.textLength - 1)
                {
                    var _loc_5:* = _loc_4;
                    var _loc_6:* = _loc_4.absoluteEnd + 1;
                    _loc_5.absoluteEnd = _loc_6;
                    _loc_4.lastLeaf = _loc_4.lastParagraph.getLastLeaf();
                }
            }
            _loc_4.textFlow = param1;
            return _loc_4;
        }// end function

        private static function adjustForLeanLeft(param1:ElementRange) : void
        {
            var _loc_2:* = null;
            if (param1.firstLeaf.getAbsoluteStart() == param1.absoluteStart)
            {
                _loc_2 = param1.firstLeaf.getPreviousLeaf(param1.firstParagraph);
                if (_loc_2 && _loc_2.getParagraph() == param1.firstLeaf.getParagraph())
                {
                    if ((!(_loc_2.parent is SubParagraphGroupElementBase) || (_loc_2.parent as SubParagraphGroupElementBase).acceptTextAfter()) && (!(param1.firstLeaf.parent is SubParagraphGroupElementBase) || _loc_2.parent === param1.firstLeaf.parent))
                    {
                        param1.firstLeaf = _loc_2;
                    }
                }
            }
            return;
        }// end function

    }
}
