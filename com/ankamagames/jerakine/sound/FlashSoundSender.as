package com.ankamagames.jerakine.sound
{
    import com.ankamagames.jerakine.logger.*;
    import flash.events.*;
    import flash.utils.*;

    public class FlashSoundSender extends AbstractFlashSound
    {
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(FlashSoundSender));

        public function FlashSoundSender(param1:uint = 0)
        {
            super(param1);
            _conn.addEventListener(StatusEvent.STATUS, this.onStatus);
            _conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.dispatchError);
            return;
        }// end function

        private function dispatchError(event:ErrorEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function onStatus(event:StatusEvent) : void
        {
            switch(event.level)
            {
                case "status":
                {
                    event.currentTarget.removeEventListener(StatusEvent.STATUS, this.onStatus);
                    dispatchEvent(new Event(Event.CONNECT));
                    removePingTimer();
                    break;
                }
                case "error":
                {
                    if (_currentNbPing >= LIMIT_PING_TRY)
                    {
                        _log.fatal("nb try reached");
                        event.currentTarget.removeEventListener(StatusEvent.STATUS, this.onStatus);
                        dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                        removePingTimer();
                    }
                    else
                    {
                        _pingTimer.start();
                    }
                    break;
                }
                default:
                {
                    _log.fatal("status level: " + event.level);
                    break;
                    break;
                }
            }
            return;
        }// end function

        override public function connect(param1:String, param2:int) : void
        {
            var _loc_4:* = _currentNbPing + 1;
            _currentNbPing = _loc_4;
            _log.debug("try to ping");
            _conn.send(CONNECTION_NAME, "ping");
            return;
        }// end function

        override public function flush() : void
        {
            _conn.send(CONNECTION_NAME, "onData", _data);
            _data.clear();
            return;
        }// end function

    }
}
