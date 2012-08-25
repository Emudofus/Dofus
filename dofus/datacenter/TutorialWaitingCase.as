// Action script...

// [Initial MovieClip Action of sprite 20716]
#initclip 237
if (!dofus.datacenter.TutorialWaitingCase)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.TutorialWaitingCase = function (sCode, aParams, mNextBlocID)
    {
        super();
        this._sCode = sCode;
        this._aParams = aParams;
        this._mNextBlocID = mNextBlocID;
    }).prototype;
    _loc1.__get__code = function ()
    {
        return (this._sCode);
    };
    _loc1.__get__params = function ()
    {
        return (this._aParams);
    };
    _loc1.__get__nextBlocID = function ()
    {
        return (this._mNextBlocID);
    };
    _loc1.addProperty("params", _loc1.__get__params, function ()
    {
    });
    _loc1.addProperty("nextBlocID", _loc1.__get__nextBlocID, function ()
    {
    });
    _loc1.addProperty("code", _loc1.__get__code, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.TutorialWaitingCase = function (sCode, aParams, mNextBlocID)
    {
        super();
        this._sCode = sCode;
        this._aParams = aParams;
        this._mNextBlocID = mNextBlocID;
    }).CASE_TIMEOUT = "TIMEOUT";
    (_global.dofus.datacenter.TutorialWaitingCase = function (sCode, aParams, mNextBlocID)
    {
        super();
        this._sCode = sCode;
        this._aParams = aParams;
        this._mNextBlocID = mNextBlocID;
    }).CASE_DEFAULT = "DEFAULT";
} // end if
#endinitclip
