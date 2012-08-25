// Action script...

// [Initial MovieClip Action of sprite 20852]
#initclip 117
if (!dofus.datacenter.ItemSet)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ItemSet = function (nID, sEffects, aItemIDs)
    {
        super();
        this.initialize(nID, sEffects, aItemIDs);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.getItemSetText(this._nID).n);
    };
    _loc1.__get__description = function ()
    {
        return (this.api.lang.getItemSetText(this._nID).d);
    };
    _loc1.__get__itemCount = function ()
    {
        return (this._aItems.length);
    };
    _loc1.__get__items = function ()
    {
        return (this._aItems);
    };
    _loc1.__get__effects = function ()
    {
        return (dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects));
    };
    _loc1.initialize = function (nID, sEffects, aItemIDs)
    {
        if (sEffects == undefined)
        {
            sEffects = "";
        } // end if
        if (aItemIDs == undefined)
        {
            aItemIDs = [];
        } // end if
        this.api = _global.API;
        this._nID = nID;
        this.setEffects(sEffects);
        this.setItems(aItemIDs);
    };
    _loc1.setEffects = function (compressedData)
    {
        this._sEffects = compressedData;
        this._aEffects = new Array();
        var _loc3 = compressedData.split(",");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4].split("#");
            _loc5[0] = _global.parseInt(_loc5[0], 16);
            _loc5[1] = _loc5[1] == "0" ? (undefined) : (_global.parseInt(_loc5[1], 16));
            _loc5[2] = _loc5[2] == "0" ? (undefined) : (_global.parseInt(_loc5[2], 16));
            _loc5[3] = _loc5[3] == "0" ? (undefined) : (_global.parseInt(_loc5[3], 16));
            this._aEffects.push(_loc5);
        } // end while
    };
    _loc1.setItems = function (aItemIDs)
    {
        var _loc3 = this.api.lang.getItemSetText(this._nID).i;
        this._aItems = new Array();
        var _loc4 = new Object();
        for (var k in aItemIDs)
        {
            _loc4[aItemIDs[k]] = true;
        } // end of for...in
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            var _loc6 = Number(_loc3[_loc5]);
            if (_global.isNaN(_loc6))
            {
                continue;
            } // end if
            var _loc7 = new dofus.datacenter.Item(0, _loc6, 1);
            var _loc8 = _loc4[_loc6] == true;
            this._aItems.push({isEquiped: _loc8, item: _loc7});
        } // end while
    };
    _loc1.addProperty("effects", _loc1.__get__effects, function ()
    {
    });
    _loc1.addProperty("items", _loc1.__get__items, function ()
    {
    });
    _loc1.addProperty("itemCount", _loc1.__get__itemCount, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
