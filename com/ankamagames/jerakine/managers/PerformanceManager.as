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

      public static var frameDuration:Number = 1000/maxFrameRate;

      private static var _totalFrames:int = 0;

      private static var _framesTime:int = 0;

      private static var _lastTime:int = 0;

      public static function init(lowQualityEnabled:Boolean) : void {
         optimize=lowQualityEnabled;
         if(optimize)
         {
            setFrameRate(50);
         }
         StageShareManager.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
      }

      public static function setFrameRate(frameRate:int) : void {
         maxFrameRate=frameRate;
         frameDuration=1000/maxFrameRate;
         StageShareManager.stage.frameRate=maxFrameRate;
      }

      private static function onEnterFrame(e:Event) : void {
         var optimalCondition:* = 0;
         var currentFrameDuration:* = 0;
         var LAST:int = performance;
         var time:int = getTimer();
         if(_totalFrames%21==0)
         {
            optimalCondition=frameDuration*20;
            if(_framesTime<optimalCondition*1.05)
            {
               performance=NORMAL;
            }
            else
            {
               if(_framesTime<optimalCondition*1.15)
               {
                  performance=LIMITED;
               }
               else
               {
                  performance=CRITICAL;
               }
            }
            _framesTime=0;
         }
         else
         {
            currentFrameDuration=time-_lastTime;
            if(currentFrameDuration<frameDuration)
            {
               currentFrameDuration=frameDuration;
            }
            _framesTime=_framesTime+currentFrameDuration;
            if(currentFrameDuration>2*frameDuration)
            {
               performance=CRITICAL;
            }
         }
         _totalFrames++;
         _lastTime=time;
      }


   }

}