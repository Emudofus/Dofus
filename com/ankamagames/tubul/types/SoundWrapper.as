package com.ankamagames.tubul.types
{
    import com.ankamagames.tubul.*;
    import com.ankamagames.tubul.events.*;
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;

    public class SoundWrapper extends EventDispatcher
    {
        private var _currentLoop:uint;
        private var _snd:Sound;
        private var _loops:int;
        private var _length:Number;
        private var _stDic:Dictionary;
        private var _duration:Number;
        private var _endOfFileEventDispatched:Boolean = false;
        private var _notify:Boolean = false;
        private var _notifyTime:Number;
        var _volume:Number = 1;
        var _leftToLeft:Number = 1;
        var _rightToLeft:Number = 0;
        var _rightToRight:Number = 1;
        var _leftToRight:Number = 0;
        var _pan:Number = 0;
        var soundData:ByteArray;
        var hadBeenCut:Boolean;
        var _extractFinished:Boolean;

        public function SoundWrapper(param1:Sound, param2:int = 1)
        {
            this._snd = param1;
            this._loops = param2;
            this._length = param1.length;
            this.currentLoop = 0;
            if (this._snd != null)
            {
                this._duration = Math.floor(this._snd.length) / 1000;
            }
            return;
        }// end function

        public function get currentLoop() : uint
        {
            return this._currentLoop;
        }// end function

        public function set currentLoop(param1:uint) : void
        {
            this._currentLoop = param1;
            var _loc_2:* = new LoopEvent(LoopEvent.SOUND_LOOP);
            _loc_2.loop = this._currentLoop;
            _loc_2.sound = this;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get position() : Number
        {
            var _loc_2:* = null;
            if (this.soundData == null && this.sound == null)
            {
                return -1;
            }
            var _loc_1:* = 0;
            if (this.soundData != null)
            {
                _loc_1 = Math.round(this.soundData.position / (8 * 44.1)) / 1000;
            }
            else
            {
                _loc_2 = Tubul.getInstance().soundMerger.getSoundChannel(this);
                if (_loc_2 != null)
                {
                    _loc_1 = Math.round(_loc_2.position) / 1000;
                }
            }
            return _loc_1;
        }// end function

        public function get duration() : Number
        {
            return this._duration;
        }// end function

        public function get sound() : Sound
        {
            return this._snd;
        }// end function

        public function get loops() : int
        {
            return this._loops;
        }// end function

        public function set loops(param1:int) : void
        {
            this._loops = param1;
            return;
        }// end function

        public function get length() : Number
        {
            return this._length;
        }// end function

        public function get volume() : Number
        {
            return this._volume;
        }// end function

        public function set volume(param1:Number) : void
        {
            this._volume = param1;
            var _loc_2:* = this.getSoundTransform();
            _loc_2.volume = this._volume;
            this.applySoundTransform(_loc_2);
            return;
        }// end function

        public function get leftToLeft() : Number
        {
            return this._leftToLeft;
        }// end function

        public function set leftToLeft(param1:Number) : void
        {
            this._leftToLeft = param1;
            var _loc_2:* = this.getSoundTransform();
            _loc_2.leftToLeft = this._leftToLeft;
            this.applySoundTransform(_loc_2);
            return;
        }// end function

        public function get rightToLeft() : Number
        {
            return this._rightToLeft;
        }// end function

        public function set rightToLeft(param1:Number) : void
        {
            this._rightToLeft = param1;
            var _loc_2:* = this.getSoundTransform();
            _loc_2.rightToLeft = this._rightToLeft;
            this.applySoundTransform(_loc_2);
            return;
        }// end function

        public function get rightToRight() : Number
        {
            return this._rightToRight;
        }// end function

        public function set rightToRight(param1:Number) : void
        {
            this._rightToRight = param1;
            var _loc_2:* = this.getSoundTransform();
            _loc_2.rightToRight = this._rightToRight;
            this.applySoundTransform(_loc_2);
            return;
        }// end function

        public function get leftToRight() : Number
        {
            return this._leftToRight;
        }// end function

        public function set leftToRight(param1:Number) : void
        {
            this._leftToRight = param1;
            var _loc_2:* = this.getSoundTransform();
            _loc_2.leftToRight = this._leftToRight;
            this.applySoundTransform(_loc_2);
            return;
        }// end function

        public function get pan() : Number
        {
            return this._pan;
        }// end function

        public function set pan(param1:Number) : void
        {
            this._pan = param1;
            var _loc_2:* = this.getSoundTransform();
            _loc_2.pan = this._pan;
            this.applySoundTransform(_loc_2);
            return;
        }// end function

        function extractFinished() : void
        {
            this._extractFinished = true;
            this._snd = null;
            return;
        }// end function

        public function checkSoundPosition() : void
        {
            var _loc_1:* = null;
            if (this._notify == false)
            {
                return;
            }
            if (this.duration - this.position < this._notifyTime + 0.5)
            {
                if (this.currentLoop == (this._loops - 1) && this._endOfFileEventDispatched == false)
                {
                    _loc_1 = new SoundWrapperEvent(SoundWrapperEvent.SOON_END_OF_FILE);
                    dispatchEvent(_loc_1);
                    this._endOfFileEventDispatched = true;
                }
            }
            else
            {
                this._endOfFileEventDispatched = false;
            }
            return;
        }// end function

        public function getSoundTransform() : SoundTransform
        {
            var _loc_2:* = undefined;
            if (this._stDic)
            {
                for (_loc_2 in this._stDic)
                {
                    
                    return _loc_2;
                }
            }
            if (!this._stDic)
            {
                this._stDic = new Dictionary(true);
            }
            var _loc_1:* = new SoundTransform(this._volume, this._pan);
            _loc_1.leftToLeft = this._leftToLeft;
            _loc_1.leftToRight = this._leftToRight;
            _loc_1.rightToLeft = this._rightToLeft;
            _loc_1.rightToRight = this._rightToRight;
            this._stDic[_loc_1] = true;
            return _loc_1;
        }// end function

        public function notifyWhenEndOfFile(param1:Boolean = false, param2:Number = -1) : void
        {
            this._notify = param1;
            if (param1 && param2 <= 0)
            {
                this._notify = false;
                return;
            }
            this._notifyTime = param2;
            return;
        }// end function

        private function applySoundTransform(param1:SoundTransform) : void
        {
            var _loc_2:* = Tubul.getInstance().soundMerger.getSoundChannel(this);
            if (_loc_2 != null)
            {
                _loc_2.soundTransform = param1;
            }
            return;
        }// end function

    }
}
