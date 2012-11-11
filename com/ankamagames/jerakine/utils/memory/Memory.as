package com.ankamagames.jerakine.utils.memory
{
    import flash.net.*;
    import flash.system.*;

    public class Memory extends Object
    {
        private static const MOD:uint = 1024;
        private static const UNITS:Array = ["B", "KB", "MB", "GB", "TB", "PB"];

        public function Memory()
        {
            return;
        }// end function

        public static function usage() : uint
        {
            return System.totalMemory;
        }// end function

        public static function humanReadableUsage() : String
        {
            var _loc_1:* = System.totalMemory;
            var _loc_2:* = 0;
            while (_loc_1 > MOD)
            {
                
                _loc_1 = _loc_1 / MOD;
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1 + " " + UNITS[_loc_2];
        }// end function

        public static function gc() : void
        {
            try
            {
                new LocalConnection().connect("foo");
                new LocalConnection().connect("foo");
            }
            catch (e)
            {
            }
            return;
        }// end function

    }
}
