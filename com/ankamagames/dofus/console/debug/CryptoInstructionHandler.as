package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import flash.utils.*;

    public class CryptoInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function CryptoInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:CRC32 = null;
            var _loc_5:ByteArray = null;
            switch(param2)
            {
                case "crc32":
                {
                    _loc_4 = new CRC32();
                    _loc_5 = new ByteArray();
                    _loc_5.writeUTFBytes(param3.join(" "));
                    _loc_4.update(_loc_5);
                    param1.output("CRC32 checksum : " + _loc_4.getValue().toString(16));
                    break;
                }
                case "md5":
                {
                    param1.output("MD5 hash : " + MD5.hash(param3.join(" ")));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "crc32":
                {
                    return "Calculate the CRC32 checksum of a given string.";
                }
                case "md5":
                {
                    return "Calculate the MD5 hash of a given string.";
                }
                default:
                {
                    break;
                }
            }
            return "No help for command \'" + param1 + "\'";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
