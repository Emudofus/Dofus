package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   import flash.utils.ByteArray;
   import by.blooddy.crypto.MD5;
   
   public class CryptoInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function CryptoInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:CRC32 = null;
         var _loc5_:ByteArray = null;
         switch(param2)
         {
            case "crc32":
               _loc4_ = new CRC32();
               _loc5_ = new ByteArray();
               _loc5_.writeUTFBytes(param3.join(" "));
               _loc4_.update(_loc5_);
               param1.output("CRC32 checksum : " + _loc4_.getValue().toString(16));
               break;
            case "md5":
               param1.output("MD5 hash : " + MD5.hash(param3.join(" ")));
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "crc32":
               return "Calculate the CRC32 checksum of a given string.";
            case "md5":
               return "Calculate the MD5 hash of a given string.";
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
