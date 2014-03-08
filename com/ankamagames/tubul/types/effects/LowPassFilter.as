package com.ankamagames.tubul.types.effects
{
   import com.ankamagames.tubul.interfaces.IEffect;
   
   public class LowPassFilter extends Object implements IEffect
   {
      
      public function LowPassFilter(pResonance:Number=0.0, pMinFreq:Number=0.0, pMaxFreq:Number=0.0, pLfoSpeed:Number=0.0) {
         super();
         this.lfoSpeedMs = pLfoSpeed;
         this.resonance = pResonance;
         this.minFreq = pMinFreq;
         this.maxFreq = pMaxFreq;
         this._lfoAdd = 1 / (this.lfoSpeedMs * 44.1);
         this._lfoPhase = 0.0;
         this._resonance = this.resonance;
         this._minFreq = this.minFreq;
         this._maxFreq = this.maxFreq;
         this._poleLVel = 0.0;
         this._poleLVal = 0.0;
         this._poleRVel = 0.0;
         this._poleRVal = 0.0;
      }
      
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
      
      public function get name() : String {
         return "LowPassFilter";
      }
      
      public function get lfoSpeedMs() : Number {
         return this._lfoSpeedMs;
      }
      
      public function set lfoSpeedMs(pLfoSpeedMs:Number) : void {
         this._lfoSpeedMs = pLfoSpeedMs;
         this._lfoAdd = 1 / (this._lfoSpeedMs * 44.1);
      }
      
      public function get resonance() : Number {
         return this._resonance;
      }
      
      public function set resonance(pResonance:Number) : void {
         this._resonance = pResonance;
      }
      
      public function get minFreq() : Number {
         return this._minFreq;
      }
      
      public function set minFreq(pMinFreq:Number) : void {
         this._minFreq = pMinFreq;
      }
      
      public function get maxFreq() : Number {
         return this._maxFreq;
      }
      
      public function set maxFreq(pMaxFreq:Number) : void {
         this._maxFreq = pMaxFreq;
      }
      
      public function process(pInput:Number) : Number {
         var lfoValue:* = NaN;
         var freq:* = NaN;
         var cutoff:* = NaN;
         lfoValue = this._lfoPhase < 0.5?this._lfoPhase * 2:2 - this._lfoPhase * 2;
         this._lfoPhase = this._lfoPhase + this._lfoAdd;
         if(this._lfoPhase >= 1)
         {
            this._lfoPhase--;
         }
         freq = this._minFreq * Math.exp(lfoValue * Math.log(this._maxFreq / this._minFreq));
         cutoff = Math.sin(2 * Math.PI * freq / 44100);
         this._poleLVel = this._poleLVel * this._resonance;
         this._poleLVel = this._poleLVel + (pInput - this._poleLVal) * cutoff;
         this._poleLVal = this._poleLVal + this._poleLVel;
         this._poleRVel = this._poleRVel * this._resonance;
         this._poleRVel = this._poleRVel + (pInput - this._poleRVal) * cutoff;
         this._poleRVal = this._poleRVal + this._poleRVel;
         return this._poleRVel;
      }
      
      public function duplicate() : IEffect {
         var LowPassCopy:LowPassFilter = new LowPassFilter();
         LowPassCopy.lfoSpeedMs = this.lfoSpeedMs;
         LowPassCopy.minFreq = this.minFreq;
         LowPassCopy.maxFreq = this.maxFreq;
         LowPassCopy.resonance = this.resonance;
         return LowPassCopy;
      }
      
      private function tanh(x:Number) : Number {
         return 1 - 2 / (Math.pow(2.71828183,2 * x) + 1);
      }
   }
}
