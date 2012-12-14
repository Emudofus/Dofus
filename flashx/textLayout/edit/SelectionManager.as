package flashx.textLayout.edit
{
    import flash.desktop.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.operations.*;
    import flashx.textLayout.utils.*;

    public class SelectionManager extends Object implements ISelectionManager
    {
        private var _focusedSelectionFormat:SelectionFormat;
        private var _unfocusedSelectionFormat:SelectionFormat;
        private var _inactiveSelectionFormat:SelectionFormat;
        private var _selFormatState:String = "unfocused";
        private var _isActive:Boolean;
        private var _textFlow:TextFlow;
        private var anchorMark:Mark;
        private var activeMark:Mark;
        private var _pointFormat:ITextLayoutFormat;
        protected var ignoreNextTextEvent:Boolean = false;
        protected var allowOperationMerge:Boolean = false;
        private var _mouseOverSelectionArea:Boolean = false;
        private var marks:Array;

        public function SelectionManager()
        {
            this.marks = [];
            this._textFlow = null;
            this.anchorMark = this.createMark();
            this.activeMark = this.createMark();
            this._pointFormat = null;
            this._isActive = false;
            return;
        }// end function

        protected function get pointFormat() : ITextLayoutFormat
        {
            return this._pointFormat;
        }// end function

        public function getSelectionState() : SelectionState
        {
            return new SelectionState(this._textFlow, this.anchorMark.position, this.activeMark.position, this.pointFormat);
        }// end function

        public function setSelectionState(param1:SelectionState) : void
        {
            this.internalSetSelection(param1.textFlow, param1.anchorPosition, param1.activePosition, param1.pointFormat);
            return;
        }// end function

        public function hasSelection() : Boolean
        {
            return this.anchorMark.position != -1;
        }// end function

        public function isRangeSelection() : Boolean
        {
            return this.anchorMark.position != -1 && this.anchorMark.position != this.activeMark.position;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._textFlow;
        }// end function

        public function set textFlow(param1:TextFlow) : void
        {
            if (this._textFlow != param1)
            {
                if (this._textFlow)
                {
                    this.flushPendingOperations();
                }
                this.clear();
                if (!param1)
                {
                    this.setMouseCursor(MouseCursor.AUTO);
                }
                this._textFlow = param1;
                if (this._textFlow && this._textFlow.interactionManager != this)
                {
                    this._textFlow.interactionManager = this;
                }
            }
            return;
        }// end function

        public function get editingMode() : String
        {
            return EditingMode.READ_SELECT;
        }// end function

        public function get windowActive() : Boolean
        {
            return this._selFormatState != SelectionFormatState.INACTIVE;
        }// end function

        public function get focused() : Boolean
        {
            return this._selFormatState == SelectionFormatState.FOCUSED;
        }// end function

        public function get currentSelectionFormat() : SelectionFormat
        {
            if (this._selFormatState == SelectionFormatState.UNFOCUSED)
            {
                return this.unfocusedSelectionFormat;
            }
            if (this._selFormatState == SelectionFormatState.INACTIVE)
            {
                return this.inactiveSelectionFormat;
            }
            return this.focusedSelectionFormat;
        }// end function

        public function set focusedSelectionFormat(param1:SelectionFormat) : void
        {
            this._focusedSelectionFormat = param1;
            if (this._selFormatState == SelectionFormatState.FOCUSED)
            {
                this.refreshSelection();
            }
            return;
        }// end function

        public function get focusedSelectionFormat() : SelectionFormat
        {
            return this._focusedSelectionFormat ? (this._focusedSelectionFormat) : (this._textFlow ? (this._textFlow.configuration.focusedSelectionFormat) : (null));
        }// end function

        public function set unfocusedSelectionFormat(param1:SelectionFormat) : void
        {
            this._unfocusedSelectionFormat = param1;
            if (this._selFormatState == SelectionFormatState.UNFOCUSED)
            {
                this.refreshSelection();
            }
            return;
        }// end function

        public function get unfocusedSelectionFormat() : SelectionFormat
        {
            return this._unfocusedSelectionFormat ? (this._unfocusedSelectionFormat) : (this._textFlow ? (this._textFlow.configuration.unfocusedSelectionFormat) : (null));
        }// end function

        public function set inactiveSelectionFormat(param1:SelectionFormat) : void
        {
            this._inactiveSelectionFormat = param1;
            if (this._selFormatState == SelectionFormatState.INACTIVE)
            {
                this.refreshSelection();
            }
            return;
        }// end function

        public function get inactiveSelectionFormat() : SelectionFormat
        {
            return this._inactiveSelectionFormat ? (this._inactiveSelectionFormat) : (this._textFlow ? (this._textFlow.configuration.inactiveSelectionFormat) : (null));
        }// end function

        function get selectionFormatState() : String
        {
            return this._selFormatState;
        }// end function

        function setSelectionFormatState(param1:String) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 != this._selFormatState)
            {
                _loc_2 = this.currentSelectionFormat;
                this._selFormatState = param1;
                _loc_3 = this.currentSelectionFormat;
                if (!_loc_3.equals(_loc_2))
                {
                    this.refreshSelection();
                }
            }
            return;
        }// end function

        function cloneSelectionFormatState(param1:ISelectionManager) : void
        {
            var _loc_2:* = param1 as SelectionManager;
            if (_loc_2)
            {
                this._isActive = _loc_2._isActive;
                this._mouseOverSelectionArea = _loc_2._mouseOverSelectionArea;
                this.setSelectionFormatState(_loc_2.selectionFormatState);
            }
            return;
        }// end function

        private function selectionPoint(param1:Object, param2:InteractiveObject, param3:Number, param4:Number, param5:Boolean = false) : SelectionState
        {
            if (!this._textFlow)
            {
                return null;
            }
            if (!this.hasSelection())
            {
                param5 = false;
            }
            var _loc_6:* = this.anchorMark.position;
            var _loc_7:* = this.activeMark.position;
            _loc_7 = computeSelectionIndex(this._textFlow, param2, param1, param3, param4);
            if (_loc_7 == -1)
            {
                return null;
            }
            _loc_7 = Math.min(_loc_7, (this._textFlow.textLength - 1));
            if (!param5)
            {
                _loc_6 = _loc_7;
            }
            if (_loc_6 == _loc_7)
            {
                _loc_6 = NavigationUtil.updateStartIfInReadOnlyElement(this._textFlow, _loc_6);
                _loc_7 = NavigationUtil.updateEndIfInReadOnlyElement(this._textFlow, _loc_7);
            }
            else
            {
                _loc_7 = NavigationUtil.updateEndIfInReadOnlyElement(this._textFlow, _loc_7);
            }
            return new SelectionState(this.textFlow, _loc_6, _loc_7);
        }// end function

        public function setFocus() : void
        {
            if (!this._textFlow)
            {
                return;
            }
            if (this._textFlow.flowComposer)
            {
                this._textFlow.flowComposer.setFocus(this.activePosition, false);
            }
            this.setSelectionFormatState(SelectionFormatState.FOCUSED);
            return;
        }// end function

        protected function setMouseCursor(param1:String) : void
        {
            Mouse.cursor = param1;
            return;
        }// end function

        public function get anchorPosition() : int
        {
            return this.anchorMark.position;
        }// end function

        public function get activePosition() : int
        {
            return this.activeMark.position;
        }// end function

        public function get absoluteStart() : int
        {
            return this.anchorMark.position < this.activeMark.position ? (this.anchorMark.position) : (this.activeMark.position);
        }// end function

        public function get absoluteEnd() : int
        {
            return this.anchorMark.position > this.activeMark.position ? (this.anchorMark.position) : (this.activeMark.position);
        }// end function

        public function selectAll() : void
        {
            this.selectRange(0, int.MAX_VALUE);
            return;
        }// end function

        public function selectRange(param1:int, param2:int) : void
        {
            this.flushPendingOperations();
            if (param1 != this.anchorMark.position || param2 != this.activeMark.position)
            {
                this.clearSelectionShapes();
                this.internalSetSelection(this._textFlow, param1, param2);
                this.selectionChanged();
                this.allowOperationMerge = false;
            }
            return;
        }// end function

        private function internalSetSelection(param1:TextFlow, param2:int, param3:int, param4:ITextLayoutFormat = null) : void
        {
            this._textFlow = param1;
            if (param2 < 0 || param3 < 0)
            {
                param2 = -1;
                param3 = -1;
            }
            var _loc_5:* = this._textFlow.textLength > 0 ? ((this._textFlow.textLength - 1)) : (0);
            if (param2 != -1 && param3 != -1)
            {
                if (param2 > _loc_5)
                {
                    param2 = _loc_5;
                }
                if (param3 > _loc_5)
                {
                    param3 = _loc_5;
                }
            }
            this._pointFormat = param4;
            this.anchorMark.position = param2;
            this.activeMark.position = param3;
            return;
        }// end function

        private function clear() : void
        {
            if (this.hasSelection())
            {
                this.flushPendingOperations();
                this.clearSelectionShapes();
                this.internalSetSelection(this._textFlow, -1, -1);
                this.selectionChanged();
                this.allowOperationMerge = false;
            }
            return;
        }// end function

        private function addSelectionShapes() : void
        {
            var _loc_1:* = 0;
            if (this._textFlow.flowComposer)
            {
                this.internalSetSelection(this._textFlow, this.anchorMark.position, this.activeMark.position, this._pointFormat);
                if (this.currentSelectionFormat && (this.absoluteStart == this.absoluteEnd && this.currentSelectionFormat.pointAlpha != 0 || this.absoluteStart != this.absoluteEnd && this.currentSelectionFormat.rangeAlpha != 0))
                {
                    _loc_1 = 0;
                    while (_loc_1 < this._textFlow.flowComposer.numControllers)
                    {
                        
                        this._textFlow.flowComposer.getControllerAt(_loc_1++).addSelectionShapes(this.currentSelectionFormat, this.absoluteStart, this.absoluteEnd);
                    }
                }
            }
            return;
        }// end function

        private function clearSelectionShapes() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = this._textFlow ? (this._textFlow.flowComposer) : (null);
            if (_loc_1)
            {
                _loc_2 = 0;
                while (_loc_2 < _loc_1.numControllers)
                {
                    
                    _loc_1.getControllerAt(_loc_2++).clearSelectionShapes();
                }
            }
            return;
        }// end function

        public function refreshSelection() : void
        {
            if (this.hasSelection())
            {
                this.clearSelectionShapes();
                this.addSelectionShapes();
            }
            return;
        }// end function

        function selectionChanged(param1:Boolean = true, param2:Boolean = true) : void
        {
            if (param2)
            {
                this._pointFormat = null;
            }
            if (param1 && this._textFlow)
            {
                this.textFlow.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_CHANGE, false, false, this.hasSelection() ? (this.getSelectionState()) : (null)));
            }
            return;
        }// end function

        function setNewSelectionPoint(param1:Object, param2:InteractiveObject, param3:Number, param4:Number, param5:Boolean = false) : Boolean
        {
            var _loc_6:* = this.selectionPoint(param1, param2, param3, param4, param5);
            if (this.selectionPoint(param1, param2, param3, param4, param5) == null)
            {
                return false;
            }
            if (_loc_6.anchorPosition != this.anchorMark.position || _loc_6.activePosition != this.activeMark.position)
            {
                this.selectRange(_loc_6.anchorPosition, _loc_6.activePosition);
                return true;
            }
            return false;
        }// end function

        public function mouseDownHandler(event:MouseEvent) : void
        {
            this.handleMouseEventForSelection(event, event.shiftKey);
            return;
        }// end function

        public function mouseMoveHandler(event:MouseEvent) : void
        {
            var _loc_2:* = this.textFlow.computedFormat.blockProgression;
            if (_loc_2 != BlockProgression.RL)
            {
                this.setMouseCursor(MouseCursor.IBEAM);
            }
            if (event.buttonDown)
            {
                this.handleMouseEventForSelection(event, true);
            }
            return;
        }// end function

        function handleMouseEventForSelection(event:MouseEvent, param2:Boolean) : void
        {
            var _loc_3:* = this.hasSelection();
            if (this.setNewSelectionPoint(event.currentTarget, event.target as InteractiveObject, event.localX, event.localY, _loc_3 && param2))
            {
                if (_loc_3)
                {
                    this.clearSelectionShapes();
                }
                if (this.hasSelection())
                {
                    this.addSelectionShapes();
                }
            }
            this.allowOperationMerge = false;
            return;
        }// end function

        public function mouseUpHandler(event:MouseEvent) : void
        {
            if (!this._mouseOverSelectionArea)
            {
                this.setMouseCursor(MouseCursor.AUTO);
            }
            return;
        }// end function

        private function atBeginningWordPos(param1:ParagraphElement, param2:int) : Boolean
        {
            if (param2 == 0)
            {
                return true;
            }
            var _loc_3:* = param1.findNextWordBoundary(param2);
            _loc_3 = param1.findPreviousWordBoundary(_loc_3);
            return param2 == _loc_3;
        }// end function

        public function mouseDoubleClickHandler(event:MouseEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (!this.hasSelection())
            {
                return;
            }
            var _loc_2:* = this._textFlow.findAbsoluteParagraph(this.activeMark.position);
            var _loc_3:* = _loc_2.getAbsoluteStart();
            if (this.anchorMark.position <= this.activeMark.position)
            {
                _loc_4 = _loc_2.findNextWordBoundary(this.activeMark.position - _loc_3) + _loc_3;
            }
            else
            {
                _loc_4 = _loc_2.findPreviousWordBoundary(this.activeMark.position - _loc_3) + _loc_3;
            }
            if (_loc_4 == _loc_3 + _loc_2.textLength)
            {
                _loc_4 = _loc_4 - 1;
            }
            if (event.shiftKey)
            {
                _loc_5 = this.anchorMark.position;
            }
            else
            {
                _loc_6 = this._textFlow.findAbsoluteParagraph(this.anchorMark.position);
                _loc_7 = _loc_6.getAbsoluteStart();
                if (this.atBeginningWordPos(_loc_6, this.anchorMark.position - _loc_7))
                {
                    _loc_5 = this.anchorMark.position;
                }
                else
                {
                    if (this.anchorMark.position <= this.activeMark.position)
                    {
                        _loc_5 = _loc_6.findPreviousWordBoundary(this.anchorMark.position - _loc_7) + _loc_7;
                    }
                    else
                    {
                        _loc_5 = _loc_6.findNextWordBoundary(this.anchorMark.position - _loc_7) + _loc_7;
                    }
                    if (_loc_5 == _loc_7 + _loc_6.textLength)
                    {
                        _loc_5 = _loc_5 - 1;
                    }
                }
            }
            if (_loc_5 != this.anchorMark.position || _loc_4 != this.activeMark.position)
            {
                this.internalSetSelection(this._textFlow, _loc_5, _loc_4, null);
                this.selectionChanged();
                this.clearSelectionShapes();
                if (this.hasSelection())
                {
                    this.addSelectionShapes();
                }
            }
            this.allowOperationMerge = false;
            return;
        }// end function

        public function mouseOverHandler(event:MouseEvent) : void
        {
            this._mouseOverSelectionArea = true;
            var _loc_2:* = this.textFlow.computedFormat.blockProgression;
            if (_loc_2 != BlockProgression.RL)
            {
                this.setMouseCursor(MouseCursor.IBEAM);
            }
            else
            {
                this.setMouseCursor(MouseCursor.AUTO);
            }
            return;
        }// end function

        public function mouseOutHandler(event:MouseEvent) : void
        {
            this._mouseOverSelectionArea = false;
            this.setMouseCursor(MouseCursor.AUTO);
            return;
        }// end function

        public function focusInHandler(event:FocusEvent) : void
        {
            this._isActive = true;
            this.setSelectionFormatState(SelectionFormatState.FOCUSED);
            return;
        }// end function

        public function focusOutHandler(event:FocusEvent) : void
        {
            if (this._isActive)
            {
                this.setSelectionFormatState(SelectionFormatState.UNFOCUSED);
            }
            return;
        }// end function

        public function activateHandler(event:Event) : void
        {
            if (!this._isActive)
            {
                this._isActive = true;
                this.setSelectionFormatState(SelectionFormatState.UNFOCUSED);
            }
            return;
        }// end function

        public function deactivateHandler(event:Event) : void
        {
            if (this._isActive)
            {
                this._isActive = false;
                this.setSelectionFormatState(SelectionFormatState.INACTIVE);
            }
            return;
        }// end function

        public function doOperation(param1:FlowOperation) : void
        {
            var opError:Error;
            var op:* = param1;
            var opEvent:* = new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_BEGIN, false, true, op, 0, null);
            this.textFlow.dispatchEvent(opEvent);
            if (!opEvent.isDefaultPrevented())
            {
                op = opEvent.operation;
                if (!(op is CopyOperation))
                {
                    throw new IllegalOperationError(GlobalSettings.resourceStringFunction("illegalOperation", [getQualifiedClassName(op)]));
                }
                opError;
                try
                {
                    op.doOperation();
                }
                catch (e:Error)
                {
                    opError = e;
                }
                opEvent = new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_END, false, true, op, 0, opError);
                this.textFlow.dispatchEvent(opEvent);
                opError = opEvent.isDefaultPrevented() ? (null) : (opEvent.error);
                if (opError)
                {
                    throw opError;
                }
                this.textFlow.dispatchEvent(new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_COMPLETE, false, false, op, 0, null));
            }
            return;
        }// end function

        public function editHandler(event:Event) : void
        {
            switch(event.type)
            {
                case Event.COPY:
                {
                    this.flushPendingOperations();
                    this.doOperation(new CopyOperation(this.getSelectionState()));
                    break;
                }
                case Event.SELECT_ALL:
                {
                    this.flushPendingOperations();
                    this.selectAll();
                    this.refreshSelection();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function handleLeftArrow(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            if (this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
            {
                if (this._textFlow.computedFormat.direction == Direction.LTR)
                {
                    if (event.ctrlKey || event.altKey)
                    {
                        NavigationUtil.previousWord(_loc_2, event.shiftKey);
                    }
                    else
                    {
                        NavigationUtil.previousCharacter(_loc_2, event.shiftKey);
                    }
                }
                else if (event.ctrlKey || event.altKey)
                {
                    NavigationUtil.nextWord(_loc_2, event.shiftKey);
                }
                else
                {
                    NavigationUtil.nextCharacter(_loc_2, event.shiftKey);
                }
            }
            else if (event.altKey)
            {
                NavigationUtil.endOfParagraph(_loc_2, event.shiftKey);
            }
            else if (event.ctrlKey)
            {
                NavigationUtil.endOfDocument(_loc_2, event.shiftKey);
            }
            else
            {
                NavigationUtil.nextLine(_loc_2, event.shiftKey);
            }
            return _loc_2;
        }// end function

        private function handleUpArrow(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            if (this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
            {
                if (event.altKey)
                {
                    NavigationUtil.startOfParagraph(_loc_2, event.shiftKey);
                }
                else if (event.ctrlKey)
                {
                    NavigationUtil.startOfDocument(_loc_2, event.shiftKey);
                }
                else
                {
                    NavigationUtil.previousLine(_loc_2, event.shiftKey);
                }
            }
            else if (this._textFlow.computedFormat.direction == Direction.LTR)
            {
                if (event.ctrlKey || event.altKey)
                {
                    NavigationUtil.previousWord(_loc_2, event.shiftKey);
                }
                else
                {
                    NavigationUtil.previousCharacter(_loc_2, event.shiftKey);
                }
            }
            else if (event.ctrlKey || event.altKey)
            {
                NavigationUtil.nextWord(_loc_2, event.shiftKey);
            }
            else
            {
                NavigationUtil.nextCharacter(_loc_2, event.shiftKey);
            }
            return _loc_2;
        }// end function

        private function handleRightArrow(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            if (this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
            {
                if (this._textFlow.computedFormat.direction == Direction.LTR)
                {
                    if (event.ctrlKey || event.altKey)
                    {
                        NavigationUtil.nextWord(_loc_2, event.shiftKey);
                    }
                    else
                    {
                        NavigationUtil.nextCharacter(_loc_2, event.shiftKey);
                    }
                }
                else if (event.ctrlKey || event.altKey)
                {
                    NavigationUtil.previousWord(_loc_2, event.shiftKey);
                }
                else
                {
                    NavigationUtil.previousCharacter(_loc_2, event.shiftKey);
                }
            }
            else if (event.altKey)
            {
                NavigationUtil.startOfParagraph(_loc_2, event.shiftKey);
            }
            else if (event.ctrlKey)
            {
                NavigationUtil.startOfDocument(_loc_2, event.shiftKey);
            }
            else
            {
                NavigationUtil.previousLine(_loc_2, event.shiftKey);
            }
            return _loc_2;
        }// end function

        private function handleDownArrow(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            if (this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
            {
                if (event.altKey)
                {
                    NavigationUtil.endOfParagraph(_loc_2, event.shiftKey);
                }
                else if (event.ctrlKey)
                {
                    NavigationUtil.endOfDocument(_loc_2, event.shiftKey);
                }
                else
                {
                    NavigationUtil.nextLine(_loc_2, event.shiftKey);
                }
            }
            else if (this._textFlow.computedFormat.direction == Direction.LTR)
            {
                if (event.ctrlKey || event.altKey)
                {
                    NavigationUtil.nextWord(_loc_2, event.shiftKey);
                }
                else
                {
                    NavigationUtil.nextCharacter(_loc_2, event.shiftKey);
                }
            }
            else if (event.ctrlKey || event.altKey)
            {
                NavigationUtil.previousWord(_loc_2, event.shiftKey);
            }
            else
            {
                NavigationUtil.previousCharacter(_loc_2, event.shiftKey);
            }
            return _loc_2;
        }// end function

        private function handleHomeKey(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            if (event.ctrlKey && !event.altKey)
            {
                NavigationUtil.startOfDocument(_loc_2, event.shiftKey);
            }
            else
            {
                NavigationUtil.startOfLine(_loc_2, event.shiftKey);
            }
            return _loc_2;
        }// end function

        private function handleEndKey(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            if (event.ctrlKey && !event.altKey)
            {
                NavigationUtil.endOfDocument(_loc_2, event.shiftKey);
            }
            else
            {
                NavigationUtil.endOfLine(_loc_2, event.shiftKey);
            }
            return _loc_2;
        }// end function

        private function handlePageUpKey(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            NavigationUtil.previousPage(_loc_2, event.shiftKey);
            return _loc_2;
        }// end function

        private function handlePageDownKey(event:KeyboardEvent) : SelectionState
        {
            var _loc_2:* = this.getSelectionState();
            NavigationUtil.nextPage(_loc_2, event.shiftKey);
            return _loc_2;
        }// end function

        private function handleKeyEvent(event:KeyboardEvent) : void
        {
            var _loc_2:* = null;
            this.flushPendingOperations();
            switch(event.keyCode)
            {
                case Keyboard.LEFT:
                {
                    _loc_2 = this.handleLeftArrow(event);
                    break;
                }
                case Keyboard.UP:
                {
                    _loc_2 = this.handleUpArrow(event);
                    break;
                }
                case Keyboard.RIGHT:
                {
                    _loc_2 = this.handleRightArrow(event);
                    break;
                }
                case Keyboard.DOWN:
                {
                    _loc_2 = this.handleDownArrow(event);
                    break;
                }
                case Keyboard.HOME:
                {
                    _loc_2 = this.handleHomeKey(event);
                    break;
                }
                case Keyboard.END:
                {
                    _loc_2 = this.handleEndKey(event);
                    break;
                }
                case Keyboard.PAGE_DOWN:
                {
                    _loc_2 = this.handlePageDownKey(event);
                    break;
                }
                case Keyboard.PAGE_UP:
                {
                    _loc_2 = this.handlePageUpKey(event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 != null)
            {
                event.preventDefault();
                this.updateSelectionAndShapes(this._textFlow, _loc_2.anchorPosition, _loc_2.activePosition);
                if (this._textFlow.flowComposer && this._textFlow.flowComposer.numControllers != 0)
                {
                    this._textFlow.flowComposer.getControllerAt((this._textFlow.flowComposer.numControllers - 1)).scrollToRange(_loc_2.activePosition, _loc_2.activePosition);
                }
            }
            this.allowOperationMerge = false;
            return;
        }// end function

        public function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!this.hasSelection() || event.isDefaultPrevented())
            {
                return;
            }
            switch(event.keyCode)
            {
                case Keyboard.LEFT:
                case Keyboard.UP:
                case Keyboard.RIGHT:
                case Keyboard.DOWN:
                case Keyboard.HOME:
                case Keyboard.END:
                case Keyboard.PAGE_DOWN:
                case Keyboard.PAGE_UP:
                case Keyboard.ESCAPE:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (event.keyCode == Keyboard.ESCAPE)
            {
            }
            return;
        }// end function

        public function keyUpHandler(event:KeyboardEvent) : void
        {
            return;
        }// end function

        public function keyFocusChangeHandler(event:FocusEvent) : void
        {
            return;
        }// end function

        public function textInputHandler(event:TextEvent) : void
        {
            this.ignoreNextTextEvent = false;
            return;
        }// end function

        public function imeStartCompositionHandler(event:IMEEvent) : void
        {
            return;
        }// end function

        public function softKeyboardActivatingHandler(event:Event) : void
        {
            return;
        }// end function

        protected function enterFrameHandler(event:Event) : void
        {
            this.flushPendingOperations();
            return;
        }// end function

        public function focusChangeHandler(event:FocusEvent) : void
        {
            return;
        }// end function

        public function menuSelectHandler(event:ContextMenuEvent) : void
        {
            var _loc_2:* = event.target as ContextMenu;
            if (this.activePosition != this.anchorPosition)
            {
                _loc_2.clipboardItems.copy = true;
                _loc_2.clipboardItems.cut = this.editingMode == EditingMode.READ_WRITE;
                _loc_2.clipboardItems.clear = this.editingMode == EditingMode.READ_WRITE;
            }
            else
            {
                _loc_2.clipboardItems.copy = false;
                _loc_2.clipboardItems.cut = false;
                _loc_2.clipboardItems.clear = false;
            }
            var _loc_3:* = Clipboard.generalClipboard;
            if (this.activePosition != -1 && this.editingMode == EditingMode.READ_WRITE && (_loc_3.hasFormat(TextClipboard.TEXT_LAYOUT_MARKUP) || _loc_3.hasFormat(ClipboardFormats.TEXT_FORMAT)))
            {
                _loc_2.clipboardItems.paste = true;
            }
            else
            {
                _loc_2.clipboardItems.paste = false;
            }
            _loc_2.clipboardItems.selectAll = true;
            return;
        }// end function

        public function mouseWheelHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        public function flushPendingOperations() : void
        {
            return;
        }// end function

        public function getCommonCharacterFormat(param1:TextRange = null) : TextLayoutFormat
        {
            if (!param1 && !this.hasSelection())
            {
                return null;
            }
            var _loc_2:* = ElementRange.createElementRange(this._textFlow, param1 ? (param1.absoluteStart) : (this.absoluteStart), param1 ? (param1.absoluteEnd) : (this.absoluteEnd));
            var _loc_3:* = _loc_2.getCommonCharacterFormat();
            if (_loc_2.absoluteEnd == _loc_2.absoluteStart && this.pointFormat)
            {
                _loc_3.apply(this.pointFormat);
            }
            return _loc_3;
        }// end function

        public function getCommonParagraphFormat(param1:TextRange = null) : TextLayoutFormat
        {
            if (!param1 && !this.hasSelection())
            {
                return null;
            }
            return ElementRange.createElementRange(this._textFlow, param1 ? (param1.absoluteStart) : (this.absoluteStart), param1 ? (param1.absoluteEnd) : (this.absoluteEnd)).getCommonParagraphFormat();
        }// end function

        public function getCommonContainerFormat(param1:TextRange = null) : TextLayoutFormat
        {
            if (!param1 && !this.hasSelection())
            {
                return null;
            }
            return ElementRange.createElementRange(this._textFlow, param1 ? (param1.absoluteStart) : (this.absoluteStart), param1 ? (param1.absoluteEnd) : (this.absoluteEnd)).getCommonContainerFormat();
        }// end function

        private function updateSelectionAndShapes(param1:TextFlow, param2:int, param3:int) : void
        {
            this.internalSetSelection(param1, param2, param3);
            if (this._textFlow.flowComposer && this._textFlow.flowComposer.numControllers != 0)
            {
                this._textFlow.flowComposer.getControllerAt((this._textFlow.flowComposer.numControllers - 1)).scrollToRange(this.activeMark.position, this.anchorMark.position);
            }
            this.selectionChanged();
            this.clearSelectionShapes();
            this.addSelectionShapes();
            return;
        }// end function

        function createMark() : Mark
        {
            var _loc_1:* = new Mark(-1);
            this.marks.push(_loc_1);
            return _loc_1;
        }// end function

        function removeMark(param1:Mark) : void
        {
            var _loc_2:* = this.marks.indexOf(param1);
            if (_loc_2 != -1)
            {
                this.marks.splice(_loc_2, (_loc_2 + 1));
            }
            return;
        }// end function

        public function notifyInsertOrDelete(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            if (param2 == 0)
            {
                return;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.marks.length)
            {
                
                _loc_4 = this.marks[_loc_3];
                if (_loc_4.position >= param1)
                {
                    if (param2 < 0)
                    {
                        _loc_4.position = _loc_4.position + param2 < param1 ? (param1) : (_loc_4.position + param2);
                    }
                    else
                    {
                        _loc_4.position = _loc_4.position + param2;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        private static function computeSelectionIndexInContainer(param1:TextFlow, param2:ContainerController, param3:Number, param4:Number) : int
        {
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_25:* = null;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = false;
            var _loc_29:* = NaN;
            var _loc_30:* = false;
            var _loc_31:* = 0;
            var _loc_32:* = null;
            var _loc_5:* = -1;
            var _loc_6:* = param2.absoluteStart;
            var _loc_7:* = param2.textLength;
            var _loc_8:* = param1.computedFormat.blockProgression;
            var _loc_9:* = param1.computedFormat.blockProgression == BlockProgression.RL;
            var _loc_10:* = param1.computedFormat.direction == Direction.RTL;
            var _loc_11:* = _loc_9 ? (param3) : (param4);
            var _loc_12:* = locateNearestColumn(param2, param3, param4, param1.computedFormat.blockProgression, param1.computedFormat.direction);
            var _loc_13:* = null;
            var _loc_14:* = -1;
            var _loc_15:* = -1;
            var _loc_18:* = param1.flowComposer.numLines - 1;
            while (_loc_18 >= 0)
            {
                
                _loc_16 = param1.flowComposer.getLineAt(_loc_18);
                if (_loc_16.controller != param2 || _loc_16.columnIndex != _loc_12)
                {
                    if (_loc_15 != -1)
                    {
                        _loc_5 = _loc_18 + 1;
                        break;
                    }
                }
                else if (_loc_16.absoluteStart < _loc_6 || _loc_16.absoluteStart >= _loc_6 + _loc_7)
                {
                }
                else
                {
                    _loc_17 = _loc_16.getTextLine();
                    if (_loc_17 == null || _loc_17.parent == null)
                    {
                    }
                    else
                    {
                        if (_loc_15 == -1)
                        {
                            _loc_15 = _loc_18;
                        }
                        _loc_25 = _loc_17.getBounds(DisplayObject(param2.container));
                        _loc_26 = _loc_9 ? (_loc_25.left) : (_loc_25.bottom);
                        _loc_27 = -1;
                        if (_loc_13)
                        {
                            _loc_29 = _loc_9 ? (_loc_13.right) : (_loc_13.top);
                            _loc_27 = (_loc_26 + _loc_29) / 2;
                        }
                        _loc_28 = _loc_9 ? (_loc_26 > _loc_11) : (_loc_26 < _loc_11);
                        if (_loc_28 || _loc_18 == 0)
                        {
                            _loc_30 = _loc_27 != -1 && (_loc_9 ? (_loc_11 < _loc_27) : (_loc_11 > _loc_27));
                            _loc_5 = _loc_30 && _loc_18 != _loc_15 ? ((_loc_18 + 1)) : (_loc_18);
                            break;
                        }
                        else
                        {
                            _loc_13 = _loc_25;
                            _loc_14 = _loc_18;
                        }
                    }
                }
                _loc_18 = _loc_18 - 1;
            }
            if (_loc_5 == -1)
            {
                _loc_5 = _loc_14;
                if (_loc_5 == -1)
                {
                    return -1;
                }
            }
            var _loc_19:* = param1.flowComposer.getLineAt(_loc_5);
            var _loc_20:* = param1.flowComposer.getLineAt(_loc_5).getTextLine(true);
            param3 = param3 - _loc_20.x;
            param4 = param4 - _loc_20.y;
            var _loc_21:* = false;
            var _loc_22:* = -1;
            if (_loc_10)
            {
                _loc_22 = _loc_20.atomCount - 1;
            }
            else if (_loc_19.absoluteStart + _loc_19.textLength >= _loc_19.paragraph.getAbsoluteStart() + _loc_19.paragraph.textLength)
            {
                if (_loc_20.atomCount > 1)
                {
                    _loc_22 = _loc_20.atomCount - 2;
                }
            }
            else
            {
                _loc_31 = _loc_19.absoluteStart + _loc_19.textLength - 1;
                _loc_32 = _loc_20.textBlock.content.rawText.charAt(_loc_31);
                if (_loc_32 == " ")
                {
                    if (_loc_20.atomCount > 1)
                    {
                        _loc_22 = _loc_20.atomCount - 2;
                    }
                }
                else
                {
                    _loc_21 = true;
                    if (_loc_20.atomCount > 0)
                    {
                        _loc_22 = _loc_20.atomCount - 1;
                    }
                }
            }
            var _loc_23:* = _loc_22 > 0 ? (_loc_20.getAtomBounds(_loc_22)) : (new Rectangle(0, 0, 0, 0));
            if (!_loc_9)
            {
                if (param3 < 0)
                {
                    param3 = 0;
                }
                else if (param3 > _loc_23.x + _loc_23.width)
                {
                    if (_loc_21)
                    {
                        return _loc_19.absoluteStart + _loc_19.textLength - 1;
                    }
                    if (_loc_23.x + _loc_23.width > 0)
                    {
                        param3 = _loc_23.x + _loc_23.width;
                    }
                }
            }
            else if (param4 < 0)
            {
                param4 = 0;
            }
            else if (param4 > _loc_23.y + _loc_23.height)
            {
                if (_loc_21)
                {
                    return _loc_19.absoluteStart + _loc_19.textLength - 1;
                }
                if (_loc_23.y + _loc_23.height > 0)
                {
                    param4 = _loc_23.y + _loc_23.height;
                }
            }
            var _loc_24:* = computeSelectionIndexInLine(param1, _loc_20, param3, param4);
            return computeSelectionIndexInLine(param1, _loc_20, param3, param4) != -1 ? (_loc_24) : (_loc_6 + _loc_7);
        }// end function

        private static function locateNearestColumn(param1:ContainerController, param2:Number, param3:Number, param4:String, param5:String) : int
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = param1.columnState;
            while (_loc_6 < (_loc_7.columnCount - 1))
            {
                
                _loc_8 = _loc_7.getColumnAt(_loc_6);
                _loc_9 = _loc_7.getColumnAt((_loc_6 + 1));
                if (_loc_8.contains(param2, param3))
                {
                    break;
                }
                if (_loc_9.contains(param2, param3))
                {
                    _loc_6++;
                    break;
                }
                else if (param4 == BlockProgression.RL)
                {
                    if (param3 < _loc_8.top || param3 < _loc_9.top && Math.abs(_loc_8.bottom - param3) <= Math.abs(_loc_9.top - param3))
                    {
                        break;
                    }
                    if (param3 > _loc_9.top)
                    {
                        _loc_6++;
                        break;
                    }
                }
                else if (param5 == Direction.LTR)
                {
                    if (param2 < _loc_8.left || param2 < _loc_9.left && Math.abs(_loc_8.right - param2) <= Math.abs(_loc_9.left - param2))
                    {
                        break;
                    }
                    if (param2 < _loc_9.left)
                    {
                        _loc_6++;
                        break;
                    }
                }
                else
                {
                    if (param2 > _loc_8.right || param2 > _loc_9.right && Math.abs(_loc_8.left - param2) <= Math.abs(_loc_9.right - param2))
                    {
                        break;
                    }
                    if (param2 > _loc_9.right)
                    {
                        _loc_6++;
                        break;
                    }
                }
                _loc_6++;
            }
            return _loc_6;
        }// end function

        private static function computeSelectionIndexInLine(param1:TextFlow, param2:TextLine, param3:Number, param4:Number) : int
        {
            var _loc_12:* = 0;
            if (!(param2.userData is TextFlowLine))
            {
                return -1;
            }
            var _loc_5:* = TextFlowLine(param2.userData);
            if (TextFlowLine(param2.userData).validity == TextLineValidity.INVALID)
            {
                return -1;
            }
            param2 = _loc_5.getTextLine(true);
            var _loc_6:* = param1.computedFormat.blockProgression == BlockProgression.RL;
            var _loc_7:* = param1.computedFormat.blockProgression == BlockProgression.RL ? (param3) : (param4);
            var _loc_8:* = new Point();
            new Point().x = param3;
            _loc_8.y = param4;
            _loc_8 = param2.localToGlobal(_loc_8);
            var _loc_9:* = param2.getAtomIndexAtPoint(_loc_8.x, _loc_8.y);
            if (param2.getAtomIndexAtPoint(_loc_8.x, _loc_8.y) == -1)
            {
                _loc_8.x = param3;
                _loc_8.y = param4;
                if (_loc_8.x < 0 || _loc_6 && _loc_7 > param2.ascent)
                {
                    _loc_8.x = 0;
                }
                if (_loc_8.y < 0 || !_loc_6 && _loc_7 > param2.descent)
                {
                    _loc_8.y = 0;
                }
                _loc_8 = param2.localToGlobal(_loc_8);
                _loc_9 = param2.getAtomIndexAtPoint(_loc_8.x, _loc_8.y);
            }
            if (_loc_9 == -1)
            {
                _loc_8.x = param3;
                _loc_8.y = param4;
                _loc_8 = param2.localToGlobal(_loc_8);
                if (param2.parent)
                {
                    _loc_8 = param2.parent.globalToLocal(_loc_8);
                }
                if (!_loc_6)
                {
                    return _loc_8.x <= param2.x ? (_loc_5.absoluteStart) : (_loc_5.absoluteStart + _loc_5.textLength - 1);
                }
                else
                {
                    return _loc_8.y <= param2.y ? (_loc_5.absoluteStart) : (_loc_5.absoluteStart + _loc_5.textLength - 1);
                }
            }
            var _loc_10:* = param2.getAtomBounds(_loc_9);
            var _loc_11:* = false;
            if (_loc_10)
            {
                if (_loc_6 && param2.getAtomTextRotation(_loc_9) != TextRotation.ROTATE_0)
                {
                    _loc_11 = param4 > _loc_10.y + _loc_10.height / 2;
                }
                else
                {
                    _loc_11 = param3 > _loc_10.x + _loc_10.width / 2;
                }
            }
            if (param2.getAtomBidiLevel(_loc_9) % 2 != 0)
            {
                _loc_12 = _loc_11 ? (param2.getAtomTextBlockBeginIndex(_loc_9)) : (param2.getAtomTextBlockEndIndex(_loc_9));
            }
            else
            {
                _loc_12 = _loc_11 ? (param2.getAtomTextBlockEndIndex(_loc_9)) : (param2.getAtomTextBlockBeginIndex(_loc_9));
            }
            return _loc_5.paragraph.getAbsoluteStart() + _loc_12;
        }// end function

        private static function checkForDisplayed(param1:DisplayObject) : Boolean
        {
            var container:* = param1;
            try
            {
                while (container)
                {
                    
                    if (!container.visible)
                    {
                        return false;
                    }
                    container = container.parent;
                    if (container is Stage)
                    {
                        return true;
                    }
                }
            }
            catch (e:Error)
            {
                return true;
            }
            return false;
        }// end function

        static function computeSelectionIndex(param1:TextFlow, param2:Object, param3:Object, param4:Number, param5:Number) : int
        {
            var _loc_7:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_6:* = 0;
            var _loc_8:* = false;
            if (param2 is TextLine)
            {
                _loc_9 = TextLine(param2).userData as TextFlowLine;
                if (_loc_9)
                {
                    _loc_10 = _loc_9.paragraph;
                    if (_loc_10.getTextFlow() == param1)
                    {
                        _loc_8 = true;
                    }
                }
            }
            if (_loc_8)
            {
                _loc_6 = computeSelectionIndexInLine(param1, TextLine(param2), param4, param5);
            }
            else
            {
                _loc_12 = 0;
                while (_loc_12 < param1.flowComposer.numControllers)
                {
                    
                    _loc_13 = param1.flowComposer.getControllerAt(_loc_12);
                    if (_loc_13.container == param2 || _loc_13.container == param3)
                    {
                        _loc_11 = _loc_13;
                        break;
                    }
                    _loc_12++;
                }
                if (_loc_11)
                {
                    if (param2 != _loc_11.container)
                    {
                        _loc_7 = DisplayObject(param2).localToGlobal(new Point(param4, param5));
                        _loc_7 = DisplayObject(_loc_11.container).globalToLocal(_loc_7);
                        param4 = _loc_7.x;
                        param5 = _loc_7.y;
                    }
                    _loc_6 = computeSelectionIndexInContainer(param1, _loc_11, param4, param5);
                }
                else
                {
                    _loc_14 = null;
                    _loc_17 = Number.MAX_VALUE;
                    _loc_18 = 0;
                    while (_loc_18 < param1.flowComposer.numControllers)
                    {
                        
                        _loc_19 = param1.flowComposer.getControllerAt(_loc_18);
                        if (!checkForDisplayed(_loc_19.container as DisplayObject))
                        {
                        }
                        else
                        {
                            _loc_20 = _loc_19.getContentBounds();
                            _loc_21 = isNaN(_loc_19.compositionWidth) ? (_loc_19.getTotalPaddingLeft() + _loc_20.width) : (_loc_19.compositionWidth);
                            _loc_22 = isNaN(_loc_19.compositionHeight) ? (_loc_19.getTotalPaddingTop() + _loc_20.height) : (_loc_19.compositionHeight);
                            _loc_7 = DisplayObject(param2).localToGlobal(new Point(param4, param5));
                            _loc_7 = DisplayObject(_loc_19.container).globalToLocal(_loc_7);
                            _loc_23 = 0;
                            _loc_24 = 0;
                            if (_loc_19.hasScrollRect)
                            {
                                var _loc_28:* = _loc_19.container.scrollRect.x;
                                _loc_23 = _loc_19.container.scrollRect.x;
                                _loc_7.x = _loc_7.x - _loc_28;
                                var _loc_28:* = _loc_19.container.scrollRect.y;
                                _loc_24 = _loc_19.container.scrollRect.y;
                                _loc_7.y = _loc_7.y - _loc_28;
                            }
                            if (_loc_7.x >= 0 && _loc_7.x <= _loc_21 && _loc_7.y >= 0 && _loc_7.y <= _loc_22)
                            {
                                _loc_14 = _loc_19;
                                _loc_15 = _loc_7.x + _loc_23;
                                _loc_16 = _loc_7.y + _loc_24;
                                break;
                            }
                            _loc_25 = 0;
                            _loc_26 = 0;
                            if (_loc_7.x < 0)
                            {
                                _loc_25 = _loc_7.x;
                                if (_loc_7.y < 0)
                                {
                                    _loc_26 = _loc_7.y;
                                }
                                else if (_loc_7.y > _loc_22)
                                {
                                    _loc_26 = _loc_7.y - _loc_22;
                                }
                            }
                            else if (_loc_7.x > _loc_21)
                            {
                                _loc_25 = _loc_7.x - _loc_21;
                                if (_loc_7.y < 0)
                                {
                                    _loc_26 = _loc_7.y;
                                }
                                else if (_loc_7.y > _loc_22)
                                {
                                    _loc_26 = _loc_7.y - _loc_22;
                                }
                            }
                            else if (_loc_7.y < 0)
                            {
                                _loc_26 = -_loc_7.y;
                            }
                            else
                            {
                                _loc_26 = _loc_7.y - _loc_22;
                            }
                            _loc_27 = _loc_25 * _loc_25 + _loc_26 * _loc_26;
                            if (_loc_27 <= _loc_17)
                            {
                                _loc_17 = _loc_27;
                                _loc_14 = _loc_19;
                                _loc_15 = _loc_7.x + _loc_23;
                                _loc_16 = _loc_7.y + _loc_24;
                            }
                        }
                        _loc_18++;
                    }
                    _loc_6 = _loc_14 ? (computeSelectionIndexInContainer(param1, _loc_14, _loc_15, _loc_16)) : (-1);
                }
            }
            if (_loc_6 >= param1.textLength)
            {
                _loc_6 = param1.textLength - 1;
            }
            return _loc_6;
        }// end function

    }
}
