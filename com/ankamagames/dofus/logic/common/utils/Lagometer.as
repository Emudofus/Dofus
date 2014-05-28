package com.ankamagames.dofus.logic.common.utils
{
   import com.ankamagames.jerakine.network.ILagometer;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class Lagometer extends Object implements ILagometer
   {
      
      public function Lagometer() {
         super();
         this._timer = new Timer(SHOW_LAG_DELAY,1);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
      }
      
      protected static const _log:Logger;
      
      protected static const SHOW_LAG_DELAY:uint = 2000.0;
      
      protected var _timer:Timer;
      
      protected var _lagging:Boolean = false;
      
      public function ping(msg:INetworkMessage = null) : void {
         this._timer.start();
      }
      
      public function pong(msg:INetworkMessage = null) : void {
         if(this._lagging)
         {
            this.stopLag();
         }
         if(this._timer.running)
         {
            this._timer.stop();
         }
      }
      
      public function stop() : void {
         if(this._timer.running)
         {
            this._timer.stop();
         }
      }
      
      protected function onTimerComplete(e:TimerEvent) : void {
         this.startLag();
      }
      
      protected function startLag() : void {
         this._lagging = true;
         this.updateUi();
      }
      
      protected function updateUi() : void {
         KernelEventsManager.getInstance().processCallback(HookList.LaggingNotification,this._lagging);
      }
      
      protected function stopLag() : void {
         this._lagging = false;
         this.updateUi();
      }
   }
}
