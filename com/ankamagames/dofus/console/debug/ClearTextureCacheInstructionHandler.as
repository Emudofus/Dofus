package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.berilia.Berilia;
   
   public class ClearTextureCacheInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function ClearTextureCacheInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         switch(param2)
         {
            case "cleartexturecache":
               if(param3.length > 0)
               {
                  param1.output("No arguments needed.");
               }
               Berilia.getInstance().cache.clear();
               param1.output("Texture cache cleared.");
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "cleartexturecache":
               return "Empty the textures cache.";
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
