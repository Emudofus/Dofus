package com.ankamagames.berilia.types.graphic
{
    import flash.events.*;
    import flash.html.*;
    import flash.utils.*;

    public class TimeoutHTMLLoader extends HTMLLoader
    {
        private var _fromCache:Boolean;
        private var _timer:Timer;
        private var _uid:String;
        private static var INSTANCE_CACHE:Dictionary = new Dictionary();
        public static const TIMEOUT:String = "TimeoutHTMLLoader_timeout";

        public function TimeoutHTMLLoader()
        {
            addEventListener(Event["LOCATION_CHANGE"], this.onLocationChange);
            return;
        }// end function

        public function set life(param1:Number) : void
        {
            this._timer = new Timer(param1 * 60 * 1000);
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimeOut);
            return;
        }// end function

        public function get fromCache() : Boolean
        {
            return this._fromCache;
        }// end function

        private function onLocationChange(event:Event) : void
        {
            if (this._timer)
            {
                this._timer.reset();
                this._timer.start();
            }
            return;
        }// end function

        private function onTimeOut(event:Event) : void
        {
            this._timer.stop();
            dispatchEvent(new Event(TIMEOUT));
            if (!this._timer.running && this._uid)
            {
                delete INSTANCE_CACHE[this._uid];
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTimeOut);
            }
            return;
        }// end function

        public static function getLoader(param1:String = null) : TimeoutHTMLLoader
        {
            var _loc_2:* = null;
            if (param1 != null && INSTANCE_CACHE[param1])
            {
                _loc_2 = INSTANCE_CACHE[param1];
                _loc_2._fromCache = true;
                _loc_2._timer.reset();
                _loc_2._timer.start();
                return _loc_2;
            }
            _loc_2 = new TimeoutHTMLLoader;
            _loc_2._uid = param1;
            if (param1)
            {
                INSTANCE_CACHE[param1] = _loc_2;
            }
            return _loc_2;
        }// end function

        public static function resetCache() : void
        {
            INSTANCE_CACHE = new Dictionary();
            return;
        }// end function

    }
}
