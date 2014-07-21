package com.ankamagames.performance.tests
{
   import flash.events.EventDispatcher;
   import com.ankamagames.performance.IBenchmarkTest;
   import flash.display.Stage;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import com.ankamagames.performance.DisplayObjectDummy;
   import flash.utils.getTimer;
   import flash.events.Event;
   import com.ankamagames.performance.Benchmark;
   
   public class TestDisplayPerformance extends EventDispatcher implements IBenchmarkTest
   {
      
      public function TestDisplayPerformance(stage:Stage, goalFPS:uint = 30) {
         super();
         this._random = new ParkMillerCarta(8888);
         this._framesNumber = 0;
         this._goalFPS = goalFPS;
         this._currentFPS = 0;
         this._toleranceMaxFPS = this._goalFPS + this._goalFPS * TOLERANCE_RATE;
         this._toleranceMinFPS = this._goalFPS - this._goalFPS * TOLERANCE_RATE;
         this._testResults = [];
         this._ctr = new Sprite();
         this._ctr.alpha = 0;
         this._ctr.mouseEnabled = this._ctr.mouseChildren = false;
         this._stage = stage;
         this._stage.addChild(this._ctr);
      }
      
      private static const TICK:uint = 3;
      
      private static const TOLERANCE_RATE:Number = 0.2;
      
      private static const MAX_DURATION:uint = 4000;
      
      private static var _results:Array;
      
      public static function getResults() : String {
         var average:Object = null;
         var i:* = 0;
         if(_results)
         {
            average = 
               {
                  "dummies":0,
                  "fps":0
               };
            i = 0;
            while(i < _results.length)
            {
               average.fps = average.fps + _results[i].fps;
               average.dummies = average.dummies + _results[i].dummies;
               i++;
            }
            average.fps = average.fps / _results.length;
            average.dummies = average.dummies / _results.length;
            return "displayPerfTest:" + average.fps + "," + average.dummies;
         }
         return "displayPerfTest:none";
      }
      
      private var _stage:Stage;
      
      private var _ctr:Sprite;
      
      private var _random:ParkMillerCarta;
      
      private var _currentFPS:uint;
      
      private var _goalFPS:uint;
      
      private var _toleranceMaxFPS:uint;
      
      private var _toleranceMinFPS:uint;
      
      private var _startTime:Number;
      
      private var _initialTime:Number;
      
      private var _framesNumber:Number;
      
      private var _lastAmount:uint;
      
      private var _testResults:Array;
      
      private function addDummies(amount:uint) : void {
         var dummy:DisplayObjectDummy = null;
         if(amount < 10)
         {
            amount = 10;
         }
         this._testResults.push(
            {
               "fps":this._currentFPS,
               "dummies":this._ctr.numChildren
            });
         var i:int = 0;
         while(i < amount)
         {
            dummy = new DisplayObjectDummy(this._random.nextDouble() * 16777215);
            dummy.x = this._random.nextDouble() * this._stage.stageWidth;
            dummy.y = this._random.nextDouble() * this._stage.stageHeight;
            this._ctr.addChild(dummy);
            i++;
         }
         this._lastAmount = amount;
      }
      
      private function removeDummies(amount:uint) : void {
         if(amount < 10)
         {
            amount = 10;
         }
         this._testResults.push(
            {
               "fps":this._currentFPS,
               "dummies":this._ctr.numChildren
            });
         if(this._ctr.numChildren < amount)
         {
            amount = this._ctr.numChildren;
         }
         var i:int = 0;
         while(i < amount)
         {
            this._ctr.removeChildAt(this._ctr.numChildren - 1);
            i++;
         }
         this._lastAmount = amount;
      }
      
      public function run() : void {
         this.addDummies(500);
         this._startTime = getTimer();
         this._initialTime = this._startTime;
         this._stage.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function onFrame(e:Event) : void {
         var stabilizedFPS:* = false;
         var l:* = 0;
         var samples:Array = null;
         var i:* = 0;
         var diff:* = NaN;
         var j:* = 0;
         var tmpDiff:* = 0;
         this._framesNumber++;
         if(this._framesNumber == TICK)
         {
            this._currentFPS = this._framesNumber / ((getTimer() - this._startTime) / 1000);
            this._startTime = getTimer();
            this._framesNumber = 0;
            if(this._currentFPS >= this._goalFPS)
            {
               this.addDummies(this._lastAmount);
            }
            else
            {
               this.removeDummies(this._lastAmount * 0.75);
            }
            if(this._testResults.length > 19)
            {
               stabilizedFPS = true;
               l = this._testResults.length;
               samples = [];
               i = l - 5;
               while(i < l)
               {
                  if((this._testResults[i].fps >= this._toleranceMinFPS) && (this._testResults[i].fps <= this._toleranceMaxFPS))
                  {
                     samples.push(this._testResults[i]);
                     i++;
                     continue;
                  }
                  stabilizedFPS = false;
                  break;
               }
               if((stabilizedFPS) || (getTimer() - this._initialTime >= MAX_DURATION))
               {
                  if(!samples.length)
                  {
                     samples = this._testResults;
                  }
                  samples.sortOn("fps");
                  diff = -1;
                  j = 0;
                  while(j < samples.length)
                  {
                     tmpDiff = Math.abs(this._goalFPS - samples[j].fps);
                     if(tmpDiff == 0)
                     {
                        this.endTest(samples[j]);
                        return;
                     }
                     if((!(diff == -1)) && (diff < tmpDiff))
                     {
                        this.endTest(samples[j - 1]);
                        return;
                     }
                     diff = tmpDiff;
                     j++;
                  }
                  this.endTest(samples.pop());
                  return;
               }
            }
         }
      }
      
      private function endTest(result:Object) : void {
         if(!_results)
         {
            _results = [];
         }
         _results.push(result);
         this.clean();
         Benchmark.onTestCompleted(this);
      }
      
      private function clean() : void {
         this._stage.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         this._stage.removeChild(this._ctr);
         this._stage = null;
         this._ctr = null;
         this._random = null;
         this._testResults = null;
      }
   }
}
