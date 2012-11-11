package com.ankamagames.jerakine.utils.misc
{
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Chrono extends Object
    {
        private static var times:Array = [];
        private static var labels:Array = [];
        private static var level:int = 0;
        private static var indent:String = "";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Chrono));
        public static var show_total_time:Boolean = true;

        public function Chrono()
        {
            return;
        }// end function

        public static function start(param1:String = "") : void
        {
            param1 = param1.length ? (param1) : ("Chrono " + times.length);
            times.push(getTimer());
            labels.push(param1);
            (level + 1);
            indent = indent + "  ";
            _log.trace(">>" + indent + "START " + param1);
            return;
        }// end function

        public static function stop() : int
        {
            var _loc_1:* = getTimer() - times.pop();
            if (!show_total_time && times.length)
            {
                times[(times.length - 1)] = times[(times.length - 1)] - _loc_1;
            }
            _log.trace("<<" + indent + "DONE " + labels.pop() + " " + _loc_1 + "ms.");
            (level - 1);
            indent = indent.slice(0, 2 * level + 1);
            return _loc_1;
        }// end function

        public static function display(param1:String) : void
        {
            _log.trace("!!" + indent + "TRACE " + param1);
            return;
        }// end function

    }
}
