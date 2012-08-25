package com.ankamagames.jerakine.utils.display
{
    import com.ankamagames.jerakine.logger.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class EnterFrameDispatcher extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EnterFrameDispatcher));
        private static var _listenerUp:Boolean;
        private static var _currentTime:uint;
        private static var _controledListeners:Dictionary = new Dictionary(true);
        private static var _realTimeListeners:Dictionary = new Dictionary();
        private static var _listenersCount:uint;

        public function EnterFrameDispatcher()
        {
            return;
        }// end function

        public static function get enterFrameListenerCount() : uint
        {
            return _listenersCount;
        }// end function

        public static function get controledEnterFrameListeners() : Dictionary
        {
            return _controledListeners;
        }// end function

        public static function get realTimeEnterFrameListeners() : Dictionary
        {
            return _realTimeListeners;
        }// end function

        public static function addEventListener(param1:Function, param2:String, param3:uint = 4.29497e+009) : void
        {
            var _loc_4:Stage = null;
            if (param3 == uint.MAX_VALUE || param3 >= StageShareManager.stage.frameRate)
            {
                _realTimeListeners[param1] = param2;
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, param1, false, 0, true);
            }
            else if (!_controledListeners[param1])
            {
                _controledListeners[param1] = new ControledEnterFrameListener(param2, param1, param3 > 0 ? (1000 / param3) : (0), _listenerUp ? (_currentTime) : (getTimer()));
                if (!_listenerUp)
                {
                    StageShareManager.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
                    _loc_4 = StageShareManager.stage;
                    _listenerUp = true;
                }
            }
            return;
        }// end function

        public static function hasEventListener(param1:Function) : Boolean
        {
            return _controledListeners[param1] != null;
        }// end function

        public static function removeEventListener(param1:Function) : void
        {
            var _loc_2:* = undefined;
            if (_controledListeners[param1])
            {
                delete _controledListeners[param1];
                var _loc_4:* = _listenersCount - 1;
                _listenersCount = _loc_4;
            }
            if (_realTimeListeners[param1])
            {
                delete _realTimeListeners[param1];
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, param1, false);
                var _loc_4:* = _listenersCount - 1;
                _listenersCount = _loc_4;
            }
            for each (_loc_2 in _controledListeners)
            {
                
                return;
            }
            if (StageShareManager.stage)
            {
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
            _listenerUp = false;
            return;
        }// end function

        private static function onEnterFrame(event:Event) : void
        {
            var _loc_2:ControledEnterFrameListener = null;
            var _loc_3:uint = 0;
            _currentTime = getTimer();
            for each (_loc_2 in _controledListeners)
            {
                
                _loc_3 = _currentTime - _loc_2.latestChange;
                if (_loc_3 > _loc_2.wantedGap - _loc_2.overhead)
                {
                    _loc_2.listener(event);
                    _loc_2.latestChange = _currentTime;
                    _loc_2.overhead = _loc_3 - _loc_2.wantedGap + _loc_2.overhead;
                }
            }
            return;
        }// end function

    }
}

class ControledEnterFrameListener extends Object
{
    public var name:String;
    public var listener:Function;
    public var wantedGap:uint;
    public var overhead:uint;
    public var latestChange:uint;

    function ControledEnterFrameListener(param1:String, param2:Function, param3:uint, param4:uint)
    {
        this.name = param1;
        this.listener = param2;
        this.wantedGap = param3;
        this.latestChange = param4;
        return;
    }// end function

}

