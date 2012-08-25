package com.ankamagames.jerakine.utils.display
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class MovieClipUtils extends Object
    {
        private static var _asynchClip:Dictionary = new Dictionary(true);
        private static var _isAsync:Boolean;
        public static var asynchStopCount:uint;
        public static var asynchStopDoneCount:uint;

        public function MovieClipUtils()
        {
            return;
        }// end function

        public static function isSingleFrame(param1:DisplayObjectContainer) : Boolean
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:DisplayObjectContainer = null;
            var _loc_2:* = param1 as MovieClip;
            if (_loc_2 && _loc_2.totalFrames > 1)
            {
                return false;
            }
            _loc_3 = -1;
            _loc_4 = param1.numChildren;
            while (++_loc_3 < _loc_4)
            {
                
                _loc_5 = param1.getChildAt(_loc_3) as DisplayObjectContainer;
                if (_loc_5 && !isSingleFrame(_loc_5))
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function stopMovieClip(param1:DisplayObjectContainer) : void
        {
            var _loc_4:DisplayObject = null;
            if (param1 is MovieClip)
            {
                MovieClip(param1).stop();
                if (_isAsync && MovieClip(param1).totalFrames > 1)
                {
                    var _loc_6:* = asynchStopDoneCount + 1;
                    asynchStopDoneCount = _loc_6;
                }
            }
            var _loc_2:int = -1;
            var _loc_3:* = param1.numChildren;
            while (++_loc_2 < _loc_3)
            {
                
                _loc_4 = param1.getChildAt(_loc_2);
                if (_loc_4 is DisplayObjectContainer)
                {
                    stopMovieClip(_loc_4 as DisplayObjectContainer);
                }
            }
            return;
        }// end function

        private static function stopMovieClipASynch(event:Event) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Boolean = false;
            var _loc_5:* = undefined;
            var _loc_6:DisplayObject = null;
            var _loc_2:Boolean = true;
            for (_loc_3 in _asynchClip)
            {
                
                if (_loc_3)
                {
                    for (_loc_5 in _asynchClip[_loc_3])
                    {
                        
                        if (!_asynchClip[_loc_3][_loc_5])
                        {
                            _loc_6 = _loc_3.getChildAt(_loc_5);
                            if (!_loc_6)
                            {
                                _loc_4 = true;
                                continue;
                            }
                            if (_loc_6 is DisplayObjectContainer)
                            {
                                _isAsync = true;
                                stopMovieClip(_loc_6 as DisplayObjectContainer);
                                _isAsync = false;
                            }
                        }
                    }
                    if (!_loc_4)
                    {
                        delete _asynchClip[_loc_3];
                        continue;
                    }
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                EnterFrameDispatcher.removeEventListener(stopMovieClipASynch);
            }
            return;
        }// end function

    }
}
