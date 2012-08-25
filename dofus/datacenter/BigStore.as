// Action script...

// [Initial MovieClip Action of sprite 20630]
#initclip 151
if (!dofus.datacenter.BigStore)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.BigStore = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__set__quantity1 = function (nQuantity1)
    {
        this._nQuantity1 = nQuantity1;
        //return (this.quantity1());
    };
    _loc1.__get__quantity1 = function ()
    {
        return (this._nQuantity1);
    };
    _loc1.__set__quantity2 = function (nQuantity2)
    {
        this._nQuantity2 = nQuantity2;
        //return (this.quantity2());
    };
    _loc1.__get__quantity2 = function ()
    {
        return (this._nQuantity2);
    };
    _loc1.__set__quantity3 = function (nQuantity3)
    {
        this._nQuantity3 = nQuantity3;
        //return (this.quantity3());
    };
    _loc1.__get__quantity3 = function ()
    {
        return (this._nQuantity3);
    };
    _loc1.__set__types = function (aTypes)
    {
        this._aTypes = aTypes;
        //return (this.types());
    };
    _loc1.__get__types = function ()
    {
        return (this._aTypes);
    };
    _loc1.__get__typesObj = function ()
    {
        var _loc2 = new Object();
        for (var k in this._aTypes)
        {
            _loc2[this._aTypes[k]] = true;
        } // end of for...in
        return (_loc2);
    };
    _loc1.__set__tax = function (nTax)
    {
        this._nTax = nTax;
        //return (this.tax());
    };
    _loc1.__get__tax = function ()
    {
        return (this._nTax);
    };
    _loc1.__set__maxLevel = function (nMaxLevel)
    {
        this._nMaxLevel = nMaxLevel;
        //return (this.maxLevel());
    };
    _loc1.__get__maxLevel = function ()
    {
        return (this._nMaxLevel);
    };
    _loc1.__set__maxItemCount = function (nMaxItemCount)
    {
        this._nMaxItemCount = nMaxItemCount;
        //return (this.maxItemCount());
    };
    _loc1.__get__maxItemCount = function ()
    {
        return (this._nMaxItemCount);
    };
    _loc1.__set__inventory2 = function (eaInventory)
    {
        this._eaInventory2 = eaInventory;
        this.dispatchEvent({type: "modelChanged2"});
        //return (this.inventory2());
    };
    _loc1.__get__inventory2 = function ()
    {
        return (this._eaInventory2);
    };
    _loc1.addProperty("maxLevel", _loc1.__get__maxLevel, _loc1.__set__maxLevel);
    _loc1.addProperty("inventory2", _loc1.__get__inventory2, _loc1.__set__inventory2);
    _loc1.addProperty("quantity1", _loc1.__get__quantity1, _loc1.__set__quantity1);
    _loc1.addProperty("maxItemCount", _loc1.__get__maxItemCount, _loc1.__set__maxItemCount);
    _loc1.addProperty("tax", _loc1.__get__tax, _loc1.__set__tax);
    _loc1.addProperty("quantity2", _loc1.__get__quantity2, _loc1.__set__quantity2);
    _loc1.addProperty("quantity3", _loc1.__get__quantity3, _loc1.__set__quantity3);
    _loc1.addProperty("types", _loc1.__get__types, _loc1.__set__types);
    _loc1.addProperty("typesObj", _loc1.__get__typesObj, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
