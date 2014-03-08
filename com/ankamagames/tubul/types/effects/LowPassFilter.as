package com.ankamagames.tubul.types.effects
{
   import com.ankamagames.tubul.interfaces.IEffect;
   
   public class LowPassFilter extends Object implements IEffect
   {
      
      public function LowPassFilter(param1:Number=0.0, param2:Number=0.0, param3:Number=0.0, param4:Number=0.0) {
         super();
         this.lfoSpeedMs = param4;
         this.resonance = param1;
         this.minFreq = param2;
         this.maxFreq = param3;
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
      
      public function set lfoSpeedMs(param1:Number) : void {
         this._lfoSpeedMs = param1;
         this._lfoAdd = 1 / (this._lfoSpeedMs * 44.1);
      }
      
      public function get resonance() : Number {
         return this._resonance;
      }
      
      public function set resonance(param1:Number) : void {
         this._resonance = param1;
      }
      
      public function get minFreq() : Number {
         return this._minFreq;
      }
      
      public function set minFreq(param1:Number) : void {
         this._minFreq = param1;
      }
      
      public function get maxFreq() : Number {
         return this._maxFreq;
      }
      
      public function set maxFreq(param1:Number) : void {
         this._maxFreq = param1;
      }
      
      public function process(param1:Number) : Number {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         _loc2_ = this._lfoPhase < 0.5?this._lfoPhase * 2:2 - this._lfoPhase * 2;
         this._lfoPhase = this._lfoPhase + this._lfoAdd;
         if(this._lfoPhase >= 1)
         {
            this._lfoPhase--;
         }
         _loc3_ = this._minFreq * Math.exp(_loc2_ * Math.log(this._maxFreq / this._minFreq));
         _loc4_ = Math.sin(2 * Math.PI * _loc3_ / 44100);
         this._poleLVel = this._poleLVel * this._resonance;
         this._poleLVel = this._poleLVel + (param1 - this._poleLVal) * _loc4_;
         this._poleLVal = this._poleLVal + this._poleLVel;
         this._poleRVel = this._poleRVel * this._resonance;
         this._poleRVel = this._poleRVel + (param1 - this._poleRVal) * _loc4_;
         this._poleRVal = this._poleRVal + this._poleRVel;
         return this._poleRVel;
      }
      
      public function duplicate() : IEffect {
         var _loc1_:LowPassFilter = new LowPassFilter();
         _loc1_.lfoSpeedMs = this.lfoSpeedMs;
         _loc1_.minFreq = this.minFreq;
         _loc1_.maxFreq = this.maxFreq;
         _loc1_.resonance = this.resonance;
         return _loc1_;
      }
      
      private function tanh(param1:Number) : Number {
         return 1 - 2 / (Math.pow(2.71828183,2 * param1) + 1);
      }
   }
}
