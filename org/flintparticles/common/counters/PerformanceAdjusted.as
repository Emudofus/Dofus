package org.flintparticles.common.counters
{
   import org.flintparticles.common.emitters.Emitter;
   import flash.utils.getTimer;
   
   public class PerformanceAdjusted extends Object implements Counter
   {
      
      public function PerformanceAdjusted(param1:Number, param2:Number, param3:Number) {
         super();
         this._stop = false;
         this._rateMin = param1;
         this._rate = this._rateMax = param2;
         this._target = param3;
         this._times = new Array();
         this._timeToRateCheck = 0;
      }
      
      private var _timeToNext:Number;
      
      private var _rateMin:Number;
      
      private var _rateMax:Number;
      
      private var _target:Number;
      
      private var _rate:Number;
      
      private var _times:Array;
      
      private var _timeToRateCheck:Number;
      
      private var _stop:Boolean;
      
      public function get rateMin() : Number {
         return this._rateMin;
      }
      
      public function set rateMin(param1:Number) : void {
         this._rateMin = param1;
         this._timeToRateCheck = 0;
      }
      
      public function get rateMax() : Number {
         return this._rateMax;
      }
      
      public function set rateMax(param1:Number) : void {
         this._rate = this._rateMax = param1;
         this._timeToRateCheck = 0;
      }
      
      public function get targetFrameRate() : Number {
         return this._target;
      }
      
      public function set targetFrameRate(param1:Number) : void {
         this._target = param1;
      }
      
      public function stop() : void {
         this._stop = true;
      }
      
      public function resume() : void {
         this._stop = false;
      }
      
      public function startEmitter(param1:Emitter) : uint {
         this.newTimeToNext();
         return 0;
      }
      
      private function newTimeToNext() : void {
         this._timeToNext = 1 / this._rate;
      }
      
      public function updateEmitter(param1:Emitter, param2:Number) : uint {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         if(this._stop)
         {
            return 0;
         }
         if(this._rate > this._rateMin && (this._timeToRateCheck = this._timeToRateCheck - param2) <= 0)
         {
            if(this._times.push(_loc5_ = getTimer()) > 9)
            {
               _loc6_ = Math.round(10000 / (_loc5_ - Number(this._times.shift())));
               if(_loc6_ < this._target)
               {
                  this._rate = Math.floor((this._rate + this._rateMin) * 0.5);
                  this._times.length = 0;
                  if(!(this._timeToRateCheck = param1.particles[0].lifetime))
                  {
                     this._timeToRateCheck = 2;
                  }
               }
            }
         }
         var _loc3_:Number = param2;
         var _loc4_:uint = 0;
         _loc3_ = _loc3_ - this._timeToNext;
         while(_loc3_ >= 0)
         {
            _loc4_++;
            this.newTimeToNext();
            _loc3_ = _loc3_ - this._timeToNext;
         }
         this._timeToNext = -_loc3_;
         return _loc4_;
      }
   }
}
