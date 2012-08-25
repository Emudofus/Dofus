package com.ankamagames.jerakine.utils.display
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class FpsControler extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FpsControler));
        private static var ScriptedAnimation:Class;
        private static var _clipList:Vector.<MovieClip> = new Vector.<MovieClip>;
        private static var _garbageTimer:Timer;
        private static var _groupId:int = 0;

        public function FpsControler()
        {
            return;
        }// end function

        public static function Init(param1:Class) : void
        {
            ScriptedAnimation = param1;
            if (!_garbageTimer)
            {
                _garbageTimer = new Timer(10000);
                _garbageTimer.addEventListener(TimerEvent.TIMER, onGarbageTimer);
                _garbageTimer.start();
            }
            return;
        }// end function

        private static function onGarbageTimer(event:Event) : void
        {
            var _loc_3:MovieClip = null;
            var _loc_2:int = 0;
            while (_loc_2 < _clipList.length)
            {
                
                _loc_3 = _clipList[_loc_2];
                if (!_loc_3.stage)
                {
                    uncontrolFps(_loc_3, false);
                }
                _loc_2++;
            }
            return;
        }// end function

        public static function controlFps(param1:MovieClip, param2:uint, param3:Boolean = false) : MovieClip
        {
            if (!MovieClipUtils.isSingleFrame(param1))
            {
                var _loc_5:* = _groupId + 1;
                _groupId = _loc_5;
                controlSingleClip(param1, _groupId, param2, param3);
            }
            return param1;
        }// end function

        public static function uncontrolFps(param1:DisplayObjectContainer, param2:Boolean = true) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Vector.<MovieClip> = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:MovieClip = null;
            if (!param1)
            {
                return;
            }
            MovieClipUtils.stopMovieClip(param1);
            var _loc_3:* = param1 as MovieClip;
            if (param2 && _loc_3)
            {
                _loc_4 = _loc_3.groupId;
                if (_loc_4)
                {
                    _loc_5 = new Vector.<MovieClip>;
                    _loc_6 = _clipList.length;
                    _loc_7 = -1;
                    while (++_loc_7 < _loc_6)
                    {
                        
                        _loc_8 = _clipList[_loc_7];
                        if (_loc_8.groupId == _loc_4)
                        {
                            _loc_8.isControled = null;
                            _clipList.splice(_loc_7, 1);
                            _loc_7 = _loc_7 - 1;
                            _loc_6 = _loc_6 - 1;
                        }
                    }
                }
            }
            removeClip(_loc_3);
            return;
        }// end function

        private static function removeClip(param1:MovieClip) : void
        {
            var _loc_2:* = _clipList.indexOf(param1);
            if (_loc_2 != -1)
            {
                _clipList.splice(_loc_2, 1);
            }
            return;
        }// end function

        private static function controlSingleClip(param1:DisplayObjectContainer, param2:int, param3:uint, param4:Boolean = false, param5:Boolean = false) : void
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:DisplayObjectContainer = null;
            if (param1 && !param4)
            {
                _loc_8 = -1;
                _loc_9 = param1.numChildren;
                while (++_loc_8 < _loc_9)
                {
                    
                    _loc_10 = param1.getChildAt(_loc_8) as DisplayObjectContainer;
                    if (_loc_10)
                    {
                        controlSingleClip(_loc_10, param2, param3, true, true);
                    }
                }
            }
            if (param5 && param1 is ScriptedAnimation)
            {
                return;
            }
            var _loc_6:* = param1 as MovieClip;
            if (!(param1 as MovieClip) || _loc_6.totalFrames == 1 || _clipList.indexOf(_loc_6) != -1)
            {
                return;
            }
            _loc_6.groupId = param2;
            var _loc_7:* = _loc_6.currentFrame > 0 ? (_loc_6.currentFrame) : (1);
            _loc_6.gotoAndStop(_loc_7);
            if (_loc_6 is ScriptedAnimation)
            {
                _loc_6.playEventAtFrame(_loc_7);
            }
            _clipList.push(_loc_6);
            _loc_6.groupId = param2;
            _loc_6.isControled = true;
            return;
        }// end function

        public static function nextFrame() : void
        {
            var _loc_3:MovieClip = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_1:* = _clipList.length;
            var _loc_2:int = -1;
            while (++_loc_2 < _loc_1)
            {
                
                _loc_3 = _clipList[_loc_2];
                if (++_loc_3.currentFrame > _loc_3.totalFrames)
                {
                    ++_loc_3.currentFrame = 1;
                }
                _loc_3.gotoAndStop(++_loc_3.currentFrame);
                if (_loc_3 is ScriptedAnimation)
                {
                    _loc_3.playEventAtFrame(_loc_4);
                }
                _loc_5 = _loc_1 - _clipList.length;
                if (_loc_5)
                {
                    _loc_1 = _loc_1 - _loc_5;
                    _loc_2 = _loc_2 - _loc_5;
                    if (_loc_2 < 0)
                    {
                        _loc_2 = 0;
                    }
                }
            }
            return;
        }// end function

    }
}
