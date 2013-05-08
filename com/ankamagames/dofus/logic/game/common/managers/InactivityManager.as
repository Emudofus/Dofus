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
         

      public function InactivityManager() {
         super();
         _log.info("Initialisation du manager d\'inactivit�");
         this._activityTimer=new Timer(INACTIVITY_DELAY);
         this._activityTimer.addEventListener(TimerEvent.TIMER,this.onActivityTimerUp);
         this._serverActivityTimer=new Timer(SERVER_INACTIVITY_DELAY,0);
         this._serverActivityTimer.addEventListener(TimerEvent.TIMER,this.onServerActivityTimerUp);
         this.resetActivity();
         this.resetServerActivity();
      }

      private static var _self:InactivityManager;

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InactivityManager));

      public static function getInstance() : InactivityManager {
         if(!_self)
         {
            _self=new InactivityManager();
         }
         return _self;
      }

      private static const SERVER_INACTIVITY_DELAY:int = 10*60*1000;

      private static const INACTIVITY_DELAY:int = 20*60*1000;

      private static function serverNotification() : void {
         var msg:BasicPingMessage = null;
         if(ConnectionsHandler.getConnection().connected)
         {
            msg=new BasicPingMessage();
            msg.quiet=true;
            ConnectionsHandler.getConnection().send(msg);
         }
      }

      private var _isAfk:Boolean;

      private var _activityTimer:Timer;

      private var _serverActivityTimer:Timer;

      private var _hasActivity:Boolean = false;

      public function start() : void {
         _log.info("D�marage du manager d\'inactivit�");
         this.resetActivity();
         this.resetServerActivity();
         StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
         StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onActivity);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
         this._isAfk=false;
      }

      public function stop() : void {
         _log.info("Arret du manager d\'inactivit�");
         this._activityTimer.stop();
         this._serverActivityTimer.stop();
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
         StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onActivity);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
      }

      public function resetActivity() : void {
         this._activityTimer.reset();
         this._activityTimer.start();
      }

      public function resetServerActivity() : void {
         this._serverActivityTimer.reset();
         this._serverActivityTimer.start();
      }

      public function activity() : void {
         this.resetActivity();
         this._hasActivity=true;
         if(this._isAfk)
         {
            this._isAfk=false;
            KernelEventsManager.getInstance().processCallback(HookList.InactivityNotification,false);
         }
      }

      private function onActivity(event:Event) : void {
         this.activity();
      }

      private function onActivityTimerUp(event:Event) : void {
         this._isAfk=true;
         _log.info("Le timer d\'activit� � expir�. Dispatch de callback de notification d\'inactivit�");
         KernelEventsManager.getInstance().processCallback(HookList.InactivityNotification,true);
      }

      private function onServerActivityTimerUp(event:Event) : void {
         if(this._hasActivity)
         {
            this._hasActivity=false;
            serverNotification();
         }
      }
   }

}