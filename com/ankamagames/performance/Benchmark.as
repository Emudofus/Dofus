package com.ankamagames.performance
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import flash.display.Stage;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.performance.tests.TestBandwidth;
   import com.ankamagames.performance.tests.TestWriteDisk;
   import com.ankamagames.performance.tests.TestReadDisk;
   import com.ankamagames.performance.tests.TestDisplayPerformance;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class Benchmark extends EventDispatcher
   {
      
      public function Benchmark() {
         super();
      }
      
      public static var isDone:Boolean = false;
      
      private static var _ds:DataStoreType;
      
      private static var _totalTestToDo:uint;
      
      private static var _onCompleteCallback:Function;
      
      public static function get hasCachedResults() : Boolean {
         var results:String = StoreDataManager.getInstance().getData(_ds,"results");
         return !(results == null);
      }
      
      public static function run(stage:Stage, onCompleteCallback:Function) : void {
         _totalTestToDo = 0;
         _onCompleteCallback = onCompleteCallback;
         isDone = false;
         if(AirScanner.isStreamingVersion())
         {
            _totalTestToDo++;
            new TestBandwidth().run();
         }
         new TestWriteDisk().run();
         new TestReadDisk().run();
         _totalTestToDo++;
         new TestDisplayPerformance(stage).run();
      }
      
      public static function onTestCompleted(test:IBenchmarkTest) : void {
         _totalTestToDo--;
         if(_totalTestToDo == 0)
         {
            Benchmark.isDone = true;
            if(_onCompleteCallback != null)
            {
               _onCompleteCallback();
            }
         }
      }
      
      public static function getResults(writeResultsOnDisk:Boolean = false, fromCacheIfExists:Boolean = true) : String {
         var res:String = null;
         if(fromCacheIfExists)
         {
            res = StoreDataManager.getInstance().getData(_ds,"results");
            if((res) && (res.length > 0))
            {
               return res;
            }
         }
         res = TestWriteDisk.getResults() + ";" + TestReadDisk.getResults() + ";" + TestDisplayPerformance.getResults() + ";" + TestBandwidth.getResults();
         if(writeResultsOnDisk)
         {
            StoreDataManager.getInstance().setData(_ds,"results",res);
         }
         return res;
      }
   }
}
