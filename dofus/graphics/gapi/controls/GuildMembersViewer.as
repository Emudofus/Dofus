// Action script...

// [Initial MovieClip Action of sprite 20700]
#initclip 221
if (!dofus.graphics.gapi.controls.GuildMembersViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.GuildMembersViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__members = function (eaMembers)
    {
        this._eaData = eaMembers;
        this.updateData(this._eaData);
        //return (this.members());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.GuildMembersViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._dgMembers.addEventListener("itemSelected", this);
        this._dgMembers.addEventListener("itemRollOver", this);
        this._dgMembers.addEventListener("itemRollOut", this);
        this._btnShowOfflineMembers.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._dgMembers.columnsNames = ["", "", this.api.lang.getText("NAME_BIG"), this.api.lang.getText("GUILD_RANK"), this.api.lang.getText("LEVEL_SMALL"), this.api.lang.getText("PERCENT_XP"), this.api.lang.getText("WIN_XP"), ""];
        this._lblDescription.text = this.api.lang.getText("GUILD_MEMBERS_LIST");
        this._lblShowOfflineMembers.text = this.api.lang.getText("DISPLAY_OFFLINE_GUILD_MEMBERS");
    };
    _loc1.updateData = function (eaMembers)
    {
        var _loc3 = 0;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < eaMembers.length)
        {
            if (eaMembers[_loc4].state != 0)
            {
                ++_loc3;
            } // end if
        } // end while
        this._lblCount.text = _loc3 + " / " + String(eaMembers.length) + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("MEMBERS"), "m", eaMembers.length < 2);
        var _loc5 = new ank.utils.ExtendedArray();
        if (!this._btnShowOfflineMembers.selected)
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < eaMembers.length)
            {
                if (eaMembers[_loc6].state != 0)
                {
                    _loc5.push(eaMembers[_loc6]);
                } // end if
            } // end while
        }
        else
        {
            _loc5 = eaMembers;
        } // end else if
        var _loc7 = 0;
        var _loc8 = 0;
        
        while (++_loc8, _loc8 < eaMembers.length)
        {
            _loc7 = _loc7 + eaMembers[_loc8].level;
        } // end while
        _loc7 = Math.floor(_loc7 / eaMembers.length);
        if (!_global.isNaN(_loc7))
        {
            this._lblSeeAvgMembersLvl.text = this.api.lang.getText("GUILD_AVG_MEMBERS_LEVEL") + " : " + _loc7;
        }
        else
        {
            this._lblSeeAvgMembersLvl.text = "";
        } // end else if
        this._dgMembers.dataProvider = _loc5;
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.row.item;
        if (_loc3.name != this.api.datacenter.Player.Name)
        {
            if (_loc3.state == 0)
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("USER_NOT_CONNECTED", [_loc3.name]), "ERROR_CHAT");
            }
            else
            {
                this.api.kernel.GameManager.showPlayerPopupMenu(_loc3.name, oEvent.row.item.name, undefined, undefined, true, undefined, this.api.datacenter.Player.isAuthorized);
            } // end if
        } // end else if
    };
    _loc1.itemRollOver = function (oEvent)
    {
        oEvent.row.cellRenderer_mc.over();
    };
    _loc1.itemRollOut = function (oEvent)
    {
        oEvent.row.cellRenderer_mc.out();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnShowOfflineMembers:
            {
                this.updateData(this._eaData);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("members", function ()
    {
    }, _loc1.__set__members);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.GuildMembersViewer = function ()
    {
        super();
    }).CLASS_NAME = "GuildMembersViewer";
} // end if
#endinitclip
