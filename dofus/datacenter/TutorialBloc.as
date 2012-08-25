// Action script...

// [Initial MovieClip Action of sprite 20589]
#initclip 110
if (!dofus.datacenter.TutorialBloc)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.TutorialBloc = function (sID, nType)
    {
        super();
        this._sID = sID;
        this._nType = nType;
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._sID);
    };
    _loc1.__get__type = function ()
    {
        return (this._nType);
    };
    _loc1.addProperty("type", _loc1.__get__type, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.TutorialBloc = function (sID, nType)
    {
        super();
        this._sID = sID;
        this._nType = nType;
    }).TYPE_ACTION = 0;
    (_global.dofus.datacenter.TutorialBloc = function (sID, nType)
    {
        super();
        this._sID = sID;
        this._nType = nType;
    }).TYPE_WAITING = 1;
    (_global.dofus.datacenter.TutorialBloc = function (sID, nType)
    {
        super();
        this._sID = sID;
        this._nType = nType;
    }).TYPE_IF = 2;
} // end if
#endinitclip
