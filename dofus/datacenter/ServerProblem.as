// Action script...

// [Initial MovieClip Action of sprite 20538]
#initclip 59
if (!dofus.datacenter.ServerProblem)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ServerProblem = function (nID, nDate, nType, nStatus, aServers, aHistory)
    {
        super();
        this._nID = nID;
        this._nDate = nDate;
        this._nType = nType;
        this._nStatus = nStatus;
        this._aServers = aServers;
        this._aHistory = aHistory;
        var _loc9 = _global.API;
        this._sType = _loc9.lang.getText("STATUS_PROBLEM_" + this._nType);
        this._sStatus = _loc9.lang.getText("STATUS_STATE_" + this._nStatus);
        var _loc10 = _loc9.lang.getConfigText("LONG_DATE_FORMAT");
        var _loc11 = _loc9.config.language;
        var _loc12 = String(this._nDate);
        var _loc13 = new Date(Number(_loc12.substr(0, 4)), Number(_loc12.substr(4, 2)) - 1, Number(_loc12.substr(6, 2)));
        this._sDate = org.utils.SimpleDateFormatter.formatDate(_loc13, _loc10, _loc11);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__date = function ()
    {
        return (this._sDate);
    };
    _loc1.__get__type = function ()
    {
        return (this._sType);
    };
    _loc1.__get__status = function ()
    {
        return (this._sStatus);
    };
    _loc1.__get__servers = function ()
    {
        return (this._aServers);
    };
    _loc1.__get__history = function ()
    {
        return (this._aHistory);
    };
    _loc1.addProperty("type", _loc1.__get__type, function ()
    {
    });
    _loc1.addProperty("date", _loc1.__get__date, function ()
    {
    });
    _loc1.addProperty("history", _loc1.__get__history, function ()
    {
    });
    _loc1.addProperty("servers", _loc1.__get__servers, function ()
    {
    });
    _loc1.addProperty("status", _loc1.__get__status, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
