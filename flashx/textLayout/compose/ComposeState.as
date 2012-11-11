package flashx.textLayout.compose
{
    import flash.text.engine.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    public class ComposeState extends BaseCompose
    {
        protected var _curLineIndex:int;
        protected var vjBeginLineIndex:int;
        protected var vjDisableThisParcel:Boolean;
        protected var _useExistingLine:Boolean;
        private static var _sharedComposeState:ComposeState;

        public function ComposeState()
        {
            return;
        }// end function

        override protected function createParcelList() : ParcelList
        {
            return ParcelList.getParcelList();
        }// end function

        override protected function releaseParcelList(param1:ParcelList) : void
        {
            ParcelList.releaseParcelList(param1);
            return;
        }// end function

        override public function composeTextFlow(param1:TextFlow, param2:int, param3:int) : int
        {
            this._curLineIndex = -1;
            _curLine = null;
            this.vjBeginLineIndex = 0;
            this.vjDisableThisParcel = false;
            return super.composeTextFlow(param1, param2, param3);
        }// end function

        override protected function initializeForComposer(param1:IFlowComposer, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = 0;
            _startComposePosition = param1.damageAbsoluteStart;
            if (param3 == -1)
            {
                _loc_5 = param1.findControllerIndexAtPosition(_startComposePosition);
                if (_loc_5 == -1)
                {
                    _loc_5 = param1.numControllers - 1;
                    while (_loc_5 != 0 && param1.getControllerAt(_loc_5).textLength == 0)
                    {
                        
                        _loc_5 = _loc_5 - 1;
                    }
                }
            }
            _startController = param1.getControllerAt(_loc_5);
            if (_startController.computedFormat.verticalAlign != VerticalAlign.TOP)
            {
                _startComposePosition = _startController.absoluteStart;
            }
            super.initializeForComposer(param1, param2, _loc_5, param4);
            return;
        }// end function

        override protected function composeInternal(param1:FlowGroupElement, param2:int) : void
        {
            var _loc_3:* = 0;
            super.composeInternal(param1, param2);
            if (_curElement)
            {
                _loc_3 = this._curLineIndex;
                while (_loc_3 < _flowComposer.numLines)
                {
                    
                    _flowComposer.getLineAt(_loc_3++).setController(null, -1);
                }
            }
            return;
        }// end function

        override protected function doVerticalAlignment(param1:Boolean, param2:Parcel) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (param1 && _curParcel && this.vjBeginLineIndex != this._curLineIndex && !this.vjDisableThisParcel)
            {
                _loc_3 = _curParcel.controller;
                _loc_4 = _loc_3.computedFormat.verticalAlign;
                if (_loc_4 == VerticalAlign.JUSTIFY)
                {
                    _loc_5 = _loc_3.numFloats - 1;
                    while (_loc_5 >= 0 && param1)
                    {
                        
                        _loc_6 = _loc_3.getFloatAt(_loc_5);
                        if (_loc_6.floatType != Float.NONE)
                        {
                            param1 = false;
                        }
                        _loc_5 = _loc_5 - 1;
                    }
                }
                if (param1 && _loc_4 != VerticalAlign.TOP)
                {
                    _loc_7 = _flowComposer.findLineIndexAtPosition(_curElementStart + _curElementOffset);
                    if (this.vjBeginLineIndex < _loc_7)
                    {
                        _loc_8 = 0;
                        _loc_9 = 0;
                        _loc_10 = (_flowComposer as StandardFlowComposer).lines;
                        if (_loc_3.numFloats > 0)
                        {
                            _loc_8 = _loc_3.findFloatIndexAtOrAfter(_loc_10[this.vjBeginLineIndex].absoluteStart);
                            _loc_9 = _loc_3.findFloatIndexAfter(_curElementStart + _curElementOffset);
                        }
                        this.applyVerticalAlignmentToColumn(_loc_3, _loc_4, _loc_10, this.vjBeginLineIndex, _loc_7 - this.vjBeginLineIndex, _loc_8, _loc_9);
                    }
                }
            }
            this.vjDisableThisParcel = false;
            this.vjBeginLineIndex = this._curLineIndex;
            return;
        }// end function

        override protected function applyVerticalAlignmentToColumn(param1:ContainerController, param2:String, param3:Array, param4:int, param5:int, param6:int, param7:int) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            super.applyVerticalAlignmentToColumn(param1, param2, param3, param4, param5, param6, param7);
            for each (_loc_8 in param1.composedLines)
            {
                
                _loc_9 = _loc_8.userData as TextFlowLine;
                _loc_9.createShape(_blockProgression, _loc_8);
            }
            return;
        }// end function

        override protected function finalParcelAdjustment(param1:ContainerController) : void
        {
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_2:* = TextLine.MAX_LINE_WIDTH;
            var _loc_3:* = TextLine.MAX_LINE_WIDTH;
            var _loc_4:* = -TextLine.MAX_LINE_WIDTH;
            var _loc_5:* = _blockProgression == BlockProgression.RL;
            if (!isNaN(_parcelLogicalTop))
            {
                if (_loc_5)
                {
                    _loc_4 = _parcelLogicalTop;
                }
                else
                {
                    _loc_3 = _parcelLogicalTop;
                }
            }
            if (!_measuring)
            {
                if (_loc_5)
                {
                    _loc_3 = _accumulatedMinimumStart;
                }
                else
                {
                    _loc_2 = _accumulatedMinimumStart;
                }
            }
            else
            {
                _loc_10 = _flowComposer.findLineIndexAtPosition(_curParcelStart);
                while (_loc_10 < this._curLineIndex)
                {
                    
                    _loc_11 = _flowComposer.getLineAt(_loc_10);
                    if (_loc_11.paragraph != _loc_7)
                    {
                        _loc_7 = _loc_11.paragraph;
                        _loc_8 = _loc_7.computedFormat;
                        _loc_9 = _loc_8.direction;
                        if (_loc_9 != Direction.LTR)
                        {
                            _loc_6 = _loc_8.paragraphEndIndent;
                        }
                    }
                    if (_loc_9 == Direction.LTR)
                    {
                        _loc_6 = Math.max(_loc_11.lineOffset, 0);
                    }
                    _loc_6 = _loc_5 ? (_loc_11.y - _loc_6) : (_loc_11.x - _loc_6);
                    _loc_12 = TextFlowLine.findNumberLine(_loc_11.getTextLine(true));
                    if (_loc_12)
                    {
                        _loc_13 = _loc_5 ? (_loc_12.y + _loc_11.y) : (_loc_12.x + _loc_11.x);
                        _loc_6 = Math.min(_loc_6, _loc_13);
                    }
                    if (_loc_5)
                    {
                        _loc_3 = Math.min(_loc_6, _loc_3);
                    }
                    else
                    {
                        _loc_2 = Math.min(_loc_6, _loc_2);
                    }
                    _loc_10++;
                }
            }
            if (_loc_2 != TextLine.MAX_LINE_WIDTH && Math.abs(_loc_2 - _parcelLeft) >= 1)
            {
                _parcelLeft = _loc_2;
            }
            if (_loc_4 != -TextLine.MAX_LINE_WIDTH && Math.abs(_loc_4 - _parcelRight) >= 1)
            {
                _parcelRight = _loc_4;
            }
            if (_loc_3 != TextLine.MAX_LINE_WIDTH && Math.abs(_loc_3 - _parcelTop) >= 1)
            {
                _parcelTop = _loc_3;
            }
            return;
        }// end function

        override protected function endLine(param1:TextLine) : void
        {
            super.endLine(param1);
            if (!this._useExistingLine)
            {
                (_flowComposer as StandardFlowComposer).addLine(_curLine, this._curLineIndex);
            }
            commitLastLineState(_curLine);
            var _loc_2:* = this;
            var _loc_3:* = this._curLineIndex + 1;
            _loc_2._curLineIndex = _loc_3;
            return;
        }// end function

        override protected function composeParagraphElement(param1:ParagraphElement, param2:int) : Boolean
        {
            if (this._curLineIndex < 0)
            {
                this._curLineIndex = _flowComposer.findLineIndexAtPosition(_curElementStart + _curElementOffset);
            }
            return super.composeParagraphElement(param1, param2);
        }// end function

        override protected function composeNextLine() : TextLine
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = NaN;
            var _loc_1:* = _curElementStart + _curElementOffset - _curParaStart;
            var _loc_2:* = this._curLineIndex < _flowComposer.numLines ? ((_flowComposer as StandardFlowComposer).lines[this._curLineIndex]) : (null);
            var _loc_3:* = _loc_2 && (!_loc_2.isDamaged() || _loc_2.validity == FlowDamageType.GEOMETRY);
            if (_listItemElement && _listItemElement.getAbsoluteStart() == _curElementStart + _curElementOffset)
            {
                var _loc_9:* = _loc_2.peekTextLine();
                _loc_6 = _loc_2.peekTextLine();
                if (_loc_3 && _loc_9 != null)
                {
                    _loc_4 = TextFlowLine.findNumberLine(_loc_6);
                }
                else
                {
                    _loc_7 = _curParaElement.computedFormat.direction == Direction.RTL;
                    _loc_4 = TextFlowLine.createNumberLine(_listItemElement, _curParaElement, _flowComposer.swfContext, _loc_7 ? (_parcelList.rightMargin) : (_parcelList.leftMargin));
                }
                pushInsideListItemMargins(_loc_4);
            }
            _parcelList.getLineSlug(_lineSlug, 0, 1, _textIndent, _curParaFormat.direction == Direction.LTR);
            if (_loc_3 && Twips.to(_lineSlug.width) != _loc_2.outerTargetWidthTW)
            {
                _loc_3 = false;
            }
            _curLine = _loc_3 ? (_loc_2) : (null);
            while (true)
            {
                
                while (!_curLine)
                {
                    
                    _loc_3 = false;
                    _loc_5 = this.createTextLine(_lineSlug.width, !_lineSlug.wrapsKnockOut);
                    if (_loc_5)
                    {
                        break;
                    }
                    _loc_8 = _curParcel.findNextTransition(_lineSlug.depth);
                    if (_loc_8 < Number.MAX_VALUE)
                    {
                        _parcelList.addTotalDepth(_loc_8 - _lineSlug.depth);
                        if (!_parcelList.getLineSlug(_lineSlug, 0, 1, _textIndent, _curParaFormat.direction == Direction.LTR))
                        {
                            return null;
                        }
                        continue;
                    }
                    advanceToNextParcel();
                    if (!_parcelList.atEnd())
                    {
                        if (_parcelList.getLineSlug(_lineSlug, 0, 1, _textIndent, _curParaFormat.direction == Direction.LTR))
                        {
                            continue;
                        }
                    }
                    popInsideListItemMargins(_loc_4);
                    return null;
                }
                if (!_loc_5)
                {
                    _loc_5 = _curLine.getTextLine(true);
                }
                if (fitLineToParcel(_loc_5, !_loc_3, _loc_4))
                {
                    break;
                }
                _curLine = null;
                if (_parcelList.atEnd())
                {
                    popInsideListItemMargins(_loc_4);
                    return null;
                }
            }
            if (_curLine.validity == FlowDamageType.GEOMETRY)
            {
                _curLine.clearDamage();
            }
            this._useExistingLine = _loc_3;
            popInsideListItemMargins(_loc_4);
            return _loc_5;
        }// end function

        override protected function createTextLine(param1:Number, param2:Boolean) : TextLine
        {
            _curLine = new TextFlowLine(null, null);
            var _loc_3:* = super.createTextLine(param1, param2);
            if (_loc_3)
            {
                _loc_3.doubleClickEnabled = true;
            }
            else
            {
                _curLine = null;
            }
            return _loc_3;
        }// end function

        static function getComposeState() : ComposeState
        {
            var _loc_1:* = _sharedComposeState;
            if (_loc_1)
            {
                _sharedComposeState = null;
                return _loc_1;
            }
            return new ComposeState;
        }// end function

        static function releaseComposeState(param1:ComposeState) : void
        {
            param1.releaseAnyReferences();
            _sharedComposeState = param1;
            return;
        }// end function

    }
}
