package com.ankamagames.jerakine.sequencer
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.events.*;
    import flash.utils.*;

    public class AbstractSequencable extends EventDispatcher implements ISequencable
    {
        private var _aListener:Array;
        private var _timeOut:Timer;
        private var _castingSpellId:int = -1;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractSequencable));

        public function AbstractSequencable()
        {
            this._aListener = new Array();
            return;
        }// end function

        public function start() : void
        {
            return;
        }// end function

        public function addListener(param1:ISequencableListener) : void
        {
            if (!this._timeOut)
            {
                this._timeOut = new Timer(5000, 1);
                this._timeOut.addEventListener(TimerEvent.TIMER, this.onTimeOut);
                this._timeOut.start();
            }
            this._aListener.push(param1);
            return;
        }// end function

        protected function executeCallbacks() : void
        {
            var _loc_1:* = null;
            FightProfiler.getInstance().stop();
            if (this._timeOut)
            {
                this._timeOut.removeEventListener(TimerEvent.TIMER, this.onTimeOut);
                this._timeOut.reset();
                this._timeOut = null;
            }
            for each (_loc_1 in this._aListener)
            {
                
                if (_loc_1)
                {
                    _loc_1.stepFinished();
                }
            }
            return;
        }// end function

        public function removeListener(param1:ISequencableListener) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aListener.length)
            {
                
                if (this._aListener[_loc_2] == param1)
                {
                    this._aListener = this._aListener.slice(0, _loc_2).concat(this._aListener.slice((_loc_2 + 1), this._aListener.length));
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function toString() : String
        {
            return getQualifiedClassName(this);
        }// end function

        public function clear() : void
        {
            if (this._timeOut)
            {
                this._timeOut.stop();
            }
            this._timeOut = null;
            this._aListener = null;
            return;
        }// end function

        public function get castingSpellId() : int
        {
            return this._castingSpellId;
        }// end function

        public function set castingSpellId(param1:int) : void
        {
            this._castingSpellId = param1;
            return;
        }// end function

        protected function onTimeOut(event:TimerEvent) : void
        {
            this.executeCallbacks();
            _log.error("Time out sur la step " + this);
            return;
        }// end function

    }
}
