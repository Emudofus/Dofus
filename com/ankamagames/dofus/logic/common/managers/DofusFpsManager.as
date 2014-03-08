package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.desktop.NativeApplication;
   import flash.events.NativeWindowDisplayStateEvent;
   import com.ankamagames.tiphon.engine.TiphonCacheManager;
   import com.ankamagames.dofus.types.data.FpsLogWrapper;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.tiphon.engine.TiphonDebugManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowDisplayState;
   import com.ankamagames.jerakine.managers.PerformanceManager;
   import com.ankamagames.dofus.types.DofusOptions;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.replay.LogFrame;
   import flash.system.System;
   import com.ankamagames.jerakine.replay.LogTypeEnum;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   
   public class DofusFpsManager extends Object
   {
      
      public function DofusFpsManager() {
         super();
      }
      
      private static var _totalFrame:int = 0;
      
      private static var _animFPS:int = 25;
      
      private static var _interval:int = 1000 / _animFPS;
      
      private static var _framePlayed:int = 0;
      
      private static var _frameNeeded:int = 0;
      
      private static var _focusListInfo:Array = new Array();
      
      public static var currentFps:Number;
      
      public static function init() : void {
         EnterFrameDispatcher.addEventListener(onEnterFrame,"DofusFpsManager");
         StageShareManager.stage.addEventListener(Event.ACTIVATE,onActivate);
         StageShareManager.stage.addEventListener(Event.DEACTIVATE,onDesactivate);
         NativeApplication.nativeApplication.openedWindows[0].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,onStateChange);
         TiphonCacheManager.init();
         _logWrapped = new FpsLogWrapper();
         _logRamWrapped = new FpsLogWrapper();
         if(BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG || BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL)
         {
            TiphonDebugManager.enable();
         }
      }
      
      public static function updateFocusList(param1:Array, param2:String) : void {
         var _loc5_:String = null;
         var _loc6_:* = NaN;
         var _loc9_:* = NaN;
         var _loc3_:Boolean = AirScanner.hasAir();
         var _loc4_:NativeWindow = NativeApplication.nativeApplication.openedWindows[0];
         if(_loc3_)
         {
            if((_loc4_) && _loc4_["displayState"] == NativeWindowDisplayState.MINIMIZED)
            {
               StageShareManager.stage.frameRate = 12;
               return;
            }
         }
         var _loc7_:int = param1.length;
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            if(_loc5_ == null)
            {
               _loc5_ = param1[_loc8_];
               _loc6_ = Number(param1[_loc8_ + 1]);
            }
            else
            {
               _loc9_ = Number(param1[_loc8_ + 1]);
               if(_loc6_ < _loc9_)
               {
                  _loc5_ = param1[_loc8_];
                  _loc6_ = _loc9_;
               }
            }
            _loc8_ = _loc8_ + 2;
         }
         if(param2 == _loc5_)
         {
            StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
         }
         else
         {
            if(!_loc3_ || ((_loc3_) && (_loc4_)) && (!_loc4_.active))
            {
               StageShareManager.stage.frameRate = 12;
            }
         }
      }
      
      private static function onActivate(param1:Event) : void {
         StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
         var _loc2_:DofusOptions = Dofus.getInstance().options;
         if((_loc2_) && (_loc2_.optimizeMultiAccount))
         {
            InterClientManager.getInstance().gainFocus();
         }
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,onStageRollOver);
      }
      
      private static function onDesactivate(param1:Event) : void {
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER,onStageRollOver);
      }
      
      private static function onStageRollOver(param1:Event) : void {
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,onStageRollOver);
         StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
      }
      
      private static function onStateChange(param1:NativeWindowDisplayStateEvent) : void {
         var _loc2_:DofusOptions = Dofus.getInstance().options;
         if((_loc2_) && (_loc2_.optimizeMultiAccount))
         {
            if(param1.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
            {
               StageShareManager.stage.frameRate = 12;
               InterClientManager.getInstance().resetFocus();
            }
            else
            {
               StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
            }
         }
      }
      
      private static var _elapsedTime:uint;
      
      private static var _lastTime:uint;
      
      private static var _frame:uint;
      
      private static var _logWrapped:FpsLogWrapper;
      
      private static var _logRamWrapped:FpsLogWrapper;
      
      private static function onEnterFrame(param1:Event) : void {
         var _loc4_:* = 0;
         var _loc2_:int = getTimer();
         _elapsedTime = _elapsedTime + (_loc2_ - _lastTime);
         _frame++;
         if(_elapsedTime > 1000)
         {
            currentFps = _frame / (_elapsedTime / 1000);
            _elapsedTime = 0;
            _frame = 0;
            if(LogFrame.enabled)
            {
               _logWrapped.fps = currentFps;
               _logRamWrapped.fps = System.totalMemory;
               LogFrame.log(LogTypeEnum.FPS,_logWrapped);
               LogFrame.log(LogTypeEnum.RAM,_logRamWrapped);
            }
         }
         _frameNeeded = _loc2_ / _interval;
         _totalFrame++;
         var _loc3_:int = _frameNeeded - _framePlayed;
         if(_loc3_)
         {
            _framePlayed = _frameNeeded;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               FpsControler.nextFrame();
               _loc4_++;
            }
         }
         _lastTime = _loc2_;
      }
   }
}
