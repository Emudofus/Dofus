package com.ankamagames.jerakine.utils.display
{
   import flash.display.Stage;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.events.NativeWindowDisplayStateEvent;
   import flash.display.StageQuality;
   import flash.display.StageDisplayState;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowDisplayState;
   
   public class StageShareManager extends Object
   {
      
      public function StageShareManager() {
         super();
      }
      
      private static const NOT_INITIALIZED:int = -77777;
      
      private static var _stage:Stage;
      
      private static var _startWidth:uint;
      
      private static var _startHeight:uint;
      
      private static var _rootContainer:DisplayObjectContainer;
      
      private static var _customMouseX:int = NOT_INITIALIZED;
      
      private static var _customMouseY:int = NOT_INITIALIZED;
      
      private static var _setQualityIsEnable:Boolean;
      
      private static var _chrome:Point = new Point();
      
      public static var nativeWindowStartWidth:uint;
      
      public static var nativeWindowStartHeight:uint;
      
      public static var chromeWidth:uint;
      
      public static var chromeHeight:uint;
      
      public static function set rootContainer(param1:DisplayObjectContainer) : void {
         _rootContainer = param1;
      }
      
      public static function get rootContainer() : DisplayObjectContainer {
         return _rootContainer;
      }
      
      public static function get stage() : Stage {
         return _stage;
      }
      
      public static function get windowScale() : Number {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(AirScanner.hasAir())
         {
            _loc1_ = (stage.nativeWindow.width - chrome.x) / startWidth;
            _loc2_ = (stage.nativeWindow.height - chrome.y) / startHeight;
            _loc3_ = Math.min(_loc1_,_loc2_);
            return _loc3_;
         }
         return Math.min(stage.stageWidth / startWidth,stage.stageHeight / startHeight);
      }
      
      public static function set stage(param1:Stage) : void {
         _stage = param1;
         _startWidth = 1280;
         _startHeight = 1024;
         if(AirScanner.hasAir())
         {
            _stage["nativeWindow"].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,displayStateChangeHandler);
         }
      }
      
      public static function testQuality() : void {
         var _loc1_:String = _stage.quality;
         _stage.quality = StageQuality.MEDIUM;
         _setQualityIsEnable = _stage.quality.toLowerCase() == StageQuality.MEDIUM;
         _stage.quality = _loc1_;
      }
      
      public static function setFullScreen(param1:Boolean, param2:Boolean=false) : void {
         if(AirScanner.hasAir())
         {
            if(param1)
            {
               if(!param2)
               {
                  StageShareManager.stage.displayState = StageDisplayState["FULL_SCREEN_INTERACTIVE"];
               }
               else
               {
                  StageShareManager.stage["nativeWindow"].maximize();
               }
            }
            else
            {
               if(!param2)
               {
                  StageShareManager.stage.displayState = StageDisplayState.NORMAL;
               }
               else
               {
                  StageShareManager.stage["nativeWindow"].minimize();
               }
            }
         }
      }
      
      public static function get startWidth() : uint {
         return _startWidth;
      }
      
      public static function get startHeight() : uint {
         return _startHeight;
      }
      
      public static function get setQualityIsEnable() : Boolean {
         return _setQualityIsEnable;
      }
      
      public static function get mouseX() : int {
         if(_customMouseX == NOT_INITIALIZED)
         {
            return _rootContainer.mouseX;
         }
         return _customMouseX;
      }
      
      public static function set mouseX(param1:int) : void {
         _customMouseX = param1;
      }
      
      public static function get mouseY() : int {
         if(_customMouseY == NOT_INITIALIZED)
         {
            return _rootContainer.mouseY;
         }
         return _customMouseY;
      }
      
      public static function set mouseY(param1:int) : void {
         _customMouseY = param1;
      }
      
      public static function get stageOffsetX() : int {
         return _rootContainer.x;
      }
      
      public static function get stageOffsetY() : int {
         return _rootContainer.y;
      }
      
      public static function get stageScaleX() : Number {
         return _rootContainer.scaleX;
      }
      
      public static function get stageScaleY() : Number {
         return _rootContainer.scaleY;
      }
      
      private static function displayStateChangeHandler(param1:NativeWindowDisplayStateEvent) : void {
         var _loc2_:NativeWindow = null;
         if(param1.beforeDisplayState == NativeWindowDisplayState.MINIMIZED)
         {
            if(AirScanner.hasAir())
            {
               _loc2_ = _stage["nativeWindow"];
               if(param1.afterDisplayState == NativeWindowDisplayState.NORMAL)
               {
                  _loc2_.width = _loc2_.width-1;
                  _loc2_.width = _loc2_.width + 1;
               }
            }
         }
      }
      
      public static function get chrome() : Point {
         return _chrome;
      }
      
      public static function set chrome(param1:Point) : void {
         _chrome = param1;
      }
   }
}
