package com.ankamagames.jerakine.utils.display
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.utils.getTimer;

    public class EnterFrameDispatcher 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EnterFrameDispatcher));
        private static var _listenerUp:Boolean;
        private static var _currentTime:uint;
        private static var _controledListeners:Dictionary = new Dictionary(true);
        private static var _realTimeListeners:Dictionary = new Dictionary();
        private static var _listenersCount:uint;


        public static function get enterFrameListenerCount():uint
        {
            return (_listenersCount);
        }

        public static function get controledEnterFrameListeners():Dictionary
        {
            return (_controledListeners);
        }

        public static function get realTimeEnterFrameListeners():Dictionary
        {
            return (_realTimeListeners);
        }

        public static function addEventListener(listener:Function, name:String, frameRate:uint=0xFFFFFFFF):void
        {
            var s:Stage;
            if ((((frameRate == uint.MAX_VALUE)) || ((frameRate >= StageShareManager.stage.frameRate))))
            {
                _realTimeListeners[listener] = name;
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, listener, false, 0, true);
            }
            else
            {
                if (!(_controledListeners[listener]))
                {
                    _controledListeners[listener] = new ControledEnterFrameListener(name, listener, (((frameRate > 0)) ? (1000 / frameRate) : (0)), ((_listenerUp) ? _currentTime : getTimer()));
                    if (!(_listenerUp))
                    {
                        StageShareManager.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
                        s = StageShareManager.stage;
                        _listenerUp = true;
                    };
                };
            };
            _listenersCount++;
        }

        public static function hasEventListener(listener:Function):Boolean
        {
            return (!((_controledListeners[listener] == null)));
        }

        public static function removeEventListener(listener:Function):void
        {
            var k:*;
            if (_controledListeners[listener])
            {
                delete _controledListeners[listener];
                _listenersCount--;
            };
            if (_realTimeListeners[listener])
            {
                delete _realTimeListeners[listener];
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, listener, false);
                _listenersCount--;
            };
            for each (k in _controledListeners)
            {
                return;
            };
            if (StageShareManager.stage)
            {
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            };
            _listenerUp = false;
        }

        private static function onEnterFrame(e:Event):void
        {
            var cefl:ControledEnterFrameListener;
            var diff:uint;
            _currentTime = getTimer();
            for each (cefl in _controledListeners)
            {
                diff = (_currentTime - cefl.latestChange);
                if (diff > (cefl.wantedGap - cefl.overhead))
                {
                    cefl.listener(e);
                    cefl.latestChange = _currentTime;
                    cefl.overhead = ((diff - cefl.wantedGap) + cefl.overhead);
                };
            };
        }


    }
}//package com.ankamagames.jerakine.utils.display

class ControledEnterFrameListener 
{

    public var name:String;
    public var listener:Function;
    public var wantedGap:uint;
    public var overhead:uint;
    public var latestChange:uint;

    public function ControledEnterFrameListener(name:String, listener:Function, wantedGap:uint, latestChange:uint)
    {
        this.name = name;
        this.listener = listener;
        this.wantedGap = wantedGap;
        this.latestChange = latestChange;
    }

}

