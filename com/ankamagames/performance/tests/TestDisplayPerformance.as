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

    public class TestDisplayPerformance implements IBenchmarkTest 
    {

        private static const TOTAL_OBJECTS:uint = 3000;
        private static const MAX_DURATION:uint = 4000;
        private static var _results:Array;
        private static var _stage:Stage;
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


        public static function set stage(s:Stage):void
        {
            _stage = s;
        }


        public function run():void
        {
            random = new ParkMillerCarta(8888);
            this._currentFps = 0;
            this._recordedFps = [];
            this._fps = 0;
            this._lastTimer = 0;
            this._tickTimer = 0;
            this._ctr = new Sprite();
            this._ctr.mouseEnabled = (this._ctr.mouseChildren = false);
            _stage.addChildAt(this._ctr, 0);
            this.addDummies(TOTAL_OBJECTS);
            this._startTime = getTimer();
            _stage.addEventListener(Event.ENTER_FRAME, this.onFrame);
        }

        public function cancel():void
        {
            this.clean();
        }

        private function onFrame(event:Event):void
        {
            var l:uint;
            var recentAverageFps:Number;
            this._timer = getTimer();
            this._tickTime = (this._timer - this._tickTimer);
            if (this._tickTime >= 500)
            {
                this._tickTimer = this._timer;
                this._currentFps = (this._fps * 2);
                if (this._recordedFps)
                {
                    this._recordedFps.push(this._currentFps);
                };
                if (((this._recordedFps) && ((this._recordedFps.length > 4))))
                {
                    l = this._recordedFps.length;
                    recentAverageFps = (((this._recordedFps[(l - 2)] + this._recordedFps[(l - 3)]) + this._recordedFps[(l - 4)]) / 3);
                    if (Math.abs((recentAverageFps - this._currentFps)) <= 2)
                    {
                        if (this._recordedFps)
                        {
                            this.endTest(Math.floor(((((this._recordedFps[(l - 1)] + this._recordedFps[(l - 2)]) + this._recordedFps[(l - 3)]) + this._recordedFps[(l - 4)]) / 4)));
                        };
                    };
                    if ((getTimer() - this._startTime) >= MAX_DURATION)
                    {
                        if (this._recordedFps)
                        {
                            this.endTest(Math.floor(((((this._recordedFps[(l - 1)] + this._recordedFps[(l - 2)]) + this._recordedFps[(l - 3)]) + this._recordedFps[(l - 4)]) / 4)));
                        };
                    };
                };
                this._fps = 0;
            };
            this._fps++;
            this._lastTimer = this._timer;
        }

        private function addDummies(amount:uint):void
        {
            var i:int;
            var dummy:DisplayObjectDummy;
            i = 0;
            while (i < amount)
            {
                dummy = new DisplayObjectDummy((random.nextDouble() * 0xFFFFFF));
                dummy.x = (random.nextDouble() * _stage.stageWidth);
                dummy.y = (random.nextDouble() * _stage.stageHeight);
                this._ctr.addChild(dummy);
                i++;
            };
        }

        private function endTest(result:uint):void
        {
            if (!(_results))
            {
                _results = [];
            };
            _results.push(result);
            this.clean();
            Benchmark.onTestCompleted(this);
        }

        public function getResults():String
        {
            var averageFps:Number;
            var i:int;
            if (_results)
            {
                averageFps = 0;
                i = 0;
                while (i < _results.length)
                {
                    averageFps = (averageFps + _results[i]);
                    i++;
                };
                averageFps = Math.floor((averageFps / _results.length));
                return (("displayPerfTest:" + averageFps.toString()));
            };
            return ("displayPerfTest:none");
        }

        private function clean():void
        {
            if (_stage)
            {
                _stage.removeEventListener(Event.ENTER_FRAME, this.onFrame);
                _stage.removeChild(this._ctr);
                _stage = null;
                this._ctr = null;
                this._recordedFps = null;
                random = null;
            };
        }

        private function logToConsole(txt:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("eval", (("console.log('" + txt) + "')"));
            };
            trace(txt);
        }


    }
}//package com.ankamagames.performance.tests

