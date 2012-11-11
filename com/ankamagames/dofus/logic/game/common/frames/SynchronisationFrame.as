package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.events.*;
    import flash.utils.*;

    public class SynchronisationFrame extends Object implements Frame
    {
        private var _synchroStep:uint = 0;
        private var _creationTimeFlash:uint;
        private var _creationTimeOs:uint;
        private var _timerSpeedHack:Timer;
        private var _timeToTest:Timer;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SynchronisationFrame));
        private static const STEP_TIME:uint = 300;

        public function SynchronisationFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function pushed() : Boolean
        {
            this._synchroStep = 0;
            this._timeToTest = new Timer(30000, 1);
            this._timeToTest.addEventListener(TimerEvent.TIMER_COMPLETE, this.checkSpeedHack);
            this._timeToTest.start();
            this._timerSpeedHack = new Timer(10000, 1);
            this._timerSpeedHack.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            switch(true)
            {
                case param1 is SequenceNumberRequestMessage:
                {
                    _loc_2 = new SequenceNumberMessage();
                    (this._synchroStep + 1);
                    _loc_2.initSequenceNumberMessage(this._synchroStep);
                    ConnectionsHandler.getConnection().send(_loc_2);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function checkSpeedHack(event:TimerEvent) : void
        {
            this._timeToTest.stop();
            this._creationTimeFlash = getTimer();
            this._creationTimeOs = new Date().time;
            this._timerSpeedHack.start();
            return;
        }// end function

        private function onTimerComplete(event:TimerEvent) : void
        {
            this._timerSpeedHack.stop();
            var _loc_2:* = getTimer() - this._creationTimeFlash;
            var _loc_3:* = new Date().time - this._creationTimeOs;
            if (_loc_2 > _loc_3 + STEP_TIME)
            {
                _log.error("This account is cheating : flash=" + _loc_2 + ", os=" + _loc_3);
                Kernel.getWorker().process(ResetGameAction.create(I18n.getUiText("ui.error.speedHack")));
            }
            this._timeToTest.start();
            return;
        }// end function

        public function pulled() : Boolean
        {
            this._timerSpeedHack.stop();
            this._timerSpeedHack.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._timerSpeedHack = null;
            this._timeToTest.stop();
            this._timeToTest.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._timeToTest = null;
            return true;
        }// end function

    }
}
