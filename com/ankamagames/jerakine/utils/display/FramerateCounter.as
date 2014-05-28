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
      
      private static var _listeners:Array;
      
      private static var _enterFrameListened:Boolean;
      
      public static function get listeners() : Array {
         return _listeners;
      }
      
      public static function get refreshRate() : uint {
         return _refreshRate;
      }
      
      public static function set refreshRate(value:uint) : void {
         _refreshRate = value;
      }
      
      public static function get frameRate() : uint {
         return _frameRate;
      }
      
      public static function get delayBetweenFrames() : uint {
         return _delayBetweenFrames;
      }
      
      public static function addListener(listener:IFramerateListener) : void {
         _listeners.push(listener);
         if(!_enterFrameListened)
         {
            EnterFrameDispatcher.addEventListener(onEnterFrame,"FramerateCounter",0);
            _enterFrameListened = true;
         }
      }
      
      public static function removeListener(listener:IFramerateListener) : void {
         var index:int = _listeners.indexOf(listener);
         if(index > -1)
         {
            _listeners.splice(index,1);
         }
         if(_listeners.length <= 0)
         {
            EnterFrameDispatcher.removeEventListener(onEnterFrame);
            _enterFrameListened = false;
         }
      }
      
      private static function dispatchFps() : void {
         var listener:IFramerateListener = null;
         for each(listener in _listeners)
         {
            listener.onFps(_frameRate);
         }
      }
      
      private static function onEnterFrame(e:Event) : void {
         _framesCountSinceThreshold++;
         var now:uint = getTimer();
         _delayBetweenFrames = now - _lastFrame;
         _lastFrame = now;
         var delay:uint = now - _lastThreshold;
         if(delay > _refreshRate)
         {
            _frameRate = 1000 * _framesCountSinceThreshold / delay;
            _framesCountSinceThreshold = 0;
            _lastThreshold = now;
            dispatchFps();
         }
      }
   }
}
