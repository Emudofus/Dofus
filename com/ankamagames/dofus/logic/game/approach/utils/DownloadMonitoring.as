package com.ankamagames.dofus.logic.game.approach.utils
{
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.updater.*;
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.dofus.network.messages.updater.parts.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.network.*;
    import flash.events.*;
    import flash.utils.*;

    public class DownloadMonitoring extends Object
    {
        private var _connection:IServerConnection;
        private var _apingSum:uint = 0;
        private var _apingCount:uint = 0;
        private var _timer:Timer;
        private var _downloadSpeed:uint;
        private var _initialized:Boolean = false;
        private var _mode:uint = 0;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DownloadMonitoring));
        private static var _singleton:DownloadMonitoring;
        public static const MODE_LISTEN:uint = 0;
        public static const MODE_WATCH:uint = 1;

        public function DownloadMonitoring() : void
        {
            return;
        }// end function

        public function get downloadSpeed() : uint
        {
            return this._downloadSpeed;
        }// end function

        public function set downloadSpeed(param1:uint) : void
        {
            this._downloadSpeed = param1;
            return;
        }// end function

        public function get mode() : uint
        {
            return this._mode;
        }// end function

        public function set mode(param1:uint) : void
        {
            this._mode = param1;
            return;
        }// end function

        public function get firstAping() : uint
        {
            return this._apingSum / this._apingCount;
        }// end function

        public function initialize() : void
        {
            var _loc_1:DownloadGetCurrentSpeedRequestMessage = null;
            if (InterClientManager.isMaster())
            {
                if (!this._initialized)
                {
                    this._initialized = true;
                    this._mode = MODE_LISTEN;
                    this._timer = new Timer(2000, 0);
                    this._timer.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
                    this._apingSum = 0;
                    this._apingCount = 0;
                    if (UpdaterConnexionHandler.getConnection())
                    {
                        _loc_1 = new DownloadGetCurrentSpeedRequestMessage();
                        _loc_1.initDownloadGetCurrentSpeedRequestMessage();
                        UpdaterConnexionHandler.getConnection().send(_loc_1);
                    }
                }
            }
            return;
        }// end function

        public function start() : void
        {
            if (InterClientManager.isMaster())
            {
                this.initialize();
                this.mode = MODE_WATCH;
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this._initialized)
            {
                this.mode = MODE_LISTEN;
            }
            return;
        }// end function

        private function onTimerEvent(event:TimerEvent) : void
        {
            var _loc_2:uint = 0;
            var _loc_3:DownloadSetSpeedRequestMessage = null;
            if (this._connection == null)
            {
                this._connection = ConnectionsHandler.getConnection();
            }
            if (this._mode == MODE_LISTEN)
            {
                if (this._connection)
                {
                    this._apingSum = this._apingSum + this._connection.latencyAvg;
                    var _loc_4:String = this;
                    var _loc_5:* = this._apingCount + 1;
                    _loc_4._apingCount = _loc_5;
                }
            }
            else if (this._mode == MODE_WATCH)
            {
                _loc_2 = this._connection.latencyAvg;
                if (_loc_2 >= this.firstAping * 2)
                {
                    if (this._downloadSpeed > 1)
                    {
                        var _loc_4:String = this;
                        var _loc_5:* = this._downloadSpeed - 1;
                        _loc_4._downloadSpeed = _loc_5;
                        _log.info("Decrease download speed to " + this._downloadSpeed);
                        _loc_3 = new DownloadSetSpeedRequestMessage();
                        _loc_3.initDownloadSetSpeedRequestMessage(this._downloadSpeed);
                        UpdaterConnexionHandler.getConnection().send(_loc_3);
                    }
                }
                else if (_loc_2 >= this.firstAping * 1.5)
                {
                }
                else if (this._downloadSpeed < 10)
                {
                    var _loc_4:String = this;
                    var _loc_5:* = this._downloadSpeed + 1;
                    _loc_4._downloadSpeed = _loc_5;
                    _log.info("Increase download speed to " + this._downloadSpeed);
                    _loc_3 = new DownloadSetSpeedRequestMessage();
                    _loc_3.initDownloadSetSpeedRequestMessage(this._downloadSpeed);
                    UpdaterConnexionHandler.getConnection().send(_loc_3);
                }
            }
            return;
        }// end function

        public static function getInstance() : DownloadMonitoring
        {
            if (!_singleton)
            {
                _singleton = new DownloadMonitoring;
            }
            return _singleton;
        }// end function

    }
}
