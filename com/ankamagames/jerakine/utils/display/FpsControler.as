package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class FpsControler extends Object
   {
      
      public function FpsControler() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FpsControler));
      
      private static var ScriptedAnimation:Class;
      
      private static var _clipList:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private static var _garbageTimer:Timer;
      
      private static var _groupId:int = 0;
      
      public static function Init(param1:Class) : void {
         ScriptedAnimation = param1;
         if(!_garbageTimer)
         {
            _garbageTimer = new Timer(10000);
            _garbageTimer.addEventListener(TimerEvent.TIMER,onGarbageTimer);
            _garbageTimer.start();
         }
      }
      
      private static function onGarbageTimer(param1:Event) : void {
         var _loc3_:MovieClip = null;
         var _loc2_:* = 0;
         while(_loc2_ < _clipList.length)
         {
            _loc3_ = _clipList[_loc2_];
            if(!_loc3_.stage)
            {
               uncontrolFps(_loc3_,false);
            }
            _loc2_++;
         }
      }
      
      public static function controlFps(param1:MovieClip, param2:uint, param3:Boolean=false) : MovieClip {
         if(!MovieClipUtils.isSingleFrame(param1))
         {
            _groupId++;
            controlSingleClip(param1,_groupId,param2,param3);
         }
         return param1;
      }
      
      public static function uncontrolFps(param1:DisplayObjectContainer, param2:Boolean=true) : void {
         var _loc4_:* = 0;
         var _loc5_:Vector.<MovieClip> = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:MovieClip = null;
         if(!param1)
         {
            return;
         }
         MovieClipUtils.stopMovieClip(param1);
         var _loc3_:MovieClip = param1 as MovieClip;
         if((param2) && (_loc3_))
         {
            _loc4_ = _loc3_.groupId;
            if(_loc4_)
            {
               _loc5_ = new Vector.<MovieClip>();
               _loc6_ = _clipList.length;
               _loc7_ = -1;
               while(++_loc7_ < _loc6_)
               {
                  _loc8_ = _clipList[_loc7_];
                  if(_loc8_.groupId == _loc4_)
                  {
                     _loc8_.isControled = null;
                     _clipList.splice(_loc7_,1);
                     _loc7_--;
                     _loc6_--;
                  }
               }
            }
         }
         removeClip(_loc3_);
      }
      
      private static function removeClip(param1:MovieClip) : void {
         var _loc2_:int = _clipList.indexOf(param1);
         if(_loc2_ != -1)
         {
            _clipList.splice(_loc2_,1);
         }
      }
      
      private static function controlSingleClip(param1:DisplayObjectContainer, param2:int, param3:uint, param4:Boolean=false, param5:Boolean=false) : void {
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:DisplayObjectContainer = null;
         if((param1) && !param4)
         {
            _loc8_ = -1;
            _loc9_ = param1.numChildren;
            while(++_loc8_ < _loc9_)
            {
               _loc10_ = param1.getChildAt(_loc8_) as DisplayObjectContainer;
               if(_loc10_)
               {
                  controlSingleClip(_loc10_,param2,param3,true,true);
               }
            }
         }
         if((param5) && param1 is ScriptedAnimation)
         {
            return;
         }
         var _loc6_:MovieClip = param1 as MovieClip;
         if(!_loc6_ || _loc6_.totalFrames == 1 || !(_clipList.indexOf(_loc6_) == -1))
         {
            return;
         }
         _loc6_.groupId = param2;
         var _loc7_:int = _loc6_.currentFrame > 0?_loc6_.currentFrame:1;
         _loc6_.gotoAndStop(_loc7_);
         if(_loc6_ is ScriptedAnimation)
         {
            _loc6_.playEventAtFrame(_loc7_);
         }
         _clipList.push(_loc6_);
         _loc6_.groupId = param2;
         _loc6_.isControled = true;
      }
      
      public static function nextFrame() : void {
         var _loc3_:MovieClip = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc1_:int = _clipList.length;
         var _loc2_:* = -1;
         while(++_loc2_ < _loc1_)
         {
            _loc3_ = _clipList[_loc2_];
            _loc4_ = _loc3_.currentFrame + 1;
            if(_loc4_ > _loc3_.totalFrames)
            {
               _loc4_ = 1;
            }
            _loc3_.gotoAndStop(_loc4_);
            if(_loc3_ is ScriptedAnimation)
            {
               _loc3_.playEventAtFrame(_loc4_);
            }
            _loc5_ = _loc1_ - _clipList.length;
            if(_loc5_)
            {
               _loc1_ = _loc1_ - _loc5_;
               _loc2_ = _loc2_ - _loc5_;
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
            }
         }
      }
   }
}
