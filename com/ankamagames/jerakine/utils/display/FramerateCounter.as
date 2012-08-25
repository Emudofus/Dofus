package com.ankamagames.jerakine.utils.display
{
    import flash.events.*;
    import flash.utils.*;

    public class FramerateCounter extends Object
    {
        private static var _refreshRate:uint = 5000;
        private static var _lastThreshold:uint;
        private static var _framesCountSinceThreshold:uint;
        private static var _frameRate:uint;
        private static var _delayBetweenFrames:uint;
        private static var _lastFrame:uint;
        private static var _listeners:Array = new Array();
        private static var _enterFrameListened:Boolean;

        public function FramerateCounter()
        {
            return;
        }// end function

        public static function get listeners() : Array
        {
            return _listeners;
        }// end function

        public static function get refreshRate() : uint
        {
            return _refreshRate;
        }// end function

        public static function set refreshRate(param1:uint) : void
        {
            _refreshRate = param1;
            return;
        }// end function

        public static function get frameRate() : uint
        {
            return _frameRate;
        }// end function

        public static function get delayBetweenFrames() : uint
        {
            return _delayBetweenFrames;
        }// end function

        public static function addListener(param1:IFramerateListener) : void
        {
            _listeners.push(param1);
            if (!_enterFrameListened)
            {
                EnterFrameDispatcher.addEventListener(onEnterFrame, "FramerateCounter", 0);
                _enterFrameListened = true;
            }
            return;
        }// end function

        public static function removeListener(param1:IFramerateListener) : void
        {
            var _loc_2:* = _listeners.indexOf(param1);
            if (_loc_2 > -1)
            {
                _listeners.splice(_loc_2, 1);
            }
            if (_listeners.length <= 0)
            {
                EnterFrameDispatcher.removeEventListener(onEnterFrame);
                _enterFrameListened = false;
            }
            return;
        }// end function

        private static function dispatchFps() : void
        {
            var _loc_1:IFramerateListener = null;
            for each (_loc_1 in _listeners)
            {
                
                _loc_1.onFps(_frameRate);
            }
            return;
        }// end function

        private static function onEnterFrame(event:Event) : void
        {
            var _loc_5:* = _framesCountSinceThreshold + 1;
            _framesCountSinceThreshold = _loc_5;
            var _loc_2:* = getTimer();
            _delayBetweenFrames = _loc_2 - _lastFrame;
            _lastFrame = _loc_2;
            var _loc_3:* = _loc_2 - _lastThreshold;
            if (_loc_3 > _refreshRate)
            {
                _frameRate = 1000 * _framesCountSinceThreshold / _loc_3;
                _framesCountSinceThreshold = 0;
                _lastThreshold = _loc_2;
                dispatchFps();
            }
            return;
        }// end function

    }
}
