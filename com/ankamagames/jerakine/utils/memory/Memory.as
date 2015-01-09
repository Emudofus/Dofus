package com.ankamagames.jerakine.utils.memory
{
    import flash.system.System;
    import flash.net.LocalConnection;

    public class Memory 
    {

        private static const MOD:uint = 0x0400;
        private static const UNITS:Array = ["B", "KB", "MB", "GB", "TB", "PB"];


        public static function usage():uint
        {
            return (System.totalMemory);
        }

        public static function humanReadableUsage():String
        {
            var memory:uint = System.totalMemory;
            var i:uint;
            while (memory > MOD)
            {
                memory = (memory / MOD);
                i++;
            };
            return (((memory + " ") + UNITS[i]));
        }

        public static function gc():void
        {
            try
            {
                new LocalConnection().connect("foo");
                new LocalConnection().connect("foo");
            }
            catch(e)
            {
            };
        }


    }
}//package com.ankamagames.jerakine.utils.memory

