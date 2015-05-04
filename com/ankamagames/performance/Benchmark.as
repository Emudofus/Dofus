package com.ankamagames.performance
{
   import com.ankamagames.jerakine.types.DataStoreType;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import flash.display.Stage;
   import com.ankamagames.performance.tests.TestDisplayPerformance;
   import flash.events.TimerEvent;
   import com.ankamagames.performance.tests.TestBandwidth;
   import com.ankamagames.performance.tests.TestWriteDisk;
   import com.ankamagames.performance.tests.TestReadDisk;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class Benchmark extends Object
   {
      
      public function Benchmark()
      {
         super();
      }
      
      public static const BENCHMARK_FORMAT_VERSION:uint = 1;
      
      public static const TESTS_DEFAULT:Vector.<Class> = new <Class>[TestBandwidth,TestWriteDisk,TestReadDisk,TestDisplayPerformance];
      
      public static const TESTS_NODISK:Vector.<Class> = new <Class>[TestBandwidth,TestDisplayPerformance];
      
      public static const TESTS_AIR:Vector.<Class> = new <Class>[TestWriteDisk,TestReadDisk,TestDisplayPerformance];
      
      public static var isDone:Boolean = false;
      
      private static var _ds:DataStoreType = new DataStoreType("Dofus_Benchmark",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
      
      private static var _totalTestToDo:uint;
      
      private static var _onCompleteCallback:Function;
      
      private static var _lastTests:Vector.<IBenchmarkTest>;
      
      private static var _timer:Timer;
      
      public static function get hasCachedResults() : Boolean
      {
         var _loc1_:String = StoreDataManager.getInstance().getData(_ds,"results");
         var _loc2_:uint = StoreDataManager.getInstance().getData(_ds,"formatVersion");
         if(_loc2_ != BENCHMARK_FORMAT_VERSION)
         {
            _loc1_ = null;
            StoreDataManager.getInstance().setData(_ds,"results",null);
         }
         return !(_loc1_ == null);
      }
      
      public static function run(param1:Stage, param2:Function, param3:Vector.<Class> = null) : void
      {
         var _loc4_:IBenchmarkTest = null;
         var _loc5_:Class = null;
         TestDisplayPerformance.stage = param1;
         if(!param3)
         {
            var param3:Vector.<Class> = TESTS_DEFAULT;
         }
         _totalTestToDo = param3.length;
         _onCompleteCallback = param2;
         isDone = false;
         _timer = new Timer(5000,1);
         _timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimedOut);
         _timer.start();
         _lastTests = new Vector.<IBenchmarkTest>();
         for each(_loc5_ in param3)
         {
            _loc4_ = new _loc5_();
            _lastTests.push(_loc4_);
            _loc4_.run();
         }
      }
      
      protected static function onTimedOut(param1:TimerEvent) : void
      {
         var _loc2_:IBenchmarkTest = null;
         for each(_loc2_ in _lastTests)
         {
            _loc2_.cancel();
         }
         endBenchmark();
      }
      
      private static function cleanTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimedOut);
            _timer = null;
         }
      }
      
      public static function onTestCompleted(param1:IBenchmarkTest) : void
      {
         _totalTestToDo--;
         if(_totalTestToDo == 0)
         {
            endBenchmark();
         }
      }
      
      private static function endBenchmark() : void
      {
         cleanTimer();
         Benchmark.isDone = true;
         if(_onCompleteCallback != null)
         {
            _onCompleteCallback();
            _onCompleteCallback = null;
         }
      }
      
      public static function getResults(param1:Boolean = false, param2:Boolean = true) : String
      {
         var _loc4_:IBenchmarkTest = null;
         var _loc3_:* = "";
         if(param2)
         {
            _loc3_ = StoreDataManager.getInstance().getData(_ds,"results");
            if((_loc3_) && _loc3_.length > 0)
            {
               return _loc3_;
            }
            _loc3_ = "";
         }
         for each(_loc4_ in _lastTests)
         {
            _loc3_ = _loc3_ + (_loc4_.getResults() + ";");
         }
         _loc3_ = _loc3_.slice(0,-1);
         if(param1)
         {
            StoreDataManager.getInstance().setData(_ds,"results",_loc3_);
            StoreDataManager.getInstance().setData(_ds,"formatVersion",BENCHMARK_FORMAT_VERSION);
         }
         return _loc3_;
      }
   }
}
