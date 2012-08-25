package com.ankamagames.tiphon.engine
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.types.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class TiphonFpsManager extends Object
    {
        private static var _tiphonGarbageCollectorTimer:Timer = new Timer(60000);
        private static var _oldScriptedAnimation:Dictionary = new Dictionary(true);

        public function TiphonFpsManager()
        {
            return;
        }// end function

        public static function init() : void
        {
            _tiphonGarbageCollectorTimer.addEventListener(TimerEvent.TIMER, onTiphonGarbageCollector);
            return;
        }// end function

        public static function addOldScriptedAnimation(param1:ScriptedAnimation, param2:Boolean = false) : void
        {
            return;
        }// end function

        private static function onTiphonGarbageCollector(event:Event) : void
        {
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:ScriptedAnimation = null;
            var _loc_2:* = new Vector.<ScriptedAnimation>;
            var _loc_3:* = getTimer();
            for (_loc_4 in _oldScriptedAnimation)
            {
                
                _loc_7 = _loc_4 as ScriptedAnimation;
                if (_loc_3 - _oldScriptedAnimation[_loc_7] > 300000)
                {
                    _loc_2.push(_loc_7);
                    destroyScriptedAnimation(_loc_7);
                }
            }
            _loc_5 = -1;
            _loc_6 = _loc_2.length;
            while (++_loc_5 < _loc_6)
            {
                
                delete _oldScriptedAnimation[_loc_2[_loc_5]];
            }
            return;
        }// end function

        private static function destroyScriptedAnimation(param1:ScriptedAnimation) : void
        {
            if (param1 && !param1.parent)
            {
                param1.destroyed = true;
                if (param1.parent)
                {
                    param1.parent.removeChild(param1);
                }
                param1.spriteHandler = null;
                eraseMovieClip(param1);
            }
            return;
        }// end function

        private static function eraseMovieClip(param1:MovieClip) : void
        {
            var _loc_2:* = param1.totalFrames + 1;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                param1.gotoAndStop(_loc_3);
                eraseFrame(param1);
                _loc_3++;
            }
            param1.stop();
            if (param1.isControled)
            {
                FpsControler.uncontrolFps(param1);
            }
            return;
        }// end function

        private static function eraseFrame(param1:DisplayObjectContainer) : void
        {
            var _loc_3:DisplayObject = null;
            var _loc_4:DisplayObject = null;
            var _loc_2:int = 0;
            while (param1.numChildren > _loc_2)
            {
                
                _loc_4 = param1.removeChildAt(_loc_2);
                if (_loc_4 == _loc_3)
                {
                    _loc_2++;
                }
                _loc_3 = _loc_4;
                if (_loc_4 is DynamicSprite)
                {
                    continue;
                }
                if (_loc_4 is ScriptedAnimation)
                {
                    destroyScriptedAnimation(param1 as ScriptedAnimation);
                    continue;
                }
                if (_loc_4 is MovieClip)
                {
                    eraseMovieClip(_loc_4 as MovieClip);
                    continue;
                }
                if (_loc_4 is DisplayObjectContainer)
                {
                    eraseFrame(_loc_4 as DisplayObjectContainer);
                    continue;
                }
                if (_loc_4 is Shape)
                {
                    (_loc_4 as Shape).graphics.clear();
                }
            }
            return;
        }// end function

    }
}
