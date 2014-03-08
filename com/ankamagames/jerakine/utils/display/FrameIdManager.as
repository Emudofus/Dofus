package com.ankamagames.jerakine.utils.display
{
   import flash.events.Event;
   
   public class FrameIdManager extends Object
   {
      
      public function FrameIdManager() {
         super();
      }
      
      private static var _init:Boolean;
      
      private static var _frameId:uint;
      
      public static function get frameId() : uint {
         return _frameId;
      }
      
      public static function init() : void {
         if(_init)
         {
            return;
         }
         EnterFrameDispatcher.addEventListener(onEnterFrame,"frameIdManager");
         _init = true;
      }
      
      private static function onEnterFrame(param1:Event) : void {
         _frameId++;
      }
   }
}
