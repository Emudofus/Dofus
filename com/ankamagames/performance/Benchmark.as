package com.ankamagames.performance
{
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.performance.tests.TestBandwidth;
    import com.ankamagames.performance.tests.TestWriteDisk;
    import com.ankamagames.performance.tests.TestReadDisk;
    import com.ankamagames.performance.tests.TestDisplayPerformance;
    import flash.display.Stage;

    public class Benchmark extends EventDispatcher 
    {

        public static var isDone:Boolean = false;
        private static var _ds:DataStoreType = new DataStoreType("Dofus_Benchmark", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        private static var _totalTestToDo:uint;
        private static var _onCompleteCallback:Function;


        public static function get hasCachedResults():Boolean
        {
            var results:String = StoreDataManager.getInstance().getData(_ds, "results");
            return (!((results == null)));
        }

        public static function run(stage:Stage, onCompleteCallback:Function):void
        {
            _totalTestToDo = 0;
            _onCompleteCallback = onCompleteCallback;
            isDone = false;
            if (AirScanner.isStreamingVersion())
            {
                _totalTestToDo++;
                new TestBandwidth().run();
            };
            new TestWriteDisk().run();
            new TestReadDisk().run();
            _totalTestToDo++;
            new TestDisplayPerformance(stage).run();
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
                };
            };
        }

        public static function getResults(writeResultsOnDisk:Boolean=false, fromCacheIfExists:Boolean=true):String
        {
            var res:String;
            if (fromCacheIfExists)
            {
                res = StoreDataManager.getInstance().getData(_ds, "results");
                if (((res) && ((res.length > 0))))
                {
                    return (res);
                };
            };
            res = ((((((TestWriteDisk.getResults() + ";") + TestReadDisk.getResults()) + ";") + TestDisplayPerformance.getResults()) + ";") + TestBandwidth.getResults());
            if (writeResultsOnDisk)
            {
                StoreDataManager.getInstance().setData(_ds, "results", res);
            };
            return (res);
        }


    }
}//package com.ankamagames.performance

