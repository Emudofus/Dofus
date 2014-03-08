package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   
   public class PanicInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function PanicInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:uint = 0;
         switch(param2)
         {
            case "panic":
               _loc4_ = uint(param3[0]);
               param1.output("Kernel panic #" + _loc4_);
               Kernel.panic(_loc4_);
               break;
            case "throw":
               throw new Error(param3.join(" "));
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "panic":
               return "Make a kernel panic.";
            case "throw":
               return "Throw an exception";
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
