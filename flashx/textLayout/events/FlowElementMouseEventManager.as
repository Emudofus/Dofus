package flashx.textLayout.events
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    public class FlowElementMouseEventManager extends Object
    {
        private var _container:DisplayObjectContainer;
        private var _hitTests:HitTestArea = null;
        private var _currentElement:FlowElement = null;
        private var _mouseDownElement:FlowElement = null;
        private var _needsCtrlKey:Boolean = false;
        private var _ctrlKeyState:Boolean = false;
        private var _lastMouseEvent:MouseEvent = null;
        private var _blockInteraction:Boolean = false;
        private const OWNER_HANDLES_EVENT:int = 0;
        private const THIS_HANDLES_EVENT:int = 1;
        private const THIS_LISTENS_FOR_EVENTS:int = 2;
        private var _eventListeners:Object;
        private var _hitRects:Object = null;

        public function FlowElementMouseEventManager(param1:DisplayObjectContainer, param2:Array)
        {
            var _loc_3:* = null;
            this._container = param1;
            this._eventListeners = {};
            var _loc_4:* = this.THIS_HANDLES_EVENT;
            this._eventListeners[KeyboardEvent.KEY_UP] = this.THIS_HANDLES_EVENT;
            this._eventListeners[KeyboardEvent.KEY_DOWN] = _loc_4;
            this._eventListeners[MouseEvent.MOUSE_MOVE] = _loc_4;
            this._eventListeners[MouseEvent.MOUSE_UP] = _loc_4;
            this._eventListeners[MouseEvent.MOUSE_DOWN] = _loc_4;
            this._eventListeners[MouseEvent.MOUSE_OUT] = _loc_4;
            this._eventListeners[MouseEvent.MOUSE_OVER] = _loc_4;
            for each (_loc_3 in param2)
            {
                
                this._eventListeners[_loc_3] = this.OWNER_HANDLES_EVENT;
            }
            return;
        }// end function

        public function mouseToContainer(event:MouseEvent) : Point
        {
            var _loc_4:* = null;
            var _loc_2:* = event.target as DisplayObject;
            var _loc_3:* = new Point(event.localX, event.localY);
            while (_loc_2 != this._container)
            {
                
                _loc_4 = _loc_2.transform.matrix;
                _loc_3.offset(_loc_4.tx, _loc_4.ty);
                _loc_2 = _loc_2.parent;
                if (!_loc_2)
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function get needsCtrlKey() : Boolean
        {
            return this._needsCtrlKey;
        }// end function

        public function set needsCtrlKey(param1:Boolean) : void
        {
            this._needsCtrlKey = param1;
            return;
        }// end function

        public function updateHitTests(param1:Number, param2:Rectangle, param3:TextFlow, param4:int, param5:int, param6:ContainerController, param7:Boolean = false) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = null;
            var _loc_25:* = false;
            var _loc_26:* = NaN;
            var _loc_27:* = null;
            var _loc_28:* = null;
            this._needsCtrlKey = param7;
            var _loc_10:* = [];
            if (param3.interactiveObjectCount != 0 && param4 != param5)
            {
                _loc_13 = param6.interactiveObjects;
                for each (_loc_14 in _loc_13)
                {
                    
                    _loc_15 = _loc_14 as FlowElement;
                    if (_loc_15 && _loc_15.getAbsoluteStart() < param5 && _loc_15.getAbsoluteStart() + _loc_15.textLength >= param4)
                    {
                        _loc_10.push(_loc_14);
                    }
                }
                _loc_16 = param6.oldInteractiveObjects;
                for each (_loc_14 in _loc_16)
                {
                    
                    _loc_15 = _loc_14 as FlowElement;
                    if (_loc_15 && _loc_15.getAbsoluteStart() < param5 && _loc_15.getAbsoluteStart() + _loc_15.textLength >= param4)
                    {
                        _loc_10.push(_loc_14);
                        _loc_13[_loc_14] = _loc_14;
                    }
                }
            }
            var _loc_12:* = 0;
            if (_loc_10.length != 0)
            {
                _loc_11 = {};
                for each (_loc_17 in _loc_10)
                {
                    
                    _loc_18 = _loc_17.getAbsoluteStart();
                    _loc_19 = Math.min(_loc_18 + _loc_17.textLength, param5);
                    _loc_20 = _loc_17.getTextFlow();
                    if (_loc_20)
                    {
                        _loc_21 = GeometryUtil.getHighlightBounds(new TextRange(_loc_20, _loc_18, _loc_19));
                        for each (_loc_9 in _loc_21)
                        {
                            
                            _loc_8 = _loc_9.rect;
                            _loc_22 = param2.x;
                            _loc_23 = param2.y;
                            _loc_24 = _loc_17.computedFormat.blockProgression;
                            _loc_25 = false;
                            _loc_25 = _loc_24 == BlockProgression.RL && (param6.horizontalScrollPolicy == ScrollPolicy.OFF && param6.verticalScrollPolicy == ScrollPolicy.OFF);
                            if (_loc_25)
                            {
                                _loc_26 = param6.measureWidth ? (param2.width) : (param6.compositionWidth);
                                _loc_22 = param2.x - _loc_26 + param6.horizontalScrollPosition + param2.width;
                            }
                            if (_loc_24 == BlockProgression.TB)
                            {
                                _loc_22 = 0;
                                _loc_23 = 0;
                            }
                            else
                            {
                                _loc_23 = 0;
                            }
                            _loc_8.x = _loc_22 + _loc_9.textLine.x + _loc_8.x + param1;
                            _loc_8.y = _loc_23 + _loc_9.textLine.y + _loc_8.y;
                            _loc_8 = _loc_8.intersection(param2);
                            if (!_loc_8.isEmpty())
                            {
                                _loc_8.x = int(_loc_8.x);
                                _loc_8.y = int(_loc_8.y);
                                _loc_8.width = int(_loc_8.width);
                                _loc_8.height = int(_loc_8.height);
                                _loc_27 = _loc_8.toString();
                                _loc_28 = _loc_11[_loc_27];
                                if (!_loc_28 || _loc_28.owner != _loc_17)
                                {
                                    _loc_11[_loc_27] = {rect:_loc_8, owner:_loc_17};
                                    _loc_12++;
                                }
                            }
                        }
                    }
                }
            }
            if (_loc_12 > 0)
            {
                if (!this._hitTests)
                {
                    this.startHitTests();
                }
                this._hitRects = _loc_11;
                this._hitTests = new HitTestArea(_loc_11);
            }
            else
            {
                this.stopHitTests();
            }
            return;
        }// end function

        function startHitTests() : void
        {
            this._currentElement = null;
            this._mouseDownElement = null;
            this._ctrlKeyState = false;
            this.addEventListener(MouseEvent.MOUSE_OVER, false);
            this.addEventListener(MouseEvent.MOUSE_OUT, false);
            this.addEventListener(MouseEvent.MOUSE_DOWN, false);
            this.addEventListener(MouseEvent.MOUSE_UP, false);
            this.addEventListener(MouseEvent.MOUSE_MOVE, false);
            return;
        }// end function

        public function stopHitTests() : void
        {
            this.removeEventListener(MouseEvent.MOUSE_OVER, false);
            this.removeEventListener(MouseEvent.MOUSE_OUT, false);
            this.removeEventListener(MouseEvent.MOUSE_DOWN, false);
            this.removeEventListener(MouseEvent.MOUSE_UP, false);
            this.removeEventListener(MouseEvent.MOUSE_MOVE, false);
            this.removeEventListener(KeyboardEvent.KEY_DOWN, true);
            this.removeEventListener(KeyboardEvent.KEY_UP, true);
            this._hitRects = null;
            this._hitTests = null;
            this._currentElement = null;
            this._mouseDownElement = null;
            this._ctrlKeyState = false;
            return;
        }// end function

        private function addEventListener(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._eventListeners[param1] === this.THIS_HANDLES_EVENT)
            {
                if (param2)
                {
                    _loc_3 = this._container.stage;
                    if (!_loc_3)
                    {
                        _loc_3 = this._container;
                    }
                    _loc_4 = this.hitTestKeyEventHandler;
                }
                else
                {
                    _loc_3 = this._container;
                    _loc_4 = this.hitTestMouseEventHandler;
                }
                _loc_3.addEventListener(param1, _loc_4, false, 1);
                this._eventListeners[param1] = this.THIS_LISTENS_FOR_EVENTS;
            }
            return;
        }// end function

        private function removeEventListener(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._eventListeners[param1] === this.THIS_LISTENS_FOR_EVENTS)
            {
                if (param2)
                {
                    _loc_3 = this._container.stage;
                    if (!_loc_3)
                    {
                        _loc_3 = this._container;
                    }
                    _loc_4 = this.hitTestKeyEventHandler;
                }
                else
                {
                    _loc_3 = this._container;
                    _loc_4 = this.hitTestMouseEventHandler;
                }
                _loc_3.removeEventListener(param1, _loc_4);
                this._eventListeners[param1] = this.THIS_HANDLES_EVENT;
            }
            return;
        }// end function

        function collectElements(param1:FlowGroupElement, param2:int, param3:int, param4:Array) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_5:* = param1.findChildIndexAtPosition(param2);
            while (_loc_5 < param1.numChildren)
            {
                
                _loc_6 = param1.getChildAt(_loc_5);
                if (_loc_6.parentRelativeStart >= param3)
                {
                    break;
                }
                if (_loc_6.hasActiveEventMirror() || _loc_6 is LinkElement)
                {
                    param4.push(_loc_6);
                }
                _loc_7 = _loc_6 as FlowGroupElement;
                if (_loc_7)
                {
                    this.collectElements(_loc_7, Math.max(param2 - _loc_7.parentRelativeStart, 0), param3 - _loc_7.parentRelativeStart, param4);
                }
                _loc_5++;
            }
            return;
        }// end function

        public function dispatchEvent(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event as MouseEvent;
            if (_loc_2)
            {
                this.hitTestMouseEventHandler(_loc_2);
            }
            else
            {
                _loc_3 = event as KeyboardEvent;
                if (_loc_3)
                {
                    this.hitTestKeyEventHandler(_loc_3);
                }
            }
            return;
        }// end function

        private function hitTestKeyEventHandler(event:KeyboardEvent) : void
        {
            if (!this._blockInteraction)
            {
                this.checkCtrlKeyState(event.ctrlKey);
            }
            return;
        }// end function

        private function checkCtrlKeyState(param1:Boolean) : void
        {
            var _loc_2:* = this._currentElement as LinkElement;
            if (!_loc_2 || !this._needsCtrlKey || !this._lastMouseEvent || param1 == this._ctrlKeyState)
            {
                return;
            }
            this._ctrlKeyState = param1;
            if (this._ctrlKeyState)
            {
                _loc_2.mouseOverHandler(this, this._lastMouseEvent);
            }
            else
            {
                _loc_2.mouseOutHandler(this, this._lastMouseEvent);
            }
            return;
        }// end function

        private function hitTestMouseEventHandler(event:MouseEvent) : void
        {
            if (!this._hitTests)
            {
                return;
            }
            this._lastMouseEvent = event;
            var _loc_2:* = this.mouseToContainer(event);
            var _loc_3:* = this._hitTests.hitTest(_loc_2.x, _loc_2.y);
            if (_loc_3 != this._currentElement)
            {
                this._mouseDownElement = null;
                if (this._currentElement)
                {
                    this.localDispatchEvent(FlowElementMouseEvent.ROLL_OUT, event);
                }
                else if (event.buttonDown)
                {
                    this._blockInteraction = true;
                }
                this._currentElement = _loc_3;
                if (this._currentElement)
                {
                    this.localDispatchEvent(FlowElementMouseEvent.ROLL_OVER, event);
                }
                else
                {
                    this._blockInteraction = false;
                }
            }
            var _loc_4:* = false;
            var _loc_5:* = null;
            switch(event.type)
            {
                case MouseEvent.MOUSE_MOVE:
                {
                    _loc_5 = FlowElementMouseEvent.MOUSE_MOVE;
                    if (!this._blockInteraction)
                    {
                        this.checkCtrlKeyState(event.ctrlKey);
                    }
                    break;
                }
                case MouseEvent.MOUSE_DOWN:
                {
                    this._mouseDownElement = this._currentElement;
                    _loc_5 = FlowElementMouseEvent.MOUSE_DOWN;
                    break;
                }
                case MouseEvent.MOUSE_UP:
                {
                    _loc_5 = FlowElementMouseEvent.MOUSE_UP;
                    _loc_4 = this._currentElement == this._mouseDownElement;
                    this._mouseDownElement = null;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._currentElement && _loc_5)
            {
                this.localDispatchEvent(_loc_5, event);
                if (_loc_4)
                {
                    this.localDispatchEvent(FlowElementMouseEvent.CLICK, event);
                }
            }
            return;
        }// end function

        function dispatchFlowElementMouseEvent(param1:String, param2:MouseEvent) : Boolean
        {
            if (this._needsCtrlKey && !param2.ctrlKey && param1 != FlowElementMouseEvent.ROLL_OUT)
            {
                return false;
            }
            var _loc_3:* = this._currentElement.hasActiveEventMirror();
            var _loc_4:* = this._currentElement.getTextFlow();
            var _loc_5:* = false;
            if (_loc_4)
            {
                _loc_5 = _loc_4.hasEventListener(param1);
            }
            if (!_loc_3 && !_loc_5)
            {
                return false;
            }
            var _loc_6:* = new FlowElementMouseEvent(param1, false, true, this._currentElement, param2);
            if (_loc_3)
            {
                this._currentElement.getEventMirror().dispatchEvent(_loc_6);
                if (_loc_6.isDefaultPrevented())
                {
                    return true;
                }
            }
            if (_loc_5)
            {
                _loc_4.dispatchEvent(_loc_6);
                if (_loc_6.isDefaultPrevented())
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function localDispatchEvent(param1:String, param2:MouseEvent) : void
        {
            if (this._blockInteraction || !this._currentElement)
            {
                return;
            }
            if (this._needsCtrlKey)
            {
                switch(param1)
                {
                    case FlowElementMouseEvent.ROLL_OVER:
                    {
                        this.addEventListener(KeyboardEvent.KEY_DOWN, true);
                        this.addEventListener(KeyboardEvent.KEY_UP, true);
                        break;
                    }
                    case FlowElementMouseEvent.ROLL_OUT:
                    {
                        this.removeEventListener(KeyboardEvent.KEY_DOWN, true);
                        this.removeEventListener(KeyboardEvent.KEY_UP, true);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (this.dispatchFlowElementMouseEvent(param1, param2))
            {
                return;
            }
            var _loc_3:* = !this._needsCtrlKey || param2.ctrlKey ? (this._currentElement as LinkElement) : (null);
            if (!_loc_3)
            {
                return;
            }
            switch(param1)
            {
                case FlowElementMouseEvent.MOUSE_DOWN:
                {
                    _loc_3.mouseDownHandler(this, param2);
                    break;
                }
                case FlowElementMouseEvent.MOUSE_MOVE:
                {
                    _loc_3.mouseMoveHandler(this, param2);
                    break;
                }
                case FlowElementMouseEvent.ROLL_OUT:
                {
                    _loc_3.mouseOutHandler(this, param2);
                    break;
                }
                case FlowElementMouseEvent.ROLL_OVER:
                {
                    _loc_3.mouseOverHandler(this, param2);
                    break;
                }
                case FlowElementMouseEvent.MOUSE_UP:
                {
                    _loc_3.mouseUpHandler(this, param2);
                    break;
                }
                case FlowElementMouseEvent.CLICK:
                {
                    _loc_3.mouseClickHandler(this, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        function setHandCursor(param1:Boolean = true) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._currentElement == null)
            {
                return;
            }
            var _loc_2:* = this._currentElement.getTextFlow();
            if (_loc_2 != null && _loc_2.flowComposer && _loc_2.flowComposer.numControllers)
            {
                _loc_3 = this._container as Sprite;
                if (_loc_3)
                {
                    _loc_3.buttonMode = param1;
                    _loc_3.useHandCursor = param1;
                }
                if (param1)
                {
                    Mouse.cursor = MouseCursor.BUTTON;
                }
                else
                {
                    _loc_4 = _loc_2.computedFormat.blockProgression;
                    if (_loc_2.interactionManager && _loc_4 != BlockProgression.RL)
                    {
                        Mouse.cursor = MouseCursor.IBEAM;
                    }
                    else
                    {
                        Mouse.cursor = Configuration.getCursorString(_loc_2.configuration, MouseCursor.AUTO);
                    }
                }
                Mouse.hide();
                Mouse.show();
            }
            return;
        }// end function

    }
}
