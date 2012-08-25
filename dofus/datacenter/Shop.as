// Action script...

// [Initial MovieClip Action of sprite 20548]
#initclip 69
if (!dofus.datacenter.Shop)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Shop = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__get__name = function ()
    {
        return (this._sName);
    };
    _loc1.__set__gfx = function (sGfx)
    {
        this._sGfx = sGfx;
        //return (this.gfx());
    };
    _loc1.__get__gfx = function ()
    {
        return (this._sGfx);
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
    _loc1.initialize = function ()
    {
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.addProperty("inventory", _loc1.__get__inventory, _loc1.__set__inventory);
    _loc1.addProperty("gfx", _loc1.__get__gfx, _loc1.__set__gfx);
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
