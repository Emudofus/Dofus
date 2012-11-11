package flashx.textLayout.elements
{
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.formats.*;

    final public class TCYElement extends SubParagraphGroupElementBase
    {

        public function TCYElement()
        {
            return;
        }// end function

        override function createContentElement() : void
        {
            super.createContentElement();
            this.updateTCYRotation();
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "tcy";
        }// end function

        override function get precedence() : uint
        {
            return 100;
        }// end function

        override function mergeToPreviousIfPossible() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (parent && !bindableElement)
            {
                _loc_1 = parent.getChildIndex(this);
                if (_loc_1 != 0)
                {
                    _loc_2 = parent.getChildAt((_loc_1 - 1)) as TCYElement;
                    if (_loc_2)
                    {
                        while (this.numChildren > 0)
                        {
                            
                            _loc_3 = this.getChildAt(0);
                            replaceChildren(0, 1);
                            _loc_2.replaceChildren(_loc_2.numChildren, _loc_2.numChildren, _loc_3);
                        }
                        parent.replaceChildren(_loc_1, (_loc_1 + 1));
                        return true;
                    }
                }
            }
            return false;
        }// end function

        override function acceptTextBefore() : Boolean
        {
            return false;
        }// end function

        override function setParentAndRelativeStart(param1:FlowGroupElement, param2:int) : void
        {
            super.setParentAndRelativeStart(param1, param2);
            this.updateTCYRotation();
            return;
        }// end function

        override function formatChanged(param1:Boolean = true) : void
        {
            super.formatChanged(param1);
            this.updateTCYRotation();
            return;
        }// end function

        function calculateAdornmentBounds(param1:SubParagraphGroupElementBase, param2:TextLine, param3:String, param4:Rectangle) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_5:* = 0;
            while (_loc_5 < param1.numChildren)
            {
                
                _loc_6 = param1.getChildAt(_loc_5) as FlowElement;
                _loc_7 = _loc_6 as FlowLeafElement;
                if (!_loc_7 && _loc_6 is SubParagraphGroupElementBase)
                {
                    this.calculateAdornmentBounds(_loc_6 as SubParagraphGroupElementBase, param2, param3, param4);
                    _loc_5++;
                    continue;
                }
                _loc_8 = null;
                if (!(_loc_7 is InlineGraphicElement))
                {
                    _loc_8 = _loc_7.getSpanBoundsOnLine(param2, param3)[0];
                }
                else
                {
                    _loc_8 = (_loc_7 as InlineGraphicElement).graphic.getBounds(param2);
                }
                if (_loc_5 != 0)
                {
                    if (_loc_8.top < param4.top)
                    {
                        param4.top = _loc_8.top;
                    }
                    if (_loc_8.bottom > param4.bottom)
                    {
                        param4.bottom = _loc_8.bottom;
                    }
                    if (param4.x > _loc_8.x)
                    {
                        param4.x = _loc_8.x;
                    }
                }
                else
                {
                    param4.top = _loc_8.top;
                    param4.bottom = _loc_8.bottom;
                    param4.x = _loc_8.x;
                }
                _loc_5++;
            }
            return;
        }// end function

        private function updateTCYRotation() : void
        {
            var _loc_1:* = getAncestorWithContainer();
            if (groupElement)
            {
                groupElement.textRotation = _loc_1 && _loc_1.computedFormat.blockProgression == BlockProgression.RL ? (TextRotation.ROTATE_270) : (TextRotation.ROTATE_0);
            }
            return;
        }// end function

    }
}
