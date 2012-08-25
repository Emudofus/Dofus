package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.utils.*;

    public class EnterFrameInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function EnterFrameInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:Dictionary = null;
            var _loc_5:Dictionary = null;
            var _loc_6:* = undefined;
            var _loc_7:String = null;
            var _loc_8:* = undefined;
            var _loc_9:String = null;
            switch(param2)
            {
                case "enterframecount":
                {
                    param1.output("ENTER_FRAME listeners count : " + EnterFrameDispatcher.enterFrameListenerCount);
                    param1.output("Controled listeners :");
                    _loc_4 = EnterFrameDispatcher.controledEnterFrameListeners;
                    for (_loc_6 in _loc_4)
                    {
                        
                        _loc_7 = _loc_4[_loc_6]["name"];
                        param1.output("  - " + _loc_7);
                    }
                    param1.output("Real time listeners :");
                    _loc_5 = EnterFrameDispatcher.realTimeEnterFrameListeners;
                    for (_loc_8 in _loc_5)
                    {
                        
                        _loc_9 = _loc_5[_loc_8];
                        param1.output("  - " + _loc_9);
                    }
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
                case "enterframecount":
                {
                    return "Count the ENTER_FRAME listeners.";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
