package flashx.textLayout.compose
{
    import flash.text.engine.*;
    import flashx.textLayout.elements.*;

    public class FlowComposerBase extends Object
    {
        private var _lines:Array;
        protected var _textFlow:TextFlow;
        protected var _damageAbsoluteStart:int;
        protected var _swfContext:ISWFContext;

        public function FlowComposerBase()
        {
            this._lines = new Array();
            this._swfContext = null;
            return;
        }// end function

        public function get lines() : Array
        {
            return this._lines;
        }// end function

        public function getLineAt(param1:int) : TextFlowLine
        {
            return this._lines[param1];
        }// end function

        public function get numLines() : int
        {
            return this._lines.length;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._textFlow;
        }// end function

        public function get damageAbsoluteStart() : int
        {
            return this._damageAbsoluteStart;
        }// end function

        protected function initializeLines() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._textFlow ? (this._textFlow.backgroundManager) : (null);
            if (TextLineRecycler.textLineRecyclerEnabled)
            {
                for each (_loc_2 in this._lines)
                {
                    
                    _loc_3 = _loc_2.peekTextLine();
                    if (_loc_3 && !_loc_3.parent)
                    {
                        if (_loc_3.validity != TextLineValidity.INVALID)
                        {
                            _loc_4 = _loc_3.textBlock;
                            _loc_3.textBlock.releaseLines(_loc_4.firstLine, _loc_4.lastLine);
                        }
                        _loc_3.userData = null;
                        TextLineRecycler.addLineForReuse(_loc_3);
                        if (_loc_1)
                        {
                            _loc_1.removeLineFromCache(_loc_3);
                        }
                    }
                }
            }
            this._lines.splice(0);
            this._damageAbsoluteStart = 0;
            return;
        }// end function

        protected function finalizeLinesAfterCompose() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (this._lines.length == 0)
            {
                _loc_1 = new TextFlowLine(null, null);
                _loc_1.setTextLength(this.textFlow.textLength);
                this._lines.push(_loc_1);
            }
            else
            {
                _loc_1 = this._lines[(this._lines.length - 1)];
                _loc_2 = _loc_1.absoluteStart + _loc_1.textLength;
                if (_loc_2 < this.textFlow.textLength)
                {
                    _loc_1 = new TextFlowLine(null, null);
                    _loc_1.setAbsoluteStart(_loc_2);
                    _loc_1.setTextLength(this.textFlow.textLength - _loc_2);
                    this._lines.push(_loc_1);
                }
            }
            return;
        }// end function

        public function updateLengths(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (this.numLines == 0)
            {
                return;
            }
            var _loc_4:* = this.findLineIndexAtPosition(param1);
            var _loc_5:* = int.MAX_VALUE;
            if (param2 > 0)
            {
                if (_loc_4 == this._lines.length)
                {
                    _loc_3 = this._lines[(this._lines.length - 1)];
                    _loc_3.setTextLength(_loc_3.textLength + param2);
                }
                else
                {
                    _loc_3 = this._lines[_loc_4++];
                    _loc_3.setTextLength(_loc_3.textLength + param2);
                }
                _loc_5 = _loc_3.absoluteStart;
            }
            else
            {
                _loc_6 = -param2;
                _loc_7 = 0;
                while (true)
                {
                    
                    _loc_3 = this._lines[_loc_4];
                    _loc_3.setAbsoluteStart(_loc_3.absoluteStart + _loc_6 + param2);
                    _loc_7 = param1 > _loc_3.absoluteStart ? (param1) : (_loc_3.absoluteStart);
                    _loc_8 = _loc_3.absoluteStart + _loc_3.textLength;
                    _loc_9 = 0;
                    if (_loc_7 + _loc_6 <= _loc_8)
                    {
                        if (_loc_7 == _loc_3.absoluteStart)
                        {
                            _loc_9 = _loc_6;
                        }
                        else if (_loc_7 == param1)
                        {
                            _loc_9 = _loc_6;
                            ;
                        }
                    }
                    else if (_loc_7 == _loc_3.absoluteStart)
                    {
                        _loc_9 = _loc_3.textLength;
                    }
                    else
                    {
                        _loc_9 = _loc_8 - _loc_7;
                    }
                    if (_loc_7 == _loc_3.absoluteStart && _loc_7 + _loc_9 == _loc_8)
                    {
                        _loc_6 = _loc_6 - _loc_9;
                        this._lines.splice(_loc_4, 1);
                    }
                    else
                    {
                        if (_loc_5 > _loc_3.absoluteStart)
                        {
                            _loc_5 = _loc_3.absoluteStart;
                        }
                        _loc_3.setTextLength(_loc_3.textLength - _loc_9);
                        _loc_6 = _loc_6 - _loc_9;
                        _loc_4++;
                    }
                    if (_loc_6 <= 0)
                    {
                        break;
                    }
                }
            }
            while (_loc_4 < this._lines.length)
            {
                
                _loc_3 = this._lines[_loc_4];
                if (param2 >= 0)
                {
                    _loc_3.setAbsoluteStart(_loc_3.absoluteStart + param2);
                }
                else
                {
                    _loc_3.setAbsoluteStart(_loc_3.absoluteStart > -param2 ? (_loc_3.absoluteStart + param2) : (0));
                }
                _loc_4++;
            }
            if (this._damageAbsoluteStart > _loc_5)
            {
                this._damageAbsoluteStart = _loc_5;
            }
            return;
        }// end function

        public function damage(param1:int, param2:int, param3:String) : void
        {
            var _loc_6:* = null;
            if (this._lines.length == 0 || this.textFlow.textLength == 0)
            {
                return;
            }
            if (param1 == this.textFlow.textLength)
            {
                return;
            }
            var _loc_4:* = this.findLineIndexAtPosition(param1);
            var _loc_5:* = this.textFlow.findLeaf(param1);
            if (this.textFlow.findLeaf(param1) && _loc_4 > 0)
            {
                _loc_4 = _loc_4 - 1;
            }
            if (this.lines[_loc_4].absoluteStart < this._damageAbsoluteStart)
            {
                this._damageAbsoluteStart = this._lines[_loc_4].absoluteStart;
            }
            while (_loc_4 < this._lines.length)
            {
                
                _loc_6 = this._lines[_loc_4];
                if (_loc_6.absoluteStart >= param1 + param2)
                {
                    break;
                }
                _loc_6.damage(param3);
                _loc_4++;
            }
            return;
        }// end function

        public function isDamaged(param1:int) : Boolean
        {
            if (this._lines.length == 0)
            {
                return true;
            }
            return this._damageAbsoluteStart <= param1 && this._damageAbsoluteStart != this.textFlow.textLength;
        }// end function

        public function findLineIndexAtPosition(param1:int, param2:Boolean = false) : int
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = this._lines.length - 1;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_5 = (_loc_3 + _loc_4) / 2;
                _loc_6 = this._lines[_loc_5];
                if (_loc_6.absoluteStart <= param1)
                {
                    if (param2)
                    {
                        if (_loc_6.absoluteStart + _loc_6.textLength >= param1)
                        {
                            return _loc_5;
                        }
                    }
                    else if (_loc_6.absoluteStart + _loc_6.textLength > param1)
                    {
                        return _loc_5;
                    }
                    _loc_3 = _loc_5 + 1;
                    continue;
                }
                _loc_4 = _loc_5 - 1;
            }
            return this._lines.length;
        }// end function

        public function findLineAtPosition(param1:int, param2:Boolean = false) : TextFlowLine
        {
            return this._lines[this.findLineIndexAtPosition(param1, param2)];
        }// end function

        public function addLine(param1:TextFlowLine, param2:int) : void
        {
            var _loc_4:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_3:* = this._lines[param2];
            var _loc_5:* = int.MAX_VALUE;
            if (this._damageAbsoluteStart == param1.absoluteStart)
            {
                this._damageAbsoluteStart = param1.absoluteStart + param1.textLength;
            }
            if (_loc_3 == null)
            {
                this.lines.push(param1);
            }
            else if (_loc_3.absoluteStart != param1.absoluteStart)
            {
                if (_loc_3.absoluteStart + _loc_3.textLength > param1.absoluteStart + param1.textLength)
                {
                    _loc_4 = new TextFlowLine(null, param1.paragraph);
                    _loc_4.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                    _loc_6 = _loc_3.textLength;
                    _loc_3.setTextLength(param1.absoluteStart - _loc_3.absoluteStart);
                    _loc_4.setTextLength(_loc_6 - param1.textLength - _loc_3.textLength);
                    this._lines.splice((param2 + 1), 0, param1, _loc_4);
                }
                else
                {
                    _loc_3.setTextLength(param1.absoluteStart - _loc_3.absoluteStart);
                    _loc_4 = this._lines[(param2 + 1)];
                    _loc_4.setTextLength(param1.absoluteStart + param1.textLength - _loc_4.absoluteStart);
                    _loc_4.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                    this._lines.splice((param2 + 1), 0, param1);
                }
                _loc_5 = _loc_3.absoluteStart;
            }
            else if (_loc_3.textLength > param1.textLength)
            {
                _loc_3.setTextLength(_loc_3.textLength - param1.textLength);
                _loc_3.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                _loc_3.damage(TextLineValidity.INVALID);
                this._lines.splice(param2, 0, param1);
                _loc_5 = _loc_3.absoluteStart;
            }
            else
            {
                _loc_7 = 1;
                if (_loc_3.textLength != param1.textLength)
                {
                    _loc_8 = param1.textLength - _loc_3.textLength;
                    _loc_9 = param2 + 1;
                    while (_loc_8 > 0)
                    {
                        
                        _loc_4 = this._lines[_loc_9];
                        if (_loc_8 < _loc_4.textLength)
                        {
                            _loc_4.setTextLength(_loc_4.textLength - _loc_8);
                            _loc_4.damage(TextLineValidity.INVALID);
                            break;
                            continue;
                        }
                        _loc_7++;
                        _loc_8 = _loc_8 - _loc_4.textLength;
                        _loc_9++;
                        _loc_4 = _loc_9 < this._lines.length ? (this._lines[_loc_9]) : (null);
                    }
                    if (_loc_4 && _loc_4.absoluteStart != param1.absoluteStart + param1.textLength)
                    {
                        _loc_4.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                        _loc_4.damage(TextLineValidity.INVALID);
                    }
                    _loc_5 = param1.absoluteStart + param1.textLength;
                }
                if (TextLineRecycler.textLineRecyclerEnabled)
                {
                    _loc_10 = this.textFlow.backgroundManager;
                    _loc_11 = param2;
                    while (_loc_11 < param2 + _loc_7)
                    {
                        
                        _loc_12 = TextFlowLine(this._lines[_loc_11]).peekTextLine();
                        if (_loc_12 && !_loc_12.parent)
                        {
                            if (_loc_12.validity != TextLineValidity.VALID)
                            {
                                _loc_12.userData = null;
                                TextLineRecycler.addLineForReuse(_loc_12);
                                if (_loc_10)
                                {
                                    _loc_10.removeLineFromCache(_loc_12);
                                }
                            }
                        }
                        _loc_11++;
                    }
                }
                this._lines.splice(param2, _loc_7, param1);
            }
            if (this._damageAbsoluteStart > _loc_5)
            {
                this._damageAbsoluteStart = _loc_5;
            }
            return;
        }// end function

        public function get swfContext() : ISWFContext
        {
            return this._swfContext;
        }// end function

        public function set swfContext(param1:ISWFContext) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 != this._swfContext)
            {
                if (this.textFlow)
                {
                    _loc_2 = computeBaseSWFContext(param1);
                    _loc_3 = computeBaseSWFContext(this._swfContext);
                    this._swfContext = param1;
                    if (_loc_2 != _loc_3)
                    {
                        this.damage(0, this.textFlow.textLength, FlowDamageType.INVALID);
                        this.textFlow.invalidateAllFormats();
                    }
                }
                else
                {
                    this._swfContext = param1;
                }
            }
            return;
        }// end function

        static function computeBaseSWFContext(param1:ISWFContext) : ISWFContext
        {
            return param1 && Object(param1).hasOwnProperty("getBaseSWFContext") ? (var _loc_2:* = param1, _loc_2.param1["getBaseSWFContext"]()) : (param1);
        }// end function

    }
}
