// Action script...

// [Initial MovieClip Action of sprite 20552]
#initclip 73
if (!dofus.datacenter.SecureCraftExchange)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.SecureCraftExchange = function (nDistantPlayerID)
    {
        super();
        this.initialize(nDistantPlayerID);
    }).prototype;
    _loc1.__get__coopGarbage = function ()
    {
        return (this._eaCoopGarbage);
    };
    _loc1.__get__payGarbage = function ()
    {
        return (this._eaPayGarbage);
    };
    _loc1.__get__payIfSuccessGarbage = function ()
    {
        return (this._eaPayIfSuccessGarbage);
    };
    _loc1.__set__payKama = function (nKama)
    {
        this._nPayKama = nKama;
        this.dispatchEvent({type: "payKamaChange", value: nKama});
        //return (this.payKama());
    };
    _loc1.__get__payKama = function ()
    {
        return (this._nPayKama);
    };
    _loc1.__set__payIfSuccessKama = function (nKama)
    {
        this._nPayIfSuccessKama = nKama;
        this.dispatchEvent({type: "payIfSuccessKamaChange", value: nKama});
        //return (this.payIfSuccessKama());
    };
    _loc1.__get__payIfSuccessKama = function ()
    {
        return (this._nPayIfSuccessKama);
    };
    _loc1.initialize = function (nDistantPlayerID)
    {
        super.initialize(nDistantPlayerID);
        this._eaCoopGarbage = new ank.utils.ExtendedArray();
        this._eaPayGarbage = new ank.utils.ExtendedArray();
        this._eaPayIfSuccessGarbage = new ank.utils.ExtendedArray();
    };
    _loc1.clearCoopGarbage = function ()
    {
        this._eaCoopGarbage.removeAll();
    };
    _loc1.clearPayGarbage = function ()
    {
        this._eaPayGarbage.removeAll();
    };
    _loc1.clearPayIfSuccessGarbage = function ()
    {
        this._eaPayIfSuccessGarbage.removeAll();
    };
    _loc1.addProperty("payKama", _loc1.__get__payKama, _loc1.__set__payKama);
    _loc1.addProperty("payIfSuccessGarbage", _loc1.__get__payIfSuccessGarbage, function ()
    {
    });
    _loc1.addProperty("payIfSuccessKama", _loc1.__get__payIfSuccessKama, _loc1.__set__payIfSuccessKama);
    _loc1.addProperty("coopGarbage", _loc1.__get__coopGarbage, function ()
    {
    });
    _loc1.addProperty("payGarbage", _loc1.__get__payGarbage, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._nPayKama = 0;
    _loc1._nPayIfSuccessKama = 0;
} // end if
#endinitclip
