package flashx.textLayout.elements
{
    import flash.events.*;
    import flash.net.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;

    final public class LinkElement extends SubParagraphGroupElementBase implements IEventDispatcher
    {
        private var _uriString:String;
        private var _targetString:String;
        private var _linkState:String;
        static const LINK_NORMAL_FORMAT_NAME:String = "linkNormalFormat";
        static const LINK_ACTIVE_FORMAT_NAME:String = "linkActiveFormat";
        static const LINK_HOVER_FORMAT_NAME:String = "linkHoverFormat";

        public function LinkElement()
        {
            this._linkState = LinkState.LINK;
            return;
        }// end function

        override function get precedence() : uint
        {
            return 800;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            getEventMirror().addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            if (!hasActiveEventMirror())
            {
                return false;
            }
            return _eventMirror.dispatchEvent(event);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            if (!hasActiveEventMirror())
            {
                return false;
            }
            return _eventMirror.hasEventListener(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            if (hasActiveEventMirror())
            {
                _eventMirror.removeEventListener(param1, param2, param3);
            }
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            if (!hasActiveEventMirror())
            {
                return false;
            }
            return _eventMirror.willTrigger(param1);
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "a";
        }// end function

        public function get href() : String
        {
            return this._uriString;
        }// end function

        public function set href(param1:String) : void
        {
            this._uriString = param1;
            modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength);
            return;
        }// end function

        public function get target() : String
        {
            return this._targetString;
        }// end function

        public function set target(param1:String) : void
        {
            this._targetString = param1;
            modelChanged(ModelChange.ELEMENT_MODIFIED, this, 0, textLength);
            return;
        }// end function

        public function get linkState() : String
        {
            return this._linkState;
        }// end function

        override public function shallowCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            if (param2 == -1)
            {
                param2 = textLength;
            }
            var _loc_3:* = super.shallowCopy(param1, param2) as LinkElement;
            _loc_3.href = this.href;
            _loc_3.target = this.target;
            return _loc_3;
        }// end function

        override function mergeToPreviousIfPossible() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (parent && !bindableElement)
            {
                _loc_1 = parent.getChildIndex(this);
                if (textLength == 0)
                {
                    parent.replaceChildren(_loc_1, (_loc_1 + 1), null);
                    return true;
                }
                if (_loc_1 != 0 && !hasActiveEventMirror())
                {
                    _loc_2 = parent.getChildAt((_loc_1 - 1)) as LinkElement;
                    if (_loc_2 != null && !_loc_2.hasActiveEventMirror())
                    {
                        if (this.href == _loc_2.href && this.target == _loc_2.target && equalStylesForMerge(_loc_2))
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
            }
            return false;
        }// end function

        private function computeLinkFormat(param1:String) : ITextLayoutFormat
        {
            var _loc_3:* = null;
            var _loc_2:* = getUserStyleWorker(param1) as ITextLayoutFormat;
            if (_loc_2 == null)
            {
                _loc_3 = getTextFlow();
                if (_loc_3)
                {
                    _loc_2 = _loc_3.configuration["defaultL" + param1.substr(1)];
                }
            }
            return _loc_2;
        }// end function

        function get effectiveLinkElementTextLayoutFormat() : ITextLayoutFormat
        {
            var _loc_1:* = null;
            if (this._linkState == LinkState.SUPPRESSED)
            {
                return null;
            }
            if (this._linkState == LinkState.ACTIVE)
            {
                _loc_1 = this.computeLinkFormat(LINK_ACTIVE_FORMAT_NAME);
                if (_loc_1)
                {
                    return _loc_1;
                }
            }
            else if (this._linkState == LinkState.HOVER)
            {
                _loc_1 = this.computeLinkFormat(LINK_HOVER_FORMAT_NAME);
                if (_loc_1)
                {
                    return _loc_1;
                }
            }
            return this.computeLinkFormat(LINK_NORMAL_FORMAT_NAME);
        }// end function

        override function get formatForCascade() : ITextLayoutFormat
        {
            var _loc_3:* = null;
            var _loc_1:* = TextLayoutFormat(format);
            var _loc_2:* = this.effectiveLinkElementTextLayoutFormat;
            if (_loc_2 || _loc_1)
            {
                if (_loc_2 && _loc_1)
                {
                    _loc_3 = new TextLayoutFormat(_loc_2);
                    if (_loc_1)
                    {
                        _loc_3.concatInheritOnly(_loc_1);
                    }
                    return _loc_3;
                }
                return _loc_1 ? (_loc_1) : (_loc_2);
            }
            return null;
        }// end function

        private function setToState(param1:String) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._linkState != param1)
            {
                _loc_2 = this.effectiveLinkElementTextLayoutFormat;
                this._linkState = param1;
                _loc_3 = this.effectiveLinkElementTextLayoutFormat;
                if (!TextLayoutFormat.isEqual(_loc_2, _loc_3))
                {
                    formatChanged(true);
                    _loc_4 = getTextFlow();
                    if (_loc_4 && _loc_4.flowComposer)
                    {
                        _loc_4.flowComposer.updateAllControllers();
                    }
                }
            }
            return;
        }// end function

        function chgLinkState(param1:String) : void
        {
            if (this._linkState != param1)
            {
                this._linkState = param1;
                formatChanged(false);
            }
            return;
        }// end function

        function mouseDownHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void
        {
            param1.setHandCursor(true);
            this.setToState(LinkState.ACTIVE);
            param2.stopImmediatePropagation();
            return;
        }// end function

        function mouseMoveHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void
        {
            param1.setHandCursor(true);
            this.setToState(param2.buttonDown ? (LinkState.ACTIVE) : (LinkState.HOVER));
            return;
        }// end function

        function mouseOutHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void
        {
            param1.setHandCursor(false);
            this.setToState(LinkState.LINK);
            return;
        }// end function

        function mouseOverHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void
        {
            param1.setHandCursor(true);
            this.setToState(param2.buttonDown ? (LinkState.ACTIVE) : (LinkState.HOVER));
            return;
        }// end function

        function mouseUpHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void
        {
            param1.setHandCursor(true);
            this.setToState(LinkState.HOVER);
            param2.stopImmediatePropagation();
            return;
        }// end function

        function mouseClickHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void
        {
            var _loc_3:* = null;
            if (this._uriString != null)
            {
                if (this._uriString.length > 6 && this._uriString.substr(0, 6) == "event:")
                {
                    param1.dispatchFlowElementMouseEvent(this._uriString.substring(6, this._uriString.length), param2);
                }
                else
                {
                    _loc_3 = new URLRequest(encodeURI(this._uriString));
                    navigateToURL(_loc_3, this.target);
                }
            }
            param2.stopImmediatePropagation();
            return;
        }// end function

        override function acceptTextBefore() : Boolean
        {
            return false;
        }// end function

        override function acceptTextAfter() : Boolean
        {
            return false;
        }// end function

        override function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void
        {
            if (param2 == ModelChange.ELEMENT_ADDED)
            {
                param1.incInteractiveObjectCount();
            }
            else if (param2 == ModelChange.ELEMENT_REMOVAL)
            {
                param1.decInteractiveObjectCount();
            }
            super.appendElementsForDelayedUpdate(param1, param2);
            return;
        }// end function

        override function updateForMustUseComposer(param1:TextFlow) : Boolean
        {
            return true;
        }// end function

    }
}
