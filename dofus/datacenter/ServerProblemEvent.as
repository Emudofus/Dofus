// Action script...

// [Initial MovieClip Action of sprite 20738]
#initclip 3
if (!dofus.datacenter.ServerProblemEvent)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ServerProblemEvent = function (nTimestamp, nEventID, bTranslated, sContent)
    {
        super();
        this._nTimestamp = nTimestamp;
        this._nID = nEventID;
        this._bTranslated = bTranslated;
        this._sContent = sContent;
        var _loc7 = _global.API;
        this._sTitle = _loc7.lang.getText("STATUS_EVENT_" + this._nID);
        var _loc8 = _loc7.lang.getConfigText("HOUR_FORMAT");
        var _loc9 = _loc7.config.language;
        var _loc10 = new Date(this._nTimestamp);
        this._sHour = org.utils.SimpleDateFormatter.formatDate(_loc10, _loc8, _loc9);
    }).prototype;
    _loc1.__get__timestamp = function ()
    {
        return (this._nTimestamp);
    };
    _loc1.__get__hour = function ()
    {
        return (this._sHour);
    };
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__title = function ()
    {
        return (this._sTitle);
    };
    _loc1.__get__translated = function ()
    {
        return (this._bTranslated);
    };
    _loc1.__get__content = function ()
    {
        return (this._sContent);
    };
    _loc1.addProperty("content", _loc1.__get__content, function ()
    {
    });
    _loc1.addProperty("translated", _loc1.__get__translated, function ()
    {
    });
    _loc1.addProperty("hour", _loc1.__get__hour, function ()
    {
    });
    _loc1.addProperty("title", _loc1.__get__title, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    _loc1.addProperty("timestamp", _loc1.__get__timestamp, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
