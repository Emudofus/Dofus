package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import flash.display.DisplayObjectContainer;
   import __AS3__.vec.*;
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
      
      public static function Init(scriptedAnimation:Class) : void {
         ScriptedAnimation = scriptedAnimation;
         if(!_garbageTimer)
         {
            _garbageTimer = new Timer(10000);
            _garbageTimer.addEventListener(TimerEvent.TIMER,onGarbageTimer);
            _garbageTimer.start();
         }
      }
      
      private static function onGarbageTimer(E:Event) : void {
         var movieClip:MovieClip = null;
         var i:int = 0;
         while(i < _clipList.length)
         {
            movieClip = _clipList[i];
            if(!movieClip.stage)
            {
               uncontrolFps(movieClip,false);
            }
            i++;
         }
      }
      
      public static function controlFps(clip:MovieClip, framerate:uint, forbidRecursivity:Boolean=false) : MovieClip {
         if(!MovieClipUtils.isSingleFrame(clip))
         {
            _groupId++;
            controlSingleClip(clip,_groupId,framerate,forbidRecursivity);
         }
         return clip;
      }
      
      public static function uncontrolFps(displayObject:DisplayObjectContainer, group:Boolean=true) : void {
         var groupId:* = 0;
         var buffer:Vector.<MovieClip> = null;
         var num:* = 0;
         var i:* = 0;
         var mc:MovieClip = null;
         if(!displayObject)
         {
            return;
         }
         MovieClipUtils.stopMovieClip(displayObject);
         var movieClip:MovieClip = displayObject as MovieClip;
         if((group) && (movieClip))
         {
            groupId = movieClip.groupId;
            if(groupId)
            {
               buffer = new Vector.<MovieClip>();
               num = _clipList.length;
               i = -1;
               while(++i < num)
               {
                  mc = _clipList[i];
                  if(mc.groupId == groupId)
                  {
                     mc.isControled = null;
                     _clipList.splice(i,1);
                     i--;
                     num--;
                  }
               }
            }
         }
         removeClip(movieClip);
      }
      
      private static function removeClip(mc:MovieClip) : void {
         var index:int = _clipList.indexOf(mc);
         if(index != -1)
         {
            _clipList.splice(index,1);
         }
      }
      
      private static function controlSingleClip(clip:DisplayObjectContainer, id:int, framerate:uint, forbidRecursivity:Boolean=false, recursive:Boolean=false) : void {
         var i:* = 0;
         var numChildren:* = 0;
         var child:DisplayObjectContainer = null;
         if((clip) && (!forbidRecursivity))
         {
            i = -1;
            numChildren = clip.numChildren;
            while(++i < numChildren)
            {
               child = clip.getChildAt(i) as DisplayObjectContainer;
               if(child)
               {
                  controlSingleClip(child,id,framerate,true,true);
               }
            }
         }
         if((recursive) && (clip is ScriptedAnimation))
         {
            return;
         }
         var movieClip:MovieClip = clip as MovieClip;
         if((!movieClip) || (movieClip.totalFrames == 1) || (!(_clipList.indexOf(movieClip) == -1)))
         {
            return;
         }
         movieClip.groupId = id;
         var startFrame:int = movieClip.currentFrame > 0?movieClip.currentFrame:1;
         movieClip.gotoAndStop(startFrame);
         if(movieClip is ScriptedAnimation)
         {
            movieClip.playEventAtFrame(startFrame);
         }
         _clipList.push(movieClip);
         movieClip.groupId = id;
         movieClip.isControled = true;
      }
      
      public static function nextFrame() : void {
         var movieClip:MovieClip = null;
         var frame:* = 0;
         var diff:* = 0;
         var num:int = _clipList.length;
         var i:int = -1;
         while(++i < num)
         {
            movieClip = _clipList[i];
            frame = movieClip.currentFrame + 1;
            if(frame > movieClip.totalFrames)
            {
               frame = 1;
            }
            movieClip.gotoAndStop(frame);
            if(movieClip is ScriptedAnimation)
            {
               movieClip.playEventAtFrame(frame);
            }
            diff = num - _clipList.length;
            if(diff)
            {
               num = num - diff;
               i = i - diff;
               if(i < 0)
               {
                  i = 0;
               }
            }
         }
      }
   }
}
