package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.death.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;

    public class StatusInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function StatusInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(param2)
            {
                case "away":
                {
                    _loc_4 = new BasicSwitchModeRequestMessage();
                    _loc_4.initBasicSwitchModeRequestMessage(0);
                    ConnectionsHandler.getConnection().send(_loc_4);
                    break;
                }
                case "invisible":
                {
                    _loc_5 = new BasicSwitchModeRequestMessage();
                    _loc_5.initBasicSwitchModeRequestMessage(1);
                    ConnectionsHandler.getConnection().send(_loc_5);
                    break;
                }
                case "release":
                {
                    _loc_6 = new GameRolePlayFreeSoulRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_6);
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
                case "away":
                {
                    return I18n.getUiText("ui.chat.console.help.away");
                }
                case "invisible":
                {
                    return I18n.getUiText("ui.chat.console.help.invisible");
                }
                case "release":
                {
                    return I18n.getUiText("ui.common.freeSoul");
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
