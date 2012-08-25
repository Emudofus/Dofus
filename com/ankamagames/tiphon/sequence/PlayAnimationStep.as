package com.ankamagames.tiphon.sequence
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import flash.events.*;
    import flash.utils.*;

    public class PlayAnimationStep extends AbstractSequencable
    {
        private var _target:TiphonSprite;
        private var _animationName:String;
        private var _loop:int;
        private var _endEvent:String;
        private var _waitEvent:Boolean;
        private var _lastAnimName:String;
        private var _lastSpriteAnimation:String;
        private var _backToLastAnimationAtEnd:Boolean;
        private var _callbackExecuted:Boolean = false;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayAnimationStep));

        public function PlayAnimationStep(param1:TiphonSprite, param2:String, param3:Boolean = true, param4:Boolean = true, param5:String = "animation_event_end", param6:int = 1)
        {
            this._endEvent = param5;
            this._target = param1;
            this._animationName = param2;
            this._loop = param6;
            this._waitEvent = param4;
            this._backToLastAnimationAtEnd = param3;
            return;
        }// end function

        public function get target() : TiphonSprite
        {
            return this._target;
        }// end function

        public function get animation() : String
        {
            return this._animationName;
        }// end function

        public function set waitEvent(param1:Boolean) : void
        {
            this._waitEvent = param1;
            return;
        }// end function

        override public function start() : void
        {
            var _loc_2:String = null;
            if (this._target.isShowingOnlyBackground())
            {
                this._callbackExecuted = true;
                executeCallbacks();
                return;
            }
            if (this._endEvent != TiphonEvent.ANIMATION_END)
            {
                this._target.addEventListener(this._endEvent, this.onCustomEvent);
            }
            this._target.addEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
            this._target.addEventListener(TiphonEvent.RENDER_FAILED, this.onAnimationFail);
            this._target.addEventListener(TiphonEvent.SPRITE_INIT_FAILED, this.onAnimationFail);
            this._lastAnimName = this._target.getAnimation();
            this._target.overrideNextAnimation = true;
            var _loc_1:* = this._target.getAvaibleDirection(this._animationName, true);
            if (!_loc_1[this._target.getDirection()])
            {
                for (_loc_2 in _loc_1)
                {
                    
                    if (_loc_1[_loc_2])
                    {
                        this._target.setDirection(uint(_loc_2));
                        break;
                    }
                }
            }
            this._target.setAnimation(this._animationName);
            this._lastSpriteAnimation = this._target.getAnimation();
            if (!this._waitEvent)
            {
                this._callbackExecuted = true;
                executeCallbacks();
            }
            return;
        }// end function

        private function onCustomEvent(event:TiphonEvent) : void
        {
            this._target.removeEventListener(this._endEvent, this.onCustomEvent);
            this._callbackExecuted = true;
            executeCallbacks();
            return;
        }// end function

        private function onAnimationFail(event:TiphonEvent) : void
        {
            if (this._endEvent != TiphonEvent.ANIMATION_END)
            {
                this.onCustomEvent(event);
            }
            this.onAnimationEnd(event);
            return;
        }// end function

        private function onAnimationEnd(event:TiphonEvent) : void
        {
            var _loc_2:String = null;
            if (this._target)
            {
                if (this._endEvent != TiphonEvent.ANIMATION_END)
                {
                    this._target.removeEventListener(this._endEvent, this.onCustomEvent);
                }
                this._target.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                this._target.removeEventListener(TiphonEvent.RENDER_FAILED, this.onAnimationEnd);
                this._target.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED, this.onAnimationFail);
                _loc_2 = this._target.getAnimation();
                if (this._backToLastAnimationAtEnd)
                {
                    if (_loc_2 && this._lastSpriteAnimation && this._lastSpriteAnimation.indexOf(_loc_2) != -1)
                    {
                        this._target.setAnimation("AnimStatique");
                    }
                }
            }
            if (!this._callbackExecuted)
            {
                executeCallbacks();
            }
            return;
        }// end function

        override public function toString() : String
        {
            return "play " + this._animationName + " on " + (this._target ? (this._target.name) : (this._target));
        }// end function

        override protected function onTimeOut(event:TimerEvent) : void
        {
            this._callbackExecuted = true;
            this.onAnimationEnd(null);
            super.onTimeOut(event);
            return;
        }// end function

    }
}
