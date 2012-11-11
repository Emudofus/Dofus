package com.ankamagames.jerakine.logger
{
    import com.ankamagames.jerakine.logger.*;

    public class LogLogger extends Object implements Logger
    {
        private var _category:String;
        private static var _enabled:Boolean = true;
        private static var _useModuleLoggerHasOutputLog:Boolean = false;

        public function LogLogger(param1:String)
        {
            this._category = param1;
            return;
        }// end function

        public function get category() : String
        {
            return this._category;
        }// end function

        public function trace(param1:Object) : void
        {
            this.log(LogLevel.TRACE, param1);
            return;
        }// end function

        public function debug(param1:Object) : void
        {
            this.log(LogLevel.DEBUG, param1);
            return;
        }// end function

        public function info(param1:Object) : void
        {
            this.log(LogLevel.INFO, param1);
            return;
        }// end function

        public function warn(param1:Object) : void
        {
            this.log(LogLevel.WARN, param1);
            return;
        }// end function

        public function error(param1:Object) : void
        {
            this.log(LogLevel.ERROR, param1);
            return;
        }// end function

        public function fatal(param1:Object) : void
        {
            this.log(LogLevel.FATAL, param1);
            return;
        }// end function

        public function logDirectly(event:LogEvent) : void
        {
            if (_enabled)
            {
                Log.broadcastToTargets(event);
            }
            return;
        }// end function

        public function log(param1:uint, param2:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (_enabled)
            {
                _loc_3 = param2.toString();
                _loc_4 = this.getFormatedMessage(_loc_3);
                Log.broadcastToTargets(new TextLogEvent(this._category, param1 != LogLevel.COMMANDS ? (_loc_4) : (_loc_3), param1));
                if (_useModuleLoggerHasOutputLog)
                {
                    ModuleLogger.log(_loc_4, param1);
                }
            }
            return;
        }// end function

        private function getFormatedMessage(param1:String) : String
        {
            if (!param1)
            {
                param1 = "";
            }
            var _loc_2:* = this._category.split("::");
            var _loc_3:* = "[" + _loc_2[(_loc_2.length - 1)] + "] ";
            var _loc_4:* = "";
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                _loc_4 = _loc_4 + " ";
                _loc_5 = _loc_5 + 1;
            }
            param1 = param1.replace("\n", "\n" + _loc_4);
            return _loc_3 + param1;
        }// end function

        public function clear() : void
        {
            this.log(LogLevel.COMMANDS, "clear");
            return;
        }// end function

        public static function useModuleLoggerHasOutputLog(param1:Boolean) : void
        {
            _useModuleLoggerHasOutputLog = param1;
            return;
        }// end function

        public static function activeLog(param1:Boolean) : void
        {
            _enabled = param1;
            return;
        }// end function

        public static function logIsActive() : Boolean
        {
            return _enabled;
        }// end function

    }
}
