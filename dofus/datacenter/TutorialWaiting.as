// Action script...

// [Initial MovieClip Action of sprite 20590]
#initclip 111
if (!dofus.datacenter.TutorialWaiting)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.TutorialWaiting = function (sID, nTimeout, aCases)
    {
        super(sID, dofus.datacenter.TutorialBloc.TYPE_WAITING);
        this._nTimeout = nTimeout;
        this.setCases(aCases);
    }).prototype;
    _loc1.__get__timeout = function ()
    {
        return (this._nTimeout == undefined ? (0) : (this._nTimeout));
    };
    _loc1.__get__cases = function ()
    {
        return (this._oCases);
    };
    _loc1.setCases = function (aCases)
    {
        this._oCases = new Object();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aCases.length)
        {
            var _loc4 = aCases[_loc3];
            var _loc5 = _loc4[0];
            var _loc6 = _loc4[1];
            var _loc7 = _loc4[2];
            var _loc8 = new dofus.datacenter.TutorialWaitingCase(_loc5, _loc6, _loc7);
            this._oCases[_loc5] = _loc8;
        } // end while
    };
    _loc1.addProperty("cases", _loc1.__get__cases, function ()
    {
    });
    _loc1.addProperty("timeout", _loc1.__get__timeout, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
