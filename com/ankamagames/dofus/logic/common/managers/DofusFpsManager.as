package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.types.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.replay.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.ankamagames.tiphon.engine.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class DofusFpsManager extends Object
    {
        private static var _totalFrame:int = 0;
        private static var _animFPS:int = 25;
        private static var _interval:int = 1000 / _animFPS;
        private static var _framePlayed:int = 0;
        private static var _frameNeeded:int = 0;
        private static var _focusListInfo:Array = new Array();
        public static var currentFps:Number;
        private static var _elapsedTime:uint;
        private static var _lastTime:uint;
        private static var _frame:uint;
        private static var _logWrapped:FpsLogWrapper;
        private static var _logRamWrapped:FpsLogWrapper;

        public function DofusFpsManager()
        {
            return;
        }// end function

        public static function init() : void
        {
            EnterFrameDispatcher.addEventListener(onEnterFrame, "DofusFpsManager");
            StageShareManager.stage.addEventListener(Event.ACTIVATE, onActivate);
            StageShareManager.stage.addEventListener(Event.DEACTIVATE, onDesactivate);
            NativeApplication.nativeApplication.openedWindows[0].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, onStateChange);
            TiphonCacheManager.init();
            _logWrapped = new FpsLogWrapper();
            _logRamWrapped = new FpsLogWrapper();
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG || BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL)
            {
                TiphonDebugManager.enable();
            }
            return;
        }// end function

        public static function updateFocusList(param1:Array, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_8:* = NaN;
            var _loc_3:* = NativeApplication.nativeApplication.openedWindows[0];
            if (AirScanner.hasAir())
            {
                if (_loc_3 && _loc_3["displayState"] == NativeWindowDisplayState.MINIMIZED)
                {
                    StageShareManager.stage.frameRate = 12;
                    return;
                }
            }
            var _loc_6:* = param1.length;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                if (_loc_4 == null)
                {
                    _loc_4 = param1[_loc_7];
                    _loc_5 = Number(param1[(_loc_7 + 1)]);
                }
                else
                {
                    _loc_8 = Number(param1[(_loc_7 + 1)]);
                    if (_loc_5 < _loc_8)
                    {
                        _loc_4 = param1[_loc_7];
                        _loc_5 = _loc_8;
                    }
                }
                _loc_7 = _loc_7 + 2;
            }
            if (param2 == _loc_4)
            {
                StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
            }
            else
            {
                StageShareManager.stage.frameRate = 12;
            }
            return;
        }// end function

        private static function onActivate(event:Event) : void
        {
            StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
            var _loc_2:* = Dofus.getInstance().options;
            if (_loc_2 && _loc_2.optimizeMultiAccount)
            {
                InterClientManager.getInstance().gainFocus();
            }
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER, onStageRollOver);
            return;
        }// end function

        private static function onDesactivate(event:Event) : void
        {
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER, onStageRollOver);
            return;
        }// end function

        private static function onStageRollOver(event:Event) : void
        {
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER, onStageRollOver);
            StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
            return;
        }// end function

        private static function onStateChange(event:NativeWindowDisplayStateEvent) : void
        {
            var _loc_2:* = Dofus.getInstance().options;
            if (_loc_2 && _loc_2.optimizeMultiAccount)
            {
                if (event.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
                {
                    StageShareManager.stage.frameRate = 12;
                    InterClientManager.getInstance().resetFocus();
                }
                else
                {
                    StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
                }
            }
            return;
        }// end function

        private static function onEnterFrame(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = getTimer();
            _elapsedTime = _elapsedTime + (_loc_2 - _lastTime);
            var _loc_6:* = _frame + 1;
            _frame = _loc_6;
            if (_elapsedTime > 1000)
            {
                currentFps = _frame / (_elapsedTime / 1000);
                _elapsedTime = 0;
                _frame = 0;
                if (LogFrame.enabled)
                {
                    _logWrapped.fps = currentFps;
                    _logRamWrapped.fps = System.totalMemory;
                    LogFrame.log(LogTypeEnum.FPS, _logWrapped);
                    LogFrame.log(LogTypeEnum.RAM, _logRamWrapped);
                }
            }
            _frameNeeded = _loc_2 / _interval;
            var _loc_6:* = _totalFrame + 1;
            _totalFrame = _loc_6;
            var _loc_3:* = _frameNeeded - _framePlayed;
            if (_loc_3)
            {
                _framePlayed = _frameNeeded;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    FpsControler.nextFrame();
                    _loc_4++;
                }
            }
            _lastTime = _loc_2;
            return;
        }// end function

    }
}
