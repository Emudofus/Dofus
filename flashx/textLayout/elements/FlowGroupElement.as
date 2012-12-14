package flashx.textLayout.elements
{
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;

    public class FlowGroupElement extends FlowElement
    {
        private var _childArray:Array;
        private var _singleChild:FlowElement;
        private var _numChildren:int;

        public function FlowGroupElement()
        {
            this._numChildren = 0;
            return;
        }// end function

        override public function deepCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param2 == -1)
            {
                param2 = textLength;
            }
            var _loc_3:* = shallowCopy(param1, param2) as FlowGroupElement;
            var _loc_5:* = 0;
            while (_loc_5 < this._numChildren)
            {
                
                _loc_6 = this.getChildAt(_loc_5);
                if (param1 - _loc_6.parentRelativeStart < _loc_6.textLength && param2 - _loc_6.parentRelativeStart > 0)
                {
                    _loc_4 = _loc_6.deepCopy(param1 - _loc_6.parentRelativeStart, param2 - _loc_6.parentRelativeStart);
                    _loc_3.replaceChildren(_loc_3.numChildren, _loc_3.numChildren, _loc_4);
                    if (_loc_3.numChildren > 1)
                    {
                        _loc_7 = _loc_3.getChildAt(_loc_3.numChildren - 2);
                        if (_loc_7.textLength == 0)
                        {
                            _loc_3.replaceChildren(_loc_3.numChildren - 2, (_loc_3.numChildren - 1));
                        }
                    }
                }
                _loc_5++;
            }
            return _loc_3;
        }// end function

        override public function getText(param1:int = 0, param2:int = -1, param3:String = "\n") : String
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_4:* = super.getText();
            if (param2 == -1)
            {
                param2 = textLength;
            }
            var _loc_5:* = param1;
            var _loc_6:* = this.findChildIndexAtPosition(param1);
            while (_loc_6 < this._numChildren && _loc_5 < param2)
            {
                
                _loc_7 = this.getChildAt(_loc_6);
                _loc_8 = _loc_5 - _loc_7.parentRelativeStart;
                _loc_9 = Math.min(param2 - _loc_7.parentRelativeStart, _loc_7.textLength);
                _loc_4 = _loc_4 + _loc_7.getText(_loc_8, _loc_9, param3);
                _loc_5 = _loc_5 + (_loc_9 - _loc_8);
                if (param3 && _loc_7 is ParagraphFormattedElement && _loc_5 < param2)
                {
                    _loc_4 = _loc_4 + param3;
                }
                _loc_6++;
            }
            return _loc_4;
        }// end function

        override function formatChanged(param1:Boolean = true) : void
        {
            var _loc_3:* = null;
            super.formatChanged(param1);
            var _loc_2:* = 0;
            while (_loc_2 < this._numChildren)
            {
                
                _loc_3 = this.getChildAt(_loc_2);
                _loc_3.formatChanged(false);
                _loc_2++;
            }
            return;
        }// end function

        override function styleSelectorChanged() : void
        {
            super.styleSelectorChanged();
            this.formatChanged(false);
            return;
        }// end function

        public function get mxmlChildren() : Array
        {
            return this._numChildren == 0 ? (null) : (this._numChildren == 1 ? ([this._singleChild]) : (this._childArray.slice()));
        }// end function

        public function set mxmlChildren(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.replaceChildren(0, this._numChildren);
            var _loc_2:* = this;
            for each (_loc_3 in param1)
            {
                
                if (_loc_3 is FlowElement)
                {
                    if (_loc_3 is ParagraphFormattedElement)
                    {
                        _loc_2 = this;
                    }
                    else if (_loc_2 is ContainerFormattedElement)
                    {
                        _loc_2 = new ParagraphElement();
                        _loc_2.impliedElement = true;
                        this.replaceChildren(this._numChildren, this._numChildren, _loc_2);
                    }
                    if (_loc_3 is SpanElement || _loc_3 is SubParagraphGroupElementBase)
                    {
                        _loc_3.bindableElement = true;
                    }
                    _loc_2.replaceChildren(_loc_2.numChildren, _loc_2.numChildren, FlowElement(_loc_3));
                    continue;
                }
                if (_loc_3 is String)
                {
                    _loc_4 = new SpanElement();
                    _loc_4.text = String(_loc_3);
                    _loc_4.bindableElement = true;
                    _loc_4.impliedElement = true;
                    if (_loc_2 is ContainerFormattedElement)
                    {
                        _loc_2 = new ParagraphElement();
                        this.replaceChildren(this._numChildren, this._numChildren, _loc_2);
                        _loc_2.impliedElement = true;
                    }
                    _loc_2.replaceChildren(_loc_2.numChildren, _loc_2.numChildren, _loc_4);
                    continue;
                }
                if (_loc_3 != null)
                {
                    throw new TypeError(GlobalSettings.resourceStringFunction("badMXMLChildrenArgument", [getQualifiedClassName(_loc_3)]));
                }
            }
            return;
        }// end function

        public function get numChildren() : int
        {
            return this._numChildren;
        }// end function

        public function getChildIndex(param1:FlowElement) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = this._numChildren - 1;
            if (_loc_2 <= 0)
            {
                return this._singleChild == param1 ? (0) : (-1);
            }
            var _loc_3:* = 0;
            while (_loc_3 <= _loc_2)
            {
                
                _loc_4 = (_loc_3 + _loc_2) / 2;
                _loc_5 = this._childArray[_loc_4];
                if (_loc_5.parentRelativeStart == param1.parentRelativeStart)
                {
                    if (_loc_5 == param1)
                    {
                        return _loc_4;
                    }
                    if (_loc_5.textLength == 0)
                    {
                        _loc_6 = _loc_4;
                        while (_loc_6 < this._numChildren)
                        {
                            
                            _loc_5 = this._childArray[_loc_6];
                            if (_loc_5 == param1)
                            {
                                return _loc_6;
                            }
                            if (_loc_5.textLength != 0)
                            {
                                break;
                            }
                            _loc_6++;
                        }
                    }
                    while (_loc_4 > 0)
                    {
                        
                        _loc_4 = _loc_4 - 1;
                        _loc_5 = this._childArray[_loc_4];
                        if (_loc_5 == param1)
                        {
                            return _loc_4;
                        }
                        if (_loc_5.textLength != 0)
                        {
                            break;
                        }
                    }
                    return -1;
                }
                if (_loc_5.parentRelativeStart < param1.parentRelativeStart)
                {
                    _loc_3 = _loc_4 + 1;
                    continue;
                }
                _loc_2 = _loc_4 - 1;
            }
            return -1;
        }// end function

        public function getChildAt(param1:int) : FlowElement
        {
            if (this._numChildren > 1)
            {
                return this._childArray[param1];
            }
            return param1 == 0 ? (this._singleChild) : (null);
        }// end function

        function getNextLeafHelper(param1:FlowGroupElement, param2:FlowElement) : FlowLeafElement
        {
            var _loc_3:* = this.getChildIndex(param2);
            if (_loc_3 == -1)
            {
                return null;
            }
            if (_loc_3 == (this._numChildren - 1))
            {
                if (param1 == this || !parent)
                {
                    return null;
                }
                return parent.getNextLeafHelper(param1, this);
            }
            param2 = this.getChildAt((_loc_3 + 1));
            return param2 is FlowLeafElement ? (FlowLeafElement(param2)) : (FlowGroupElement(param2).getFirstLeaf());
        }// end function

        function getPreviousLeafHelper(param1:FlowGroupElement, param2:FlowElement) : FlowLeafElement
        {
            var _loc_3:* = this.getChildIndex(param2);
            if (_loc_3 == -1)
            {
                return null;
            }
            if (_loc_3 == 0)
            {
                if (param1 == this || !parent)
                {
                    return null;
                }
                return parent.getPreviousLeafHelper(param1, this);
            }
            param2 = this.getChildAt((_loc_3 - 1));
            return param2 is FlowLeafElement ? (FlowLeafElement(param2)) : (FlowGroupElement(param2).getLastLeaf());
        }// end function

        public function findLeaf(param1:int) : FlowLeafElement
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = this.findChildIndexAtPosition(param1);
            if (_loc_3 != -1)
            {
                do
                {
                    
                    _loc_4 = this.getChildAt(_loc_3++);
                    if (!_loc_4)
                    {
                        break;
                    }
                    _loc_5 = param1 - _loc_4.parentRelativeStart;
                    if (_loc_4 is FlowGroupElement)
                    {
                        _loc_2 = FlowGroupElement(_loc_4).findLeaf(_loc_5);
                        continue;
                    }
                    if (_loc_5 >= 0 && _loc_5 < _loc_4.textLength || _loc_4.textLength == 0 && this._numChildren == 1)
                    {
                        _loc_2 = FlowLeafElement(_loc_4);
                    }
                }while (!_loc_2 && !_loc_4.textLength)
            }
            return _loc_2;
        }// end function

        public function findChildIndexAtPosition(param1:int) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = this._numChildren - 1;
            while (_loc_2 <= _loc_3)
            {
                
                _loc_4 = (_loc_2 + _loc_3) / 2;
                _loc_5 = this.getChildAt(_loc_4);
                if (_loc_5.parentRelativeStart <= param1)
                {
                    if (_loc_5.parentRelativeStart == param1)
                    {
                        while (_loc_4 != 0)
                        {
                            
                            _loc_5 = this.getChildAt((_loc_4 - 1));
                            if (_loc_5.textLength != 0)
                            {
                                break;
                            }
                            _loc_4 = _loc_4 - 1;
                        }
                        return _loc_4;
                    }
                    if (_loc_5.parentRelativeStart + _loc_5.textLength > param1)
                    {
                        return _loc_4;
                    }
                    _loc_2 = _loc_4 + 1;
                    continue;
                }
                _loc_3 = _loc_4 - 1;
            }
            return -1;
        }// end function

        public function getFirstLeaf() : FlowLeafElement
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._numChildren > 1)
            {
                _loc_1 = 0;
                while (_loc_1 < this._numChildren)
                {
                    
                    _loc_2 = this._childArray[_loc_1];
                    _loc_3 = _loc_2 is FlowGroupElement ? (FlowGroupElement(_loc_2).getFirstLeaf()) : (FlowLeafElement(_loc_2));
                    if (_loc_3)
                    {
                        return _loc_3;
                    }
                    _loc_1++;
                }
                return null;
            }
            return this._numChildren == 0 ? (null) : (this._singleChild is FlowGroupElement ? (FlowGroupElement(this._singleChild).getFirstLeaf()) : (FlowLeafElement(this._singleChild)));
        }// end function

        public function getLastLeaf() : FlowLeafElement
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._numChildren > 1)
            {
                _loc_1 = this._numChildren;
                while (_loc_1 != 0)
                {
                    
                    _loc_2 = this._childArray[(_loc_1 - 1)];
                    _loc_3 = _loc_2 is FlowGroupElement ? (FlowGroupElement(_loc_2).getLastLeaf()) : (FlowLeafElement(_loc_2));
                    if (_loc_3)
                    {
                        return _loc_3;
                    }
                    _loc_1 = _loc_1 - 1;
                }
                return null;
            }
            return this._numChildren == 0 ? (null) : (this._singleChild is FlowGroupElement ? (FlowGroupElement(this._singleChild).getLastLeaf()) : (FlowLeafElement(this._singleChild)));
        }// end function

        override public function getCharAtPosition(param1:int) : String
        {
            var _loc_2:* = this.findLeaf(param1);
            return _loc_2 ? (_loc_2.getCharAtPosition(param1 - _loc_2.getElementRelativeStart(this))) : ("");
        }// end function

        override function applyFunctionToElements(param1:Function) : Boolean
        {
            if (this.param1(this))
            {
                return true;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._numChildren)
            {
                
                if (this.getChildAt(_loc_2).applyFunctionToElements(param1))
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

        function removeBlockElement(param1:FlowElement, param2:ContentElement) : void
        {
            return;
        }// end function

        function insertBlockElement(param1:FlowElement, param2:ContentElement) : void
        {
            return;
        }// end function

        function hasBlockElement() : Boolean
        {
            return false;
        }// end function

        function createContentAsGroup() : GroupElement
        {
            return null;
        }// end function

        function addChildAfterInternal(param1:FlowElement, param2:FlowElement) : void
        {
            if (this._numChildren > 1)
            {
                this._childArray.splice((this._childArray.indexOf(param1) + 1), 0, param2);
            }
            else
            {
                this._childArray = [this._singleChild, param2];
                this._singleChild = null;
            }
            var _loc_3:* = this;
            var _loc_4:* = this._numChildren + 1;
            _loc_3._numChildren = _loc_4;
            param2.setParentAndRelativeStartOnly(this, param1.parentRelativeEnd);
            return;
        }// end function

        function canOwnFlowElement(param1:FlowElement) : Boolean
        {
            return !(param1 is TextFlow) && !(param1 is FlowLeafElement) && !(param1 is SubParagraphGroupElementBase) && !(param1 is ListItemElement);
        }// end function

        public function replaceChildren(param1:int, param2:int, ... args) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            if (param1 > this._numChildren || param2 > this._numChildren)
            {
                throw RangeError(GlobalSettings.resourceStringFunction("badReplaceChildrenIndex"));
            }
            args = getAbsoluteStart();
            var _loc_5:* = args + (param1 == this._numChildren ? (textLength) : (this.getChildAt(param1).parentRelativeStart));
            var _loc_6:* = param1 == this._numChildren ? (textLength) : (this.getChildAt(param1).parentRelativeStart);
            if (param1 < param2)
            {
                _loc_14 = 0;
                while (param1 < param2)
                {
                    
                    _loc_13 = this.getChildAt(param1);
                    this.modelChanged(ModelChange.ELEMENT_REMOVAL, _loc_13, _loc_13.parentRelativeStart, _loc_13.textLength);
                    _loc_14 = _loc_14 + _loc_13.textLength;
                    _loc_13.setParentAndRelativeStart(null, 0);
                    if (this._numChildren == 1)
                    {
                        this._singleChild = null;
                        this._numChildren = 0;
                    }
                    else
                    {
                        this._childArray.splice(param1, 1);
                        var _loc_21:* = this;
                        var _loc_22:* = this._numChildren - 1;
                        _loc_21._numChildren = _loc_22;
                        if (this._numChildren == 1)
                        {
                            this._singleChild = this._childArray[0];
                            this._childArray = null;
                        }
                    }
                    param2 = param2 - 1;
                }
                if (_loc_14)
                {
                    while (param2 < this._numChildren)
                    {
                        
                        _loc_13 = this.getChildAt(param2);
                        this.getChildAt(param2).setParentRelativeStart(_loc_13.parentRelativeStart - _loc_14);
                        param2++;
                    }
                    updateLengths(_loc_5, -_loc_14, true);
                    deleteContainerText(_loc_6 + _loc_14, _loc_14);
                }
            }
            var _loc_7:* = 0;
            for each (_loc_12 in args)
            {
                
                if (!_loc_12)
                {
                    continue;
                }
                _loc_15 = getNestedArgCount(_loc_12);
                _loc_11 = 0;
                while (_loc_11 < _loc_15)
                {
                    
                    _loc_10 = getNestedArg(_loc_12, _loc_11);
                    if (_loc_10)
                    {
                        _loc_16 = _loc_10.parent;
                        if (_loc_16)
                        {
                            if (_loc_16 == this)
                            {
                                _loc_17 = this.getChildIndex(_loc_10);
                                _loc_16.removeChild(_loc_10);
                                args = getAbsoluteStart();
                                if (_loc_17 <= param1)
                                {
                                    param1 = param1 - 1;
                                    _loc_5 = args + (param1 == this._numChildren ? (textLength) : (this.getChildAt(param1).parentRelativeStart));
                                    _loc_6 = param1 == this._numChildren ? (textLength) : (this.getChildAt(param1).parentRelativeStart);
                                }
                            }
                            else
                            {
                                _loc_16.removeChild(_loc_10);
                                args = getAbsoluteStart();
                                _loc_5 = args + (param1 == this._numChildren ? (textLength) : (this.getChildAt(param1).parentRelativeStart));
                                _loc_6 = param1 == this._numChildren ? (textLength) : (this.getChildAt(param1).parentRelativeStart);
                            }
                        }
                        if (!this.canOwnFlowElement(_loc_10))
                        {
                            throw ArgumentError(GlobalSettings.resourceStringFunction("invalidChildType"));
                        }
                        if (_loc_7 == 0)
                        {
                            _loc_9 = _loc_10;
                        }
                        else if (_loc_7 == 1)
                        {
                            _loc_8 = [_loc_9, _loc_10];
                        }
                        else
                        {
                            _loc_8.push(_loc_10);
                        }
                        _loc_7++;
                    }
                    _loc_11++;
                }
            }
            if (_loc_7)
            {
                _loc_18 = 0;
                _loc_11 = 0;
                while (_loc_11 < _loc_7)
                {
                    
                    _loc_10 = _loc_7 == 1 ? (_loc_9) : (_loc_8[_loc_11]);
                    if (this._numChildren == 0)
                    {
                        this._singleChild = _loc_10;
                    }
                    else if (this._numChildren > 1)
                    {
                        this._childArray.splice(param1, 0, _loc_10);
                    }
                    else
                    {
                        this._childArray = param1 == 0 ? ([_loc_10, this._singleChild]) : ([this._singleChild, _loc_10]);
                        this._singleChild = null;
                    }
                    var _loc_21:* = this;
                    var _loc_22:* = this._numChildren + 1;
                    _loc_21._numChildren = _loc_22;
                    _loc_10.setParentAndRelativeStart(this, _loc_6 + _loc_18);
                    _loc_18 = _loc_18 + _loc_10.textLength;
                    param1++;
                    _loc_11++;
                }
                if (_loc_18)
                {
                    while (_loc_1 < this._numChildren)
                    {
                        
                        _loc_13 = this.getChildAt(param1++);
                        this.getChildAt(param1++).setParentRelativeStart(_loc_13.parentRelativeStart + _loc_18);
                    }
                    updateLengths(_loc_5, _loc_18, true);
                    _loc_19 = getEnclosingController(_loc_6);
                    if (_loc_19)
                    {
                        ContainerController(_loc_19).setTextLength(_loc_19.textLength + _loc_18);
                    }
                }
                _loc_11 = 0;
                while (_loc_11 < _loc_7)
                {
                    
                    _loc_10 = _loc_7 == 1 ? (_loc_9) : (_loc_8[_loc_11]);
                    this.modelChanged(ModelChange.ELEMENT_ADDED, _loc_10, _loc_10.parentRelativeStart, _loc_10.textLength);
                    _loc_11++;
                }
            }
            else
            {
                _loc_20 = getTextFlow();
                if (_loc_20 != null)
                {
                    if (_loc_1 < this._numChildren)
                    {
                        _loc_11 = args + this.getChildAt(_loc_1).parentRelativeStart;
                    }
                    else if (_loc_1 > 1)
                    {
                        _loc_10 = this.getChildAt((_loc_1 - 1));
                        _loc_11 = args + _loc_10.parentRelativeStart + _loc_10.textLength - 1;
                    }
                    else
                    {
                        _loc_11 = args;
                        if (_loc_11 >= _loc_20.textLength)
                        {
                            _loc_11 = _loc_11 - 1;
                        }
                    }
                    _loc_20.damage(_loc_11, 1, FlowDamageType.INVALID, false);
                }
            }
            return;
        }// end function

        public function addChild(param1:FlowElement) : FlowElement
        {
            this.replaceChildren(this._numChildren, this._numChildren, param1);
            return param1;
        }// end function

        public function addChildAt(param1:uint, param2:FlowElement) : FlowElement
        {
            this.replaceChildren(param1, param1, param2);
            return param2;
        }// end function

        public function removeChild(param1:FlowElement) : FlowElement
        {
            var _loc_2:* = this.getChildIndex(param1);
            if (_loc_2 == -1)
            {
                throw ArgumentError(GlobalSettings.resourceStringFunction("badRemoveChild"));
            }
            this.removeChildAt(_loc_2);
            return param1;
        }// end function

        public function removeChildAt(param1:uint) : FlowElement
        {
            var _loc_2:* = this.getChildAt(param1);
            this.replaceChildren(param1, (param1 + 1));
            return _loc_2;
        }// end function

        public function splitAtIndex(param1:int) : FlowGroupElement
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1 > this._numChildren)
            {
                throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtIndex"));
            }
            var _loc_2:* = shallowCopy() as FlowGroupElement;
            var _loc_3:* = this._numChildren - param1;
            if (_loc_3 == 1)
            {
                _loc_2.addChild(this.removeChildAt(param1));
            }
            else if (_loc_3 != 0)
            {
                _loc_4 = this._childArray.slice(param1);
                this.replaceChildren(param1, (this._numChildren - 1));
                _loc_2.replaceChildren(0, 0, _loc_4);
            }
            if (parent)
            {
                _loc_5 = parent.getChildIndex(this);
                parent.replaceChildren((_loc_5 + 1), (_loc_5 + 1), _loc_2);
            }
            return _loc_2;
        }// end function

        override public function splitAtPosition(param1:int) : FlowElement
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1 < 0 || param1 > textLength)
            {
                throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtPosition"));
            }
            if (param1 == textLength)
            {
                _loc_2 = this._numChildren;
            }
            else
            {
                _loc_2 = this.findChildIndexAtPosition(param1);
                _loc_3 = this.getChildAt(_loc_2);
                if (_loc_3.parentRelativeStart != param1)
                {
                    if (_loc_3 is FlowGroupElement)
                    {
                        FlowGroupElement(_loc_3).splitAtPosition(param1 - _loc_3.parentRelativeStart);
                    }
                    else
                    {
                        SpanElement(_loc_3).splitAtPosition(param1 - _loc_3.parentRelativeStart);
                    }
                    _loc_2++;
                }
            }
            return this.splitAtIndex(_loc_2);
        }// end function

        override function normalizeRange(param1:uint, param2:uint) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_3:* = this.findChildIndexAtPosition(param1);
            if (_loc_3 != -1 && _loc_3 < this._numChildren)
            {
                _loc_4 = this.getChildAt(_loc_3);
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
                    else
                    {
                        _loc_3++;
                    }
                    if (_loc_3 == this._numChildren)
                    {
                        break;
                    }
                    _loc_4 = this.getChildAt(_loc_3);
                    if (_loc_4.parentRelativeStart > param2)
                    {
                        break;
                    }
                    param1 = 0;
                }
            }
            return;
        }// end function

        override function applyWhiteSpaceCollapse(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            if (param1 == null)
            {
                param1 = this.computedFormat.whiteSpaceCollapse;
            }
            else
            {
                _loc_3 = this.formatForCascade;
                _loc_4 = _loc_3 ? (_loc_3.whiteSpaceCollapse) : (undefined);
                if (_loc_4 !== undefined && _loc_4 != FormatValue.INHERIT)
                {
                    param1 = _loc_4;
                }
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._numChildren)
            {
                
                _loc_5 = this.getChildAt(_loc_2);
                _loc_5.applyWhiteSpaceCollapse(param1);
                if (_loc_5.parent == this)
                {
                    _loc_2++;
                }
            }
            if (textLength == 0 && impliedElement && parent != null)
            {
                parent.removeChild(this);
            }
            super.applyWhiteSpaceCollapse(param1);
            return;
        }// end function

        override function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._numChildren)
            {
                
                _loc_4 = this.getChildAt(_loc_3);
                _loc_4.appendElementsForDelayedUpdate(param1, param2);
                _loc_3++;
            }
            return;
        }// end function

        private static function getNestedArgCount(param1:Object) : uint
        {
            return param1 is Array ? (param1.length) : (1);
        }// end function

        private static function getNestedArg(param1:Object, param2:uint) : FlowElement
        {
            return (param1 is Array ? (param1[param2]) : (param1)) as FlowElement;
        }// end function

    }
}
