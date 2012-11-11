package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;

    public class MessagingInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function MessagingInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            switch(param2)
            {
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
                case "w":
                {
                    return I18n.getUiText("ui.chat.console.help.whisper");
                }
                case "whisper":
                {
                    return I18n.getUiText("ui.chat.console.help.whisper");
                }
                case "msg":
                {
                    return I18n.getUiText("ui.chat.console.help.whisper");
                }
                case "t":
                {
                    return I18n.getUiText("ui.chat.console.help.teammessage");
                }
                case "g":
                {
                    return I18n.getUiText("ui.chat.console.help.guildmessage");
                }
                case "p":
                {
                    return I18n.getUiText("ui.chat.console.help.groupmessage");
                }
                case "a":
                {
                    return I18n.getUiText("ui.chat.console.help.alignmessage");
                }
                case "r":
                {
                    return I18n.getUiText("ui.chat.console.help.aroundguildmessage");
                }
                case "b":
                {
                    return I18n.getUiText("ui.chat.console.help.sellbuymessage");
                }
                case "m":
                {
                    return I18n.getUiText("ui.chat.console.help.meetmessage");
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
