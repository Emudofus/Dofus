package com.ankamagames.tiphon.display
{
    import flash.display.*;
    import flash.utils.*;

    public class RasterizedAnimation extends TiphonAnimation
    {
        protected var _target:MovieClip;
        private var _targetName:String;
        private var _bitmap:Bitmap;
        private var _smoothing:Boolean;
        protected var _totalFrames:uint;
        private var _currentIndex:int = -1;
        public static var FRAMES:Dictionary = new Dictionary(false);

        public function RasterizedAnimation(param1:MovieClip, param2:String)
        {
            this._target = param1;
            this._targetName = "[" + this._target.scaleX + "," + this._target.scaleY + "]" + param1.toString() + " [" + param2 + "]";
            this._totalFrames = this._target.totalFrames;
            var _loc_3:* = FRAMES[this._targetName];
            if (_loc_3)
            {
                _loc_3.death = 0;
                _loc_3.life = _loc_3.life + 2;
                if (_loc_3.life > _loc_3.maxLife)
                {
                    _loc_3.life = _loc_3.maxLife;
                }
            }
            else
            {
                FRAMES[this._targetName] = new RasterizedFrameList(this._targetName, 5);
            }
            return;
        }// end function

        override public function get totalFrames() : int
        {
            return this._totalFrames;
        }// end function

        override public function get currentFrame() : int
        {
            return (this._currentIndex + 1);
        }// end function

        public function get smoothing() : Boolean
        {
            return this._smoothing;
        }// end function

        public function set smoothing(param1:Boolean) : void
        {
            this._smoothing = param1;
            if (this._bitmap)
            {
                this._bitmap.smoothing = param1;
            }
            return;
        }// end function

        override public function gotoAndStop(param1:Object, param2:String = null) : void
        {
            var _loc_3:* = param1 as uint;
            if (_loc_3 > 0)
            {
                _loc_3 = _loc_3 - 1;
            }
            this.displayFrame(_loc_3 % this._totalFrames);
            return;
        }// end function

        override public function gotoAndPlay(param1:Object, param2:String = null) : void
        {
            this.gotoAndStop(param1, param2);
            this.play();
            return;
        }// end function

        override public function play() : void
        {
            return;
        }// end function

        override public function stop() : void
        {
            return;
        }// end function

        override public function nextFrame() : void
        {
            this.displayFrame((this._currentIndex + 1) % this._totalFrames);
            return;
        }// end function

        override public function prevFrame() : void
        {
            this.displayFrame(this._currentIndex > 0 ? ((this._currentIndex - 1)) : ((this._totalFrames - 1)));
            return;
        }// end function

        protected function displayFrame(param1:uint) : Boolean
        {
            if (param1 == this._currentIndex)
            {
                return false;
            }
            var _loc_2:* = FRAMES[this._targetName].frameList;
            var _loc_3:* = _loc_2[param1] as RasterizedFrame;
            if (!_loc_3)
            {
                _loc_3 = new RasterizedFrame(this._target, param1);
                _loc_2[param1] = _loc_3;
            }
            if (!this._bitmap)
            {
                this._bitmap = new Bitmap(_loc_3.bitmapData);
                this._bitmap.smoothing = this._smoothing;
                addChild(this._bitmap);
            }
            else
            {
                this._bitmap.bitmapData = _loc_3.bitmapData;
            }
            this._bitmap.x = _loc_3.x;
            this._bitmap.y = _loc_3.y;
            this._currentIndex = param1;
            return true;
        }// end function

        public static function countFrames() : Object
        {
            var _loc_3:RasterizedFrameList = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            for each (_loc_3 in FRAMES)
            {
                
                _loc_1++;
                _loc_4 = _loc_3.frameList.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (_loc_3.frameList[_loc_5])
                    {
                        _loc_2++;
                    }
                    _loc_5++;
                }
            }
            return {animations:_loc_1, frames:_loc_2};
        }// end function

        public static function optimize(param1:int = 1) : void
        {
            var _loc_2:RasterizedFrameList = null;
            for each (_loc_2 in FRAMES)
            {
                
                _loc_2.death = _loc_2.death + param1;
                _loc_2.life = _loc_2.life - _loc_2.death;
                if (_loc_2.life < 1)
                {
                    delete FRAMES[_loc_2.key];
                }
            }
            return;
        }// end function

    }
}
