package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.dofus.logic.common.actions.DirectSelectionCharacterAction;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
    import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
    import com.ankamagames.dofus.network.messages.game.context.notification.NotificationListMessage;
    import com.ankamagames.dofus.misc.utils.errormanager.WebServiceDataHandler;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
    import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
    import com.ankamagames.jerakine.messages.Message;

    public class ChangeCharacterFrame implements Frame 
    {


        public function get priority():int
        {
            return (0);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:DirectSelectionCharacterAction;
            var _local_3:LoginValidationAction;
            var _local_4:LoginValidationAction;
            var _local_5:ChangeCharacterAction;
            var _local_6:LoginValidationAction;
            var _local_7:LoginValidationAction;
            var _local_8:LoginValidationAction;
            var _local_9:LoginValidationAction;
            var _local_10:NotificationListMessage;
            var _local_11:int;
            var c:int;
            var val:int;
            var bit:int;
            switch (true)
            {
                case (msg is DirectSelectionCharacterAction):
                    _local_2 = (msg as DirectSelectionCharacterAction);
                    WebServiceDataHandler.getInstance().changeCharacter();
                    PlayerManager.getInstance().allowAutoConnectCharacter = true;
                    PlayerManager.getInstance().autoConnectOfASpecificCharacterId = _local_2.characterId;
                    _local_3 = AuthentificationManager.getInstance().loginValidationAction;
                    _local_4 = LoginValidationAction.create(_local_3.username, _local_3.password, true, _local_2.serverId);
                    AuthentificationManager.getInstance().setValidationAction(_local_4);
                    SoundManager.getInstance().manager.removeAllSounds();
                    ConnectionsHandler.closeConnection();
                    Kernel.getWorker().resume();
                    Kernel.getInstance().reset(null, ((AuthentificationManager.getInstance().canAutoConnectWithToken) || (!(AuthentificationManager.getInstance().tokenMode))));
                    return (true);
                case (msg is ChangeCharacterAction):
                    _local_5 = (msg as ChangeCharacterAction);
                    WebServiceDataHandler.getInstance().changeCharacter();
                    _local_6 = AuthentificationManager.getInstance().loginValidationAction;
                    _local_7 = LoginValidationAction.create(_local_6.username, _local_6.password, true, _local_5.serverId);
                    AuthentificationManager.getInstance().setValidationAction(_local_7);
                    SoundManager.getInstance().manager.removeAllSounds();
                    ConnectionsHandler.closeConnection();
                    Kernel.getWorker().resume();
                    Kernel.getInstance().reset(null, ((AuthentificationManager.getInstance().canAutoConnectWithToken) || (!(AuthentificationManager.getInstance().tokenMode))));
                    return (true);
                case (msg is ChangeServerAction):
                    _local_8 = AuthentificationManager.getInstance().loginValidationAction;
                    _local_9 = LoginValidationAction.create(_local_8.username, _local_8.password, false);
                    AuthentificationManager.getInstance().setValidationAction(_local_9);
                    ConnectionsHandler.closeConnection();
                    Kernel.getInstance().reset(null, ((AuthentificationManager.getInstance().canAutoConnectWithToken) || (!(AuthentificationManager.getInstance().tokenMode))));
                    return (true);
                case (msg is NotificationListMessage):
                    _local_10 = (msg as NotificationListMessage);
                    QuestFrame.notificationList = new Array();
                    _local_11 = _local_10.flags.length;
                    c = 0;
                    while (c < _local_11)
                    {
                        val = _local_10.flags[c];
                        bit = 0;
                        while (bit < 32)
                        {
                            QuestFrame.notificationList[(bit + (c * 32))] = Boolean((val & 1));
                            val = (val >> 1);
                            bit++;
                        };
                        c++;
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.common.frames

