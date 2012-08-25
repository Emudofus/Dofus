// Action script...

// [Initial MovieClip Action of sprite 20604]
#initclip 125
if (!dofus.datacenter.TutorialAction)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.TutorialAction = function (sID, sActionCode, aParams, mNextBlocID, bKeepLastWaitingBloc)
    {
        super(sID, dofus.datacenter.TutorialBloc.TYPE_ACTION);
        this._sActionCode = sActionCode;
        this._aParams = aParams;
        this._mNextBlocID = mNextBlocID;
        this._bKeepLastWaitingBloc = bKeepLastWaitingBloc;
    }).prototype;
    _loc1.__get__actionCode = function ()
    {
        return (this._sActionCode);
    };
    _loc1.__get__params = function ()
    {
        return (this._aParams);
    };
    _loc1.__get__nextBlocID = function ()
    {
        return (this._mNextBlocID);
    };
    _loc1.__get__keepLastWaitingBloc = function ()
    {
        return (this._bKeepLastWaitingBloc == true);
    };
    _loc1.addProperty("params", _loc1.__get__params, function ()
    {
    });
    _loc1.addProperty("keepLastWaitingBloc", _loc1.__get__keepLastWaitingBloc, function ()
    {
    });
    _loc1.addProperty("nextBlocID", _loc1.__get__nextBlocID, function ()
    {
    });
    _loc1.addProperty("actionCode", _loc1.__get__actionCode, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
