package com.ankamagames.berilia.types.graphic
{
    import flash.display.*;
    import flash.geom.*;
    import gs.*;
    import gs.events.*;

    public class MapGroupElement extends Sprite
    {
        private var _icons:Array;
        private var _initialPos:Array;
        private var _mapWidth:uint;
        private var _mapHeight:uint;
        private var _tween:Array;
        private var _shape:Shape;
        private var _open:Boolean;

        public function MapGroupElement(param1:uint, param2:uint)
        {
            this._icons = new Array();
            this._mapWidth = param1;
            this._mapHeight = param2;
            doubleClickEnabled = true;
            return;
        }// end function

        public function get opened() : Boolean
        {
            return this._open;
        }// end function

        public function open() : void
        {
            var _loc_8:* = null;
            var _loc_1:* = this._icons.length * 5;
            var _loc_2:* = new Point(0, 0);
            if (_loc_1 < this._mapWidth * 3 / 4)
            {
                _loc_1 = this._mapWidth * 3 / 4;
            }
            if (_loc_1 < this._mapHeight * 3 / 4)
            {
                _loc_1 = this._mapHeight * 3 / 4;
            }
            var _loc_3:* = Math.min(0.1 * this._icons.length, 0.5);
            if (!this._shape)
            {
                this._shape = new Shape();
            }
            else
            {
                this._shape.graphics.clear();
            }
            graphics.beginFill(0, 0);
            graphics.drawCircle(0, 0, _loc_1 + 40);
            this._shape.alpha = 0;
            this._shape.graphics.beginGradientFill(GradientType.RADIAL, [16777215, 16777215], [0, 0.6], [0, 127]);
            this._shape.graphics.drawCircle(_loc_2.x, _loc_2.y, _loc_1 + 10);
            this._shape.graphics.beginFill(16777215, 0.3);
            this._shape.graphics.drawCircle(_loc_2.x, _loc_2.y, Math.min(this._mapWidth, this._mapHeight) / 3);
            super.addChildAt(this._shape, 0);
            this.killAllTween();
            this._tween.push(new TweenMax(this._shape, _loc_3, {alpha:1}));
            var _loc_4:* = false;
            if (!this._initialPos)
            {
                this._initialPos = new Array();
                _loc_4 = true;
            }
            var _loc_5:* = Math.PI * 2 / this._icons.length;
            var _loc_6:* = Math.PI / 2 + Math.PI / 4;
            var _loc_7:* = this._icons.length - 1;
            while (_loc_7 >= 0)
            {
                
                _loc_8 = this._icons[_loc_7];
                if (_loc_4)
                {
                    this._initialPos.push({icon:_loc_8, x:_loc_8.x, y:_loc_8.y});
                }
                this._tween.push(new TweenMax(_loc_8, _loc_3, {x:Math.cos(_loc_5 * _loc_7 + _loc_6) * _loc_1 + _loc_2.x, y:Math.sin(_loc_5 * _loc_7 + _loc_6) * _loc_1 + _loc_2.y}));
                _loc_7 = _loc_7 - 1;
            }
            this._open = true;
            return;
        }// end function

        public function close() : void
        {
            var _loc_1:* = null;
            graphics.clear();
            this.killAllTween();
            this._tween.push(new TweenMax(this._shape, 0.2, {alpha:0, onCompleteListener:this.shapeTweenFinished}));
            for each (_loc_1 in this._initialPos)
            {
                
                this._tween.push(new TweenMax(_loc_1.icon, 0.2, {x:_loc_1.x, y:_loc_1.y}));
            }
            this._open = false;
            return;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            super.addChild(param1);
            this._icons.push(param1);
            return param1;
        }// end function

        public function remove() : void
        {
            while (numChildren)
            {
                
                removeChildAt(0);
            }
            this._icons = null;
            this.killAllTween();
            return;
        }// end function

        private function killAllTween() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._tween)
            {
                
                _loc_1.clear();
                _loc_1.gc = true;
            }
            this._tween = new Array();
            return;
        }// end function

        private function shapeTweenFinished(event:TweenEvent) : void
        {
            this._shape.graphics.clear();
            return;
        }// end function

        public function get icons() : Array
        {
            return this._icons;
        }// end function

    }
}
