package com.ankamagames.performance.tests
{
   import com.ankamagames.performance.IBenchmarkTest;
   import flash.display.Stage;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import flash.events.Event;
   import com.ankamagames.performance.DisplayObjectDummy;
   import com.ankamagames.performance.Benchmark;
   import flash.external.ExternalInterface;
   
   public class TestDisplayPerformance extends Object implements IBenchmarkTest
   {
      
      public function TestDisplayPerformance()
      {
         super();
      }
      
      private static const TOTAL_OBJECTS:uint = 3000;
      
      private static const MAX_DURATION:uint = 4000;
      
      private static var _results:Array;
      
      private static var _stage:Stage;
      
      public static function set stage(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public static var random:ParkMillerCarta;
      
      private var _ctr:Sprite;
      
      private var _currentFps:uint;
      
      private var _recordedFps:Array;
      
      private var _startTime:Number;
      
      private var _timer:uint;
      
      private var _fps:int;
      
      private var _lastTimer:int;
      
      private var _tickTimer:int;
      
      private var _tickTime:uint;
      
      public function run() : void
      {
         random = new ParkMillerCarta(8888);
         this._currentFps = 0;
         this._recordedFps = [];
         this._fps = 0;
         this._lastTimer = 0;
         this._tickTimer = 0;
         this._ctr = new Sprite();
         this._ctr.mouseEnabled = this._ctr.mouseChildren = false;
         _stage.addChildAt(this._ctr,0);
         this.addDummies(TOTAL_OBJECTS);
         this._startTime = getTimer();
         _stage.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      public function cancel() : void
      {
         this.clean();
      }
      
      private function onFrame(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:* = NaN;
         this._timer = getTimer();
         this._tickTime = this._timer - this._tickTimer;
         if(this._tickTime >= 500)
         {
            this._tickTimer = this._timer;
            this._currentFps = this._fps * 2;
            if(this._recordedFps)
            {
               this._recordedFps.push(this._currentFps);
            }
            if((this._recordedFps) && this._recordedFps.length > 4)
            {
               _loc2_ = this._recordedFps.length;
               _loc3_ = (this._recordedFps[_loc2_ - 2] + this._recordedFps[_loc2_ - 3] + this._recordedFps[_loc2_ - 4]) / 3;
               if(Math.abs(_loc3_ - this._currentFps) <= 2)
               {
                  if(this._recordedFps)
                  {
                     this.endTest(Math.floor((this._recordedFps[_loc2_ - 1] + this._recordedFps[_loc2_ - 2] + this._recordedFps[_loc2_ - 3] + this._recordedFps[_loc2_ - 4]) / 4));
                  }
               }
               if(getTimer() - this._startTime >= MAX_DURATION)
               {
                  if(this._recordedFps)
                  {
                     this.endTest(Math.floor((this._recordedFps[_loc2_ - 1] + this._recordedFps[_loc2_ - 2] + this._recordedFps[_loc2_ - 3] + this._recordedFps[_loc2_ - 4]) / 4));
                  }
               }
            }
            this._fps = 0;
         }
         this._fps++;
         this._lastTimer = this._timer;
      }
      
      private function addDummies(param1:uint) : void
      {
         var _loc2_:* = 0;
         var _loc3_:DisplayObjectDummy = null;
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = new DisplayObjectDummy(random.nextDouble() * 16777215);
            _loc3_.x = random.nextDouble() * _stage.stageWidth;
            _loc3_.y = random.nextDouble() * _stage.stageHeight;
            this._ctr.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      private function endTest(param1:uint) : void
      {
         if(!_results)
         {
            _results = [];
         }
         _results.push(param1);
         this.clean();
         Benchmark.onTestCompleted(this);
      }
      
      public function getResults() : String
      {
         var _loc1_:* = NaN;
         var _loc2_:* = 0;
         if(_results)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _results.length)
            {
               _loc1_ = _loc1_ + _results[_loc2_];
               _loc2_++;
            }
            _loc1_ = Math.floor(_loc1_ / _results.length);
            return "displayPerfTest:" + _loc1_.toString();
         }
         return "displayPerfTest:none";
      }
      
      private function clean() : void
      {
         if(_stage)
         {
            _stage.removeEventListener(Event.ENTER_FRAME,this.onFrame);
            _stage.removeChild(this._ctr);
            _stage = null;
            this._ctr = null;
            this._recordedFps = null;
            random = null;
         }
      }
      
      private function logToConsole(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("eval","console.log(\'" + param1 + "\')");
         }
         trace(param1);
      }
   }
}
