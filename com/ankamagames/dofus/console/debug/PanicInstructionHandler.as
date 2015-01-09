package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class PanicInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:uint;
            switch (cmd)
            {
                case "panic":
                    _local_4 = uint(args[0]);
                    console.output(("Kernel panic #" + _local_4));
                    Kernel.panic(_local_4);
                    return;
                case "throw":
                    throw (new Error(args.join(" ")));
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "panic":
                    return ("Make a kernel panic.");
                case "throw":
                    return ("Throw an exception");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

