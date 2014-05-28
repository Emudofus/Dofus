package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   
   public class EnterFrameInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function EnterFrameInstructionHandler() {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var ctrlDic:Dictionary = null;
         var rtDic:Dictionary = null;
         var cefl:* = undefined;
         var cname:String = null;
         var refl:* = undefined;
         var rname:String = null;
         switch(cmd)
         {
            case "enterframecount":
               console.output("ENTER_FRAME listeners count : " + EnterFrameDispatcher.enterFrameListenerCount);
               console.output("Controled listeners :");
               ctrlDic = EnterFrameDispatcher.controledEnterFrameListeners;
               for(cefl in ctrlDic)
               {
                  cname = ctrlDic[cefl]["name"];
                  console.output("  - " + cname);
               }
               console.output("Real time listeners :");
               rtDic = EnterFrameDispatcher.realTimeEnterFrameListeners;
               for(refl in rtDic)
               {
                  rname = rtDic[refl];
                  console.output("  - " + rname);
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "enterframecount":
               return "Count the ENTER_FRAME listeners.";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         return [];
      }
   }
}
