package com.ankamagames.tubul.types
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.tubul.events.*;
    import flash.events.*;
    import flash.utils.*;

    public class SoundSilence extends EventDispatcher
    {
        private var _silenceMin:Number;
        private var _silenceMax:Number;
        private var _timer:Timer;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundSilence));

        public function SoundSilence(param1:Number, param2:Number)
        {
            this.setSilence(param1, param2);
            return;
        }// end function

        public function get silenceMin() : Number
        {
            return this._silenceMin;
        }// end function

        public function get silenceMax() : Number
        {
            return this._silenceMax;
        }// end function

        public function get running() : Boolean
        {
            if (this._timer && this._timer.running)
            {
                return true;
            }
            return false;
        }// end function

        public function start() : void
        {
            if (this._timer && this._timer.running)
            {
                return;
            }
            var _loc_1:* = (Math.random() * (this._silenceMax - this._silenceMin) + this._silenceMin) * 1000 * 60;
            this._timer = new Timer(_loc_1, 1);
            if (!this._timer.hasEventListener(TimerEvent.TIMER))
            {
                this._timer.addEventListener(TimerEvent.TIMER, this.onTimerEnd);
            }
            this._timer.start();
            var _loc_2:* = new SoundSilenceEvent(SoundSilenceEvent.START);
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function stop() : void
        {
            if (!this.running)
            {
                return;
            }
            this._timer.stop();
            return;
        }// end function

        public function clean() : void
        {
            this.stop();
            if (this._timer == null)
            {
                return;
            }
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerEnd);
            this._timer = null;
            return;
        }// end function

        public function setSilence(param1:Number, param2:Number) : void
        {
            this._silenceMin = Math.min(param1, param2);
            this._silenceMax = Math.max(param1, param2);
            return;
        }// end function

        private function onTimerEnd(event:TimerEvent) : void
        {
            this.clean();
            var _loc_2:* = new SoundSilenceEvent(SoundSilenceEvent.COMPLETE);
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
