package org.flintparticles.common.counters
{
    import flash.utils.*;
    import org.flintparticles.common.counters.*;
    import org.flintparticles.common.emitters.*;

    public class PerformanceAdjusted extends Object implements Counter
    {
        private var _timeToNext:Number;
        private var _rateMin:Number;
        private var _rateMax:Number;
        private var _target:Number;
        private var _rate:Number;
        private var _times:Array;
        private var _timeToRateCheck:Number;
        private var _stop:Boolean;

        public function PerformanceAdjusted(param1:Number, param2:Number, param3:Number)
        {
            this._stop = false;
            this._rateMin = param1;
            var _loc_4:* = param2;
            this._rateMax = param2;
            this._rate = _loc_4;
            this._target = param3;
            this._times = new Array();
            this._timeToRateCheck = 0;
            return;
        }// end function

        public function get rateMin() : Number
        {
            return this._rateMin;
        }// end function

        public function set rateMin(param1:Number) : void
        {
            this._rateMin = param1;
            this._timeToRateCheck = 0;
            return;
        }// end function

        public function get rateMax() : Number
        {
            return this._rateMax;
        }// end function

        public function set rateMax(param1:Number) : void
        {
            var _loc_2:* = param1;
            this._rateMax = param1;
            this._rate = _loc_2;
            this._timeToRateCheck = 0;
            return;
        }// end function

        public function get targetFrameRate() : Number
        {
            return this._target;
        }// end function

        public function set targetFrameRate(param1:Number) : void
        {
            this._target = param1;
            return;
        }// end function

        public function stop() : void
        {
            this._stop = true;
            return;
        }// end function

        public function resume() : void
        {
            this._stop = false;
            return;
        }// end function

        public function startEmitter(param1:Emitter) : uint
        {
            this.newTimeToNext();
            return 0;
        }// end function

        private function newTimeToNext() : void
        {
            this._timeToNext = 1 / this._rate;
            return;
        }// end function

        public function updateEmitter(param1:Emitter, param2:Number) : uint
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (this._stop)
            {
                return 0;
            }
            var _loc_7:* = this._timeToRateCheck - param2;
            this._timeToRateCheck = this._timeToRateCheck - param2;
            if (this._rate > this._rateMin && _loc_7 <= 0)
            {
                var _loc_7:* = getTimer();
                _loc_5 = getTimer();
                if (this._times.push(_loc_7) > 9)
                {
                    _loc_6 = Math.round(10000 / (_loc_5 - Number(this._times.shift())));
                    if (_loc_6 < this._target)
                    {
                        this._rate = Math.floor((this._rate + this._rateMin) * 0.5);
                        this._times.length = 0;
                        var _loc_7:* = param1.particles[0].lifetime;
                        this._timeToRateCheck = param1.particles[0].lifetime;
                        if (!_loc_7)
                        {
                            this._timeToRateCheck = 2;
                        }
                    }
                }
            }
            var _loc_3:* = param2;
            var _loc_4:* = 0;
            _loc_3 = _loc_3 - this._timeToNext;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = _loc_4 + 1;
                this.newTimeToNext();
                _loc_3 = _loc_3 - this._timeToNext;
            }
            this._timeToNext = -_loc_3;
            return _loc_4;
        }// end function

    }
}
