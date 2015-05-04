package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.basic.SequenceNumberMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.basic.SequenceNumberRequestMessage;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SynchronisationFrame extends Object implements Frame
   {
      
      public function SynchronisationFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SynchronisationFrame));
      
      private static const STEP_TIME:uint = 2000;
      
      private var _synchroStep:uint = 0;
      
      private var _creationTimeFlash:uint;
      
      private var _creationTimeOs:uint;
      
      private var _timerSpeedHack:Timer;
      
      private var _timeToTest:Timer;
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function pushed() : Boolean
      {
         this._synchroStep = 0;
         this._timeToTest = new Timer(30000,1);
         this._timeToTest.addEventListener(TimerEvent.TIMER_COMPLETE,this.checkSpeedHack);
         this._timeToTest.start();
         this._timerSpeedHack = new Timer(10000,1);
         this._timerSpeedHack.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:SequenceNumberMessage = null;
         switch(true)
         {
            case param1 is SequenceNumberRequestMessage:
               _loc2_ = new SequenceNumberMessage();
               this._synchroStep = this._synchroStep + 1;
               _loc2_.initSequenceNumberMessage(this._synchroStep);
               ConnectionsHandler.getConnection().send(_loc2_);
               return true;
            default:
               return false;
         }
      }
      
      private function checkSpeedHack(param1:TimerEvent) : void
      {
         this._timeToTest.stop();
         this._creationTimeFlash = getTimer();
         this._creationTimeOs = new Date().time;
         this._timerSpeedHack.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this._timerSpeedHack.stop();
         var _loc2_:uint = getTimer() - this._creationTimeFlash;
         var _loc3_:uint = new Date().time - this._creationTimeOs;
         if(_loc2_ > _loc3_ + STEP_TIME)
         {
            _log.error("This account is cheating : flash=" + _loc2_ + ", os=" + _loc3_ + ", diff= flash:" + _loc2_ + " / os:" + _loc3_);
            if(BuildInfos.BUILD_TYPE != BuildTypeEnum.DEBUG)
            {
               Kernel.getWorker().process(ResetGameAction.create(I18n.getUiText("ui.error.speedHack")));
            }
            else
            {
               _log.fatal("Reset du jeu annulé mais on sait bien que tu cheat");
            }
         }
         this._timeToTest.start();
      }
      
      public function pulled() : Boolean
      {
         this._timerSpeedHack.stop();
         this._timerSpeedHack.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timerSpeedHack = null;
         this._timeToTest.stop();
         this._timeToTest.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timeToTest = null;
         return true;
      }
   }
}
