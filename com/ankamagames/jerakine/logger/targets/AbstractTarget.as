package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;

    public class AbstractTarget extends Object implements LoggingTarget
    {
        private var _loggers:Array;
        private var _filters:Array;
        private static const FILTERS_FORBIDDEN_CHARS:String = "[]~$^&/(){}<>+=`!#%?,:;\'\"@";

        public function AbstractTarget()
        {
            this._loggers = new Array();
            this._filters = new Array();
            return;
        }// end function

        public function set filters(param1:Array) : void
        {
            if (!this.checkIsFiltersValid(param1))
            {
                throw new InvalidFilterError("These characters are invalid on a filter : " + FILTERS_FORBIDDEN_CHARS);
            }
            this._filters = param1;
            return;
        }// end function

        public function get filters() : Array
        {
            return this._filters;
        }// end function

        public function logEvent(event:LogEvent) : void
        {
            return;
        }// end function

        public function addLogger(param1:Logger) : void
        {
            this._loggers.push(param1);
            return;
        }// end function

        public function removeLogger(param1:Logger) : void
        {
            var _loc_2:* = this._loggers.indexOf(param1);
            if (_loc_2 > -1)
            {
                this._loggers.splice(_loc_2, 1);
            }
            return;
        }// end function

        private function checkIsFiltersValid(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                if (!this.checkIsFilterValid(_loc_2.target))
                {
                    return false;
                }
            }
            return true;
        }// end function

        private function checkIsFilterValid(param1:String) : Boolean
        {
            var _loc_2:* = 0;
            while (_loc_2 < FILTERS_FORBIDDEN_CHARS.length)
            {
                
                if (param1.indexOf(FILTERS_FORBIDDEN_CHARS.charAt(_loc_2)) > -1)
                {
                    return false;
                }
                _loc_2++;
            }
            return true;
        }// end function

        public function onLog(event:LogEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_2:* = false;
            if (this._filters.length > 0)
            {
                for each (_loc_3 in this._filters)
                {
                    
                    _loc_4 = new RegExp(_loc_3.target.replace("*", ".*"), "i");
                    _loc_5 = _loc_4.test(event.category);
                    if (event.category == _loc_3.target && !_loc_3.allow)
                    {
                        _loc_2 = false;
                        break;
                    }
                    if (_loc_5 && _loc_3.allow)
                    {
                        _loc_2 = true;
                    }
                }
            }
            else
            {
                _loc_2 = true;
            }
            if (_loc_2)
            {
                this.logEvent(event);
            }
            return;
        }// end function

    }
}
