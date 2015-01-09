package com.ankamagames.tiphon.engine
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.tiphon.types.cache.SpriteCacheInfo;
    import com.ankamagames.tiphon.types.cache.AnimCache;
    import com.ankamagames.jerakine.types.Callback;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.tiphon.types.ScriptedAnimation;
    import com.ankamagames.jerakine.types.Swl;
    import com.ankamagames.tiphon.types.TiphonUtility;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.managers.PerformanceManager;
    import __AS3__.vec.*;

    public class TiphonCacheManager 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonCacheManager));
        public static const _cacheList:Dictionary = new Dictionary();
        private static const _spritesListToRender:Vector.<SpriteCacheInfo> = new Vector.<SpriteCacheInfo>();
        private static var _processing:Boolean = false;
        private static var _lastRender:int = 0;
        private static var _waitRender:int = 0;


        public static function init():void
        {
            var bone:int;
            var k:int;
            var anim:String;
            var pokemonBones:Array = new Array(15, 16, 17, 18, 22, 34, 36, 38, 40, 12, 13, 14);
            var animList:Array = new Array("AnimStatique", "AnimMarche", "AnimCourse");
            var i:int = -1;
            var num:int = pokemonBones.length;
            var numAnim:int = animList.length;
            while (++i < num)
            {
                bone = pokemonBones[i];
                k = -1;
                while (++k < numAnim)
                {
                    anim = animList[k];
                    _cacheList[((bone + "_") + anim)] = new AnimCache();
                    Tiphon.skullLibrary.askResource(bone, anim, new Callback(checkRessourceState), new Callback(onRenderFail));
                };
            };
        }

        public static function addSpriteToRender(sprite:TiphonSprite, look:TiphonEntityLook):void
        {
            _spritesListToRender.push(new SpriteCacheInfo(sprite, look));
            if (!(_processing))
            {
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            };
        }

        public static function hasCache(bone:int, anim:String):Boolean
        {
            if (_cacheList[((bone + "_") + anim)])
            {
                return (true);
            };
            return (false);
        }

        public static function pushScriptedAnimation(scriptedAnimation:ScriptedAnimation):void
        {
            var animCache:AnimCache = _cacheList[((scriptedAnimation.bone + "_") + scriptedAnimation.animationName)];
            if (animCache)
            {
                animCache.pushAnimation(scriptedAnimation, scriptedAnimation.direction);
            };
        }

        public static function getScriptedAnimation(bone:int, anim:String, direction:int):ScriptedAnimation
        {
            var scriptedAnimation:ScriptedAnimation;
            var _local_6:Class;
            var _local_7:Swl;
            var _local_8:String;
            var animCache:AnimCache = _cacheList[((bone + "_") + anim)];
            if (animCache)
            {
                scriptedAnimation = animCache.getAnimation(direction);
                if (scriptedAnimation)
                {
                    return (scriptedAnimation);
                };
                _local_7 = Tiphon.skullLibrary.getResourceById(bone, anim);
                _local_8 = ((anim + "_") + direction);
                if (_local_7.hasDefinition(_local_8))
                {
                    _local_6 = (_local_7.getDefinition(_local_8) as Class);
                }
                else
                {
                    _local_8 = ((anim + "_") + TiphonUtility.getFlipDirection(direction));
                    if (_local_7.hasDefinition(_local_8))
                    {
                        _local_6 = (_local_7.getDefinition(_local_8) as Class);
                    };
                };
                scriptedAnimation = (new (_local_6)() as ScriptedAnimation);
                scriptedAnimation.bone = bone;
                scriptedAnimation.animationName = anim;
                scriptedAnimation.direction = direction;
                scriptedAnimation.inCache = true;
                return (scriptedAnimation);
            };
            return (null);
        }

        private static function onEnterFrame(e:Event):void
        {
            var time:int;
            var spriteInfo:SpriteCacheInfo;
            var sprite:TiphonSprite;
            var currentAnim:String;
            var currentDirection:int;
            if (_spritesListToRender.length)
            {
                time = getTimer();
                if ((time - _lastRender) > _waitRender)
                {
                    _lastRender = time;
                    spriteInfo = _spritesListToRender.shift();
                    while (((spriteInfo.sprite.destroyed) && (_spritesListToRender.length)))
                    {
                        spriteInfo = _spritesListToRender.shift();
                    };
                    sprite = spriteInfo.sprite;
                    currentAnim = sprite.getAnimation();
                    currentDirection = sprite.getDirection();
                    sprite.look.updateFrom(spriteInfo.look);
                    sprite.setAnimationAndDirection(currentAnim, currentDirection);
                    if (PerformanceManager.performance == PerformanceManager.NORMAL)
                    {
                        _waitRender = 20;
                    }
                    else
                    {
                        if (PerformanceManager.performance == PerformanceManager.LIMITED)
                        {
                            _waitRender = 200;
                        }
                        else
                        {
                            _waitRender = 500;
                        };
                    };
                };
            }
            else
            {
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                _processing = false;
            };
        }

        private static function checkRessourceState():void
        {
        }

        private static function onRenderFail():void
        {
        }


    }
}//package com.ankamagames.tiphon.engine

