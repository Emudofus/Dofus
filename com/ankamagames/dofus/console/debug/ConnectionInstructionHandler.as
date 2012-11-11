package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.jerakine.console.*;

    public class ConnectionInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function ConnectionInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            switch(param2)
            {
                case "connectionstatus":
                {
                    param1.output("" + (ConnectionsHandler.getConnection() ? (ConnectionsHandler.getConnection()) : ("There is currently no connection.")));
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
                case "connectionstatus":
                {
                    return "Print the status of the current connection (if any).";
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
