package com.ankamagames.jerakine.utils.system
{
    import flash.system.*;

    public class AirScanner extends Object
    {
        private static var _initialized:Boolean = false;
        private static var _hasAir:Boolean;
        private static var _isStreaming:Boolean;

        public function AirScanner()
        {
            return;
        }// end function

        public static function init(param1:Boolean = false) : void
        {
            if (!_initialized)
            {
                initialize();
                _isStreaming = param1;
            }
            return;
        }// end function

        private static function initialize() : void
        {
            _initialized = true;
            var _loc_1:* = new LoaderContext();
            if (_loc_1.hasOwnProperty("allowLoadBytesCodeExecution"))
            {
                _hasAir = true;
            }
            else
            {
                _hasAir = false;
            }
            var _loc_2:* = Capabilities.version.substr(0, 3);
            if (_loc_2 != "LNX" && _loc_2 != "WIN" && _loc_2 != "MAC")
            {
                _hasAir = false;
            }
            return;
        }// end function

        public static function hasAir() : Boolean
        {
            if (!_initialized)
            {
                initialize();
                _isStreaming = false;
            }
            return _hasAir;
        }// end function

        public static function isStreamingVersion() : Boolean
        {
            if (!_initialized)
            {
                initialize();
                _isStreaming = false;
            }
            return _isStreaming;
        }// end function

        public static function allowByteCodeExecution(param1:LoaderContext, param2:Boolean) : void
        {
            if (param1.hasOwnProperty("allowCodeImport"))
            {
                param1["allowCodeImport"] = param2;
            }
            else
            {
                param1["allowLoadBytesCodeExecution"] = param2;
            }
            return;
        }// end function

    }
}
