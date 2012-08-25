package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;
    import flash.system.*;

    public class InfoInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function InfoInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:BasicWhoIsRequestMessage = null;
            var _loc_5:BasicWhoAmIRequestMessage = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:Date = null;
            switch(param2)
            {
                case "whois":
                {
                    if (param3.length == 0)
                    {
                        return;
                    }
                    _loc_4 = new BasicWhoIsRequestMessage();
                    _loc_4.initBasicWhoIsRequestMessage(param3.shift());
                    ConnectionsHandler.getConnection().send(_loc_4);
                    break;
                }
                case "version":
                {
                    param1.output(this.getVersion());
                    break;
                }
                case "ver":
                {
                    param1.output(this.getVersion());
                    break;
                }
                case "about":
                {
                    param1.output(this.getVersion());
                    break;
                }
                case "whoami":
                {
                    _loc_5 = new BasicWhoAmIRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_5);
                    break;
                }
                case "mapid":
                {
                    _loc_6 = MapDisplayManager.getInstance().currentMapPoint.x + "/" + MapDisplayManager.getInstance().currentMapPoint.y;
                    _loc_7 = MapDisplayManager.getInstance().currentMapPoint.mapId.toString();
                    param1.output(I18n.getUiText("ui.chat.console.currentMap", [PlayedCharacterManager.getInstance().currentMap.outdoorX + "/" + PlayedCharacterManager.getInstance().currentMap.outdoorY + ", " + _loc_6, _loc_7]));
                    break;
                }
                case "cellid":
                {
                    _loc_8 = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id).position.cellId.toString();
                    param1.output(I18n.getUiText("ui.console.chat.currentCell", [_loc_8]));
                    break;
                }
                case "time":
                {
                    _loc_9 = new Date();
                    param1.output(TimeManager.getInstance().formatDateIG(0) + " - " + TimeManager.getInstance().formatClock(0, false));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getVersion() : String
        {
            return "----------------------------------------------\n" + "DOFUS CLIENT v " + BuildInfos.BUILD_VERSION + "\n" + "(c) ANKAMA GAMES (" + BuildInfos.BUILD_DATE + ") \n" + "Flash player " + Capabilities.version + "\n----------------------------------------------";
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "version":
                {
                    return I18n.getUiText("ui.chat.console.help.version");
                }
                case "ver":
                {
                    return I18n.getUiText("ui.chat.console.help.version");
                }
                case "about":
                {
                    return I18n.getUiText("ui.chat.console.help.version");
                }
                case "whois":
                {
                    return I18n.getUiText("ui.chat.console.help.whois");
                }
                case "whoami":
                {
                    return I18n.getUiText("ui.chat.console.help.whoami");
                }
                case "cellid":
                {
                    return I18n.getUiText("ui.chat.console.help.cellid");
                }
                case "mapid":
                {
                    return I18n.getUiText("ui.chat.console.help.mapid");
                }
                case "time":
                {
                    return I18n.getUiText("ui.chat.console.help.time");
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
