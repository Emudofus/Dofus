// Action script...

// [Initial MovieClip Action of sprite 20541]
#initclip 62
if (!dofus.managers.AreasManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.AreasManager = function ()
    {
        super();
        dofus.managers.AreasManager._sSelf = this;
    }).prototype;
    (_global.dofus.managers.AreasManager = function ()
    {
        super();
        dofus.managers.AreasManager._sSelf = this;
    }).getInstance = function ()
    {
        return (dofus.managers.AreasManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this._oAreasCoords = new Object();
        this._oSubAreasCoords = new Object();
        var _loc4 = this.api.lang.getAllMapsInfos();
        for (var k in _loc4)
        {
            var _loc5 = _loc4[k];
            var _loc6 = this.api.lang.getMapSubAreaText(_loc5.sa).a;
            var _loc7 = this.api.lang.getMapAreaText(_loc6).sua;
            var _loc8 = _loc7 + "_" + _loc5.x + "_" + _loc5.y;
            if (this._oAreasCoords[_loc8] == undefined)
            {
                this._oAreasCoords[_loc8] = _loc6;
                this._oSubAreasCoords[_loc8] = _loc5.sa;
            } // end if
        } // end of for...in
    };
    _loc1.getAreaIDFromCoordinates = function (nX, nY, nSuperAreaID)
    {
        if (nSuperAreaID == undefined)
        {
            nSuperAreaID = 0;
        } // end if
        return (this._oAreasCoords[nSuperAreaID + "_" + nX + "_" + nY]);
    };
    _loc1.getSubAreaIDFromCoordinates = function (nX, nY, nSuperAreaID)
    {
        if (nSuperAreaID == undefined)
        {
            nSuperAreaID = 0;
        } // end if
        return (this._oSubAreasCoords[nSuperAreaID + "_" + nX + "_" + nY]);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.AreasManager = function ()
    {
        super();
        dofus.managers.AreasManager._sSelf = this;
    })._sSelf = null;
} // end if
#endinitclip
