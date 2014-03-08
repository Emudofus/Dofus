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
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:Dictionary = null;
         var _loc5_:Dictionary = null;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         switch(param2)
         {
            case "enterframecount":
               param1.output("ENTER_FRAME listeners count : " + EnterFrameDispatcher.enterFrameListenerCount);
               param1.output("Controled listeners :");
               _loc4_ = EnterFrameDispatcher.controledEnterFrameListeners;
               for (_loc6_ in _loc4_)
               {
                  _loc7_ = _loc4_[_loc6_]["name"];
                  param1.output("  - " + _loc7_);
               }
               param1.output("Real time listeners :");
               _loc5_ = EnterFrameDispatcher.realTimeEnterFrameListeners;
               for (_loc8_ in _loc5_)
               {
                  _loc9_ = _loc5_[_loc8_];
                  param1.output("  - " + _loc9_);
               }
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "enterframecount":
               return "Count the ENTER_FRAME listeners.";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
