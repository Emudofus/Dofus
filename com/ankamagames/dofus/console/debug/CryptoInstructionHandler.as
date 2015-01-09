package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.utils.crypto.CRC32;
    import flash.utils.ByteArray;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class CryptoInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:CRC32;
            var _local_5:ByteArray;
            switch (cmd)
            {
                case "crc32":
                    _local_4 = new CRC32();
                    _local_5 = new ByteArray();
                    _local_5.writeUTFBytes(args.join(" "));
                    _local_4.update(_local_5);
                    console.output(("CRC32 checksum : " + _local_4.getValue().toString(16)));
                    return;
                case "md5":
                    console.output(("MD5 hash : " + MD5.hash(args.join(" "))));
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "crc32":
                    return ("Calculate the CRC32 checksum of a given string.");
                case "md5":
                    return ("Calculate the MD5 hash of a given string.");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

