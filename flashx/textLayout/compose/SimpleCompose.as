package flashx.textLayout.compose
{
    import flash.text.engine.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    public class SimpleCompose extends BaseCompose
    {
        protected var workingLine:TextFlowLine;
        public var _lines:Array;
        private var _vjLines:Array;
        private var vjBeginLineIndex:int = 0;
        private var vjDisableThisParcel:Boolean = false;
        private var vjType:String;
        private var _totalLength:Number;
        private var _resetLineHandler:Function;

        public function SimpleCompose()
        {
            this.workingLine = new TextFlowLine(null, null);
            this._lines = new Array();
            this._vjLines = new Array();
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

        override protected function initializeForComposer(param1:IFlowComposer, param2:int, param3:int, param4:int) : void
        {
            _startController = param1.getControllerAt(0);
            _startComposePosition = 0;
            super.initializeForComposer(param1, param2, 0, param4);
            this._vjLines.splice(0);
            this.vjBeginLineIndex = 0;
            this.vjDisableThisParcel = false;
            this.vjType = _startController.computedFormat.verticalAlign;
            return;
        }// end function

        override public function composeTextFlow(param1:TextFlow, param2:int, param3:int) : int
        {
            _flowComposer = param1.flowComposer as StandardFlowComposer;
            _curLine = this.workingLine;
            this._lines.splice(0);
            this._totalLength = 0;
            return super.composeTextFlow(param1, param2, param3);
        }// end function

        override protected function doVerticalAlignment(param1:Boolean, param2:Parcel) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_3:* = parcelList.currentParcel;
            if (param1 && this.vjType != VerticalAlign.TOP && this.vjBeginLineIndex != this._lines.length && !this.vjDisableThisParcel)
            {
                _loc_4 = _curParcel.controller;
                _loc_5 = 0;
                _loc_6 = 0;
                if (_loc_4.numFloats > 0)
                {
                    _loc_5 = _loc_4.findFloatIndexAtOrAfter(_curParcelStart);
                    _loc_6 = _loc_4.findFloatIndexAfter(_curElementStart + _curElementOffset);
                }
                applyVerticalAlignmentToColumn(_loc_3.controller, this.vjType, this._vjLines, 0, this._vjLines.length, _loc_5, _loc_6);
            }
            this._vjLines.splice(0);
            this.vjBeginLineIndex = this._lines.length;
            this.vjDisableThisParcel = false;
            if (param2)
            {
                this.vjType = param2.controller.computedFormat.verticalAlign;
            }
            return;
        }// end function

        override protected function isLineVisible(param1:TextLine) : Boolean
        {
            return param1 != null;
        }// end function

        override protected function endLine(param1:TextLine) : void
        {
            super.endLine(param1);
            _curLine.createShape(_blockProgression, param1);
            if (this.textFlow.backgroundManager)
            {
                this.textFlow.backgroundManager.finalizeLine(_curLine);
            }
            param1.userData = this._totalLength;
            this._totalLength = this._totalLength + param1.rawTextLength;
            this._lines.push(param1);
            if (this.vjType != VerticalAlign.TOP)
            {
                this._vjLines.push(new VJHelper(param1, _curLine.height));
            }
            commitLastLineState(_curLine);
            return;
        }// end function

        public function get textFlow() : TextFlow
        {
            return _textFlow;
        }// end function

        public function get resetLineHandler() : Function
        {
            return this._resetLineHandler;
        }// end function

        public function set resetLineHandler(param1:Function) : void
        {
            this._resetLineHandler = param1;
            return;
        }// end function

        override protected function resetLine(param1:TextLine) : void
        {
            super.resetLine(param1);
            if (this._resetLineHandler != null)
            {
                this._resetLineHandler(param1);
            }
            return;
        }// end function

        override protected function composeNextLine() : TextLine
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = NaN;
            if (_listItemElement && _listItemElement.getAbsoluteStart() == _curElementStart + _curElementOffset)
            {
                _loc_3 = _curParaElement.computedFormat.direction == Direction.RTL;
                _loc_1 = TextFlowLine.createNumberLine(_listItemElement, _curParaElement, _flowComposer.swfContext, _loc_3 ? (_parcelList.rightMargin) : (_parcelList.leftMargin));
                pushInsideListItemMargins(_loc_1);
            }
            if (!_parcelList.getLineSlug(_lineSlug, 0, 0, _textIndent, _curParaFormat.direction == Direction.LTR))
            {
                return null;
            }
            while (true)
            {
                
                while (true)
                {
                    
                    _loc_2 = createTextLine(_lineSlug.width, !_lineSlug.wrapsKnockOut);
                    if (_loc_2)
                    {
                        break;
                    }
                    _loc_4 = _curParcel.findNextTransition(_lineSlug.depth);
                    if (_loc_4 < Number.MAX_VALUE)
                    {
                        _parcelList.addTotalDepth(_loc_4 - _lineSlug.depth);
                        _parcelList.getLineSlug(_lineSlug, 0, 1, _textIndent, _curParaFormat.direction == Direction.LTR);
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
                    popInsideListItemMargins(_loc_1);
                    return null;
                }
                if (fitLineToParcel(_loc_2, true, _loc_1))
                {
                    break;
                }
                if (this.resetLineHandler != null)
                {
                    this.resetLineHandler(_loc_2);
                }
                if (_parcelList.atEnd())
                {
                    popInsideListItemMargins(_loc_1);
                    return null;
                }
            }
            popInsideListItemMargins(_loc_1);
            return _loc_2;
        }// end function

        function swapLines(param1:Array) : Array
        {
            var _loc_2:* = this._lines;
            this._lines = param1;
            return _loc_2;
        }// end function

        override protected function finalParcelAdjustment(param1:ContainerController) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = NaN;
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
                _loc_7 = 0;
                _loc_13 = 0;
                _loc_14 = 0;
                _loc_15 = null;
                for each (_loc_6 in this._lines)
                {
                    
                    _loc_16 = param1.textFlow.findLeaf(_loc_7);
                    _loc_17 = _loc_16.getParagraph();
                    if (_loc_17 != _loc_15)
                    {
                        _loc_13 = 0;
                        _loc_14 = 0;
                        _loc_20 = _loc_17;
                        while (_loc_20 && _loc_20.parent)
                        {
                            
                            if (_loc_5)
                            {
                                _loc_13 = _loc_13 + _loc_20.getEffectivePaddingRight();
                                _loc_14 = _loc_14 + _loc_20.getEffectivePaddingTop();
                            }
                            else
                            {
                                _loc_13 = _loc_13 + _loc_20.getEffectivePaddingTop();
                                _loc_14 = _loc_14 + _loc_20.getEffectivePaddingLeft();
                            }
                            _loc_20 = _loc_20.parent;
                        }
                        _loc_15 = _loc_17;
                    }
                    _loc_18 = 0;
                    if (_loc_6.numChildren > 0)
                    {
                        _loc_21 = _loc_16.getAbsoluteStart();
                        _loc_18 = TextFlowLine.getTextLineTypographicAscent(_loc_6, _loc_16, _loc_21, _loc_7 + _loc_6.rawTextLength);
                    }
                    if (_loc_11 != _loc_17)
                    {
                        _loc_12 = _loc_17.computedFormat;
                        if (_loc_12.direction == Direction.LTR)
                        {
                            _loc_8 = Math.max(_loc_12.textIndent, 0);
                            _loc_9 = _loc_12.paragraphStartIndent;
                        }
                        else
                        {
                            _loc_8 = 0;
                            _loc_9 = _loc_12.paragraphEndIndent;
                        }
                    }
                    _loc_9 = _loc_9 + _loc_14;
                    _loc_10 = _loc_6.textBlockBeginIndex == 0 ? (_loc_9 + _loc_8) : (_loc_9);
                    _loc_10 = _loc_5 ? (_loc_6.y - _loc_10) : (_loc_6.x - _loc_10);
                    _loc_19 = TextFlowLine.findNumberLine(_loc_6);
                    if (_loc_19)
                    {
                        _loc_22 = _loc_5 ? (_loc_19.y + _loc_6.y) : (_loc_19.x + _loc_6.x);
                        _loc_10 = Math.min(_loc_10, _loc_22);
                    }
                    if (_loc_5)
                    {
                        _loc_3 = Math.min(_loc_10, _loc_3);
                        _loc_4 = Math.max(_loc_6.x + Math.max(_loc_18, _loc_6.ascent) + _loc_13, _loc_4);
                    }
                    else
                    {
                        _loc_2 = Math.min(_loc_10, _loc_2);
                        if (_loc_18 < _loc_6.ascent)
                        {
                            _loc_18 = _loc_6.ascent;
                        }
                        _loc_3 = Math.min(_loc_6.y - (_loc_18 + _loc_13), _loc_3);
                    }
                    _loc_7 = _loc_7 + _loc_6.rawTextLength;
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

        override function releaseAnyReferences() : void
        {
            super.releaseAnyReferences();
            this.workingLine.initialize(null, 0, 0, 0, 0, null);
            this.resetLineHandler = null;
            return;
        }// end function

    }
}

import flash.text.engine.*;

import flashx.textLayout.container.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

class VJHelper extends Object implements IVerticalJustificationLine
{
    private var _line:TextLine;
    private var _height:Number;

    function VJHelper(param1:TextLine, param2:Number)
    {
        this._line = param1;
        this._height = param2;
        return;
    }// end function

    public function get x() : Number
    {
        return this._line.x;
    }// end function

    public function set x(param1:Number) : void
    {
        this._line.x = param1;
        return;
    }// end function

    public function get y() : Number
    {
        return this._line.y;
    }// end function

    public function set y(param1:Number) : void
    {
        this._line.y = param1;
        return;
    }// end function

    public function get ascent() : Number
    {
        return this._line.ascent;
    }// end function

    public function get descent() : Number
    {
        return this._line.descent;
    }// end function

    public function get height() : Number
    {
        return this._height;
    }// end function

}

