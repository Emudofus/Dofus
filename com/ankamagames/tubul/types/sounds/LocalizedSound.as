package com.ankamagames.tubul.types.sounds
{
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tubul.*;
    import com.ankamagames.tubul.interfaces.*;
    import flash.geom.*;

    public class LocalizedSound extends MP3SoundDofus implements ILocalizedSound
    {
        private var _pan:Number;
        private var _position:Point;
        private var _range:Number;
        private var _saturationRange:Number;
        private var _observerPosition:Point;
        private var _volumeMax:Number;

        public function LocalizedSound(param1:uint, param2:Uri, param3:Boolean)
        {
            super(param1, param2, param3);
            this._pan = 0;
            this.volumeMax = 1;
            this.updateObserverPosition(Tubul.getInstance().earPosition);
            return;
        }// end function

        public function get pan() : Number
        {
            return this._pan;
        }// end function

        public function set pan(param1:Number) : void
        {
            if (param1 < -1)
            {
                this._pan = -1;
                return;
            }
            if (param1 > 1)
            {
                this._pan = 1;
                return;
            }
            this._pan = param1;
            return;
        }// end function

        public function get range() : Number
        {
            return this._range;
        }// end function

        public function set range(param1:Number) : void
        {
            if (param1 < this._saturationRange)
            {
                param1 = this._saturationRange;
            }
            this._range = param1;
            return;
        }// end function

        public function get saturationRange() : Number
        {
            return this._saturationRange;
        }// end function

        public function set saturationRange(param1:Number) : void
        {
            if (param1 >= this._range)
            {
                param1 = this._range;
            }
            this._saturationRange = param1;
            return;
        }// end function

        public function get position() : Point
        {
            return this._position;
        }// end function

        public function set position(param1:Point) : void
        {
            this._position = param1;
            if (this._observerPosition)
            {
                this.updateSound();
            }
            return;
        }// end function

        public function get volumeMax() : Number
        {
            return this._volumeMax;
        }// end function

        public function set volumeMax(param1:Number) : void
        {
            if (param1 > 1)
            {
                param1 = 1;
            }
            if (param1 < 0)
            {
                param1 = 0;
            }
            this._volumeMax = param1;
            return;
        }// end function

        override public function get effectiveVolume() : Number
        {
            return busVolume * volume * currentFadeVolume * this.volumeMax;
        }// end function

        public function updateObserverPosition(param1:Point) : void
        {
            this._observerPosition = param1;
            if (this.position)
            {
                this.updateSound();
            }
            return;
        }// end function

        override protected function applyParam() : void
        {
            if (_soundWrapper == null)
            {
                return;
            }
            _soundWrapper.volume = this.effectiveVolume;
            _soundWrapper.pan = this._pan;
            return;
        }// end function

        private function updateSound() : void
        {
            var _loc_1:* = NaN;
            var _loc_10:* = NaN;
            _loc_1 = this._position.y + (this._position.y - this._observerPosition.y) * 2;
            var _loc_2:* = Math.abs(this._observerPosition.x - this._position.x);
            var _loc_3:* = Math.abs(this._observerPosition.y - _loc_1);
            var _loc_4:* = _loc_2 * _loc_2;
            var _loc_5:* = _loc_3 * _loc_3;
            var _loc_6:* = Math.sqrt(_loc_4 + _loc_5);
            var _loc_7:* = this._range * this._range;
            var _loc_8:* = this._saturationRange * this._saturationRange;
            if (_loc_6 <= this._saturationRange)
            {
                volume = 1;
            }
            else if (_loc_6 <= this._range)
            {
                _loc_10 = (this._range - _loc_6) / (this._range - this._saturationRange);
                volume = _loc_10;
            }
            else
            {
                volume = 0;
            }
            var _loc_9:* = 640;
            this.pan = this._position.x / _loc_9 - 1;
            if (_soundLoaded)
            {
                this.applyParam();
            }
            return;
        }// end function

    }
}
