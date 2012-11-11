package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.jerakine.console.*;

    public class PanicInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function PanicInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = 0;
            switch(param2)
            {
                case "panic":
                {
                    _loc_4 = uint(param3[0]);
                    param1.output("Kernel panic #" + _loc_4);
                    Kernel.panic(_loc_4);
                    break;
                }
                case "throw":
                {
                    throw new Error(param3.join(" "));
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "panic":
                {
                    return "Make a kernel panic.";
                }
                case "throw":
                {
                    return "Throw an exception";
                }
                default:
                {
                    break;
                }
            }
            return "No help for command \'" + param1 + "\'";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
