package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class TimeApi extends Object implements IApi
    {
        private var _module:UiModule;
        protected var _log:Logger;

        public function TimeApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(TimeApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getTimestamp() : Number
        {
            return TimeManager.getInstance().getTimestamp();
        }// end function

        public function getClock(param1:Number = 0, param2:Boolean = false, param3:Boolean = false) : String
        {
            return TimeManager.getInstance().formatClock(param1, param2, param3);
        }// end function

        public function getClockNumbers() : Object
        {
            var _loc_1:* = TimeManager.getInstance().getDateFromTime(0);
            return [_loc_1[0], _loc_1[1]];
        }// end function

        public function getDate(param1:Number = 0, param2:Boolean = false) : String
        {
            return TimeManager.getInstance().formatDateIRL(param1, param2);
        }// end function

        public function getDofusDate(param1:Number = 0) : String
        {
            return TimeManager.getInstance().formatDateIG(param1);
        }// end function

        public function getDurationTimeSinceEpoch(param1:Number = 0) : Number
        {
            var _loc_2:* = new Date();
            var _loc_3:* = _loc_2.getTime() / 1000;
            var _loc_4:* = TimeManager.getInstance().timezoneOffset / 1000;
            var _loc_5:* = TimeManager.getInstance().serverTimeLag / 1000;
            return Math.floor(_loc_3 - param1 + _loc_4 - _loc_5);
        }// end function

        public function getDuration(param1:Number, param2:Boolean = false) : String
        {
            return TimeManager.getInstance().getDuration(param1, param2);
        }// end function

        public function getShortDuration(param1:Number, param2:Boolean = false) : String
        {
            return TimeManager.getInstance().getDuration(param1, true, param2);
        }// end function

    }
}
