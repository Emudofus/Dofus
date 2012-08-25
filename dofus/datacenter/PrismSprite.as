// Action script...

// [Initial MovieClip Action of sprite 20906]
#initclip 171
if (!dofus.datacenter.PrismSprite)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.PrismSprite = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    }).prototype;
    _loc1.__get__name = function ()
    {
        return (this.api.lang.getMonstersText(this._nLinkedMonsterId).n);
    };
    _loc1.__set__linkedMonster = function (value)
    {
        this._nLinkedMonsterId = value;
        //return (this.linkedMonster());
    };
    _loc1.__get__linkedMonster = function ()
    {
        return (this._nLinkedMonsterId);
    };
    _loc1.__set__alignment = function (value)
    {
        this._aAlignment = value;
        //return (this.alignment());
    };
    _loc1.__get__alignment = function ()
    {
        return (this._aAlignment);
    };
    _loc1.addProperty("alignment", _loc1.__get__alignment, _loc1.__set__alignment);
    _loc1.addProperty("linkedMonster", _loc1.__get__linkedMonster, _loc1.__set__linkedMonster);
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
