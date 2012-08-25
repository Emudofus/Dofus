// Action script...

// [Initial MovieClip Action of sprite 20551]
#initclip 72
if (!dofus.datacenter.Exchange)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Exchange = function (nDistantPlayerID)
    {
        super();
        this.initialize(nDistantPlayerID);
    }).prototype;
    _loc1.__set__inventory = function (eaInventory)
    {
        this._eaInventory = eaInventory;
        //return (this.inventory());
    };
    _loc1.__get__inventory = function ()
    {
        return (this._eaInventory);
    };
    _loc1.__get__localGarbage = function ()
    {
        return (this._eaLocalGarbage);
    };
    _loc1.__get__distantGarbage = function ()
    {
        return (this._eaDistantGarbage);
    };
    _loc1.__get__coopGarbage = function ()
    {
        return (this._eaCoopGarbage);
    };
    _loc1.__get__readyStates = function ()
    {
        return (this._eaReadyStates);
    };
    _loc1.__get__distantPlayerID = function ()
    {
        return (this._nDistantPlayerID);
    };
    _loc1.__set__localKama = function (nLocalKama)
    {
        this._nLocalKama = nLocalKama;
        this.dispatchEvent({type: "localKamaChange", value: nLocalKama});
        //return (this.localKama());
    };
    _loc1.__get__localKama = function ()
    {
        return (this._nLocalKama);
    };
    _loc1.__set__distantKama = function (nDistantKama)
    {
        this._nDistantKama = nDistantKama;
        this.dispatchEvent({type: "distantKamaChange", value: nDistantKama});
        //return (this.distantKama());
    };
    _loc1.__get__distantKama = function ()
    {
        return (this._nDistantKama);
    };
    _loc1.initialize = function (nDistantPlayerID)
    {
        mx.events.EventDispatcher.initialize(this);
        this._nDistantPlayerID = nDistantPlayerID;
        this._eaLocalGarbage = new ank.utils.ExtendedArray();
        this._eaDistantGarbage = new ank.utils.ExtendedArray();
        this._eaCoopGarbage = new ank.utils.ExtendedArray();
        this._eaReadyStates = new ank.utils.ExtendedArray();
        this._eaReadyStates[0] = false;
        this._eaReadyStates[1] = false;
    };
    _loc1.clearLocalGarbage = function ()
    {
        this._eaLocalGarbage.removeAll();
    };
    _loc1.clearDistantGarbage = function ()
    {
        this._eaDistantGarbage.removeAll();
    };
    _loc1.clearCoopGarbage = function ()
    {
        this._eaCoopGarbage.removeAll();
    };
    _loc1.addProperty("distantKama", _loc1.__get__distantKama, _loc1.__set__distantKama);
    _loc1.addProperty("localKama", _loc1.__get__localKama, _loc1.__set__localKama);
    _loc1.addProperty("distantPlayerID", _loc1.__get__distantPlayerID, function ()
    {
    });
    _loc1.addProperty("readyStates", _loc1.__get__readyStates, function ()
    {
    });
    _loc1.addProperty("inventory", _loc1.__get__inventory, _loc1.__set__inventory);
    _loc1.addProperty("localGarbage", _loc1.__get__localGarbage, function ()
    {
    });
    _loc1.addProperty("coopGarbage", _loc1.__get__coopGarbage, function ()
    {
    });
    _loc1.addProperty("distantGarbage", _loc1.__get__distantGarbage, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._nLocalKama = 0;
    _loc1._nDistantKama = 0;
} // end if
#endinitclip
