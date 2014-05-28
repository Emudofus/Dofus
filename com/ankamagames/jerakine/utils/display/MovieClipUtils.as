package com.ankamagames.jerakine.utils.display
{
   import flash.utils.Dictionary;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class MovieClipUtils extends Object
   {
      
      public function MovieClipUtils() {
         super();
      }
      
      private static var _asynchClip:Dictionary;
      
      private static var _isAsync:Boolean;
      
      public static var asynchStopCount:uint;
      
      public static var asynchStopDoneCount:uint;
      
      public static function isSingleFrame(mc:DisplayObjectContainer) : Boolean {
         var i:* = 0;
         var num:* = 0;
         var child:DisplayObjectContainer = null;
         var movieClip:MovieClip = mc as MovieClip;
         if((movieClip) && (movieClip.totalFrames > 1))
         {
            return false;
         }
         i = -1;
         num = mc.numChildren;
         while(++i < num)
         {
            child = mc.getChildAt(i) as DisplayObjectContainer;
            if((child) && (!isSingleFrame(child)))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function stopMovieClip(clip:DisplayObjectContainer) : void {
         var child:DisplayObject = null;
         if(clip is MovieClip)
         {
            MovieClip(clip).stop();
            if((_isAsync) && (MovieClip(clip).totalFrames > 1))
            {
               asynchStopDoneCount++;
            }
         }
         var i:int = -1;
         var num:int = clip.numChildren;
         while(++i < num)
         {
            child = clip.getChildAt(i);
            if(child is DisplayObjectContainer)
            {
               stopMovieClip(child as DisplayObjectContainer);
            }
         }
      }
      
      private static function stopMovieClipASynch(e:Event) : void {
         var clip:Object = null;
         var missing:* = false;
         var frame:* = undefined;
         var clipToStop:DisplayObject = null;
         var allDone:Boolean = true;
         for(clip in _asynchClip)
         {
            if(clip)
            {
               for(frame in _asynchClip[clip])
               {
                  if(!_asynchClip[clip][frame])
                  {
                     clipToStop = clip.getChildAt(frame);
                     if(!clipToStop)
                     {
                        missing = true;
                     }
                     else if(clipToStop is DisplayObjectContainer)
                     {
                        _isAsync = true;
                        stopMovieClip(clipToStop as DisplayObjectContainer);
                        _isAsync = false;
                     }
                     
                  }
               }
               if(!missing)
               {
                  delete _asynchClip[clip];
               }
               else
               {
                  allDone = false;
               }
            }
         }
         if(allDone)
         {
            EnterFrameDispatcher.removeEventListener(stopMovieClipASynch);
         }
      }
   }
}
