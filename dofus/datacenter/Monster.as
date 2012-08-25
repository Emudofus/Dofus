// Action script...

// [Initial MovieClip Action of sprite 20491]
#initclip 12
if (!dofus.datacenter.Monster)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Monster = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    }).prototype;
    _loc1.__set__name = function (nNameID)
    {
        this._nNameID = Number(nNameID);
        //return (this.name());
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.getMonstersText(this._nNameID).n);
    };
    _loc1.__get__kickable = function ()
    {
        return (this.api.lang.getMonstersText(this._nNameID).k);
    };
    _loc1.__set__powerLevel = function (nPowerLevel)
    {
        this._nPowerLevel = Number(nPowerLevel);
        //return (this.powerLevel());
    };
    _loc1.__get__powerLevel = function ()
    {
        return (this._nPowerLevel);
    };
    _loc1.__get__Level = function ()
    {
        return (this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].l);
    };
    _loc1.__get__resistances = function ()
    {
        var _loc2 = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
        var _loc3 = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc2.length)
        {
            _loc3[_loc4] = _loc2[_loc4];
        } // end while
        _loc3[5] = _loc3[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
        _loc3[6] = _loc3[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
        return (_loc3);
    };
    _loc1.__get__alignment = function ()
    {
        return (new dofus.datacenter.Alignment(this.api.lang.getMonstersText(this._nNameID).a, 0));
    };
    _loc1.alertChatText = function ()
    {
        var _loc2 = this.api.datacenter.Map;
        return (this.name + " niveau " + this.Level + " en " + _loc2.x + "," + _loc2.y + ".");
    };
    _loc1.addProperty("powerLevel", _loc1.__get__powerLevel, _loc1.__set__powerLevel);
    _loc1.addProperty("kickable", _loc1.__get__kickable, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("resistances", _loc1.__get__resistances, function ()
    {
    });
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("Level", _loc1.__get__Level, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._nSpeedModerator = 1;
} // end if
#endinitclip
