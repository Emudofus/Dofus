package flashx.textLayout.edit
{
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;

    public class TextScrap extends Object
    {
        private var _textFlow:TextFlow;
        private var _plainText:int;
        static const MERGE_TO_NEXT_ON_PASTE:String = "mergeToNextOnPaste";

        public function TextScrap(param1:TextFlow = null)
        {
            this._textFlow = param1;
            this._textFlow.flowComposer = null;
            this._plainText = -1;
            return;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._textFlow;
        }// end function

        public function clone() : TextScrap
        {
            return new TextScrap(this.textFlow.deepCopy() as TextFlow);
        }// end function

        function setPlainText(param1:Boolean) : void
        {
            this._plainText = param1 ? (0) : (1);
            return;
        }// end function

        function isPlainText() : Boolean
        {
            var isPlainElement:Function;
            var i:int;
            isPlainElement = function (param1:FlowElement) : Boolean
            {
                var _loc_3:* = null;
                if (!(param1 is ParagraphElement) && !(param1 is SpanElement))
                {
                    foundAttributes = true;
                    return true;
                }
                var _loc_2:* = param1.styles;
                if (_loc_2)
                {
                    for (_loc_3 in _loc_2)
                    {
                        
                        if (_loc_3 != ConverterBase.MERGE_TO_NEXT_ON_PASTE)
                        {
                            foundAttributes = true;
                            return true;
                        }
                    }
                }
                return false;
            }// end function
            ;
            var foundAttributes:Boolean;
            if (this._plainText == -1)
            {
                i = (this._textFlow.numChildren - 1);
                while (i >= 0)
                {
                    
                    this._textFlow.getChildAt(i).applyFunctionToElements(isPlainElement);
                    i = (i - 1);
                }
                this._plainText = foundAttributes ? (1) : (0);
            }
            return this._plainText == 0;
        }// end function

        public static function createTextScrap(param1:TextRange) : TextScrap
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = param1.absoluteStart;
            var _loc_3:* = param1.absoluteEnd;
            var _loc_4:* = param1.textFlow;
            if (!param1.textFlow || _loc_2 >= _loc_3)
            {
                return null;
            }
            var _loc_5:* = _loc_4.deepCopy(_loc_2, _loc_3) as TextFlow;
            (_loc_4.deepCopy(_loc_2, _loc_3) as TextFlow).normalize();
            var _loc_6:* = new TextScrap(_loc_5);
            if (_loc_5.textLength > 0)
            {
                _loc_7 = _loc_5.getLastLeaf();
                _loc_8 = _loc_4.findLeaf((_loc_3 - 1));
                _loc_9 = _loc_5.getLastLeaf();
                if (_loc_9 is SpanElement && !(_loc_8 is SpanElement))
                {
                    _loc_9 = _loc_5.findLeaf(_loc_5.textLength - 2);
                }
                while (_loc_9 && _loc_8)
                {
                    
                    if (_loc_3 < _loc_8.getAbsoluteStart() + _loc_8.textLength)
                    {
                        _loc_9.setStyle(MERGE_TO_NEXT_ON_PASTE, "true");
                    }
                    _loc_9 = _loc_9.parent;
                    _loc_8 = _loc_8.parent;
                }
                return _loc_6;
            }
            return null;
        }// end function

    }
}
