package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.jerakine.console.*;

    public class SystemInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function SystemInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            switch(param2)
            {
                case "getuid":
                {
                    param1.output("Client flashkey : " + InterClientManager.getInstance().flashKey);
                    break;
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
                case "getuid":
                {
                    return "Get the client flashkey.";
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
