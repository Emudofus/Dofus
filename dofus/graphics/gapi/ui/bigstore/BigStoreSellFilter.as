// Action script...

// [Initial MovieClip Action of sprite 20560]
#initclip 81
if (!dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui.bigstore)
    {
        _global.dofus.graphics.gapi.ui.bigstore = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter = function (maximalLevel, allowedTypes)
    {
        this._nMaximalLevel = maximalLevel;
        this._aAllowedTypes = allowedTypes;
    }).prototype;
    _loc1.isItemListed = function (item)
    {
        if (this._nMaximalLevel != null && item.level > this._nMaximalLevel)
        {
            return (false);
        } // end if
        var _loc3 = false;
        for (var i in this._aAllowedTypes)
        {
            if (item.type == Number(this._aAllowedTypes[i]))
            {
                _loc3 = true;
                break;
            } // end if
        } // end of for...in
        if (!_loc3)
        {
            return (false);
        } // end if
        return (true);
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1._nMaximalLevel = null;
    _loc1._aAllowedTypes = null;
} // end if
#endinitclip
