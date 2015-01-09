package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationAction;
    import com.ankamagames.dofus.network.messages.game.friend.FriendAddRequestMessage;
    import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddRequestMessage;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class SocialInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:PartyInvitationAction;
            var reason:String;
            var farmsg:FriendAddRequestMessage;
            var iarmsg:IgnoredAddRequestMessage;
            switch (cmd)
            {
                case "f":
                    if (args.length != 2)
                    {
                        return;
                    };
                    _local_4 = (args[0] as String);
                    _local_5 = (args[1] as String);
                    if ((((_local_5.length < 2)) || ((_local_5.length > 20))))
                    {
                        reason = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        console.output(reason);
                        return;
                    };
                    if (_local_5 != PlayedCharacterManager.getInstance().infos.name)
                    {
                        if ((((_local_4 == "a")) || ((_local_4 == "+"))))
                        {
                            farmsg = new FriendAddRequestMessage();
                            farmsg.initFriendAddRequestMessage(_local_5);
                            ConnectionsHandler.getConnection().send(farmsg);
                        };
                    }
                    else
                    {
                        console.output(I18n.getUiText("ui.social.friend.addFailureEgocentric"));
                    };
                    return;
                case "ignore":
                    if (args.length != 2)
                    {
                        return;
                    };
                    _local_4 = (args[0] as String);
                    _local_5 = (args[1] as String);
                    if ((((_local_5.length < 2)) || ((_local_5.length > 20))))
                    {
                        reason = I18n.getUiText("ui.social.friend.addFailureNotFound");
                        console.output(reason);
                        return;
                    };
                    if (_local_5 == PlayedCharacterManager.getInstance().infos.name)
                    {
                        console.output(I18n.getUiText("ui.social.friend.addFailureEgocentric"));
                        return;
                    };
                    if ((((_local_4 == "a")) || ((_local_4 == "+"))))
                    {
                        iarmsg = new IgnoredAddRequestMessage();
                        iarmsg.initIgnoredAddRequestMessage(_local_5);
                        ConnectionsHandler.getConnection().send(iarmsg);
                    };
                    return;
                case "invite":
                    if (args.length != 1)
                    {
                        return;
                    };
                    _local_6 = (args[0] as String);
                    if ((((((_local_6 == "")) || ((_local_6.length < 2)))) || ((_local_6.length > 19))))
                    {
                        return;
                    };
                    _local_7 = PartyInvitationAction.create(_local_6);
                    Kernel.getWorker().process(_local_7);
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "f":
                    return (I18n.getUiText("ui.chat.console.help.friendhelp"));
                case "ignore":
                    return (I18n.getUiText("ui.chat.console.help.enemyhelp"));
                case "invite":
                    return (I18n.getUiText("ui.chat.console.help.invite"));
            };
            return (I18n.getUiText("ui.chat.console.noHelp", [cmd]));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.chat

