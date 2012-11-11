package com.ankamagames.jerakine.console
{
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ConsolesManager extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ConsolesManager));
        private static var _consoles:Dictionary = new Dictionary();

        public function ConsolesManager()
        {
            return;
        }// end function

        public static function getConsole(param1:String) : ConsoleHandler
        {
            return _consoles[param1];
        }// end function

        public static function registerConsole(param1:String, param2:ConsoleHandler, param3:ConsoleInstructionRegistar) : void
        {
            if (getConsole(param1))
            {
                getConsole(param1).changeOutputHandler(param2);
                param2.name = param1;
                _consoles[param1] = param2;
                param3.registerInstructions(param2);
                return;
            }
            param2.name = param1;
            _consoles[param1] = param2;
            param3.registerInstructions(param2);
            return;
        }// end function

        public static function getMessage(param1:String) : ConsoleInstructionMessage
        {
            var _loc_2:* = param1.split(" ");
            var _loc_3:* = _loc_2[0];
            _loc_2.splice(0, 1);
            return new ConsoleInstructionMessage(_loc_3, _loc_2);
        }// end function

    }
}
