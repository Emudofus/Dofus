package flashx.textLayout.compose
{
    import flashx.textLayout.container.*;
    import flashx.textLayout.formats.*;

    final public class VerticalJustifier extends Object
    {

        public function VerticalJustifier()
        {
            return;
        }// end function

        public static function applyVerticalAlignmentToColumn(param1:ContainerController, param2:String, param3:Array, param4:int, param5:int, param6:int, param7:int) : Number
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            if (param1.rootElement.computedFormat.blockProgression == BlockProgression.RL)
            {
                _loc_8 = new RL_VJHelper(param1);
            }
            else
            {
                _loc_8 = new TB_VJHelper(param1);
            }
            switch(param2)
            {
                case VerticalAlign.MIDDLE:
                case VerticalAlign.BOTTOM:
                {
                    _loc_11 = param3[param4 + param5 - 1];
                    _loc_12 = _loc_8.getBottom(_loc_11, param1, param6, param7);
                    _loc_10 = param2 == VerticalAlign.MIDDLE ? (_loc_8.computeMiddleAdjustment(_loc_12)) : (_loc_8.computeBottomAdjustment(_loc_12));
                    _loc_9 = param4;
                    while (_loc_9 < param4 + param5)
                    {
                        
                        _loc_8.applyAdjustment(param3[_loc_9]);
                        _loc_9++;
                    }
                    _loc_13 = param6;
                    while (_loc_13 < param7)
                    {
                        
                        _loc_14 = param1.getFloatAt(_loc_13);
                        if (_loc_14.floatType != Float.NONE)
                        {
                            _loc_8.applyAdjustmentToFloat(_loc_14);
                        }
                        _loc_13++;
                    }
                    break;
                }
                case VerticalAlign.JUSTIFY:
                {
                    _loc_10 = _loc_8.computeJustifyAdjustment(param3, param4, param5);
                    _loc_8.applyJustifyAdjustment(param3, param4, param5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_10;
        }// end function

    }
}

import flashx.textLayout.container.*;

import flashx.textLayout.formats.*;

interface IVerticalAdjustmentHelper
{

    function IVerticalAdjustmentHelper();

    function getBottom(param1:IVerticalJustificationLine, param2:ContainerController, param3:int, param4:int) : Number;

    function computeMiddleAdjustment(param1:Number) : Number;

    function applyAdjustment(param1:IVerticalJustificationLine) : void;

    function applyAdjustmentToFloat(param1:FloatCompositionData) : void;

    function computeBottomAdjustment(param1:Number) : Number;

    function computeJustifyAdjustment(param1:Array, param2:int, param3:int) : Number;

    function applyJustifyAdjustment(param1:Array, param2:int, param3:int) : void;

}


import flashx.textLayout.container.*;

import flashx.textLayout.formats.*;

class TB_VJHelper extends Object implements IVerticalAdjustmentHelper
{
    private var _textFrame:ContainerController;
    private var adj:Number;

    function TB_VJHelper(param1:ContainerController) : void
    {
        this._textFrame = param1;
        return;
    }// end function

    public function getBottom(param1:IVerticalJustificationLine, param2:ContainerController, param3:int, param4:int) : Number
    {
        var _loc_7:* = null;
        var _loc_8:* = null;
        var _loc_5:* = this.getBaseline(param1) + param1.descent;
        var _loc_6:* = param3;
        while (_loc_6 < param4)
        {
            
            _loc_7 = param2.getFloatAt(_loc_6);
            if (_loc_7.floatType != Float.NONE)
            {
                _loc_8 = param2.rootElement.findLeaf(_loc_7.absolutePosition) as InlineGraphicElement;
                _loc_5 = Math.max(_loc_5, _loc_7.y + _loc_8.elementHeightWithMarginsAndPadding());
            }
            _loc_6++;
        }
        return _loc_5;
    }// end function

    public function getBottomOfLine(param1:IVerticalJustificationLine) : Number
    {
        return this.getBaseline(param1) + param1.descent;
    }// end function

    private function getBaseline(param1:IVerticalJustificationLine) : Number
    {
        if (param1 is TextFlowLine)
        {
            return param1.y + param1.ascent;
        }
        return param1.y;
    }// end function

    private function setBaseline(param1:IVerticalJustificationLine, param2:Number) : void
    {
        if (param1 is TextFlowLine)
        {
            param1.y = param2 - param1.ascent;
        }
        else
        {
            param1.y = param2;
        }
        return;
    }// end function

    public function computeMiddleAdjustment(param1:Number) : Number
    {
        var _loc_2:* = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
        this.adj = (_loc_2 - param1) / 2;
        if (this.adj < 0)
        {
            this.adj = 0;
        }
        return this.adj;
    }// end function

    public function computeBottomAdjustment(param1:Number) : Number
    {
        var _loc_2:* = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
        this.adj = _loc_2 - param1;
        if (this.adj < 0)
        {
            this.adj = 0;
        }
        return this.adj;
    }// end function

    public function applyAdjustment(param1:IVerticalJustificationLine) : void
    {
        param1.y = param1.y + this.adj;
        return;
    }// end function

    public function applyAdjustmentToFloat(param1:FloatCompositionData) : void
    {
        param1.y = param1.y + this.adj;
        return;
    }// end function

    public function computeJustifyAdjustment(param1:Array, param2:int, param3:int) : Number
    {
        this.adj = 0;
        if (param3 == 1)
        {
            return 0;
        }
        var _loc_4:* = param1[param2];
        var _loc_5:* = this.getBaseline(_loc_4);
        var _loc_6:* = param1[param2 + param3 - 1];
        var _loc_7:* = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
        var _loc_8:* = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom()) - this.getBottomOfLine(_loc_6);
        if (this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom()) - this.getBottomOfLine(_loc_6) < 0)
        {
            return 0;
        }
        var _loc_9:* = this.getBaseline(_loc_6);
        this.adj = _loc_8 / (_loc_9 - _loc_5);
        return this.adj;
    }// end function

    public function applyJustifyAdjustment(param1:Array, param2:int, param3:int) : void
    {
        var _loc_7:* = null;
        var _loc_8:* = NaN;
        var _loc_9:* = NaN;
        if (param3 == 1 || this.adj == 0)
        {
            return;
        }
        var _loc_4:* = param1[param2];
        var _loc_5:* = this.getBaseline(_loc_4);
        var _loc_6:* = this.getBaseline(_loc_4);
        var _loc_10:* = 1;
        while (_loc_10 < param3)
        {
            
            _loc_7 = param1[_loc_10 + param2];
            _loc_9 = this.getBaseline(_loc_7);
            _loc_8 = _loc_5 + (_loc_9 - _loc_6) * (1 + this.adj);
            this.setBaseline(_loc_7, _loc_8);
            _loc_6 = _loc_9;
            _loc_5 = _loc_8;
            _loc_10++;
        }
        return;
    }// end function

}


