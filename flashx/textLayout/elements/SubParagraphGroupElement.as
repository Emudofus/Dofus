package flashx.textLayout.elements
{

    final public class SubParagraphGroupElement extends SubParagraphGroupElementBase
    {

        public function SubParagraphGroupElement()
        {
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "g";
        }// end function

        override function get precedence() : uint
        {
            return kMinSPGEPrecedence;
        }// end function

        override function get allowNesting() : Boolean
        {
            return true;
        }// end function

        override function mergeToPreviousIfPossible() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (parent && !bindableElement && !hasActiveEventMirror())
            {
                _loc_1 = parent.getChildIndex(this);
                if (_loc_1 != 0)
                {
                    _loc_2 = parent.getChildAt((_loc_1 - 1)) as SubParagraphGroupElement;
                    if (_loc_2 == null || _loc_2.hasActiveEventMirror())
                    {
                        return false;
                    }
                    if (equalStylesForMerge(_loc_2))
                    {
                        parent.removeChildAt(_loc_1);
                        if (numChildren > 0)
                        {
                            _loc_2.replaceChildren(_loc_2.numChildren, _loc_2.numChildren, this.mxmlChildren);
                        }
                        return true;
                    }
                }
            }
            return false;
        }// end function

    }
}
