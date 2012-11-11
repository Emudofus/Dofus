package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class PerformanceManager extends Object
    {
        public static const CRITICAL:int = 0;
        public static const LIMITED:int = 1;
        public static const NORMAL:int = 2;
        public static var optimize:Boolean = false;
        public static var performance:int = 2;
        public static const BASE_FRAMERATE:int = 50;
        public static var maxFrameRate:int = 50;
        public static var frameDuration:Number = 1000 / maxFrameRate;
        private static var _totalFrames:int = 0;
        private static var _framesTime:int = 0;
        private static var _lastTime:int = 0;

        public function PerformanceManager()
        {
            return;
        }// end function

        public static function init(param1:Boolean) : void
        {
            optimize = param1;
            if (optimize)
            {
                setFrameRate(50);
            }
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            return;
        }// end function

        public static function setFrameRate(param1:int) : void
        {
            maxFrameRate = param1;
            frameDuration = 1000 / maxFrameRate;
            StageShareManager.stage.frameRate = maxFrameRate;
            return;
        }// end function

        private static function onEnterFrame(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = performance;
            var _loc_3:* = getTimer();
            if (_totalFrames % 21 == 0)
            {
                _loc_4 = frameDuration * 20;
                if (_framesTime < _loc_4 * 1.05)
                {
                    performance = NORMAL;
                }
                else if (_framesTime < _loc_4 * 1.15)
                {
                    performance = LIMITED;
                }
                else
                {
                    performance = CRITICAL;
                }
                _framesTime = 0;
            }
            else
            {
                _loc_5 = _loc_3 - _lastTime;
                if (_loc_5 < frameDuration)
                {
                    _loc_5 = frameDuration;
                }
                _framesTime = _framesTime + _loc_5;
                if (_loc_5 > 2 * frameDuration)
                {
                    performance = CRITICAL;
                }
            }
            var _loc_7:* = _totalFrames + 1;
            _totalFrames = _loc_7;
            _lastTime = _loc_3;
            return;
        }// end function

    }
}
