package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.jerakine.console.*;

    public class ClearTextureCacheInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function ClearTextureCacheInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            switch(param2)
            {
                case "cleartexturecache":
                {
                    if (param3.length > 0)
                    {
                        param1.output("No arguments needed.");
                    }
                    Berilia.getInstance().cache.clear();
                    param1.output("Texture cache cleared.");
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
                case "cleartexturecache":
                {
                    return "Empty the textures cache.";
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
