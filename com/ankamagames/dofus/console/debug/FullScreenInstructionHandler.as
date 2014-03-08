package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.StageDisplayState;
   import flash.geom.Rectangle;
   
   public class FullScreenInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function FullScreenInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         switch(param2)
         {
            case "fullscreen":
               if(param3.length == 0)
               {
                  if(AirScanner.hasAir())
                  {
                     if(StageShareManager.stage.displayState == StageDisplayState["FULL_SCREEN_INTERACTIVE"])
                     {
                        StageShareManager.stage.displayState = StageDisplayState["NORMAL"];
                     }
                     else
                     {
                        param1.output("Resolution needed.");
                     }
                  }
               }
               else
               {
                  if(param3.length == 2)
                  {
                     if(AirScanner.hasAir())
                     {
                        _loc4_ = uint(param3[0]);
                        _loc5_ = uint(param3[1]);
                        StageShareManager.stage.fullScreenSourceRect = new Rectangle(0,0,_loc4_,_loc5_);
                        StageShareManager.stage.displayState = StageDisplayState["FULL_SCREEN_INTERACTIVE"];
                     }
                  }
               }
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "fullscreen":
               return "Toggle the full-screen display mode.";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
