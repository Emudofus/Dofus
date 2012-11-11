package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.party.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.messages.game.friend.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;

    public class SocialInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function SocialInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            switch(param2)
            {
                case "f":
                {
                    if (param3.length != 2)
                    {
                        return;
                    }
                    _loc_4 = param3[0] as String;
                    _loc_5 = param3[1] as String;
                    if (_loc_5.length < 2 || _loc_5.length > 20)
                    {
                        _loc_8 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        param1.output(_loc_8);
                        return;
                    }
                    if (_loc_5 != PlayedCharacterManager.getInstance().infos.name)
                    {
                        if (_loc_4 == "a" || _loc_4 == "+")
                        {
                            _loc_9 = new FriendAddRequestMessage();
                            _loc_9.initFriendAddRequestMessage(_loc_5);
                            ConnectionsHandler.getConnection().send(_loc_9);
                        }
                        else if (_loc_4 == "d" || _loc_4 == "-" || _loc_4 == "r")
                        {
                            _loc_10 = new FriendDeleteRequestMessage();
                            _loc_10.initFriendDeleteRequestMessage(_loc_5);
                            ConnectionsHandler.getConnection().send(_loc_10);
                        }
                    }
                    else
                    {
                        param1.output(I18n.getUiText("ui.social.friend.addFailureEgocentric"));
                    }
                    break;
                }
                case "ignore":
                {
                    if (param3.length != 2)
                    {
                        return;
                    }
                    _loc_4 = param3[0] as String;
                    _loc_5 = param3[1] as String;
                    if (_loc_5.length < 2 || _loc_5.length > 20)
                    {
                        _loc_8 = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        param1.output(_loc_8);
                        return;
                    }
                    if (_loc_5 == PlayedCharacterManager.getInstance().infos.name)
                    {
                        param1.output(I18n.getUiText("ui.social.friend.addFailureEgocentric"));
                        return;
                    }
                    if (_loc_4 == "a" || _loc_4 == "+")
                    {
                        _loc_11 = new IgnoredAddRequestMessage();
                        _loc_11.initIgnoredAddRequestMessage(_loc_5);
                        ConnectionsHandler.getConnection().send(_loc_11);
                    }
                    else if (_loc_4 == "d" || _loc_4 == "-" || _loc_4 == "r")
                    {
                        _loc_12 = new IgnoredDeleteRequestMessage();
                        _loc_12.initIgnoredDeleteRequestMessage(_loc_5);
                        ConnectionsHandler.getConnection().send(_loc_12);
                    }
                    break;
                }
                case "invite":
                {
                    if (param3.length != 1)
                    {
                        return;
                    }
                    _loc_6 = param3[0] as String;
                    if (_loc_6 == "" || _loc_6.length < 2 || _loc_6.length > 19)
                    {
                        return;
                    }
                    _loc_7 = PartyInvitationAction.create(_loc_6);
                    Kernel.getWorker().process(_loc_7);
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
                case "f":
                {
                    return I18n.getUiText("ui.chat.console.help.friendhelp");
                }
                case "ignore":
                {
                    return I18n.getUiText("ui.chat.console.help.enemyhelp");
                }
                case "invite":
                {
                    return I18n.getUiText("ui.chat.console.help.invite");
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
