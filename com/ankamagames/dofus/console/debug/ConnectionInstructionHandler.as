package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.network.ServerConnection;
   
   public class ConnectionInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function ConnectionInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         switch(param2)
         {
            case "connectionstatus":
               param1.output("" + (ConnectionsHandler.getConnection()?ConnectionsHandler.getConnection():"There is currently no connection."));
               break;
            case "inspecttraffic":
               ServerConnection.DEBUG_VERBOSE = !ServerConnection.DEBUG_VERBOSE;
               param1.output("Inspect traffic is " + (ServerConnection.DEBUG_VERBOSE?"ON":"OFF"));
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "connectionstatus":
               return "Print the status of the current connection (if any).";
            case "inspecttraffic":
               return "Show detailled informations about network activities.";
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
