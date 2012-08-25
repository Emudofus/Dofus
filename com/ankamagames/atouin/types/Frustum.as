package com.ankamagames.atouin.types
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Frustum extends Rectangle
    {
        private var _marginLeft:int;
        private var _marginRight:int;
        private var _marginTop:int;
        private var _marginBottom:int;
        public var scale:Number;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Frustum));
        public static const MAX_WIDTH:Number = 1247;
        public static const MAX_HEIGHT:Number = 881.5;
        public static const RATIO:Number = 1.41463;

        public function Frustum(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0)
        {
            this._marginTop = param2;
            this._marginRight = param1;
            this._marginBottom = param4;
            this._marginLeft = param3;
            this.refresh();
            return;
        }// end function

        public function refresh() : Frustum
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            width = MAX_WIDTH + this._marginRight + this._marginLeft;
            height = MAX_HEIGHT + this._marginTop + this._marginBottom;
            var _loc_1:* = StageShareManager.startHeight / height;
            width = MAX_WIDTH * _loc_1;
            height = MAX_HEIGHT * _loc_1;
            if (width / height < RATIO)
            {
                height = width / RATIO;
            }
            if (width / height > RATIO)
            {
                width = height * RATIO;
            }
            this.scale = _loc_1;
            var _loc_2:* = StageShareManager.startWidth - MAX_WIDTH * this.scale + this._marginLeft - this._marginRight;
            var _loc_3:* = StageShareManager.startHeight - MAX_HEIGHT * this.scale + this._marginTop - this._marginBottom;
            if (this._marginLeft && this._marginRight)
            {
                _loc_4 = (this._marginLeft + this._marginRight) / this._marginLeft;
            }
            else if (this._marginLeft)
            {
                _loc_4 = 2 + _loc_2 / this._marginLeft;
            }
            else if (this._marginRight)
            {
                _loc_4 = 2 - _loc_2 / this._marginRight;
            }
            else
            {
                _loc_4 = 2;
            }
            if (this._marginTop && this._marginBottom)
            {
                _loc_5 = (this._marginTop + this._marginBottom) / this._marginTop;
            }
            else if (this._marginTop)
            {
                _loc_5 = 2 + _loc_3 / this._marginTop;
            }
            else if (this._marginBottom)
            {
                _loc_5 = _loc_3 / this._marginBottom - 2;
            }
            else
            {
                _loc_5 = 2;
            }
            x = _loc_2 / _loc_4;
            y = _loc_3 / _loc_5;
            return this;
        }// end function

        override public function toString() : String
        {
            return super.toString() + " scale=" + this.scale;
        }// end function

    }
}
