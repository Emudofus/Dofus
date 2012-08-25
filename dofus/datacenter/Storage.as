// Action script...

// [Initial MovieClip Action of sprite 20803]
#initclip 68
if (!dofus.datacenter.Storage)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Storage = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__set__localOwner = function (bLocalOwner)
    {
        this._bLocalOwner = bLocalOwner;
        //return (this.localOwner());
    };
    _loc1.__get__localOwner = function ()
    {
        return (this._bLocalOwner);
    };
    _loc1.__set__isLocked = function (bLocked)
    {
        this._bLocked = bLocked;
        this.dispatchEvent({type: "locked", value: bLocked});
        //return (this.isLocked());
    };
    _loc1.__get__isLocked = function ()
    {
        return (this._bLocked);
    };
    _loc1.__set__inventory = function (eaInventory)
    {
        this._eaInventory = eaInventory;
        this.dispatchEvent({type: "modelChanged"});
        //return (this.inventory());
    };
    _loc1.__get__inventory = function ()
    {
        return (this._eaInventory);
    };
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
    _loc1.initialize = function ()
    {
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.addProperty("Kama", _loc1.__get__Kama, _loc1.__set__Kama);
    _loc1.addProperty("localOwner", _loc1.__get__localOwner, _loc1.__set__localOwner);
    _loc1.addProperty("isLocked", _loc1.__get__isLocked, _loc1.__set__isLocked);
    _loc1.addProperty("inventory", _loc1.__get__inventory, _loc1.__set__inventory);
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bLocalOwner = false;
    _loc1._bLocked = false;
} // end if
#endinitclip
