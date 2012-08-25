// Action script...

// [Initial MovieClip Action of sprite 20637]
#initclip 158
if (!dofus.datacenter.Crafter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Crafter = function (sId, sName)
    {
        super();
        this.api = _global.API;
        this.id = sId;
        this._sName = sName;
    }).prototype;
    _loc1.__get__name = function ()
    {
        return (this._sName);
    };
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__get__job = function ()
    {
        return (this._oJob);
    };
    _loc1.__set__job = function (value)
    {
        this._oJob = value;
        //return (this.job());
    };
    _loc1.__get__breedId = function ()
    {
        return (this._nBreedId);
    };
    _loc1.__set__breedId = function (nBreedId)
    {
        this._nBreedId = nBreedId;
        //return (this.breedId());
    };
    _loc1.__get__gfxFile = function ()
    {
        var _loc2 = this._nBreedId * 10 + this._nSex;
        return (dofus.Constants.CLIPS_PERSOS_PATH + _loc2 + ".swf");
    };
    _loc1.__get__gfxBreedFile = function ()
    {
        return (dofus.Constants.GUILDS_MINI_PATH + (this._nBreedId * 10 + this._nSex) + ".swf");
    };
    _loc1.__get__sex = function ()
    {
        return (this._nSex);
    };
    _loc1.__set__sex = function (value)
    {
        this._nSex = Number(value);
        //return (this.sex());
    };
    _loc1.__get__color1 = function ()
    {
        return (this._nColor1);
    };
    _loc1.__set__color1 = function (value)
    {
        this._nColor1 = Number(value);
        //return (this.color1());
    };
    _loc1.__get__color2 = function ()
    {
        return (this._nColor2);
    };
    _loc1.__set__color2 = function (value)
    {
        this._nColor2 = Number(value);
        //return (this.color2());
    };
    _loc1.__get__color3 = function ()
    {
        return (this._nColor3);
    };
    _loc1.__set__color3 = function (value)
    {
        this._nColor3 = Number(value);
        //return (this.color3());
    };
    _loc1.__get__accessories = function ()
    {
        return (this._aAccessories);
    };
    _loc1.__set__accessories = function (value)
    {
        this._aAccessories = value;
        //return (this.accessories());
    };
    _loc1.__set__mapId = function (nMapId)
    {
        this._nMapId = nMapId;
        //return (this.mapId());
    };
    _loc1.__get__subarea = function ()
    {
        if (this._nMapId == 0)
        {
            return;
        } // end if
        var _loc2 = this.api.lang.getMapText(this._nMapId);
        var _loc3 = this.api.lang.getMapSubAreaText(_loc2.sa);
        var _loc4 = this.api.lang.getMapAreaText(_loc3.a);
        return (_loc3.n.charAt(0) == "/" && _loc3.n.charAt(1) == "/" ? (_loc4.n) : (_loc4.n + " (" + _loc3.n + ")"));
    };
    _loc1.__get__coord = function ()
    {
        if (this._nMapId == 0)
        {
            return;
        } // end if
        var _loc2 = this.api.lang.getMapText(this._nMapId);
        return ({x: _loc2.x, y: _loc2.y});
    };
    _loc1.addProperty("sex", _loc1.__get__sex, _loc1.__set__sex);
    _loc1.addProperty("gfxFile", _loc1.__get__gfxFile, function ()
    {
    });
    _loc1.addProperty("mapId", function ()
    {
    }, _loc1.__set__mapId);
    _loc1.addProperty("breedId", _loc1.__get__breedId, _loc1.__set__breedId);
    _loc1.addProperty("accessories", _loc1.__get__accessories, _loc1.__set__accessories);
    _loc1.addProperty("job", _loc1.__get__job, _loc1.__set__job);
    _loc1.addProperty("gfxBreedFile", _loc1.__get__gfxBreedFile, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("color1", _loc1.__get__color1, _loc1.__set__color1);
    _loc1.addProperty("color2", _loc1.__get__color2, _loc1.__set__color2);
    _loc1.addProperty("color3", _loc1.__get__color3, _loc1.__set__color3);
    _loc1.addProperty("coord", _loc1.__get__coord, function ()
    {
    });
    _loc1.addProperty("subarea", _loc1.__get__subarea, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
