package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class InactivityManager extends Object
   {
      
      public function InactivityManager()
      {
         super();
         this._activityTimer = new Timer(INACTIVITY_DELAY);
         this._activityTimer.addEventListener(TimerEvent.TIMER,this.onActivityTimerUp);
         this._serverActivityTimer = new Timer(SERVER_INACTIVITY_DELAY,0);
         this._serverActivityTimer.addEventListener(TimerEvent.TIMER,this.onServerActivityTimerUp);
         this.resetActivity();
         this.resetServerActivity();
      }
      
      private static var _self:InactivityManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InactivityManager));
      
      public static function getInstance() : InactivityManager
      {
         if(!_self)
         {
            _self = new InactivityManager();
         }
         return _self;
      }
      
      private static const SERVER_INACTIVITY_DELAY:int = 10 * 60 * 1000;
      
      private static const INACTIVITY_DELAY:int = 20 * 60 * 1000;
      
      private static function serverNotification() : void
      {
         var _loc1_:BasicPingMessage = null;
         if(ConnectionsHandler.getConnection().connected)
         {
            _loc1_ = new BasicPingMessage();
            _loc1_.initBasicPingMessage(true);
            ConnectionsHandler.getConnection().send(_loc1_);
         }
      }
      
      private var _isAfk:Boolean;
      
      private var _activityTimer:Timer;
      
      private var _serverActivityTimer:Timer;
      
      private var _hasActivity:Boolean = false;
      
      public function get inactivityDelay() : Number
      {
         return this._activityTimer.delay;
      }
      
      public function set inactivityDelay(param1:Number) : void
      {
         this._activityTimer.delay = param1;
         this._activityTimer.reset();
         this._activityTimer.start();
      }
      
      public function start() : void
      {
         this.resetActivity();
         this.resetServerActivity();
         StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
         StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onActivity);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
         this._isAfk = false;
      }
      
      public function stop() : void
      {
         this._activityTimer.stop();
         this._serverActivityTimer.stop();
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
         StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onActivity);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
      }
      
      public function resetActivity() : void
      {
         this._activityTimer.reset();
         this._activityTimer.start();
      }
      
      public function resetServerActivity() : void
      {
         this._serverActivityTimer.reset();
         this._serverActivityTimer.start();
      }
      
      public function activity() : void
      {
         this.resetActivity();
         this._hasActivity = true;
         if(this._isAfk)
         {
            this._isAfk = false;
            KernelEventsManager.getInstance().processCallback(HookList.InactivityNotification,false);
         }
      }
      
      private function onActivity(param1:Event) : void
      {
         this.activity();
      }
      
      private function onActivityTimerUp(param1:Event) : void
      {
         this._isAfk = true;
         KernelEventsManager.getInstance().processCallback(HookList.InactivityNotification,true);
      }
      
      private function onServerActivityTimerUp(param1:Event) : void
      {
         if(this._hasActivity)
         {
            this._hasActivity = false;
            serverNotification();
         }
      }
   }
}
