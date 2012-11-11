package flashx.textLayout.elements
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.events.*;

    public class SubParagraphGroupElementBase extends FlowGroupElement
    {
        private var _groupElement:GroupElement;
        var _eventMirror:FlowElementEventDispatcher = null;
        static const kMaxSPGEPrecedence:uint = 1000;
        static const kMinSPGEPrecedence:uint = 0;

        public function SubParagraphGroupElementBase()
        {
            return;
        }// end function

        override function createContentElement() : void
        {
            var _loc_2:* = null;
            if (this._groupElement)
            {
                return;
            }
            this._groupElement = new GroupElement(null);
            var _loc_1:* = 0;
            while (_loc_1 < numChildren)
            {
                
                _loc_2 = getChildAt(_loc_1);
                _loc_2.createContentElement();
                _loc_1++;
            }
            if (parent)
            {
                parent.insertBlockElement(this, this._groupElement);
            }
            return;
        }// end function

        override function releaseContentElement() : void
        {
            var _loc_2:* = null;
            if (this._groupElement == null)
            {
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < numChildren)
            {
                
                _loc_2 = getChildAt(_loc_1);
                _loc_2.releaseContentElement();
                _loc_1++;
            }
            this._groupElement = null;
            _computedFormat = null;
            return;
        }// end function

        function get precedence() : uint
        {
            return kMaxSPGEPrecedence;
        }// end function

        function get groupElement() : GroupElement
        {
            return this._groupElement;
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

        override function createContentAsGroup() : GroupElement
        {
            return this.groupElement;
        }// end function

        override function removeBlockElement(param1:FlowElement, param2:ContentElement) : void
        {
            var _loc_3:* = this.getChildIndex(param1);
            this.groupElement.replaceElements(_loc_3, (_loc_3 + 1), null);
            return;
        }// end function

        override function insertBlockElement(param1:FlowElement, param2:ContentElement) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this.groupElement)
            {
                _loc_3 = this.getChildIndex(param1);
                _loc_4 = new Vector.<ContentElement>;
                _loc_4.push(param2);
                this.groupElement.replaceElements(_loc_3, _loc_3, _loc_4);
            }
            else
            {
                param1.releaseContentElement();
                _loc_5 = getParagraph();
                if (_loc_5)
                {
                    _loc_5.createTextBlock();
                }
            }
            return;
        }// end function

        override function hasBlockElement() : Boolean
        {
            return this.groupElement != null;
        }// end function

        override function setParentAndRelativeStart(param1:FlowGroupElement, param2:int) : void
        {
            if (param1 == parent)
            {
                return;
            }
            if (parent && parent.hasBlockElement() && this.groupElement)
            {
                parent.removeBlockElement(this, this.groupElement);
            }
            if (param1 && !param1.hasBlockElement() && this.groupElement)
            {
                param1.createContentElement();
            }
            super.setParentAndRelativeStart(param1, param2);
            if (parent && parent.hasBlockElement())
            {
                if (!this.groupElement)
                {
                    this.createContentElement();
                }
                else
                {
                    parent.insertBlockElement(this, this.groupElement);
                }
            }
            return;
        }// end function

        override public function replaceChildren(param1:int, param2:int, ... args) : void
        {
            args = [param1, param2];
            super.replaceChildren.apply(this, args.concat(args));
            var _loc_5:* = this.getParagraph();
            if (this.getParagraph())
            {
                _loc_5.ensureTerminatorAfterReplace();
            }
            return;
        }// end function

        override function normalizeRange(param1:uint, param2:uint) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
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
            if (numChildren == 0 && parent != null)
            {
                _loc_8 = new SpanElement();
                this.replaceChildren(0, 0, _loc_8);
                _loc_8.normalizeRange(0, _loc_8.textLength);
            }
            return;
        }// end function

        function get allowNesting() : Boolean
        {
            return false;
        }// end function

        private function checkForNesting(param1:SubParagraphGroupElementBase) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1)
            {
                if (!param1.allowNesting)
                {
                    _loc_3 = getDefinitionByName(getQualifiedClassName(param1)) as Class;
                    if (this is _loc_3 || this.getParentByType(_loc_3))
                    {
                        return false;
                    }
                }
                _loc_2 = param1.numChildren - 1;
                while (_loc_2 >= 0)
                {
                    
                    if (!this.checkForNesting(param1.getChildAt(_loc_2) as SubParagraphGroupElementBase))
                    {
                        return false;
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            return true;
        }// end function

        override function canOwnFlowElement(param1:FlowElement) : Boolean
        {
            if (param1 is FlowLeafElement)
            {
                return true;
            }
            if (param1 is SubParagraphGroupElementBase && this.checkForNesting(param1 as SubParagraphGroupElementBase))
            {
                return true;
            }
            return false;
        }// end function

        function acceptTextBefore() : Boolean
        {
            return true;
        }// end function

        function acceptTextAfter() : Boolean
        {
            return true;
        }// end function

    }
}
