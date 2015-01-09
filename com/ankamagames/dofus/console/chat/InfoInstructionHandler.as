package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.dofus.network.messages.game.basic.BasicWhoAmIRequestMessage;
    import com.ankamagames.dofus.network.messages.game.basic.BasicWhoIsRequestMessage;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.dofus.BuildInfos;
    import flash.system.Capabilities;

    public class InfoInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:String;
            var _local_5:BasicWhoAmIRequestMessage;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:Date;
            var bwrm:BasicWhoIsRequestMessage;
            switch (cmd)
            {
                case "whois":
                    if (args.length == 0)
                    {
                        return;
                    };
                    _local_4 = args.shift();
                    if ((((_local_4.length >= 1)) && ((_local_4.length <= ProtocolConstantsEnum.MAX_PLAYER_OR_ACCOUNT_NAME_LEN))))
                    {
                        bwrm = new BasicWhoIsRequestMessage();
                        bwrm.initBasicWhoIsRequestMessage(true, _local_4);
                        ConnectionsHandler.getConnection().send(bwrm);
                    };
                    return;
                case "version":
                    console.output(this.getVersion());
                    return;
                case "about":
                    console.output(this.getVersion());
                    return;
                case "whoami":
                    _local_5 = new BasicWhoAmIRequestMessage();
                    _local_5.initBasicWhoAmIRequestMessage(true);
                    ConnectionsHandler.getConnection().send(_local_5);
                    return;
                case "mapid":
                    _local_6 = ((MapDisplayManager.getInstance().currentMapPoint.x + "/") + MapDisplayManager.getInstance().currentMapPoint.y);
                    _local_7 = MapDisplayManager.getInstance().currentMapPoint.mapId.toString();
                    console.output(I18n.getUiText("ui.chat.console.currentMap", [((((PlayedCharacterManager.getInstance().currentMap.outdoorX + "/") + PlayedCharacterManager.getInstance().currentMap.outdoorY) + ", ") + _local_6), _local_7]));
                    return;
                case "cellid":
                    _local_8 = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id).position.cellId.toString();
                    console.output(I18n.getUiText("ui.console.chat.currentCell", [_local_8]));
                    return;
                case "time":
                    _local_9 = new Date();
                    console.output(((TimeManager.getInstance().formatDateIG(0) + " - ") + TimeManager.getInstance().formatClock(0, false)));
                    return;
            };
        }

        private function getVersion():String
        {
            return (((((((((("----------------------------------------------\n" + "DOFUS CLIENT v ") + BuildInfos.BUILD_VERSION) + "\n") + "(c) ANKAMA GAMES (") + BuildInfos.BUILD_DATE) + ") \n") + "Flash player ") + Capabilities.version) + "\n----------------------------------------------"));
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "version":
                    return (I18n.getUiText("ui.chat.console.help.version"));
                case "about":
                    return (I18n.getUiText("ui.chat.console.help.version"));
                case "whois":
                    return (I18n.getUiText("ui.chat.console.help.whois"));
                case "whoami":
                    return (I18n.getUiText("ui.chat.console.help.whoami"));
                case "cellid":
                    return (I18n.getUiText("ui.chat.console.help.cellid"));
                case "mapid":
                    return (I18n.getUiText("ui.chat.console.help.mapid"));
                case "time":
                    return (I18n.getUiText("ui.chat.console.help.time"));
            };
            return (I18n.getUiText("ui.chat.console.noHelp", [cmd]));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.chat

