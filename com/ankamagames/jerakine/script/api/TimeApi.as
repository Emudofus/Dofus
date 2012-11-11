package com.ankamagames.jerakine.script.api
{
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class TimeApi extends Object
    {

        public function TimeApi()
        {
            return;
        }// end function

        public static function Timeout(param1:uint, param2:Function, ... args) : uint
        {
            if (!args)
            {
                args = new Array();
            }
            args.unshift(param1);
            args.unshift(param2);
            return CallWithParameters.callR(setTimeout, args);
        }// end function

        public static function CancelTimeout(param1:uint) : void
        {
            clearTimeout(param1);
            return;
        }// end function

        public static function Repeat(param1:uint, param2:Function, ... args) : uint
        {
            if (!args)
            {
                args = new Array();
            }
            args.unshift(param1);
            args.unshift(param2);
            return CallWithParameters.callR(setInterval, args);
        }// end function

        public static function CancelRepeat(param1:uint) : void
        {
            clearInterval(param1);
            return;
        }// end function

    }
}
