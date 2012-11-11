package com.ankamagames.tiphon.engine
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.cache.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.events.*;
    import flash.utils.*;

    public class TiphonCacheManager extends Object
    {
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonCacheManager));
        public static const _cacheList:Dictionary = new Dictionary();
        private static const _spritesListToRender:Vector.<SpriteCacheInfo> = new Vector.<SpriteCacheInfo>;
        private static var _processing:Boolean = false;
        private static var _lastRender:int = 0;
        private static var _waitRender:int = 0;

        public function TiphonCacheManager()
        {
            return;
        }// end function

        public static function init() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_1:* = new Array(15, 16, 17, 18, 22, 34, 36, 38, 40, 12, 13, 14);
            var _loc_2:* = new Array("AnimStatique", "AnimMarche", "AnimCourse");
            var _loc_3:* = -1;
            var _loc_4:* = _loc_1.length;
            var _loc_5:* = _loc_2.length;
            while (++_loc_3 < _loc_4)
            {
                
                _loc_6 = _loc_1[_loc_3];
                _loc_7 = -1;
                while (++_loc_7 < _loc_5)
                {
                    
                    _loc_8 = _loc_2[_loc_7];
                    _cacheList[_loc_6 + "_" + _loc_8] = new AnimCache();
                    Tiphon.skullLibrary.askResource(_loc_6, _loc_8, new Callback(checkRessourceState), new Callback(onRenderFail));
                }
            }
            return;
        }// end function

        public static function addSpriteToRender(param1:TiphonSprite, param2:TiphonEntityLook) : void
        {
            _spritesListToRender.push(new SpriteCacheInfo(param1, param2));
            if (!_processing)
            {
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
            return;
        }// end function

        public static function hasCache(param1:int, param2:String) : Boolean
        {
            if (_cacheList[param1 + "_" + param2])
            {
                return true;
            }
            return false;
        }// end function

        public static function pushScriptedAnimation(param1:ScriptedAnimation) : void
        {
            var _loc_2:* = _cacheList[param1.bone + "_" + param1.animationName];
            if (_loc_2)
            {
                _loc_2.pushAnimation(param1, param1.direction);
            }
            return;
        }// end function

        public static function getScriptedAnimation(param1:int, param2:String, param3:int) : ScriptedAnimation
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = _cacheList[param1 + "_" + param2];
            if (_cacheList[param1 + "_" + param2])
            {
                _loc_5 = _loc_4.getAnimation(param3);
                if (_loc_5)
                {
                    return _loc_5;
                }
                _loc_7 = Tiphon.skullLibrary.getResourceById(param1, param2);
                _loc_8 = param2 + "_" + param3;
                if (_loc_7.hasDefinition(_loc_8))
                {
                    _loc_6 = _loc_7.getDefinition(_loc_8) as Class;
                }
                else
                {
                    _loc_8 = param2 + "_" + TiphonUtility.getFlipDirection(param3);
                    if (_loc_7.hasDefinition(_loc_8))
                    {
                        _loc_6 = _loc_7.getDefinition(_loc_8) as Class;
                    }
                }
                _loc_5 = new _loc_6 as ScriptedAnimation;
                _loc_5.bone = param1;
                _loc_5.animationName = param2;
                _loc_5.direction = param3;
                _loc_5.inCache = true;
                return _loc_5;
            }
            else
            {
                return null;
            }
        }// end function

        private static function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (_spritesListToRender.length)
            {
                _loc_2 = getTimer();
                if (_loc_2 - _lastRender > _waitRender)
                {
                    _lastRender = _loc_2;
                    _loc_3 = _spritesListToRender.shift();
                    while (_loc_3.sprite.destroyed && _spritesListToRender.length)
                    {
                        
                        _loc_3 = _spritesListToRender.shift();
                    }
                    _loc_4 = _loc_3.sprite;
                    _loc_5 = _loc_4.getAnimation();
                    _loc_6 = _loc_4.getDirection();
                    _loc_4.look.updateFrom(_loc_3.look);
                    _loc_4.setAnimationAndDirection(_loc_5, _loc_6);
                    if (PerformanceManager.performance == PerformanceManager.NORMAL)
                    {
                        _waitRender = 20;
                    }
                    else if (PerformanceManager.performance == PerformanceManager.LIMITED)
                    {
                        _waitRender = 200;
                    }
                    else
                    {
                        _waitRender = 500;
                    }
                }
            }
            else
            {
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                _processing = false;
            }
            return;
        }// end function

        private static function checkRessourceState() : void
        {
            return;
        }// end function

        private static function onRenderFail() : void
        {
            return;
        }// end function

    }
}
