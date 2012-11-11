package flashx.textLayout.compose
{
    import __AS3__.vec.*;
    import flash.text.engine.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.formats.*;

    public class Parcel extends Object
    {
        public var x:Number;
        public var y:Number;
        public var width:Number;
        public var height:Number;
        public var logicalWidth:Number;
        private var _controller:ContainerController;
        private var _columnIndex:int;
        private var _fitAny:Boolean;
        private var _composeToPosition:Boolean;
        private var _left:Edge;
        private var _right:Edge;
        private var _maxWidth:Number;
        private const EDGE_CACHE_MAX:int = 6;
        private var _verticalText:Boolean;
        private static var edgeCache:Vector.<Edge>;

        public function Parcel(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number, param6:ContainerController, param7:int)
        {
            this.initialize(param1, param2, param3, param4, param5, param6, param7);
            return;
        }// end function

        public function initialize(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number, param6:ContainerController, param7:int) : Parcel
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            this.x = param2;
            this.y = param3;
            this.width = param4;
            this.height = param5;
            this.logicalWidth = param1 ? (param5) : (param4);
            this._verticalText = param1;
            this._controller = param6;
            this._columnIndex = param7;
            this._fitAny = false;
            this._composeToPosition = false;
            if (param1)
            {
                _loc_8 = param3;
                this._maxWidth = param5;
            }
            else
            {
                _loc_8 = param2;
                this._maxWidth = param4;
            }
            this._left = this.allocateEdge(_loc_8);
            this._right = this.allocateEdge(_loc_8 + this._maxWidth);
            return this;
        }// end function

        function releaseAnyReferences() : void
        {
            this._controller = null;
            this.deallocateEdge(this._left);
            this.deallocateEdge(this._right);
            return;
        }// end function

        private function allocateEdge(param1:Number) : Edge
        {
            if (!edgeCache)
            {
                edgeCache = new Vector.<Edge>;
            }
            var _loc_2:* = edgeCache.length > 0 ? (edgeCache.pop()) : (new Edge());
            _loc_2.initialize(param1);
            return _loc_2;
        }// end function

        private function deallocateEdge(param1:Edge) : void
        {
            if (edgeCache.length < this.EDGE_CACHE_MAX)
            {
                edgeCache.push(param1);
            }
            return;
        }// end function

        public function get bottom() : Number
        {
            return this.y + this.height;
        }// end function

        public function get right() : Number
        {
            return this.x + this.width;
        }// end function

        public function get controller() : ContainerController
        {
            return this._controller;
        }// end function

        public function get columnIndex() : int
        {
            return this._columnIndex;
        }// end function

        public function get fitAny() : Boolean
        {
            return this._fitAny;
        }// end function

        public function set fitAny(param1:Boolean) : void
        {
            this._fitAny = param1;
            return;
        }// end function

        public function get composeToPosition() : Boolean
        {
            return this._composeToPosition;
        }// end function

        public function set composeToPosition(param1:Boolean) : void
        {
            this._composeToPosition = param1;
            return;
        }// end function

        private function getLogicalHeight() : Number
        {
            if (this._verticalText)
            {
                return this._controller.measureWidth ? (TextLine.MAX_LINE_WIDTH) : (this.width);
            }
            else
            {
            }
            return this._controller.measureHeight ? (TextLine.MAX_LINE_WIDTH) : (this.height);
        }// end function

        public function applyClear(param1:String, param2:Number, param3:String) : Number
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = param2;
            if (param1 == ClearFloats.START)
            {
                param1 = param3 == Direction.LTR ? (ClearFloats.LEFT) : (ClearFloats.RIGHT);
            }
            else if (param1 == ClearFloats.END)
            {
                param1 = param3 == Direction.RTL ? (ClearFloats.LEFT) : (ClearFloats.RIGHT);
            }
            while (_loc_6 < Number.MAX_VALUE)
            {
                
                _loc_4 = this._left.getMaxForSpan(_loc_6, (_loc_6 + 1));
                if (_loc_4 > 0 && (param1 == ClearFloats.BOTH || param1 == ClearFloats.LEFT))
                {
                    _loc_6 = this._left.findNextTransition(_loc_6);
                    continue;
                }
                _loc_5 = this._right.getMaxForSpan(_loc_6, (_loc_6 + 1));
                if (_loc_5 > 0 && (param1 == ClearFloats.BOTH || param1 == ClearFloats.RIGHT))
                {
                    _loc_6 = this._right.findNextTransition(_loc_6);
                    continue;
                }
                return _loc_6 - param2;
            }
            return this._verticalText ? (this.width) : (this.height);
        }// end function

        public function fitsInHeight(param1:Number, param2:Number) : Boolean
        {
            return this.composeToPosition || param1 + param2 <= this.getLogicalHeight();
        }// end function

        public function getLineSlug(param1:Slug, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean, param10:Boolean) : Boolean
        {
            if (!this.fitsInHeight(param2, param5))
            {
                return false;
            }
            param1.height = param3;
            while (param2 < Number.MAX_VALUE)
            {
                
                param1.depth = param2;
                param1.leftMargin = this._left.getMaxForSpan(param1.depth, param1.depth + param3);
                param1.wrapsKnockOut = param1.leftMargin != 0;
                if (param6 > 0)
                {
                    param1.leftMargin = Math.max(param6, param1.leftMargin);
                }
                else
                {
                    param1.leftMargin = param1.leftMargin + param6;
                }
                param1.rightMargin = this._right.getMaxForSpan(param1.depth, param1.depth + param3);
                param1.wrapsKnockOut = param1.wrapsKnockOut || param1.rightMargin != 0;
                if (param7 > 0)
                {
                    param1.rightMargin = Math.max(param7, param1.rightMargin);
                }
                else
                {
                    param1.rightMargin = param1.rightMargin + param7;
                }
                if (param8)
                {
                    if (param9)
                    {
                        param1.leftMargin = param1.leftMargin + param8;
                    }
                    else
                    {
                        param1.rightMargin = param1.rightMargin + param8;
                    }
                }
                if (param10 || this._verticalText && this._controller.measureHeight || !this._verticalText && this._controller.measureWidth)
                {
                    param1.width = TextLine.MAX_LINE_WIDTH;
                }
                else
                {
                    param1.width = this.logicalWidth - (param1.leftMargin + param1.rightMargin);
                }
                if (!param4 || param1.width >= param4)
                {
                    break;
                }
                param2 = this.findNextTransition(param2);
            }
            return param2 < Number.MAX_VALUE;
        }// end function

        public function knockOut(param1:Number, param2:Number, param3:Number, param4:Boolean) : void
        {
            var _loc_5:* = param4 ? (this._left) : (this._right);
            (param4 ? (this._left) : (this._right)).addSpan(param1, param2, param3);
            return;
        }// end function

        public function removeKnockOut(param1:Number, param2:Number, param3:Number, param4:Boolean) : void
        {
            var _loc_5:* = param4 ? (this._left) : (this._right);
            (param4 ? (this._left) : (this._right)).removeSpan(param1, param2, param3);
            return;
        }// end function

        public function isRectangular() : Boolean
        {
            return this._left.numSpans <= 0 && this._right.numSpans <= 0;
        }// end function

        public function findNextTransition(param1:Number) : Number
        {
            return Math.min(this._left.findNextTransition(param1), this._right.findNextTransition(param1));
        }// end function

    }
}

