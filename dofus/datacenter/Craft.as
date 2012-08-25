// Action script...

// [Initial MovieClip Action of sprite 20793]
#initclip 58
if (!dofus.datacenter.Craft)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Craft = function (nID, oSkill)
    {
        super();
        this.initialize(nID, oSkill);
    }).prototype;
    _loc1.__get__skill = function ()
    {
        return (this._oSkill);
    };
    _loc1.__get__craftItem = function ()
    {
        return (this._oCraftItem);
    };
    _loc1.__get__items = function ()
    {
        return (this._aItems);
    };
    _loc1.__get__itemsCount = function ()
    {
        return (this._aItems.length);
    };
    _loc1.__get__craftLevel = function ()
    {
        return (this.craftItem.level);
    };
    _loc1.__get__difficulty = function ()
    {
        return (this._nDifficulty);
    };
    _loc1.initialize = function (nID, oSkill)
    {
        this.api = _global.API;
        this._oSkill = oSkill;
        this._oCraftItem = new dofus.datacenter.Item(0, nID, 1);
        this.name = this._oCraftItem.name;
        var _loc4 = this.api.lang.getCraftText(nID);
        this._aItems = new Array();
        if (!_global.isNaN(_loc4.length))
        {
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc4.length)
            {
                var _loc6 = new dofus.datacenter.Item(0, _loc4[_loc5][0], _loc4[_loc5][1]);
                this._aItems.push(_loc6);
            } // end while
        } // end if
        if (this._aItems.length < Number(this._oSkill.param1) - 4)
        {
            this._nDifficulty = 1;
        }
        else if (this._aItems.length < Number(this._oSkill.param1) - 2)
        {
            this._nDifficulty = 2;
        }
        else
        {
            this._nDifficulty = 3;
        } // end else if
    };
    _loc1.addProperty("itemsCount", _loc1.__get__itemsCount, function ()
    {
    });
    _loc1.addProperty("difficulty", _loc1.__get__difficulty, function ()
    {
    });
    _loc1.addProperty("craftLevel", _loc1.__get__craftLevel, function ()
    {
    });
    _loc1.addProperty("items", _loc1.__get__items, function ()
    {
    });
    _loc1.addProperty("craftItem", _loc1.__get__craftItem, function ()
    {
    });
    _loc1.addProperty("skill", _loc1.__get__skill, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
