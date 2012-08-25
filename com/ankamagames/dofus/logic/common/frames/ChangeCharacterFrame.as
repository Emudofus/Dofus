package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.connection.actions.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.network.messages.game.context.notification.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.messages.*;

    public class ChangeCharacterFrame extends Object implements Frame
    {

        public function ChangeCharacterFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return 0;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:String = null;
            var _loc_3:ChangeCharacterAction = null;
            var _loc_4:LoginValidationAction = null;
            var _loc_5:LoginValidationAction = null;
            var _loc_6:LoginValidationAction = null;
            var _loc_7:LoginValidationAction = null;
            var _loc_8:NotificationListMessage = null;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            switch(true)
            {
                case param1 is ChangeCharacterAction:
                {
                    _loc_3 = param1 as ChangeCharacterAction;
                    _loc_2 = XmlConfig.getInstance().getEntry("config.loginMode");
                    _loc_4 = AuthentificationManager.getInstance().loginValidationAction;
                    _loc_5 = LoginValidationAction.create(_loc_4.username, _loc_4.password, true, _loc_3.serverId);
                    AuthentificationManager.getInstance().setValidationAction(_loc_5);
                    SoundManager.getInstance().manager.removeAllSounds();
                    ConnectionsHandler.closeConnection();
                    Kernel.getInstance().reset(null, AuthentificationManager.getInstance().canAutoConnectWithToken || !AuthentificationManager.getInstance().tokenMode);
                    return true;
                }
                case param1 is ChangeServerAction:
                {
                    _loc_6 = AuthentificationManager.getInstance().loginValidationAction;
                    _loc_7 = LoginValidationAction.create(_loc_6.username, _loc_6.password, false);
                    AuthentificationManager.getInstance().setValidationAction(_loc_7);
                    ConnectionsHandler.closeConnection();
                    Kernel.getInstance().reset(null, AuthentificationManager.getInstance().canAutoConnectWithToken || !AuthentificationManager.getInstance().tokenMode);
                    return true;
                }
                case param1 is NotificationListMessage:
                {
                    _loc_8 = param1 as NotificationListMessage;
                    QuestFrame.notificationList = new Array();
                    _loc_9 = _loc_8.flags.length;
                    _loc_10 = 0;
                    while (_loc_10 < _loc_9)
                    {
                        
                        _loc_11 = _loc_8.flags[_loc_10];
                        _loc_12 = 0;
                        while (_loc_12 < 32)
                        {
                            
                            QuestFrame.notificationList[_loc_12 + _loc_10 * 32] = Boolean(_loc_11 & 1);
                            _loc_11 = _loc_11 >> 1;
                            _loc_12++;
                        }
                        _loc_10++;
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

    }
}
