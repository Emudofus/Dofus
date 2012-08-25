// Action script...

// [Initial MovieClip Action of sprite 20883]
#initclip 148
if (!dofus.datacenter.Specialization)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Specialization = function (nIndex)
    {
        super();
        this.api = _global.API;
        this.initialize(nIndex);
    }).prototype;
    _loc1.__get__index = function ()
    {
        return (this._nIndex);
    };
    _loc1.__set__index = function (nIndex)
    {
        this._nIndex = _global.isNaN(nIndex) || nIndex == undefined ? (0) : (nIndex);
        //return (this.index());
    };
    _loc1.__get__name = function ()
    {
        return (this._oSpecInfos.n);
    };
    _loc1.__get__description = function ()
    {
        return (this._oSpecInfos.d);
    };
    _loc1.__get__order = function ()
    {
        return (new dofus.datacenter.Order(this._oSpecInfos.o));
    };
    _loc1.__get__alignment = function ()
    {
        return (new dofus.datacenter.Alignment(this.order.alignment.index, this._oSpecInfos.av));
    };
    _loc1.__get__feats = function ()
    {
        return (this._eaFeats);
    };
    _loc1.initialize = function (nIndex)
    {
        this._nIndex = nIndex;
        this._oSpecInfos = this.api.lang.getAlignmentSpecialization(nIndex);
        this._eaFeats = new ank.utils.ExtendedArray();
        var _loc3 = this._oSpecInfos.f;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            this._eaFeats.push(new dofus.datacenter.Feat(_loc3[_loc4][0], _loc3[_loc4][1], _loc3[_loc4][2]));
        } // end while
    };
    _loc1.addProperty("index", _loc1.__get__index, _loc1.__set__index);
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("order", _loc1.__get__order, function ()
    {
    });
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("feats", _loc1.__get__feats, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
