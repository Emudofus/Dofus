package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MapAreaShape extends MapElement
    {
        public var shape:Texture;
        private var _lineColor:uint;
        private var _fillColor:uint;
        private var _duration:int;
        private var _t0:int;
        private var _redMultiplier:Number = 1;
        private var _greenMultiplier:Number = 1;
        private var _blueMultiplier:Number = 1;
        private var _alphaMultiplier:Number = 0;
        private var _redOffset:Number = 0;
        private var _greenOffset:Number = 0;
        private var _blueOffset:Number = 0;
        private var _alphaOffset:Number = 0;
        private var _lastRedMultiplier:Number;
        private var _lastGreenMultiplier:Number;
        private var _lastBlueMultiplier:Number;
        private var _lastAlphaMultiplier:Number;
        private var _lastRedOffset:Number;
        private var _lastGreenOffset:Number;
        private var _lastBlueOffset:Number;
        private var _lastAlphaOffset:Number;

        public function MapAreaShape(param1:String, param2:String, param3:Texture, param4:int, param5:int, param6:uint, param7:uint, param8)
        {
            this._lineColor = param6;
            this._fillColor = param7;
            super(param1, param4, param5, param2, param8);
            this.shape = param3;
            param3.transform.colorTransform = new ColorTransform(1, 1, 1, 0);
            return;
        }// end function

        public function get lineColor() : uint
        {
            return this._lineColor;
        }// end function

        public function get fillColor() : uint
        {
            return this._fillColor;
        }// end function

        public function colorTransform(param1:int, param2:Number = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0) : void
        {
            this._lastAlphaMultiplier = this._alphaMultiplier;
            this._lastAlphaOffset = this._alphaOffset;
            this._lastBlueMultiplier = this._blueMultiplier;
            this._lastBlueOffset = this._blueOffset;
            this._lastGreenMultiplier = this._greenMultiplier;
            this._lastGreenOffset = this._greenOffset;
            this._lastRedMultiplier = this._redMultiplier;
            this._lastRedOffset = this._redOffset;
            this._redMultiplier = param2;
            this._blueMultiplier = param4;
            this._greenMultiplier = param3;
            this._alphaMultiplier = param5;
            this._redOffset = param6;
            this._greenOffset = param7;
            this._blueOffset = param8;
            this._alphaOffset = param9;
            if (this._alphaMultiplier != 0)
            {
                this.shape.visible = true;
            }
            if (param1 == 0)
            {
                this.shape.transform.colorTransform = new ColorTransform(param2, param3, param4, param5, param6, param7, param8, param9);
            }
            else
            {
                this._t0 = getTimer();
                this._duration = param1;
                EnterFrameDispatcher.addEventListener(this.onEnterFrame, "AreaShapeColorTransform", 20);
            }
            return;
        }// end function

        override public function remove() : void
        {
            this.shape.removeEventListener("enterFrame", this.onEnterFrame);
            if (this.shape.parent)
            {
                this.shape.parent.removeChild(this.shape);
            }
            this.shape = null;
            super.remove();
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = (getTimer() - this._t0) / this._duration;
            if (this.shape)
            {
                if (_loc_2 >= 1)
                {
                    EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
                    if (this._alphaMultiplier == 0)
                    {
                        this.shape.visible = false;
                    }
                    else
                    {
                        this.shape.visible = true;
                    }
                    this.shape.transform.colorTransform = new ColorTransform(this._redMultiplier, this._greenMultiplier, this._blueMultiplier, this._alphaMultiplier, this._redOffset, this._greenOffset, this._blueOffset, this._alphaOffset);
                }
                else
                {
                    this.shape.transform.colorTransform = new ColorTransform(this._lastRedMultiplier + (this._redMultiplier - this._lastRedMultiplier) * _loc_2, this._lastGreenMultiplier + (this._greenMultiplier - this._lastGreenMultiplier) * _loc_2, this._lastBlueMultiplier + (this._blueMultiplier - this._lastBlueMultiplier) * _loc_2, this._lastAlphaMultiplier + (this._alphaMultiplier - this._lastAlphaMultiplier) * _loc_2, this._lastRedOffset + (this._redOffset - this._lastRedOffset) * _loc_2, this._lastGreenOffset + (this._greenOffset - this._lastGreenOffset) * _loc_2, this._lastBlueOffset + (this._blueOffset - this._lastBlueOffset) * _loc_2, this._lastAlphaOffset + (this._alphaOffset - this._lastAlphaOffset) * _loc_2);
                }
            }
            return;
        }// end function

    }
}
