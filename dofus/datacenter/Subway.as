// Action script...

// [Initial MovieClip Action of sprite 20636]
#initclip 157
if (!dofus.datacenter.Subway)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Subway = function (data, cost)
    {
        super(data);
        this._nCost = cost;
        this.fieldToSort = this.name + this.mapID;
    }).prototype;
    _loc1.__get__cost = function ()
    {
        return (this._nCost);
    };
    _loc1.addProperty("cost", _loc1.__get__cost, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
