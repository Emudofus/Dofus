package com.ankamagames.tubul.types.effects
{
    import com.ankamagames.tubul.interfaces.*;

    public class LowPassFilter extends Object implements IEffect
    {
        private var _lfoPhase:Number;
        private var _lfoAdd:Number;
        private var _poleLVel:Number;
        private var _poleLVal:Number;
        private var _poleRVel:Number;
        private var _poleRVal:Number;
        private var _resonance:Number;
        private var _minFreq:Number;
        private var _maxFreq:Number;
        private var _lfoSpeedMs:Number;

        public function LowPassFilter(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            this.lfoSpeedMs = param4;
            this.resonance = param1;
            this.minFreq = param2;
            this.maxFreq = param3;
            this._lfoAdd = 1 / (this.lfoSpeedMs * 44.1);
            this._lfoPhase = 0;
            this._resonance = this.resonance;
            this._minFreq = this.minFreq;
            this._maxFreq = this.maxFreq;
            this._poleLVel = 0;
            this._poleLVal = 0;
            this._poleRVel = 0;
            this._poleRVal = 0;
            return;
        }// end function

        public function get name() : String
        {
            return "LowPassFilter";
        }// end function

        public function get lfoSpeedMs() : Number
        {
            return this._lfoSpeedMs;
        }// end function

        public function set lfoSpeedMs(param1:Number) : void
        {
            this._lfoSpeedMs = param1;
            this._lfoAdd = 1 / (this._lfoSpeedMs * 44.1);
            return;
        }// end function

        public function get resonance() : Number
        {
            return this._resonance;
        }// end function

        public function set resonance(param1:Number) : void
        {
            this._resonance = param1;
            return;
        }// end function

        public function get minFreq() : Number
        {
            return this._minFreq;
        }// end function

        public function set minFreq(param1:Number) : void
        {
            this._minFreq = param1;
            return;
        }// end function

        public function get maxFreq() : Number
        {
            return this._maxFreq;
        }// end function

        public function set maxFreq(param1:Number) : void
        {
            this._maxFreq = param1;
            return;
        }// end function

        public function process(param1:Number) : Number
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            _loc_2 = this._lfoPhase < 0.5 ? (this._lfoPhase * 2) : (2 - this._lfoPhase * 2);
            this._lfoPhase = this._lfoPhase + this._lfoAdd;
            if (this._lfoPhase >= 1)
            {
                var _loc_5:* = this;
                var _loc_6:* = this._lfoPhase - 1;
                _loc_5._lfoPhase = _loc_6;
            }
            _loc_3 = this._minFreq * Math.exp(_loc_2 * Math.log(this._maxFreq / this._minFreq));
            _loc_4 = Math.sin(2 * Math.PI * _loc_3 / 44100);
            this._poleLVel = this._poleLVel * this._resonance;
            this._poleLVel = this._poleLVel + (param1 - this._poleLVal) * _loc_4;
            this._poleLVal = this._poleLVal + this._poleLVel;
            this._poleRVel = this._poleRVel * this._resonance;
            this._poleRVel = this._poleRVel + (param1 - this._poleRVal) * _loc_4;
            this._poleRVal = this._poleRVal + this._poleRVel;
            return this._poleRVel;
        }// end function

        public function duplicate() : IEffect
        {
            var _loc_1:* = new LowPassFilter();
            _loc_1.lfoSpeedMs = this.lfoSpeedMs;
            _loc_1.minFreq = this.minFreq;
            _loc_1.maxFreq = this.maxFreq;
            _loc_1.resonance = this.resonance;
            return _loc_1;
        }// end function

        private function tanh(param1:Number) : Number
        {
            return 1 - 2 / (Math.pow(2.71828, 2 * param1) + 1);
        }// end function

    }
}
