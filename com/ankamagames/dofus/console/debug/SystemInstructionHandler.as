package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   
   public class SystemInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function SystemInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         switch(param2)
         {
            case "getuid":
               param1.output("Client flashkey : " + InterClientManager.getInstance().flashKey);
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "getuid":
               return "Get the client flashkey.";
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
