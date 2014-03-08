package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.tiphon.types.cache.SpriteCacheInfo;
   import com.ankamagames.tiphon.types.cache.AnimCache;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.managers.PerformanceManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class TiphonCacheManager extends Object
   {
      
      public function TiphonCacheManager() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonCacheManager));
      
      public static const _cacheList:Dictionary = new Dictionary();
      
      private static const _spritesListToRender:Vector.<SpriteCacheInfo> = new Vector.<SpriteCacheInfo>();
      
      private static var _processing:Boolean = false;
      
      private static var _lastRender:int = 0;
      
      private static var _waitRender:int = 0;
      
      public static function init() : void {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         var _loc1_:Array = new Array(15,16,17,18,22,34,36,38,40,12,13,14);
         var _loc2_:Array = new Array("AnimStatique","AnimMarche","AnimCourse");
         var _loc3_:* = -1;
         var _loc4_:int = _loc1_.length;
         var _loc5_:int = _loc2_.length;
         while(++_loc3_ < _loc4_)
         {
            _loc6_ = _loc1_[_loc3_];
            _loc7_ = -1;
            while(++_loc7_ < _loc5_)
            {
               _loc8_ = _loc2_[_loc7_];
               _cacheList[_loc6_ + "_" + _loc8_] = new AnimCache();
               Tiphon.skullLibrary.askResource(_loc6_,_loc8_,new Callback(checkRessourceState),new Callback(onRenderFail));
            }
         }
      }
      
      public static function addSpriteToRender(param1:TiphonSprite, param2:TiphonEntityLook) : void {
         _spritesListToRender.push(new SpriteCacheInfo(param1,param2));
         if(!_processing)
         {
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         }
      }
      
      public static function hasCache(param1:int, param2:String) : Boolean {
         if(_cacheList[param1 + "_" + param2])
         {
            return true;
         }
         return false;
      }
      
      public static function pushScriptedAnimation(param1:ScriptedAnimation) : void {
         var _loc2_:AnimCache = _cacheList[param1.bone + "_" + param1.animationName];
         if(_loc2_)
         {
            _loc2_.pushAnimation(param1,param1.direction);
         }
      }
      
      public static function getScriptedAnimation(param1:int, param2:String, param3:int) : ScriptedAnimation {
         var _loc5_:ScriptedAnimation = null;
         var _loc6_:Class = null;
         var _loc7_:Swl = null;
         var _loc8_:String = null;
         var _loc4_:AnimCache = _cacheList[param1 + "_" + param2];
         if(_loc4_)
         {
            _loc5_ = _loc4_.getAnimation(param3);
            if(_loc5_)
            {
               return _loc5_;
            }
            _loc7_ = Tiphon.skullLibrary.getResourceById(param1,param2);
            _loc8_ = param2 + "_" + param3;
            if(_loc7_.hasDefinition(_loc8_))
            {
               _loc6_ = _loc7_.getDefinition(_loc8_) as Class;
            }
            else
            {
               _loc8_ = param2 + "_" + TiphonUtility.getFlipDirection(param3);
               if(_loc7_.hasDefinition(_loc8_))
               {
                  _loc6_ = _loc7_.getDefinition(_loc8_) as Class;
               }
            }
            _loc5_ = new _loc6_() as ScriptedAnimation;
            _loc5_.bone = param1;
            _loc5_.animationName = param2;
            _loc5_.direction = param3;
            _loc5_.inCache = true;
            return _loc5_;
         }
         return null;
      }
      
      private static function onEnterFrame(param1:Event) : void {
         var _loc2_:* = 0;
         var _loc3_:SpriteCacheInfo = null;
         var _loc4_:TiphonSprite = null;
         var _loc5_:String = null;
         var _loc6_:* = 0;
         if(_spritesListToRender.length)
         {
            _loc2_ = getTimer();
            if(_loc2_ - _lastRender > _waitRender)
            {
               _lastRender = _loc2_;
               _loc3_ = _spritesListToRender.shift();
               while((_loc3_.sprite.destroyed) && (_spritesListToRender.length))
               {
                  _loc3_ = _spritesListToRender.shift();
               }
               _loc4_ = _loc3_.sprite;
               _loc5_ = _loc4_.getAnimation();
               _loc6_ = _loc4_.getDirection();
               _loc4_.look.updateFrom(_loc3_.look);
               _loc4_.setAnimationAndDirection(_loc5_,_loc6_);
               if(PerformanceManager.performance == PerformanceManager.NORMAL)
               {
                  _waitRender = 20;
               }
               else
               {
                  if(PerformanceManager.performance == PerformanceManager.LIMITED)
                  {
                     _waitRender = 200;
                  }
                  else
                  {
                     _waitRender = 500;
                  }
               }
            }
         }
         else
         {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            _processing = false;
         }
      }
      
      private static function checkRessourceState() : void {
      }
      
      private static function onRenderFail() : void {
      }
   }
}
