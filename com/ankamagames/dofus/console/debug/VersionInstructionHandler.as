package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.Metadata;
   import com.ankamagames.dofus.misc.BuildTypeParser;
   
   public class VersionInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function VersionInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         switch(param2)
         {
            case "version":
               switch(param3[0])
               {
                  case "revision":
                     param1.output("Build revision : " + BuildInfos.BUILD_REVISION);
                     break;
                  case "patch":
                     param1.output("Build patch : " + BuildInfos.BUILD_PATCH);
                     break;
                  case "date":
                     param1.output("Build date     : " + BuildInfos.BUILD_DATE);
                     break;
                  case "protocol":
                     param1.output("Protocol       : " + Metadata.PROTOCOL_BUILD + " (" + Metadata.PROTOCOL_DATE + ")");
                     break;
                  case undefined:
                     param1.output("DOFUS v" + BuildInfos.BUILD_VERSION + " (" + BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + ")");
                     break;
                  default:
                     param1.output("Unknown argument : " + param3[0]);
               }
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "version":
               return "Get the client version.";
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
