// Action script...

// [Initial MovieClip Action of sprite 20624]
#initclip 145
if (!dofus.datacenter.Hint)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Hint = function (data)
    {
        super();
        this.api = _global.API;
        this._oData = data;
    }).prototype;
    _loc1.__get__mapID = function ()
    {
        return (this._oData.m);
    };
    _loc1.__get__name = function ()
    {
        return (this._oData.n);
    };
    _loc1.__get__category = function ()
    {
        return (this.api.lang.getHintsCategory(this.categoryID).n);
    };
    _loc1.__get__categoryID = function ()
    {
        return (this._oData.c);
    };
    _loc1.__get__coordinates = function ()
    {
        return (this.x + ", " + this.y);
    };
    _loc1.__get__x = function ()
    {
        if (this._oData.m == undefined)
        {
            return (this._oData.x);
        } // end if
        return (this.api.lang.getMapText(this._oData.m).x);
    };
    _loc1.__get__y = function ()
    {
        if (this._oData.m == undefined)
        {
            return (this._oData.y);
        } // end if
        return (this.api.lang.getMapText(this._oData.m).y);
    };
    _loc1.__get__superAreaID = function ()
    {
        var _loc2 = this.api.lang.getMapText(this._oData.m).sa;
        var _loc3 = this.api.lang.getMapSubAreaText(_loc2).a;
        var _loc4 = this.api.lang.getMapAreaText(_loc3).sua;
        return (_loc4);
    };
    _loc1.__get__gfx = function ()
    {
        return (this._oData.g);
    };
    _loc1.addProperty("y", _loc1.__get__y, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("category", _loc1.__get__category, function ()
    {
    });
    _loc1.addProperty("mapID", _loc1.__get__mapID, function ()
    {
    });
    _loc1.addProperty("gfx", _loc1.__get__gfx, function ()
    {
    });
    _loc1.addProperty("superAreaID", _loc1.__get__superAreaID, function ()
    {
    });
    _loc1.addProperty("coordinates", _loc1.__get__coordinates, function ()
    {
    });
    _loc1.addProperty("x", _loc1.__get__x, function ()
    {
    });
    _loc1.addProperty("categoryID", _loc1.__get__categoryID, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
