package com.ankamagames.jerakine.utils.display
{
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;

    public class StageShareManager extends Object
    {
        private static const NOT_INITIALIZED:int = -77777;
        private static var _stage:Stage;
        private static var _startWidth:uint;
        private static var _startHeight:uint;
        private static var _rootContainer:DisplayObjectContainer;
        private static var _customMouseX:int = -77777;
        private static var _customMouseY:int = -77777;
        private static var _lastStageX:Number;
        private static var _lastStageY:Number;
        private static var _setQualityIsEnable:Boolean;

        public function StageShareManager()
        {
            return;
        }// end function

        public static function set rootContainer(param1:DisplayObjectContainer) : void
        {
            _rootContainer = param1;
            return;
        }// end function

        public static function get rootContainer() : DisplayObjectContainer
        {
            return _rootContainer;
        }// end function

        public static function get stage() : Stage
        {
            return _stage;
        }// end function

        public static function set stage(param1:Stage) : void
        {
            _stage = param1;
            _startWidth = 1280;
            _startHeight = 1024;
            if (AirScanner.hasAir())
            {
                _stage["nativeWindow"].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, displayStateChangeHandler);
            }
            return;
        }// end function

        public static function testQuality() : void
        {
            var _loc_1:* = _stage.quality;
            _stage.quality = StageQuality.MEDIUM;
            _setQualityIsEnable = _stage.quality.toLowerCase() == StageQuality.MEDIUM;
            _stage.quality = _loc_1;
            return;
        }// end function

        public static function get startWidth() : uint
        {
            return _startWidth;
        }// end function

        public static function get startHeight() : uint
        {
            return _startHeight;
        }// end function

        public static function get setQualityIsEnable() : Boolean
        {
            return _setQualityIsEnable;
        }// end function

        public static function get mouseX() : int
        {
            if (_customMouseX == NOT_INITIALIZED)
            {
                return _rootContainer.mouseX;
            }
            return _customMouseX;
        }// end function

        public static function set mouseX(param1:int) : void
        {
            _customMouseX = param1;
            return;
        }// end function

        public static function get mouseY() : int
        {
            if (_customMouseY == NOT_INITIALIZED)
            {
                return _rootContainer.mouseY;
            }
            return _customMouseY;
        }// end function

        public static function set mouseY(param1:int) : void
        {
            _customMouseY = param1;
            return;
        }// end function

        public static function get stageOffsetX() : int
        {
            return _rootContainer.x;
        }// end function

        public static function get stageOffsetY() : int
        {
            return _rootContainer.y;
        }// end function

        public static function get stageScaleX() : Number
        {
            return _rootContainer.scaleX;
        }// end function

        public static function get stageScaleY() : Number
        {
            return _rootContainer.scaleY;
        }// end function

        private static function displayStateChangeHandler(event:NativeWindowDisplayStateEvent) : void
        {
            var _loc_2:NativeWindow = null;
            if (event.beforeDisplayState == NativeWindowDisplayState.MINIMIZED)
            {
                if (AirScanner.hasAir())
                {
                    _loc_2 = _stage["nativeWindow"];
                    if (event.afterDisplayState == NativeWindowDisplayState.NORMAL)
                    {
                        (_loc_2.width - 1);
                        (_loc_2.width + 1);
                    }
                }
            }
            return;
        }// end function

    }
}
