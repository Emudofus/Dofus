package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.geom.*;

    public class FullScreenInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function FullScreenInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            switch(param2)
            {
                case "fullscreen":
                {
                    if (param3.length == 0)
                    {
                        if (AirScanner.hasAir())
                        {
                            if (StageShareManager.stage.displayState == StageDisplayState["FULL_SCREEN_INTERACTIVE"])
                            {
                                StageShareManager.stage.displayState = StageDisplayState["NORMAL"];
                            }
                            else
                            {
                                param1.output("Resolution needed.");
                            }
                        }
                    }
                    else if (param3.length == 2)
                    {
                        if (AirScanner.hasAir())
                        {
                            _loc_4 = uint(param3[0]);
                            _loc_5 = uint(param3[1]);
                            StageShareManager.stage.fullScreenSourceRect = new Rectangle(0, 0, _loc_4, _loc_5);
                            StageShareManager.stage.displayState = StageDisplayState["FULL_SCREEN_INTERACTIVE"];
                        }
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
                case "fullscreen":
                {
                    return "Toggle the full-screen display mode.";
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
