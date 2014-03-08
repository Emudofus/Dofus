package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class PerformanceManager extends Object
   {
      
      public function PerformanceManager() {
         super();
      }
      
      public static const CRITICAL:int = 0;
      
      public static const LIMITED:int = 1;
      
      public static const NORMAL:int = 2;
      
      public static var optimize:Boolean = false;
      
      public static var performance:int = NORMAL;
      
      public static const BASE_FRAMERATE:int = 50;
      
      public static var maxFrameRate:int = BASE_FRAMERATE;
      
      public static var frameDuration:Number = 1000 / maxFrameRate;
      
      private static var _totalFrames:int = 0;
      
      private static var _framesTime:int = 0;
      
      private static var _lastTime:int = 0;
      
      public static function init(param1:Boolean) : void {
         optimize = param1;
         if(optimize)
         {
            setFrameRate(50);
         }
         StageShareManager.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
      }
      
      public static function setFrameRate(param1:int) : void {
         maxFrameRate = param1;
         frameDuration = 1000 / maxFrameRate;
         StageShareManager.stage.frameRate = maxFrameRate;
      }
      
      private static function onEnterFrame(param1:Event) : void {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc2_:int = performance;
         var _loc3_:int = getTimer();
         if(_totalFrames % 21 == 0)
         {
            _loc4_ = frameDuration * 20;
            if(_framesTime < _loc4_ * 1.05)
            {
               performance = NORMAL;
            }
            else
            {
               if(_framesTime < _loc4_ * 1.15)
               {
                  performance = LIMITED;
               }
               else
               {
                  performance = CRITICAL;
               }
            }
            _framesTime = 0;
         }
         else
         {
            _loc5_ = _loc3_ - _lastTime;
            if(_loc5_ < frameDuration)
            {
               _loc5_ = frameDuration;
            }
            _framesTime = _framesTime + _loc5_;
            if(_loc5_ > 2 * frameDuration)
            {
               performance = CRITICAL;
            }
         }
         _totalFrames++;
         _lastTime = _loc3_;
      }
   }
}
