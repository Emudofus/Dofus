package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   
   public class ResetInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function ResetInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         switch(param2)
         {
            case "reset":
               Kernel.getWorker().process(new ResetGameAction());
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "reset":
               return "Resets the Kernel and restart the game.";
            default:
               return "Unknown command \'" + param1 + "\'.";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
