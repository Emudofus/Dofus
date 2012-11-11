package com.ankamagames.jerakine.utils.misc
{
    import flash.utils.*;

    public class FightProfiler extends Object
    {
        private var _info:String;
        private static const _profiler:FightProfiler = new FightProfiler;
        private static var _startTime:int = 0;

        public function FightProfiler()
        {
            return;
        }// end function

        public function start() : void
        {
            _startTime = getTimer();
            return;
        }// end function

        public function stop() : void
        {
            this._info = (getTimer() - _startTime).toString();
            return;
        }// end function

        public function get info() : String
        {
            return this._info;
        }// end function

        public static function getInstance() : FightProfiler
        {
            return _profiler;
        }// end function

    }
}
