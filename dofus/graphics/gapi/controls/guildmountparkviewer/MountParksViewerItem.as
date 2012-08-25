// Action script...

// [Initial MovieClip Action of sprite 20674]
#initclip 195
if (!dofus.graphics.gapi.controls.guildmountparkviewer.MountParksViewerItem)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls.guildmountparkviewer)
    {
        _global.dofus.graphics.gapi.controls.guildmountparkviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.guildmountparkviewer.MountParksViewerItem = function ()
    {
        super();
        this.api = _global.API;
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        this._bUsed = bUsed;
        if (bUsed)
        {
            this._oItem = oItem;
            var _loc5 = this.api.lang.getMapText(Number(oItem.map)).x;
            var _loc6 = this.api.lang.getMapText(Number(oItem.map)).y;
            this._lblSubArea.text = this.api.kernel.MapsServersManager.getMapName(oItem.map) + " (" + _loc5 + ", " + _loc6 + ")";
            oItem.sortLocalisation = this._lblSubArea.text;
            this._lblItems.text = this.api.lang.getText("MOUNTPARKS_MAX_ITEMS", [oItem.items]);
            this._lblMounts.text = this.api.lang.getText("MOUNTPARKS_CURRENT_MOUNTS", [oItem.mounts.length, oItem.size]);
            oItem.sortMounts = oItem.mounts.length;
            this._btnTeleport._visible = true;
            this._btnTeleport.onRollOver = function ()
            {
                this._parent.gapi.showTooltip(this._parent.api.lang.getText("GUILD_FARM_TELEPORT_TOOLTIP"), this, -20);
            };
            this._btnTeleport.onRollOut = function ()
            {
                this._parent.gapi.hideTooltip();
            };
        }
        else
        {
            this._btnTeleport._visible = false;
            if (this._lblArea.text != undefined)
            {
                this._lblArea.text = "";
                this._lblSubArea.text = "";
                this._lblItems.text = "-";
                this._lblMounts.text = "";
            } // end if
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._lblMounts.onRollOver = function ()
        {
            this._parent.over({target: this});
        };
        this._lblMounts.onRollOut = function ()
        {
            this._parent.out({target: this});
        };
        this._btnTeleport.addEventListener("click", this);
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = this._mcList._parent._parent.api;
        switch (oEvent.target)
        {
            case this._lblMounts:
            {
                var _loc4 = "";
                var _loc5 = this._oItem.mounts;
                var _loc6 = 0;
                
                while (++_loc6, _loc6 < _loc5.length)
                {
                    if (_loc6 > 0)
                    {
                        _loc4 = _loc4 + "\n\n";
                    } // end if
                    var _loc7 = _loc5[_loc6];
                    _loc4 = _loc4 + (_loc3.lang.getText("MOUNT_OF", [_loc7.ownerName]) + " : " + _loc7.name + "\n(" + _loc7.modelName + ")");
                } // end while
                if (_loc4 != "")
                {
                    _loc3.ui.showTooltip(_loc4, oEvent.target, -30, {bXLimit: true, bYLimit: false});
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnTeleport:
            {
                if (!this._bUsed)
                {
                    return;
                } // end if
                this.api.network.Guild.teleportToGuildFarm(this._oItem.map);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        var _loc3 = this._mcList._parent._parent.api;
        _loc3.ui.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
