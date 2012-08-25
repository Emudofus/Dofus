// Action script...

// [Initial MovieClip Action of sprite 20688]
#initclip 209
if (!dofus.graphics.gapi.ui.HouseIndoor)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.HouseIndoor = function ()
    {
        super();
    }).prototype;
    _loc1.__set__house = function (oHouse)
    {
        this._oHouse = oHouse;
        oHouse.addEventListener("forsale", this);
        oHouse.addEventListener("locked", this);
        this._mcForSale._visible = oHouse.isForSale;
        this._mcLock._visible = oHouse.isLocked;
        //return (this.house());
    };
    _loc1.__set__skills = function (aSkills)
    {
        this._aSkills = aSkills;
        //return (this.skills());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.HouseIndoor.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._mcHouse.onRelease = this.click;
        if (this._oHouse == undefined)
        {
            this._mcForSale._visible = false;
            this._mcLock._visible = false;
        } // end if
    };
    _loc1.click = function ()
    {
        var _loc2 = this._parent.gapi.createPopupMenu();
        var _loc3 = this._parent._oHouse;
        var _loc4 = this._parent.api;
        _loc2.addStaticItem(_loc3.name);
        for (var k in this._parent._aSkills)
        {
            var _loc5 = this._parent._aSkills[k];
            var _loc6 = _loc5.getState(true, _loc3.localOwner, _loc3.isForSale, _loc3.isLocked, true);
            if (_loc6 != "X")
            {
                _loc2.addItem(_loc5.description, _loc4.kernel.GameManager, _loc4.kernel.GameManager.useSkill, [_loc5.id], _loc6 == "V");
            } // end if
        } // end of for...in
        if (_loc4.datacenter.Player.guildInfos != undefined && _loc4.datacenter.Player.guildInfos.isValid)
        {
            _loc2.addItem(_loc4.lang.getText("GUILD_HOUSE_CONFIGURATION"), this._parent, this._parent.guildHouse);
        } // end if
        _loc2.show(_root._xmouse, _root._ymouse);
    };
    _loc1.guildHouse = function ()
    {
        this.api.ui.loadUIComponent("GuildHouseRights", "GuildHouseRights", {house: this._oHouse});
    };
    _loc1.forsale = function (oEvent)
    {
        this._mcForSale._visible = oEvent.value;
    };
    _loc1.locked = function (oEvent)
    {
        this._mcLock._visible = oEvent.value;
    };
    _loc1.addProperty("skills", function ()
    {
    }, _loc1.__set__skills);
    _loc1.addProperty("house", function ()
    {
    }, _loc1.__set__house);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.HouseIndoor = function ()
    {
        super();
    }).CLASS_NAME = "HouseIndoor";
} // end if
#endinitclip
