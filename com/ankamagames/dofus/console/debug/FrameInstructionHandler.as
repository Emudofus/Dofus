package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class FrameInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function FrameInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var priority:int;
            var f:Frame;
            var className:String;
            var split:Array;
            var console:* = param1;
            var cmd:* = param2;
            var args:* = param3;
            switch(cmd)
            {
                case "framelist":
                {
                    var _loc_5:* = 0;
                    var _loc_6:* = Kernel.getWorker().framesList;
                    while (_loc_6 in _loc_5)
                    {
                        
                        f = _loc_6[_loc_5];
                        className = getQualifiedClassName(f);
                        split = className.split("::");
                        console.output(split[(split.length - 1)] + " (" + Priority.toString(f.com.ankamagames.jerakine.utils.misc:Prioritizable::priority) + ")");
                    }
                    break;
                }
                case "framepriority":
                {
                    if (args.length != 2)
                    {
                        console.output("You must specify a frame and a priority to set.");
                        return;
                    }
                    priority = Priority.fromString(args[1]);
                    if (priority == 666)
                    {
                        console.output(args[1] + " : invalid priority (available priority are LOG, ULTIMATE_HIGHEST_DEPTH_OF_DOOM, HIGHEST, HIGH, NORMAL, LOW and LOWEST");
                        return;
                    }
                    var _loc_5:* = 0;
                    var _loc_6:* = Kernel.getWorker().framesList;
                    while (_loc_6 in _loc_5)
                    {
                        
                        f = _loc_6[_loc_5];
                        className = getQualifiedClassName(f);
                        split = className.split("::");
                        if (split[(split.length - 1)] == args[0])
                        {
                            try
                            {
                                f["priority"] = priority;
                            }
                            catch (e:Error)
                            {
                                console.output("Priority set not available for frame " + args[0]);
                            }
                            return;
                        }
                    }
                    console.output(args[0] + " : frame not found");
                    return;
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
                case "framelist":
                {
                    return "list all enabled frame";
                }
                case "framepriority":
                {
                    return "overwrite a frame priority";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command \'" + param1 + "\'.";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
