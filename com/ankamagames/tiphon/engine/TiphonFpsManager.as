package com.ankamagames.tiphon.engine
{
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import flash.events.TimerEvent;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import flash.events.Event;
   import __AS3__.vec.*;
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
      
      public static function addOldScriptedAnimation(scriptedAnimation:ScriptedAnimation, destroyNow:Boolean=false) : void {
      }
      
      private static function onTiphonGarbageCollector(e:Event) : void {
         var object:Object = null;
         var i:* = 0;
         var num:* = 0;
         var scriptedAnimation:ScriptedAnimation = null;
         var destroyedScriptedAnimation:Vector.<ScriptedAnimation> = new Vector.<ScriptedAnimation>();
         var time:int = getTimer();
         for (object in _oldScriptedAnimation)
         {
            scriptedAnimation = object as ScriptedAnimation;
            if(time - _oldScriptedAnimation[scriptedAnimation] > 300000)
            {
               destroyedScriptedAnimation.push(scriptedAnimation);
               destroyScriptedAnimation(scriptedAnimation);
            }
         }
         i = -1;
         num = destroyedScriptedAnimation.length;
         while(++i < num)
         {
            delete _oldScriptedAnimation[[destroyedScriptedAnimation[i]]];
         }
      }
      
      private static function destroyScriptedAnimation(scriptedAnimation:ScriptedAnimation) : void {
         if((scriptedAnimation) && (!scriptedAnimation.parent))
         {
            scriptedAnimation.destroyed = true;
            if(scriptedAnimation.parent)
            {
               scriptedAnimation.parent.removeChild(scriptedAnimation);
            }
            scriptedAnimation.spriteHandler = null;
            eraseMovieClip(scriptedAnimation);
         }
      }
      
      private static function eraseMovieClip(clip:MovieClip) : void {
         var frames:int = clip.totalFrames + 1;
         var i:int = 1;
         while(i < frames)
         {
            clip.gotoAndStop(i);
            eraseFrame(clip);
            i++;
         }
         clip.stop();
         if(clip.isControled)
         {
            FpsControler.uncontrolFps(clip);
         }
      }
      
      private static function eraseFrame(clip:DisplayObjectContainer) : void {
         var lastChild:DisplayObject = null;
         var child:DisplayObject = null;
         var index:int = 0;
         while(clip.numChildren > index)
         {
            child = clip.removeChildAt(index);
            if(child == lastChild)
            {
               index++;
            }
            lastChild = child;
            if(!(child is DynamicSprite))
            {
               if(child is ScriptedAnimation)
               {
                  destroyScriptedAnimation(clip as ScriptedAnimation);
               }
               else
               {
                  if(child is MovieClip)
                  {
                     eraseMovieClip(child as MovieClip);
                  }
                  else
                  {
                     if(child is DisplayObjectContainer)
                     {
                        eraseFrame(child as DisplayObjectContainer);
                     }
                     else
                     {
                        if(child is Shape)
                        {
                           (child as Shape).graphics.clear();
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
