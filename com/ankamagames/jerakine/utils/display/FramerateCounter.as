package com.ankamagames.jerakine.utils.display
{
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class FramerateCounter extends Object
   {
      
      public function FramerateCounter() {
         super();
      }
      
      private static var _refreshRate:uint = 5000;
      
      private static var _lastThreshold:uint;
      
      private static var _framesCountSinceThreshold:uint;
      
      private static var _frameRate:uint;
      
      private static var _delayBetweenFrames:uint;
      
      private static var _lastFrame:uint;
      
      private static var _listeners:Array = new Array();
      
      private static var _enterFrameListened:Boolean;
      
      public static function get listeners() : Array {
         return _listeners;
      }
      
      public static function get refreshRate() : uint {
         return _refreshRate;
      }
      
      public static function set refreshRate(param1:uint) : void {
         _refreshRate = param1;
      }
      
      public static function get frameRate() : uint {
         return _frameRate;
      }
      
      public static function get delayBetweenFrames() : uint {
         return _delayBetweenFrames;
      }
      
      public static function addListener(param1:IFramerateListener) : void {
         _listeners.push(param1);
         if(!_enterFrameListened)
         {
            EnterFrameDispatcher.addEventListener(onEnterFrame,"FramerateCounter",0);
            _enterFrameListened = true;
         }
      }
      
      public static function removeListener(param1:IFramerateListener) : void {
         var _loc2_:int = _listeners.indexOf(param1);
         if(_loc2_ > -1)
         {
            _listeners.splice(_loc2_,1);
         }
         if(_listeners.length <= 0)
         {
            EnterFrameDispatcher.removeEventListener(onEnterFrame);
            _enterFrameListened = false;
         }
      }
      
      private static function dispatchFps() : void {
         var _loc1_:IFramerateListener = null;
         for each (_loc1_ in _listeners)
         {
            _loc1_.onFps(_frameRate);
         }
      }
      
      private static function onEnterFrame(param1:Event) : void {
         _framesCountSinceThreshold++;
         var _loc2_:uint = getTimer();
         _delayBetweenFrames = _loc2_ - _lastFrame;
         _lastFrame = _loc2_;
         var _loc3_:uint = _loc2_ - _lastThreshold;
         if(_loc3_ > _refreshRate)
         {
            _frameRate = 1000 * _framesCountSinceThreshold / _loc3_;
            _framesCountSinceThreshold = 0;
            _lastThreshold = _loc2_;
            dispatchFps();
         }
      }
   }
}