import __AS3__.vec.*;

import flash.text.engine.*;

import flashx.textLayout.container.*;

import flashx.textLayout.formats.*;

class Edge extends Object
{
    private var _xbase:Number;
    private var _spanList:Vector.<Span>;

    function Edge()
    {
        this._spanList = new Vector.<Span>;
        return;
    }// end function

    public function initialize(param1:Number) : void
    {
        this._xbase = param1;
        this._spanList.length = 0;
        return;
    }// end function

    public function get base() : Number
    {
        return this._xbase;
    }// end function

    public function addSpan(param1:Number, param2:Number, param3:Number) : void
    {
        this._spanList.push(new Span(param1, param2, param3));
        return;
    }// end function

    public function removeSpan(param1:Number, param2:Number, param3:Number) : void
    {
        var _loc_4:* = 0;
        while (_loc_4 < this._spanList.length)
        {
            
            if (this._spanList[_loc_4].equals(param1, param2, param3))
            {
                this._spanList.splice(_loc_4, 1);
                return;
            }
            _loc_4++;
        }
        return;
    }// end function

    public function get numSpans() : int
    {
        return this._spanList.length;
    }// end function

    public function getMaxForSpan(param1:Number, param2:Number) : Number
    {
        var _loc_4:* = null;
        var _loc_3:* = 0;
        for each (_loc_4 in this._spanList)
        {
            
            if (_loc_4.x > _loc_3 && _loc_4.overlapsInY(param1, param2))
            {
                _loc_3 = _loc_4.x;
            }
        }
        return _loc_3;
    }// end function

    public function findNextTransition(param1:Number) : Number
    {
        var _loc_3:* = null;
        var _loc_2:* = Number.MAX_VALUE;
        for each (_loc_3 in this._spanList)
        {
            
            if (_loc_3.ymin > param1 && _loc_3.ymin < _loc_2)
            {
                _loc_2 = _loc_3.ymin;
            }
            if (_loc_3.ymax > param1 && _loc_3.ymax < _loc_2)
            {
                _loc_2 = _loc_3.ymax;
            }
        }
        return _loc_2;
    }// end function

}

