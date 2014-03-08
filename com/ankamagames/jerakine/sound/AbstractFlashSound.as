package com.ankamagames.jerakine.sound
{
   import flash.net.Socket;
   import flash.net.LocalConnection;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   
   public class AbstractFlashSound extends Socket
   {
      
      public function AbstractFlashSound(param1:uint=0) {
         super();
         CONNECTION_NAME = CONNECTION_NAME + param1.toString();
         this._data = new ByteArray();
         this._conn = new LocalConnection();
         this._pingTimer = new Timer(5000,1);
         this._pingTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPingTimerComplete);
      }
      
      protected static var CONNECTION_NAME:String = "DofusRegConnection";
      
      protected static const LIMIT_PING_TRY:int = 10000;
      
      protected var _currentNbPing:int = 0;
      
      protected var _conn:LocalConnection;
      
      protected var _data:ByteArray;
      
      protected var _pingTimer:Timer;
      
      protected function removePingTimer() : void {
         this._pingTimer.stop();
         this._pingTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPingTimerComplete);
         this._pingTimer = null;
      }
      
      private function onPingTimerComplete(param1:TimerEvent) : void {
         this.connect("",0);
      }
      
      override public function connect(param1:String, param2:int) : void {
      }
      
      override public function readUTFBytes(param1:uint) : String {
         return this._data.readUTFBytes(param1);
      }
      
      override public function writeUTFBytes(param1:String) : void {
         this._data.writeUTFBytes(param1);
      }
      
      override public function flush() : void {
      }
      
      override public function close() : void {
         this._data.clear();
         this._conn.close();
      }
   }
}
