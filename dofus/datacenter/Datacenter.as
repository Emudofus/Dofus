// Action script...

// [Initial MovieClip Action of sprite 20583]
#initclip 104
if (!dofus.datacenter.Datacenter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Datacenter = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).prototype;
    _loc1.initialize = function (oAPI)
    {
        this._oAPI = oAPI;
        this.Player = new dofus.datacenter.LocalPlayer(oAPI);
        this.Basics = new dofus.datacenter.Basics();
        this.Challenges = new ank.utils.ExtendedObject();
        this.Sprites = new ank.utils.ExtendedObject();
        this.Houses = new ank.utils.ExtendedObject();
        this.Storages = new ank.utils.ExtendedObject();
        this.Game = new dofus.datacenter.Game();
        this.Conquest = new dofus.datacenter.Conquest();
        this.Subareas = new ank.utils.ExtendedObject();
        this.Map = new dofus.datacenter.DofusMap();
        this.Temporary = new Object();
    };
    _loc1.clear = function ()
    {
        this.Player = new dofus.datacenter.LocalPlayer(this._oAPI);
        this.Basics.initialize();
        this.Challenges = new ank.utils.ExtendedObject();
        this.Sprites = new ank.utils.ExtendedObject();
        this.Houses = new ank.utils.ExtendedObject();
        this.Storages = new ank.utils.ExtendedObject();
        this.Game = new dofus.datacenter.Game();
        this.Conquest = new dofus.datacenter.Conquest();
        this.Subareas = new ank.utils.ExtendedObject();
        this.Map = new dofus.datacenter.DofusMap();
        this.Temporary = new Object();
        delete this.Exchange;
    };
    _loc1.clearGame = function ()
    {
        this.Game = new dofus.datacenter.Game();
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
