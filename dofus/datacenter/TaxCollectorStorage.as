// Action script...

// [Initial MovieClip Action of sprite 20767]
#initclip 32
if (!dofus.datacenter.TaxCollectorStorage)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.TaxCollectorStorage = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__set__Kama = function (nKamas)
    {
        this._nKamas = nKamas;
        this.dispatchEvent({type: "kamaChanged", value: nKamas});
        //return (this.Kama());
    };
    _loc1.__get__Kama = function ()
    {
        return (this._nKamas);
    };
    _loc1.addProperty("Kama", _loc1.__get__Kama, _loc1.__set__Kama);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
