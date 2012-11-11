package com.ankamagames.dofus.logic.common.utils
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.network.*;
    import flash.events.*;
    import flash.utils.*;

    public class Lagometer extends Object implements ILagometer
    {
        private var _timer:Timer;
        private var _lagging:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Lagometer));
        private static const SHOW_LAG_DELAY:uint = 2000;

        public function Lagometer()
        {
            this._timer = new Timer(SHOW_LAG_DELAY, 1);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            return;
        }// end function

        public function ping() : void
        {
            this._timer.start();
            return;
        }// end function

        public function pong() : void
        {
            if (this._lagging)
            {
                this.stopLag();
            }
            if (this._timer.running)
            {
                this._timer.stop();
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this._timer.running)
            {
                this._timer.stop();
            }
            return;
        }// end function

        private function onTimerComplete(event:TimerEvent) : void
        {
            this.startLag();
            return;
        }// end function

        private function startLag() : void
        {
            this._lagging = true;
            this.updateUi();
            return;
        }// end function

        private function updateUi() : void
        {
            _log.info("Send lagging notification: " + this._lagging);
            KernelEventsManager.getInstance().processCallback(HookList.LaggingNotification, this._lagging);
            return;
        }// end function

        private function stopLag() : void
        {
            this._lagging = false;
            this.updateUi();
            return;
        }// end function

    }
}
