package com.ankamagames.performance.tests
{
   import com.ankamagames.performance.IBenchmarkTest;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.utils.getTimer;
   import com.ankamagames.performance.Benchmark;
   
   public class TestReadDisk extends Object implements IBenchmarkTest
   {
      
      public function TestReadDisk() {
         super();
      }
      
      private static var _results:Array;
      
      public function run() : void {
         var startTime:Number = NaN;
         var cso:CustomSharedObject = null;
         try
         {
            CustomSharedObject.clearCache("benchmark");
            startTime = getTimer();
            cso = CustomSharedObject.getLocal("benchmark");
            if(!_results)
            {
               _results = [];
            }
            _results.push(getTimer() - startTime);
            cso.clear();
         }
         catch(error:Error)
         {
            _results.push("error");
         }
         Benchmark.onTestCompleted(this);
      }
      
      public function getResults() : String {
         var averageTime:* = NaN;
         var i:* = 0;
         if(_results)
         {
            averageTime = 0;
            i = 0;
            while(i < _results.length)
            {
               if(_results[i] == "error")
               {
                  return "readDiskTest:error";
               }
               averageTime = averageTime + _results[i];
               i++;
            }
            averageTime = averageTime / _results.length;
            return "readDiskTest:" + averageTime.toString();
         }
         return "readDiskTest:none";
      }
   }
}
