package com.ankamagames.dofus.logic.game.roleplay.types
{
    import flash.events.*;
    import flash.utils.*;

    final public class AnimFunTimer extends Object
    {
        public var actorId:int;
        public var animId:int;
        private var _callBack:Function;
        private var _timer:Timer;

        public function AnimFunTimer(param1:int, param2:int, param3:int, param4:Function)
        {
            this._callBack = param4;
            this.actorId = param1;
            this.animId = param3;
            this._timer = new Timer(param2, 1);
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            this._timer.start();
            return;
        }// end function

        public function destroy() : void
        {
            if (this._timer)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timer = null;
            }
            return;
        }// end function

        public function get running() : Boolean
        {
            return this._timer.running;
        }// end function

        private function onTimer(event:Event) : void
        {
            this._callBack(this);
            this.destroy();
            return;
        }// end function

    }
}
