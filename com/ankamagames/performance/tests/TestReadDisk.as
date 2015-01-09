package com.ankamagames.performance.tests
{
    import com.ankamagames.performance.IBenchmarkTest;
    import com.ankamagames.jerakine.types.CustomSharedObject;
    import flash.utils.getTimer;
    import com.ankamagames.performance.Benchmark;

    public class TestReadDisk implements IBenchmarkTest 
    {

        private static var _results:Array;


        public function run():void
        {
            var startTime:Number;
            var cso:CustomSharedObject;
            try
            {
                CustomSharedObject.clearCache("benchmark");
                startTime = getTimer();
                cso = CustomSharedObject.getLocal("benchmark");
                if (!(_results))
                {
                    _results = [];
                };
                _results.push((getTimer() - startTime));
                cso.clear();
            }
            catch(error:Error)
            {
                _results.push("error");
            };
            Benchmark.onTestCompleted(this);
        }

        public function cancel():void
        {
        }

        public function getResults():String
        {
            var averageTime:Number;
            var i:int;
            if (_results)
            {
                averageTime = 0;
                i = 0;
                while (i < _results.length)
                {
                    if (_results[i] == "error")
                    {
                        return ("readDiskTest:error");
                    };
                    averageTime = (averageTime + _results[i]);
                    i++;
                };
                averageTime = (averageTime / _results.length);
                return (("readDiskTest:" + averageTime.toString()));
            };
            return ("readDiskTest:none");
        }


    }
}//package com.ankamagames.performance.tests

