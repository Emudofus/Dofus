package com.ankamagames.dofus.logic.game.approach.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.network.IServerConnection;
   import flash.utils.Timer;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadGetCurrentSpeedRequestMessage;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadSetSpeedRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   
   public class DownloadMonitoring extends Object
   {
      
      public function DownloadMonitoring() {
         super();
      }
      
      protected static const _log:Logger;
      
      private static var _singleton:DownloadMonitoring;
      
      public static const MODE_LISTEN:uint = 0;
      
      public static const MODE_WATCH:uint = 1;
      
      public static function getInstance() : DownloadMonitoring {
         if(!_singleton)
         {
            _singleton = new DownloadMonitoring();
         }
         return _singleton;
      }
      
      private var _connection:IServerConnection;
      
      private var _apingSum:uint = 0;
      
      private var _apingCount:uint = 0;
      
      private var _timer:Timer;
      
      private var _downloadSpeed:uint;
      
      private var _initialized:Boolean = false;
      
      private var _mode:uint = 0;
      
      public function get downloadSpeed() : uint {
         return this._downloadSpeed;
      }
      
      public function set downloadSpeed(speed:uint) : void {
         this._downloadSpeed = speed;
      }
      
      public function get mode() : uint {
         return this._mode;
      }
      
      public function set mode(value:uint) : void {
         this._mode = value;
      }
      
      public function get firstAping() : uint {
         return this._apingSum / this._apingCount;
      }
      
      public function initialize() : void {
         var dcsrmsg:DownloadGetCurrentSpeedRequestMessage = null;
         if(InterClientManager.isMaster())
         {
            if(!this._initialized)
            {
               this._initialized = true;
               this._mode = MODE_LISTEN;
               this._timer = new Timer(2000,0);
               this._timer.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
               this._apingSum = 0;
               this._apingCount = 0;
               if(UpdaterConnexionHandler.getConnection())
               {
                  dcsrmsg = new DownloadGetCurrentSpeedRequestMessage();
                  dcsrmsg.initDownloadGetCurrentSpeedRequestMessage();
                  UpdaterConnexionHandler.getConnection().send(dcsrmsg);
               }
            }
         }
      }
      
      public function start() : void {
         if(InterClientManager.isMaster())
         {
            this.initialize();
            this.mode = MODE_WATCH;
         }
      }
      
      public function stop() : void {
         if(this._initialized)
         {
            this.mode = MODE_LISTEN;
         }
      }
      
      private function onTimerEvent(te:TimerEvent) : void {
         var aping:uint = 0;
         var dssrmsg:DownloadSetSpeedRequestMessage = null;
         if(this._connection == null)
         {
            this._connection = ConnectionsHandler.getConnection().mainConnection;
         }
         if(this._mode == MODE_LISTEN)
         {
            if(this._connection)
            {
               this._apingSum = this._apingSum + this._connection.latencyAvg;
               this._apingCount++;
            }
         }
         else if(this._mode == MODE_WATCH)
         {
            aping = this._connection.latencyAvg;
            if(aping >= this.firstAping * 2)
            {
               if(this._downloadSpeed > 1)
               {
                  this._downloadSpeed--;
                  _log.info("Decrease download speed to " + this._downloadSpeed);
                  dssrmsg = new DownloadSetSpeedRequestMessage();
                  dssrmsg.initDownloadSetSpeedRequestMessage(this._downloadSpeed);
                  UpdaterConnexionHandler.getConnection().send(dssrmsg);
               }
            }
            else if(aping < this.firstAping * 1.5)
            {
               if(this._downloadSpeed < 10)
               {
                  this._downloadSpeed++;
                  _log.info("Increase download speed to " + this._downloadSpeed);
                  dssrmsg = new DownloadSetSpeedRequestMessage();
                  dssrmsg.initDownloadSetSpeedRequestMessage(this._downloadSpeed);
                  UpdaterConnexionHandler.getConnection().send(dssrmsg);
               }
            }
            
         }
         
      }
   }
}
