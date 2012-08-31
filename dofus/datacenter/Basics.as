// Action script...

// [Initial MovieClip Action of sprite 919]
#initclip 131
class dofus.datacenter.Basics extends Object
{
    var _sLogin, __get__login, connexionKey, lastPingTimer, gfx_lastActionTime, gfx_canLaunch, gfx_lastArea, aks_chat_lastActionTime, aks_emote_lastActionTime, aks_exchange_echangeType, aks_infos_lifeRestoreInterval, aks_infos_highlightCoords, aks_ticket, aks_servers, aks_current_server, aks_a_logs, aks_a_prompt, spellManager_errorMsg, interactionsManager_path, inventory_filter, banner_targetCoords, craftViewer_filter, isLogged, serverMessageID, __set__login;
    function Basics()
    {
        super();
        this.initialize();
    } // End of the function
    function set login(sLogin)
    {
        _sLogin = sLogin.toLowerCase();
        //return (this.login());
        null;
    } // End of the function
    function get login()
    {
        return (_sLogin);
    } // End of the function
    function initialize()
    {
        delete this.connexionKey;
        delete this.lastPingTimer;
        delete this.gfx_lastActionTime;
        delete this.gfx_canLaunch;
        delete this.gfx_lastArea;
        delete this.aks_chat_lastActionTime;
        delete this.aks_emote_lastActionTime;
        delete this.aks_exchange_echangeType;
        clearInterval(aks_infos_lifeRestoreInterval);
        delete this.aks_infos_lifeRestoreInterval;
        delete this.aks_infos_highlightCoords;
        delete this.aks_ticket;
        aks_servers = new ank.utils.ExtendedArray();
        delete this.aks_current_server;
        if (aks_a_logs == undefined)
        {
            aks_a_logs = "";
        } // end if
        aks_a_prompt = "";
        delete this.spellManager_errorMsg;
        delete this.interactionsManager_path;
        delete this.inventory_filter;
        delete this.banner_targetCoords;
        craftViewer_filter = [true, true, true, true, true, true, true, true];
        isLogged = false;
        serverMessageID = -1;
    } // End of the function
} // End of Class
#endinitclip
