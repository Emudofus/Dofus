package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.jerakine.console.*;

    public class ResetInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function ResetInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            switch(param2)
            {
                case "reset":
                {
                    Kernel.getWorker().process(new ResetGameAction());
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
                case "reset":
                {
                    return "Resets the Kernel and restart the game.";
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
