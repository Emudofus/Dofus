// Action script...

// [Initial MovieClip Action of sprite 20707]
#initclip 228
if (!dofus.datacenter.DofusMap)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.DofusMap = function (nID)
    {
        super(nID);
    }).prototype;
    _loc1.__get__coordinates = function ()
    {
        var _loc2 = _global.API.lang.getMapText(this.id);
        return (_global.API.lang.getText("COORDINATES") + " : " + _loc2.x + ", " + _loc2.y);
    };
    _loc1.__get__x = function ()
    {
        return (_global.API.lang.getMapText(this.id).x);
    };
    _loc1.__get__y = function ()
    {
        return (_global.API.lang.getMapText(this.id).y);
    };
    _loc1.__get__superarea = function ()
    {
        var _loc2 = _global.API.lang;
        return (_loc2.getMapAreaInfos(this.subarea).superareaID);
    };
    _loc1.__get__area = function ()
    {
        var _loc2 = _global.API.lang;
        return (_loc2.getMapAreaInfos(this.subarea).areaID);
    };
    _loc1.__get__subarea = function ()
    {
        var _loc2 = _global.API.lang;
        return (_loc2.getMapText(this.id).sa);
    };
    _loc1.__get__musics = function ()
    {
        var _loc2 = _global.API.lang;
        return (_loc2.getMapSubAreaText(this.subarea).m);
    };
    _loc1.addProperty("y", _loc1.__get__y, function ()
    {
    });
    _loc1.addProperty("musics", _loc1.__get__musics, function ()
    {
    });
    _loc1.addProperty("area", _loc1.__get__area, function ()
    {
    });
    _loc1.addProperty("subarea", _loc1.__get__subarea, function ()
    {
    });
    _loc1.addProperty("coordinates", _loc1.__get__coordinates, function ()
    {
    });
    _loc1.addProperty("superarea", _loc1.__get__superarea, function ()
    {
    });
    _loc1.addProperty("x", _loc1.__get__x, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
