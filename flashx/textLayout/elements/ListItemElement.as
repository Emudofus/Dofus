package flashx.textLayout.elements
{
    import flashx.textLayout.formats.*;

    final public class ListItemElement extends ContainerFormattedElement
    {
        var _listNumberHint:int = 2147483647;

        public function ListItemElement()
        {
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "li";
        }// end function

        function computedListMarkerFormat() : IListMarkerFormat
        {
            var _loc_2:* = null;
            var _loc_1:* = this.getUserStyleWorker(ListElement.LIST_MARKER_FORMAT_NAME) as IListMarkerFormat;
            if (_loc_1 == null)
            {
                _loc_2 = this.getTextFlow();
                if (_loc_2)
                {
                    _loc_1 = _loc_2.configuration.defaultListMarkerFormat;
                }
            }
            return _loc_1;
        }// end function

        function normalizeNeedsInitialParagraph() : Boolean
        {
            var _loc_1:* = this;
            while (_loc_1)
            {
                
                _loc_1 = _loc_1.getChildAt(0) as FlowGroupElement;
                if (_loc_1 is ParagraphElement)
                {
                    return false;
                }
                if (!(_loc_1 is DivElement))
                {
                    return true;
                }
            }
            return true;
        }// end function

        override function normalizeRange(param1:uint, param2:uint) : void
        {
            var _loc_3:* = null;
            super.normalizeRange(param1, param2);
            this._listNumberHint = int.MAX_VALUE;
            if (this.normalizeNeedsInitialParagraph())
            {
                _loc_3 = new ParagraphElement();
                _loc_3.replaceChildren(0, 0, new SpanElement());
                replaceChildren(0, 0, _loc_3);
                _loc_3.normalizeRange(0, _loc_3.textLength);
            }
            return;
        }// end function

        function getListItemNumber(param1:IListMarkerFormat = null) : int
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (this._listNumberHint == int.MAX_VALUE)
            {
                if (param1 == null)
                {
                    param1 = this.computedListMarkerFormat();
                }
                _loc_2 = param1.counterReset;
                if (_loc_2 && _loc_2.hasOwnProperty("ordered"))
                {
                    this._listNumberHint = _loc_2.ordered;
                }
                else
                {
                    _loc_4 = parent.getChildIndex(this);
                    this._listNumberHint = 0;
                    while (_loc_4 > 0)
                    {
                        
                        _loc_4 = _loc_4 - 1;
                        _loc_5 = parent.getChildAt(_loc_4) as ListItemElement;
                        if (_loc_5)
                        {
                            this._listNumberHint = _loc_5.getListItemNumber();
                            break;
                        }
                    }
                }
                _loc_3 = param1.counterIncrement;
                this._listNumberHint = this._listNumberHint + (_loc_3 && _loc_3.hasOwnProperty("ordered") ? (_loc_3.ordered) : (1));
            }
            return this._listNumberHint;
        }// end function

        override function getEffectivePaddingLeft() : Number
        {
            if (getTextFlow().computedFormat.blockProgression == BlockProgression.TB)
            {
                if (computedFormat.paddingLeft == FormatValue.AUTO)
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return 0;
                }
                else
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.paddingLeft + computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return computedFormat.paddingLeft;
                }
            }
            else
            {
                return 0;
            }
        }// end function

        override function getEffectivePaddingTop() : Number
        {
            if (getTextFlow().computedFormat.blockProgression == BlockProgression.RL)
            {
                if (computedFormat.paddingTop == FormatValue.AUTO)
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return 0;
                }
                else
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.paddingTop + computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return computedFormat.paddingTop;
                }
            }
            else
            {
                return 0;
            }
        }// end function

        override function getEffectivePaddingRight() : Number
        {
            if (getTextFlow().computedFormat.blockProgression == BlockProgression.TB)
            {
                if (computedFormat.paddingRight == FormatValue.AUTO)
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return 0;
                }
                else
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.paddingRight + computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return computedFormat.paddingRight;
                }
            }
            else
            {
                return 0;
            }
        }// end function

        override function getEffectivePaddingBottom() : Number
        {
            if (getTextFlow().computedFormat.blockProgression == BlockProgression.RL)
            {
                if (computedFormat.paddingBottom == FormatValue.AUTO)
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return 0;
                }
                else
                {
                    if (computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
                    {
                        return computedFormat.paddingBottom + computedFormat.listMarkerFormat.paragraphStartIndent;
                    }
                    return computedFormat.paddingBottom;
                }
            }
            else
            {
                return 0;
            }
        }// end function

    }
}
