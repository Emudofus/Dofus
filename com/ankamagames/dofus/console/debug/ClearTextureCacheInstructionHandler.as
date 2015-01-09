package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class ClearTextureCacheInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            switch (cmd)
            {
                case "cleartexturecache":
                    if (args.length > 0)
                    {
                        console.output("No arguments needed.");
                    };
                    Berilia.getInstance().cache.clear();
                    console.output("Texture cache cleared.");
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "cleartexturecache":
                    return ("Empty the textures cache.");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

