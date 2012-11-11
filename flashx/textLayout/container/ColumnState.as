package flashx.textLayout.container
{
    import flash.geom.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    public class ColumnState extends Object
    {
        private var _inputsChanged:Boolean;
        private var _blockProgression:String;
        private var _columnDirection:String;
        private var _paddingTop:Number;
        private var _paddingBottom:Number;
        private var _paddingLeft:Number;
        private var _paddingRight:Number;
        private var _compositionWidth:Number;
        private var _compositionHeight:Number;
        private var _forceSingleColumn:Boolean;
        private var _inputColumnWidth:Object;
        private var _inputColumnGap:Number;
        private var _inputColumnCount:Object;
        private var _columnWidth:Number;
        private var _columnCount:int;
        private var _columnGap:Number;
        private var _inset:Number;
        private var _columnArray:Array;
        private var _singleColumn:Rectangle;

        public function ColumnState(param1:String, param2:String, param3:ContainerController, param4:Number, param5:Number)
        {
            this._inputsChanged = true;
            this._columnCount = 0;
            if (param1 != null)
            {
                this.updateInputs(param1, param2, param3, param4, param5);
                this.computeColumns();
            }
            return;
        }// end function

        public function get columnWidth() : Number
        {
            return this._columnWidth;
        }// end function

        public function get columnCount() : int
        {
            return this._columnCount;
        }// end function

        public function get columnGap() : Number
        {
            return this._columnGap;
        }// end function

        public function getColumnAt(param1:int) : Rectangle
        {
            return this._columnCount == 1 ? (this._singleColumn) : (this._columnArray[param1]);
        }// end function

        function updateInputs(param1:String, param2:String, param3:ContainerController, param4:Number, param5:Number) : void
        {
            var _loc_6:* = param3.getTotalPaddingTop();
            var _loc_7:* = param3.getTotalPaddingBottom();
            var _loc_8:* = param3.getTotalPaddingLeft();
            var _loc_9:* = param3.getTotalPaddingRight();
            var _loc_10:* = param3.computedFormat;
            var _loc_11:* = param3.computedFormat.columnWidth;
            var _loc_12:* = _loc_10.columnGap;
            var _loc_13:* = _loc_10.columnCount;
            var _loc_14:* = _loc_10.columnCount == FormatValue.AUTO && (_loc_10.columnWidth == FormatValue.AUTO || Number(_loc_10.columnWidth) == 0) || param3.rootElement.computedFormat.lineBreak == LineBreak.EXPLICIT || isNaN(param1 == BlockProgression.RL ? (param5) : (param4));
            if (this._inputsChanged == false)
            {
                this._inputsChanged = param4 != this._compositionHeight || param5 != this._compositionHeight || this._paddingTop != _loc_6 || this._paddingBottom != _loc_7 || this._paddingLeft != _loc_8 || this._paddingRight != _loc_9 || this._blockProgression != this._blockProgression || this._columnDirection != param2 || this._forceSingleColumn != _loc_14 || this._inputColumnWidth != _loc_11 || this._inputColumnGap != _loc_12 || this._inputColumnCount != _loc_13;
            }
            if (this._inputsChanged)
            {
                this._blockProgression = param1;
                this._columnDirection = param2;
                this._paddingTop = _loc_6;
                this._paddingBottom = _loc_7;
                this._paddingLeft = _loc_8;
                this._paddingRight = _loc_9;
                this._compositionWidth = param4;
                this._compositionHeight = param5;
                this._forceSingleColumn = _loc_14;
                this._inputColumnWidth = _loc_11;
                this._inputColumnGap = _loc_12;
                this._inputColumnCount = _loc_13;
            }
            return;
        }// end function

        function computeColumns() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            if (!this._inputsChanged)
            {
                return;
            }
            var _loc_4:* = this._blockProgression == BlockProgression.RL ? (this._compositionHeight) : (this._compositionWidth);
            var _loc_5:* = this._blockProgression == BlockProgression.RL ? (this._paddingTop + this._paddingBottom) : (this._paddingLeft + this._paddingRight);
            _loc_4 = _loc_4 > _loc_5 && !isNaN(_loc_4) ? (_loc_4 - _loc_5) : (0);
            if (this._forceSingleColumn)
            {
                _loc_2 = 1;
                _loc_3 = _loc_4;
                _loc_1 = 0;
            }
            else
            {
                _loc_1 = this._inputColumnGap;
                if (this._inputColumnWidth == FormatValue.AUTO)
                {
                    _loc_2 = Number(this._inputColumnCount);
                    if ((_loc_2 - 1) * _loc_1 < _loc_4)
                    {
                        _loc_3 = (_loc_4 - (_loc_2 - 1) * _loc_1) / _loc_2;
                    }
                    else if (_loc_1 > _loc_4)
                    {
                        _loc_2 = 1;
                        _loc_3 = _loc_4;
                        _loc_1 = 0;
                    }
                    else
                    {
                        _loc_2 = Math.floor(_loc_4 / _loc_1);
                        _loc_3 = (_loc_4 - (_loc_2 - 1) * _loc_1) / _loc_2;
                    }
                }
                else if (this._inputColumnCount == FormatValue.AUTO)
                {
                    _loc_3 = Number(this._inputColumnWidth);
                    if (_loc_3 >= _loc_4)
                    {
                        _loc_2 = 1;
                        _loc_3 = _loc_4;
                        _loc_1 = 0;
                    }
                    else
                    {
                        _loc_2 = Math.floor((_loc_4 + _loc_1) / (_loc_3 + _loc_1));
                        _loc_3 = (_loc_4 + _loc_1) / _loc_2 - _loc_1;
                    }
                }
                else
                {
                    _loc_2 = Number(this._inputColumnCount);
                    _loc_3 = Number(this._inputColumnWidth);
                    if (_loc_2 * _loc_3 + (_loc_2 - 1) * _loc_1 <= _loc_4)
                    {
                    }
                    else if (_loc_3 >= _loc_4)
                    {
                        _loc_2 = 1;
                        _loc_1 = 0;
                    }
                    else
                    {
                        _loc_2 = Math.floor((_loc_4 + _loc_1) / (_loc_3 + _loc_1));
                        _loc_3 = (_loc_4 + _loc_1) / _loc_2 - _loc_1;
                    }
                }
            }
            this._columnWidth = _loc_3;
            this._columnCount = _loc_2;
            this._columnGap = _loc_1;
            this._inset = _loc_5;
            if (this._blockProgression == BlockProgression.TB)
            {
                if (this._columnDirection == Direction.LTR)
                {
                    _loc_6 = this._paddingLeft;
                    _loc_8 = this._columnWidth + this._columnGap;
                    _loc_11 = this._columnWidth;
                }
                else
                {
                    _loc_6 = isNaN(this._compositionWidth) ? (this._paddingLeft) : (this._compositionWidth - this._paddingRight - this._columnWidth);
                    _loc_8 = -(this._columnWidth + this._columnGap);
                    _loc_11 = this._columnWidth;
                }
                _loc_7 = this._paddingTop;
                _loc_9 = 0;
                _loc_12 = this._paddingTop + this._paddingBottom;
                _loc_10 = this._compositionHeight > _loc_12 && !isNaN(this._compositionHeight) ? (this._compositionHeight - _loc_12) : (0);
            }
            else if (this._blockProgression == BlockProgression.RL)
            {
                _loc_6 = isNaN(this._compositionWidth) ? (-this._paddingRight) : (this._paddingLeft - this._compositionWidth);
                _loc_7 = this._paddingTop;
                _loc_8 = 0;
                _loc_9 = this._columnWidth + this._columnGap;
                _loc_12 = this._paddingLeft + this._paddingRight;
                _loc_11 = this._compositionWidth > _loc_12 ? (this._compositionWidth - _loc_12) : (0);
                _loc_10 = this._columnWidth;
            }
            if (_loc_11 == 0)
            {
                _loc_11 = Twips.ONE_TWIP;
                if (this._blockProgression == BlockProgression.RL)
                {
                    _loc_6 = _loc_6 - _loc_11;
                }
            }
            if (_loc_10 == 0)
            {
                _loc_10 = Twips.ONE_TWIP;
            }
            if (this._columnCount == 1)
            {
                this._singleColumn = new Rectangle(_loc_6, _loc_7, _loc_11, _loc_10);
                this._columnArray = null;
            }
            else if (this._columnCount == 0)
            {
                this._singleColumn = null;
                this._columnArray = null;
            }
            else
            {
                if (this._columnArray)
                {
                    this._columnArray.splice(0);
                }
                else
                {
                    this._columnArray = new Array();
                }
                _loc_13 = 0;
                while (_loc_13 < this._columnCount)
                {
                    
                    this._columnArray.push(new Rectangle(_loc_6, _loc_7, _loc_11, _loc_10));
                    _loc_6 = _loc_6 + _loc_8;
                    _loc_7 = _loc_7 + _loc_9;
                    _loc_13++;
                }
            }
            return;
        }// end function

    }
}