import flashx.textLayout.container.*;

import flashx.textLayout.formats.*;

class RL_VJHelper extends Object implements IVerticalAdjustmentHelper
{
    private var _textFrame:ContainerController;
    private var adj:Number = 0;

    function RL_VJHelper(param1:ContainerController) : void
    {
        this._textFrame = param1;
        return;
    }// end function

    public function getBottom(param1:IVerticalJustificationLine, param2:ContainerController, param3:int, param4:int) : Number
    {
        var _loc_8:* = null;
        var _loc_5:* = this._textFrame.compositionWidth - Number(this._textFrame.getTotalPaddingLeft());
        var _loc_6:* = this._textFrame.compositionWidth - Number(this._textFrame.getTotalPaddingLeft()) + param1.x - param1.descent;
        var _loc_7:* = param3;
        while (_loc_7 < param4)
        {
            
            _loc_8 = param2.getFloatAt(_loc_7);
            if (_loc_8.floatType != Float.NONE)
            {
                _loc_6 = Math.min(_loc_6, _loc_8.x + _loc_5);
            }
            _loc_7++;
        }
        return _loc_6;
    }// end function

    public function computeMiddleAdjustment(param1:Number) : Number
    {
        this.adj = param1 / 2;
        if (this.adj < 0)
        {
            this.adj = 0;
        }
        return -this.adj;
    }// end function

    public function computeBottomAdjustment(param1:Number) : Number
    {
        this.adj = param1;
        if (this.adj < 0)
        {
            this.adj = 0;
        }
        return -this.adj;
    }// end function

    public function applyAdjustment(param1:IVerticalJustificationLine) : void
    {
        param1.x = param1.x - this.adj;
        return;
    }// end function

    public function applyAdjustmentToFloat(param1:FloatCompositionData) : void
    {
        param1.x = param1.x - this.adj;
        return;
    }// end function

    public function computeJustifyAdjustment(param1:Array, param2:int, param3:int) : Number
    {
        this.adj = 0;
        if (param3 == 1)
        {
            return 0;
        }
        var _loc_4:* = param1[param2];
        var _loc_5:* = param1[param2].x;
        var _loc_6:* = param1[param2 + param3 - 1];
        var _loc_7:* = Number(this._textFrame.getTotalPaddingLeft()) - this._textFrame.compositionWidth;
        var _loc_8:* = _loc_6.x - _loc_6.descent - _loc_7;
        if (_loc_6.x - _loc_6.descent - _loc_7 < 0)
        {
            return 0;
        }
        var _loc_9:* = _loc_6.x;
        this.adj = _loc_8 / (_loc_5 - _loc_9);
        return -this.adj;
    }// end function

    public function applyJustifyAdjustment(param1:Array, param2:int, param3:int) : void
    {
        var _loc_7:* = null;
        var _loc_8:* = NaN;
        var _loc_9:* = NaN;
        if (param3 == 1 || this.adj == 0)
        {
            return;
        }
        var _loc_4:* = param1[param2];
        var _loc_5:* = param1[param2].x;
        var _loc_6:* = param1[param2].x;
        var _loc_10:* = 1;
        while (_loc_10 < param3)
        {
            
            _loc_7 = param1[_loc_10 + param2];
            _loc_9 = _loc_7.x;
            _loc_8 = _loc_5 - (_loc_6 - _loc_9) * (1 + this.adj);
            _loc_7.x = _loc_8;
            _loc_6 = _loc_9;
            _loc_5 = _loc_8;
            _loc_10++;
        }
        return;
    }// end function

}

