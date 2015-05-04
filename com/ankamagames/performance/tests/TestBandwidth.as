package com.ankamagames.performance.tests
{
   import com.ankamagames.performance.IBenchmarkTest;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import flash.utils.getTimer;
   import com.ankamagames.performance.Benchmark;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequestHeader;
   
   public class TestBandwidth extends Object implements IBenchmarkTest
   {
      
      public function TestBandwidth(param1:URLLoader = null, param2:URLRequest = null)
      {
         super();
         if(!_results)
         {
            _results = [];
         }
         if(!param2)
         {
            var param2:URLRequest = new URLRequest("http://dl.ak.ankama.com/games/dofus2-streaming/beta/dummy.version_" + new Date().time + ".file");
         }
         if(!param1)
         {
            var param1:URLLoader = new URLLoader();
         }
         this._loader = param1;
         this._loader.addEventListener(Event.OPEN,this.onOpen);
         this._loader.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._urlRequest = param2;
         this._urlRequest.requestHeaders = [new URLRequestHeader("pragma","no-cache")];
      }
      
      private static const MAX_DURATION:uint = 4000;
      
      private static var _results:Array;
      
      public static function resetResults() : void
      {
         _results = [];
      }
      
      public static function pushResult(param1:int) : void
      {
         if(!_results)
         {
            _results = [];
         }
         _results.push(param1);
      }
      
      private var _loader:URLLoader;
      
      private var _urlRequest:URLRequest;
      
      private var _startTime:Number;
      
      private var _timer:Timer;
      
      public function run() : void
      {
         this._loader.load(this._urlRequest);
         this._timer = new Timer(MAX_DURATION,1);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timer.start();
      }
      
      public function cancel() : void
      {
         this.clean();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this.onError(null);
      }
      
      private function onOpen(param1:Event) : void
      {
         this._startTime = getTimer();
      }
      
      private function onError(param1:Event) : void
      {
         this.clean();
         Benchmark.onTestCompleted(this);
      }
      
      private function onComplete(param1:Event) : void
      {
         this.clean();
         var _loc2_:Number = getTimer() - this._startTime;
         var _loc3_:uint = param1.currentTarget.bytesTotal;
         var _loc4_:int = _loc3_ / _loc2_;
         _results.push(_loc4_);
         Benchmark.onTestCompleted(this);
      }
      
      private function clean() : void
      {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
            this._timer = null;
            try
            {
               this._loader.close();
            }
            catch(error:Error)
            {
            }
            this._loader.removeEventListener(Event.OPEN,this.onOpen);
            this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
            this._loader = null;
            this._urlRequest = null;
         }
      }
      
      public function getResults() : String
      {
         var _loc1_:* = NaN;
         var _loc2_:* = 0;
         if(_results)
         {
            if(_results.length == 0)
            {
               return "bandwidthTest:error";
            }
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _results.length)
            {
               _loc1_ = _loc1_ + _results[_loc2_];
               _loc2_++;
            }
            _loc1_ = _loc1_ / _results.length;
            return "bandwidthTest:" + _loc1_.toString();
         }
         return "bandwidthTest:none";
      }
   }
}
