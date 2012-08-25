// Action script...

// [Initial MovieClip Action of sprite 20769]
#initclip 34
if (!dofus.graphics.gapi.ui.party.PartyItem)
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
    if (!dofus.graphics.gapi.ui.party)
    {
        _global.dofus.graphics.gapi.ui.party = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.party.PartyItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oSprite)
    {
        this._oSprite = oSprite;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.data());
    };
    _loc1.__set__isFollowing = function (bIsFollowing)
    {
        this._bIsFollowing = bIsFollowing;
        this._mcFollow._visible = bIsFollowing;
        //return (this.isFollowing());
    };
    _loc1.__get__isInGroup = function (bIsInGroup)
    {
        return (this._bIsInGroup);
    };
    _loc1.setHealth = function (oSprite)
    {
        if (oSprite.life == undefined)
        {
            return;
        } // end if
        var _loc3 = oSprite.life.split(",");
        this._mcHealth._yscale = _loc3[0] / _loc3[1] * 100;
        this._oSprite.life = oSprite.life;
    };
    _loc1.setData = function (oSprite)
    {
        if (this.doReload(oSprite))
        {
            this._oSprite = oSprite;
            if (this.initialized)
            {
                this.updateData();
            } // end if
        }
        else
        {
            this.setHealth(oSprite);
        } // end else if
    };
    _loc1.doReload = function (oSprite)
    {
        var _loc3 = true;
        if (this._oSprite.accessories && (oSprite.accessories.length == this._oSprite.accessories.length && oSprite.id == this._oSprite.id))
        {
            var _loc4 = this._oSprite.accessories;
            var _loc5 = oSprite.accessories;
            var _loc6 = new Array();
            var _loc7 = new Array();
            for (var i in _loc4)
            {
                _loc6.push(_loc4[i].unicID);
            } // end of for...in
            for (var i in _loc5)
            {
                _loc7.push(_loc5[i].unicID);
            } // end of for...in
            _loc6.sort();
            _loc7.sort();
            _loc3 = !_loc6 || _loc6.join(",") != _loc7.join(",");
        } // end if
        return (_loc3);
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this._mcBack._visible = false;
        this._mcFollow._visible = false;
        this._mcHealth._visible = false;
        this._btn._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._ldrSprite.addEventListener("initialization", this);
        this._btn.addEventListener("over", this);
        this._btn.addEventListener("out", this);
        this._btn.addEventListener("click", this);
    };
    _loc1.updateData = function ()
    {
        if (this._oSprite != undefined)
        {
            this._ldrSprite.contentPath = this._oSprite.gfxFile == undefined ? ("") : (this._oSprite.gfxFile);
            this.api.colors.addSprite(this._ldrSprite, this._oSprite);
            this._mcBack._visible = true;
            this._btn.enabled = true;
            this._btn._visible = true;
            this._mcHealth._visible = true;
            this.setHealth(this._oSprite.life);
            this._bIsInGroup = true;
            this._visible = true;
        }
        else
        {
            this._ldrSprite.contentPath = "";
            this._mcBack._visible = false;
            this._mcFollow._visible = false;
            this._btn.enabled = false;
            this._btn._visible = false;
            this._mcHealth._visible = false;
            this._bIsInGroup = false;
            this._visible = false;
        } // end else if
    };
    _loc1.isLocalPlayerLeader = function ()
    {
        return (this._parent.leaderID == this.api.datacenter.Player.ID);
    };
    _loc1.isLocalPlayer = function ()
    {
        return (this._oSprite.id == this.api.datacenter.Player.ID);
    };
    _loc1.partyWhere = function ()
    {
        this.api.network.Party.where();
        this.api.ui.loadUIAutoHideComponent("MapExplorer", "MapExplorer");
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.target.content;
        _loc3.attachMovie("staticR", "anim", 10);
        _loc3._xscale = -65;
        _loc3._yscale = 65;
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = this._oSprite.life.split(",");
        this._mcHealth._yscale = _loc3[0] / _loc3[1] * 100;
        this.gapi.showTooltip(this._oSprite.name + "\n" + this.api.lang.getText("LEVEL") + " : " + this._oSprite.level + "\n" + this.api.lang.getText("LIFEPOINTS") + " : " + _loc3[0] + " / " + _loc3[1], oEvent.target, 30);
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.click = function (oEvent)
    {
        this.api.kernel.GameManager.showPlayerPopupMenu(undefined, this._oSprite.name, this);
    };
    _loc1.addPartyMenuItems = function (pm)
    {
        pm.addStaticItem(this.api.lang.getText("PARTY"));
        pm.addItem(this.api.lang.getText("PARTY_WHERE"), this, this.partyWhere, []);
        if (this._oSprite.id == this.api.datacenter.Player.ID)
        {
            pm.addItem(this.api.lang.getText("LEAVE_PARTY"), this.api.network.Party, this.api.network.Party.leave, []);
            if (this.isLocalPlayerLeader())
            {
                if (this._bIsFollowing)
                {
                    pm.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_ME_ALL"), this.api.network.Party, this.api.network.Party.followAll, [true, this._oSprite.id]);
                }
                else
                {
                    pm.addItem(this.api.lang.getText("PARTY_FOLLOW_ME_ALL"), this.api.network.Party, this.api.network.Party.followAll, [false, this._oSprite.id]);
                } // end if
            } // end else if
        }
        else
        {
            if (this.isLocalPlayer)
            {
                if (this._bIsFollowing)
                {
                    pm.addItem(this.api.lang.getText("STOP_FOLLOW"), this.api.network.Party, this.api.network.Party.follow, [true, this._oSprite.id]);
                }
                else
                {
                    pm.addItem(this.api.lang.getText("FOLLOW"), this.api.network.Party, this.api.network.Party.follow, [false, this._oSprite.id]);
                } // end if
            } // end else if
            if (this.isLocalPlayerLeader())
            {
                if (this._bIsFollowing)
                {
                    pm.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_HIM_ALL"), this.api.network.Party, this.api.network.Party.followAll, [true, this._oSprite.id]);
                }
                else
                {
                    pm.addItem(this.api.lang.getText("PARTY_FOLLOW_HIM_ALL"), this.api.network.Party, this.api.network.Party.followAll, [false, this._oSprite.id]);
                } // end else if
                pm.addItem(this.api.lang.getText("KICK_FROM_PARTY"), this.api.network.Party, this.api.network.Party.leave, [this._oSprite.id]);
            } // end if
        } // end else if
    };
    _loc1.addProperty("isInGroup", _loc1.__get__isInGroup, function ()
    {
    });
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    _loc1.addProperty("isFollowing", function ()
    {
    }, _loc1.__set__isFollowing);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
