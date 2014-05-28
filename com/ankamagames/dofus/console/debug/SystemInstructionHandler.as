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
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         switch(cmd)
         {
            case "getuid":
               console.output("Client flashkey : " + InterClientManager.getInstance().flashKey);
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "getuid":
               return "Get the client flashkey.";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         return [];
      }
   }
}
