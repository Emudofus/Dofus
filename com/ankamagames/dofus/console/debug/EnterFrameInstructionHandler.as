package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class EnterFrameInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:Dictionary;
            var _local_5:Dictionary;
            var cefl:*;
            var cname:String;
            var refl:*;
            var rname:String;
            switch (cmd)
            {
                case "enterframecount":
                    console.output(("ENTER_FRAME listeners count : " + EnterFrameDispatcher.enterFrameListenerCount));
                    console.output("Controled listeners :");
                    _local_4 = EnterFrameDispatcher.controledEnterFrameListeners;
                    for (cefl in _local_4)
                    {
                        cname = _local_4[cefl]["name"];
                        console.output(("  - " + cname));
                    };
                    console.output("Real time listeners :");
                    _local_5 = EnterFrameDispatcher.realTimeEnterFrameListeners;
                    for (refl in _local_5)
                    {
                        rname = _local_5[refl];
                        console.output(("  - " + rname));
                    };
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "enterframecount":
                    return ("Count the ENTER_FRAME listeners.");
            };
            return ("Unknown command");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

