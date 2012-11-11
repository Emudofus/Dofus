package com.ankamagames.jerakine.logger
{

    final public class ModuleLogger extends Object
    {
        public static var active:Boolean = false;
        private static var _callBack:Function;

        public function ModuleLogger()
        {
            return;
        }// end function

        public static function log(... args) : void
        {
            if (active && _callBack != null)
            {
                _callBack.apply(_callBack, args);
            }
            return;
        }// end function

        public static function init(param1:Function) : void
        {
            _callBack = param1;
            return;
        }// end function

    }
}
