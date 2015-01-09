package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.network.ServerConnection;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class ConnectionInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            switch (cmd)
            {
                case "connectionstatus":
                    console.output(("" + ((ConnectionsHandler.getConnection()) ? ConnectionsHandler.getConnection() : "There is currently no connection.")));
                    return;
                case "inspecttraffic":
                    ServerConnection.DEBUG_VERBOSE = !(ServerConnection.DEBUG_VERBOSE);
                    console.output(("Inspect traffic is " + ((ServerConnection.DEBUG_VERBOSE) ? "ON" : "OFF")));
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "connectionstatus":
                    return ("Print the status of the current connection (if any).");
                case "inspecttraffic":
                    return ("Show detailled informations about network activities.");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

