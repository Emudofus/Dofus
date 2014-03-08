package com.ankamagames.tiphon.engine
{
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import flash.events.TimerEvent;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import flash.events.Event;
   import __AS3__.vec.Vector;
   import flash.utils.getTimer;
   import flash.display.MovieClip;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import com.ankamagames.tiphon.types.DynamicSprite;
   import flash.display.Shape;
   
   public class TiphonFpsManager extends Object
   {
      
      public function TiphonFpsManager() {
         super();
      }
      
      private static var _tiphonGarbageCollectorTimer:Timer = new Timer(60000);
      
      private static var _oldScriptedAnimation:Dictionary = new Dictionary(true);
      
      public static function init() : void {
         _tiphonGarbageCollectorTimer.addEventListener(TimerEvent.TIMER,onTiphonGarbageCollector);
      }
      
      public static function addOldScriptedAnimation(param1:ScriptedAnimation, param2:Boolean=false) : void {
      }
      
      private static function onTiphonGarbageCollector(param1:Event) : void {
         var _loc4_:Object = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:ScriptedAnimation = null;
         var _loc2_:Vector.<ScriptedAnimation> = new Vector.<ScriptedAnimation>();
         var _loc3_:int = getTimer();
         for (_loc4_ in _oldScriptedAnimation)
         {
            _loc7_ = _loc4_ as ScriptedAnimation;
            if(_loc3_ - _oldScriptedAnimation[_loc7_] > 300000)
            {
               _loc2_.push(_loc7_);
               destroyScriptedAnimation(_loc7_);
            }
         }
         _loc5_ = -1;
         _loc6_ = _loc2_.length;
         while(++_loc5_ < _loc6_)
         {
            delete _oldScriptedAnimation[[_loc2_[_loc5_]]];
         }
      }
      
      private static function destroyScriptedAnimation(param1:ScriptedAnimation) : void {
         if((param1) && !param1.parent)
         {
            param1.destroyed = true;
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
            param1.spriteHandler = null;
            eraseMovieClip(param1);
         }
      }
      
      private static function eraseMovieClip(param1:MovieClip) : void {
         var _loc2_:int = param1.totalFrames + 1;
         var _loc3_:* = 1;
         while(_loc3_ < _loc2_)
         {
            param1.gotoAndStop(_loc3_);
            eraseFrame(param1);
            _loc3_++;
         }
         param1.stop();
         if(param1.isControled)
         {
            FpsControler.uncontrolFps(param1);
         }
      }
      
      private static function eraseFrame(param1:DisplayObjectContainer) : void {
         var _loc3_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         var _loc2_:* = 0;
         while(param1.numChildren > _loc2_)
         {
            _loc4_ = param1.removeChildAt(_loc2_);
            if(_loc4_ == _loc3_)
            {
               _loc2_++;
            }
            _loc3_ = _loc4_;
            if(!(_loc4_ is DynamicSprite))
            {
               if(_loc4_ is ScriptedAnimation)
               {
                  destroyScriptedAnimation(param1 as ScriptedAnimation);
               }
               else
               {
                  if(_loc4_ is MovieClip)
                  {
                     eraseMovieClip(_loc4_ as MovieClip);
                  }
                  else
                  {
                     if(_loc4_ is DisplayObjectContainer)
                     {
                        eraseFrame(_loc4_ as DisplayObjectContainer);
                     }
                     else
                     {
                        if(_loc4_ is Shape)
                        {
                           (_loc4_ as Shape).graphics.clear();
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
