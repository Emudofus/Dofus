package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;

    public class OptionsInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function OptionsInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            switch(param2)
            {
                case "tab":
                {
                    if (!param3[0] || param3[0] < 1)
                    {
                        param1.output("Error : need a valid tab index.");
                        return;
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TabNameChange, param3[0], param3[1]);
                    break;
                }
                case "clear":
                {
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ClearChat);
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
                case "tab":
                {
                    return I18n.getUiText("ui.chat.console.help.tab");
                }
                case "clear":
                {
                    return I18n.getUiText("ui.chat.console.help.clear");
                }
                default:
                {
                    break;
                }
            }
            return I18n.getUiText("ui.chat.console.noHelp", [param1]);
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
