package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class LivingObjectInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryInstructionHandler));

        public function LivingObjectInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            switch(param2)
            {
                case "floodlivingobject":
                {
                    if (SpeakingItemManager.getInstance().speakTimerMinuteDelay != SpeakingItemManager.MINUTE_DELAY)
                    {
                        SpeakingItemManager.getInstance().speakTimerMinuteDelay = SpeakingItemManager.MINUTE_DELAY;
                    }
                    else
                    {
                        SpeakingItemManager.getInstance().speakTimerMinuteDelay = 100;
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
                case "floodlivingobject":
                {
                    return "Make a flood of talk from living objects.";
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
