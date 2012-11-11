package com.ankamagames.jerakine.sound
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class AbstractFlashSound extends Socket
    {
        protected var _currentNbPing:int = 0;
        protected var _conn:LocalConnection;
        protected var _data:ByteArray;
        protected var _pingTimer:Timer;
        static var CONNECTION_NAME:String = "DofusRegConnection";
        static const LIMIT_PING_TRY:int = 10000;

        public function AbstractFlashSound(param1:uint = 0)
        {
            CONNECTION_NAME = CONNECTION_NAME + param1.toString();
            this._data = new ByteArray();
            this._conn = new LocalConnection();
            this._pingTimer = new Timer(5000, 1);
            this._pingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPingTimerComplete);
            return;
        }// end function

        protected function removePingTimer() : void
        {
            this._pingTimer.stop();
            this._pingTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPingTimerComplete);
            this._pingTimer = null;
            return;
        }// end function

        private function onPingTimerComplete(event:TimerEvent) : void
        {
            this.connect("", 0);
            return;
        }// end function

        override public function connect(param1:String, param2:int) : void
        {
            return;
        }// end function

        override public function readUTFBytes(param1:uint) : String
        {
            return this._data.readUTFBytes(param1);
        }// end function

        override public function writeUTFBytes(param1:String) : void
        {
            this._data.writeUTFBytes(param1);
            return;
        }// end function

        override public function flush() : void
        {
            return;
        }// end function

        override public function close() : void
        {
            this._data.clear();
            this._conn.close();
            return;
        }// end function

    }
}
