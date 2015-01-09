package com.ankamagames.performance
{
    import __AS3__.vec.Vector;
    import com.ankamagames.performance.tests.TestBandwidth;
    import com.ankamagames.performance.tests.TestWriteDisk;
    import com.ankamagames.performance.tests.TestReadDisk;
    import com.ankamagames.performance.tests.TestDisplayPerformance;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import flash.display.Stage;
    import __AS3__.vec.*;

    public class Benchmark 
    {

        public static const BENCHMARK_FORMAT_VERSION:uint = 1;
        public static const TESTS_DEFAULT:Vector.<Class> = new <Class>[TestBandwidth, TestWriteDisk, TestReadDisk, TestDisplayPerformance];
        public static const TESTS_NODISK:Vector.<Class> = new <Class>[TestBandwidth, TestDisplayPerformance];
        public static const TESTS_AIR:Vector.<Class> = new <Class>[TestWriteDisk, TestReadDisk, TestDisplayPerformance];
        public static var isDone:Boolean = false;
        private static var _ds:DataStoreType = new DataStoreType("Dofus_Benchmark", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        private static var _totalTestToDo:uint;
        private static var _onCompleteCallback:Function;
        private static var _lastTests:Vector.<IBenchmarkTest>;


        public static function get hasCachedResults():Boolean
        {
            var results:String = StoreDataManager.getInstance().getData(_ds, "results");
            var formatVersion:uint = StoreDataManager.getInstance().getData(_ds, "formatVersion");
            if (formatVersion != BENCHMARK_FORMAT_VERSION)
            {
                results = null;
                StoreDataManager.getInstance().setData(_ds, "results", null);
            };
            return (!((results == null)));
        }

        public static function run(stage:Stage, onCompleteCallback:Function, tests:Vector.<Class>=null):void
        {
            var test:IBenchmarkTest;
            var testClass:Class;
            TestDisplayPerformance.stage = stage;
            if (!(tests))
            {
                tests = TESTS_DEFAULT;
            };
            _totalTestToDo = tests.length;
            _onCompleteCallback = onCompleteCallback;
            isDone = false;
            _lastTests = new Vector.<IBenchmarkTest>();
            for each (testClass in tests)
            {
                test = new (testClass)();
                _lastTests.push(test);
                test.run();
            };
        }

        public static function onTestCompleted(test:IBenchmarkTest):void
        {
            _totalTestToDo--;
            if (_totalTestToDo == 0)
            {
                Benchmark.isDone = true;
                if (_onCompleteCallback != null)
                {
                    _onCompleteCallback();
                    _onCompleteCallback = null;
                };
            };
        }

        public static function getResults(writeResultsOnDisk:Boolean=false, fromCacheIfExists:Boolean=true):String
        {
            var test:IBenchmarkTest;
            var res:String = "";
            if (fromCacheIfExists)
            {
                res = StoreDataManager.getInstance().getData(_ds, "results");
                if (((res) && ((res.length > 0))))
                {
                    return (res);
                };
                res = "";
            };
            for each (test in _lastTests)
            {
                res = (res + (test.getResults() + ";"));
            };
            res = res.slice(0, -1);
            if (writeResultsOnDisk)
            {
                StoreDataManager.getInstance().setData(_ds, "results", res);
                StoreDataManager.getInstance().setData(_ds, "formatVersion", BENCHMARK_FORMAT_VERSION);
            };
            return (res);
        }


    }
}//package com.ankamagames.performance

