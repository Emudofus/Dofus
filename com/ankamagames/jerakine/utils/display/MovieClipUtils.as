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
      
      private static var _asynchClip:Dictionary = new Dictionary(true);
      
      private static var _isAsync:Boolean;
      
      public static var asynchStopCount:uint;
      
      public static var asynchStopDoneCount:uint;
      
      public static function isSingleFrame(param1:DisplayObjectContainer) : Boolean {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:DisplayObjectContainer = null;
         var _loc2_:MovieClip = param1 as MovieClip;
         if((_loc2_) && _loc2_.totalFrames > 1)
         {
            return false;
         }
         _loc3_ = -1;
         _loc4_ = param1.numChildren;
         while(++_loc3_ < _loc4_)
         {
            _loc5_ = param1.getChildAt(_loc3_) as DisplayObjectContainer;
            if((_loc5_) && !isSingleFrame(_loc5_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function stopMovieClip(param1:DisplayObjectContainer) : void {
         var _loc4_:DisplayObject = null;
         if(param1 is MovieClip)
         {
            MovieClip(param1).stop();
            if((_isAsync) && MovieClip(param1).totalFrames > 1)
            {
               asynchStopDoneCount++;
            }
         }
         var _loc2_:* = -1;
         var _loc3_:int = param1.numChildren;
         while(++_loc2_ < _loc3_)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_ is DisplayObjectContainer)
            {
               stopMovieClip(_loc4_ as DisplayObjectContainer);
            }
         }
      }
      
      private static function stopMovieClipASynch(param1:Event) : void {
         var _loc3_:Object = null;
         var _loc4_:* = false;
         var _loc5_:* = undefined;
         var _loc6_:DisplayObject = null;
         var _loc2_:* = true;
         for (_loc3_ in _asynchClip)
         {
            if(_loc3_)
            {
               for (_loc5_ in _asynchClip[_loc3_])
               {
                  if(!_asynchClip[_loc3_][_loc5_])
                  {
                     _loc6_ = _loc3_.getChildAt(_loc5_);
                     if(!_loc6_)
                     {
                        _loc4_ = true;
                     }
                     else
                     {
                        if(_loc6_ is DisplayObjectContainer)
                        {
                           _isAsync = true;
                           stopMovieClip(_loc6_ as DisplayObjectContainer);
                           _isAsync = false;
                        }
                     }
                  }
               }
               if(!_loc4_)
               {
                  delete _asynchClip[[_loc3_]];
               }
               else
               {
                  _loc2_ = false;
               }
            }
         }
         if(_loc2_)
         {
            EnterFrameDispatcher.removeEventListener(stopMovieClipASynch);
         }
      }
   }
}
