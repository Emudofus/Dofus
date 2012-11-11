package com.ankamagames.jerakine.utils.display
{
    import flash.events.*;

    public class FrameIdManager extends Object
    {
        private static var _init:Boolean;
        private static var _frameId:uint;

        public function FrameIdManager()
        {
            return;
        }// end function

        public static function get frameId() : uint
        {
            return _frameId;
        }// end function

        public static function init() : void
        {
            if (_init)
            {
                return;
            }
            EnterFrameDispatcher.addEventListener(onEnterFrame, "frameIdManager");
            _init = true;
            return;
        }// end function

        private static function onEnterFrame(event:Event) : void
        {
            var _loc_3:* = _frameId + 1;
            _frameId = _loc_3;
            return;
        }// end function

    }
}
