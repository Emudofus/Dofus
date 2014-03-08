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
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var errorId:uint = 0;
         switch(cmd)
         {
            case "panic":
               errorId = uint(args[0]);
               console.output("Kernel panic #" + errorId);
               Kernel.panic(errorId);
               break;
            case "throw":
               throw new Error(args.join(" "));
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "panic":
               return "Make a kernel panic.";
            case "throw":
               return "Throw an exception";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         return [];
      }
   }
}
