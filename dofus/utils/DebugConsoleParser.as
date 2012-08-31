// Action script...

// [Initial MovieClip Action of sprite 907]
#initclip 119
class dofus.utils.DebugConsoleParser extends dofus.utils.AbstractConsoleParser
{
    var api;
    function DebugConsoleParser(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
    } // End of the function
    function process(sCmd)
    {
        super.process(sCmd);
        if (sCmd.charAt(0) == "/")
        {
            var _loc3 = sCmd.split(" ");
            var _loc5 = _loc3[0].substr(1).toUpperCase();
            _loc3.splice(0, 1);
            switch (_loc5)
            {
                case "INFOS":
                {
                    var _loc6 = "Svr:";
                    _loc6 = _loc6 + ("\n Maps : " + api.kernel.MapsServersManager.getCurrentServer());
                    _loc6 = _loc6 + ("\n Docs : " + api.kernel.DocumentsServersManager.getCurrentServer());
                    _loc6 = _loc6 + ("\n Tuto : " + api.kernel.TutorialManager.getCurrentServer());
                    _loc6 = _loc6 + "\nNb:";
                    _loc6 = _loc6 + ("\n Map  : " + String(api.datacenter.Game.playerCount));
                    _loc6 = _loc6 + ("\n Cell : " + api.datacenter.Map.data[api.datacenter.Player.data.cellNum].spriteOnCount);
                    _loc6 = _loc6 + "\nLang:";
                    _loc6 = _loc6 + ("\n pH  : " + api.config.playHost);
                    _loc6 = _loc6 + ("\n pHl : " + api.config.playHostLink + dofus.Constants.HTTP_LANG_FILE);
                    _loc6 = _loc6 + ("\n l   : " + api.config.language + " (" + api.lang.getLangVersion() + " & " + api.lang.getXtraVersion() + ")");
                    api.kernel.showMessage(undefined, _loc6, "DEBUG_LOG");
                    break;
                } 
                case "TIMERSCOUNT":
                {
                    api.kernel.showMessage(undefined, String(ank.utils.Timer.getTimersCount()), "DEBUG_LOG");
                    break;
                } 
                case "VARS":
                {
                    api.kernel.showMessage(undefined, api.kernel.TutorialManager.vars, "DEBUG_LOG");
                    break;
                } 
                case "ANIM":
                {
                    if (dofus.Constants.DEBUG)
                    {
                        if (_loc3.length > 1)
                        {
                            api.gfx.setSpriteLoopAnim(api.datacenter.Player.ID, _loc3[0], _loc3[1]);
                        }
                        else
                        {
                            api.gfx.setSpriteAnim(api.datacenter.Player.ID, _loc3.join(""));
                        } // end if
                    } // end else if
                    break;
                } 
                case "C":
                {
                    if (dofus.Constants.DEBUG)
                    {
                        _loc6 = _loc3[0];
                        _loc3.splice(0, 1);
                        switch (_loc6)
                        {
                            case ">":
                            {
                                api.network.send(_loc3.join(" "));
                                break;
                            } 
                            case "<":
                            {
                                api.network.processCommand(_loc3.join(" "));
                                break;
                            } 
                        } // End of switch
                    } // end if
                    break;
                } 
                case "PING":
                {
                    api.network.ping();
                    break;
                } 
                case "MAPID":
                {
                    api.kernel.showMessage(undefined, "carte : " + api.datacenter.Map.id, "DEBUG_LOG");
                    break;
                } 
                case "CELLID":
                {
                    api.kernel.showMessage(undefined, "cellule : " + api.datacenter.Player.data.cellNum, "DEBUG_LOG");
                    break;
                } 
                case "TIME":
                {
                    api.kernel.showMessage(undefined, "Heure : " + api.kernel.NightManager.time, "DEBUG_LOG");
                    break;
                } 
                case "CACHE":
                {
                    api.kernel.askClearCache();
                    break;
                } 
                case "REBOOT":
                {
                    api.kernel.reboot();
                    break;
                } 
                case "FPS":
                {
                    api.ui.getUIComponent("Debug").showFps();
                    break;
                } 
                default:
                {
                    api.kernel.showMessage(undefined, api.lang.getText("UNKNOW_COMMAND", [_loc5]), "DEBUG_ERROR");
                    break;
                } 
            } // End of switch
        }
        else if (api.datacenter.Basics.isLogged)
        {
            api.network.Basics.autorisedCommand(sCmd);
        }
        else
        {
            api.kernel.showMessage(undefined, api.lang.getText("UNKNOW_COMMAND", [sCmd]), "DEBUG_ERROR");
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
