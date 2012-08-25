// Action script...

// [Initial MovieClip Action of sprite 20992]
#initclip 1
if (!dofus.datacenter.Basics)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Basics = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__set__login = function (sLogin)
    {
        this._sLogin = sLogin.toLowerCase();
        //return (this.login());
    };
    _loc1.__get__login = function ()
    {
        return (this._sLogin);
    };
    _loc1.__get__aks_infos_highlightCoords = function ()
    {
        return (this._aks_infos_highlightCoords);
    };
    _loc1.__set__aks_infos_highlightCoords = function (aCoord)
    {
        this._aks_infos_highlightCoords = aCoord;
        this.api.ui.getUIComponent("Banner").illustration.updateFlags();
        //return (this.aks_infos_highlightCoords());
    };
    _loc1.__set__banner_targetCoords = function (aCoord)
    {
        this._banner_targetCoords = aCoord;
        this.api.ui.getUIComponent("Banner").illustration.updateFlags();
        //return (this.banner_targetCoords());
    };
    _loc1.__get__banner_targetCoords = function ()
    {
        return (this._banner_targetCoords);
    };
    _loc1.team = function (nTeamNumber)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = this.api.datacenter.Sprites.getItems();
        for (var i in _loc4)
        {
            if (this.api.datacenter.Sprites.getItemAt(i).Team == nTeamNumber)
            {
                _loc3.push(this.api.datacenter.Sprites.getItemAt(i));
            } // end if
        } // end of for...in
        return (_loc3);
    };
    _loc1.initialize = function ()
    {
        delete this.connexionKey;
        delete this.lastPingTimer;
        delete this.gfx_lastActionTime;
        delete this.gfx_canLaunch;
        delete this.gfx_lastArea;
        this.lastDateUpdate = -1000000;
        this.aks_server_will_disconnect = false;
        this.aks_gifts_stack = new Array();
        delete this.aks_chat_lastActionTime;
        this.chat_type_visible = new Object();
        delete this.aks_emote_lastActionTime;
        delete this.aks_exchange_echangeType;
        _global.clearInterval(this.aks_infos_lifeRestoreInterval);
        delete this.aks_infos_lifeRestoreInterval;
        delete this.aks_infos_highlightCoords;
        delete this.aks_ticket;
        delete this.aks_gameserver_ip;
        delete this.aks_gameserver_port;
        this.aks_rescue_count = -1;
        this.aks_servers = new ank.utils.ExtendedArray();
        delete this.aks_current_server;
        delete this.aks_can_send_identity;
        delete this.aks_identity;
        if (this.aks_a_logs == undefined)
        {
            this.aks_a_logs = "";
        } // end if
        this.aks_a_prompt = "";
        delete this.spellManager_errorMsg;
        delete this.interactionsManager_path;
        delete this.inventory_filter;
        delete this.banner_targetCoords;
        this.payzone_isFirst = true;
        delete this.quests_lastID;
        this.craftViewer_filter = [true, true, true, true, true, true, true, true];
        this.mapExplorer_filter = [false, false, true, false, true];
        this.mapExplorer_zoom = 50;
        this.mapExplorer_coord = undefined;
        this.mapExplorer_grid = false;
        this.isLogged = false;
        this.inGame = false;
        this.serverMessageID = -1;
        this.createCharacter = false;
        this.chatParams = new Object();
        this.aks_current_team = -1;
        this.aks_team1_starts = null;
        this.aks_team2_starts = null;
        this.inactivity_signaled = 0;
        this.first_connection_from_miniclip = false;
        this.first_movement = false;
        this.canUseSeeAllSpell = true;
        _global.API.kernel.SpellsBoostsManager.clear();
    };
    _loc1.aks_infos_highlightCoords_clear = function (nFlagType)
    {
        if (_global.isNaN(nFlagType))
        {
            this._aks_infos_highlightCoords = new Array();
        }
        else
        {
            var _loc3 = new Array();
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < this._aks_infos_highlightCoords.length)
            {
                if (this._aks_infos_highlightCoords[_loc4].type != nFlagType)
                {
                    _loc3.push(this._aks_infos_highlightCoords[_loc4]);
                } // end if
            } // end while
            this._aks_infos_highlightCoords = _loc3;
        } // end else if
        this.api.ui.getUIComponent("Banner").illustration.updateFlags();
    };
    _loc1.addProperty("banner_targetCoords", _loc1.__get__banner_targetCoords, _loc1.__set__banner_targetCoords);
    _loc1.addProperty("login", _loc1.__get__login, _loc1.__set__login);
    _loc1.addProperty("aks_infos_highlightCoords", _loc1.__get__aks_infos_highlightCoords, _loc1.__set__aks_infos_highlightCoords);
    ASSetPropFlags(_loc1, null, 1);
    _loc1.aks_current_regional_version = Number.POSITIVE_INFINITY;
} // end if
#endinitclip
