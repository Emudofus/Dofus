package flashx.textLayout.elements
{
    import flashx.textLayout.formats.*;

    public class SpecialCharacterElement extends SpanElement
    {

        public function SpecialCharacterElement()
        {
            whiteSpaceCollapse = WhiteSpaceCollapse.PRESERVE;
            return;
        }// end function

        override function mergeToPreviousIfPossible() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (parent)
            {
                _loc_1 = parent.getChildIndex(this);
                if (_loc_1 != 0)
                {
                    _loc_3 = parent.getChildAt((_loc_1 - 1)) as SpanElement;
                    if (_loc_3 != null && _loc_3 is SpanElement && TextLayoutFormat.isEqual(_loc_3.format, format))
                    {
                        _loc_4 = _loc_3.textLength;
                        _loc_3.replaceText(_loc_4, _loc_4, this.text);
                        parent.replaceChildren(_loc_1, (_loc_1 + 1));
                        return true;
                    }
                }
                _loc_2 = new SpanElement();
                _loc_2.text = this.text;
                _loc_2.format = format;
                parent.replaceChildren(_loc_1, (_loc_1 + 1), _loc_2);
                _loc_2.normalizeRange(0, _loc_2.textLength);
                return false;
            }
            return false;
        }// end function

    }
}
