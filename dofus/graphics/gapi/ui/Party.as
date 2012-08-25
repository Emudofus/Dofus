// Action script...

// [Initial MovieClip Action of sprite 20853]
#initclip 118
if (!dofus.graphics.gapi.ui.Party)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Party = function ()
    {
        super();
    }).prototype;
    _loc1.__get__leaderID = function ()
    {
        return (this._sLeaderID);
    };
    _loc1.__get__followID = function ()
    {
        return (this._sFollowID);
    };
    _loc1.addMember = function (oMember, bRefresh)
    {
        this._aMembers.push(oMember);
        if (bRefresh)
        {
            this.updateData();
        } // end if
    };
    _loc1.getMember = function (sMemberID)
    {
        var _loc3 = this._aMembers.findFirstItem("id", sMemberID);
        if (_loc3.index != -1)
        {
            return (_loc3.item);
        } // end if
        return (null);
    };
    _loc1.getMemberById = function (nMemberID)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
        {
            if (this._aMembers[_loc3].id == nMemberID)
            {
                return (this._aMembers[_loc3]);
            } // end if
        } // end while
        return (null);
    };
    _loc1.removeMember = function (sMemberID, bRefresh)
    {
        var _loc4 = this._aMembers.findFirstItem("id", sMemberID);
        if (this._sFollowID == sMemberID)
        {
            this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0], this.api.datacenter.Basics.banner_targetCoords[1]);
            delete this._sFollowID;
        } // end if
        if (_loc4.index != -1)
        {
            this._aMembers.removeItems(_loc4.index, 1);
        } // end if
        if (bRefresh)
        {
            this.updateData();
        } // end if
    };
    _loc1.refresh = function ()
    {
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.setLeader = function (sLeaderID)
    {
        this._sLeaderID = sLeaderID;
        this.updateData();
        if (sLeaderID == undefined)
        {
            this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0], this.api.datacenter.Basics.banner_targetCoords[0]);
        } // end if
    };
    _loc1.setFollow = function (sFollowID)
    {
        this._sFollowID = sFollowID;
        this.updateData();
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Party.CLASS_NAME);
        this._aMembers = new ank.utils.ExtendedArray();
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
        this.addToQueue({object: this, method: this.initOption});
    };
    _loc1.addListeners = function ()
    {
        this._btnOpenClose.addEventListener("click", this);
        this._btnOpenClose.addEventListener("over", this);
        this._btnOpenClose.addEventListener("out", this);
        this._btnBlockJoinerExceptParty.addEventListener("click", this);
        this._btnBlockJoinerExceptParty.addEventListener("over", this);
        this._btnBlockJoinerExceptParty.addEventListener("out", this);
    };
    _loc1.initOption = function ()
    {
        this._btnBlockJoinerExceptParty.selected = this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
    };
    _loc1.updateData = function (oMemberTarget)
    {
        var _loc3 = 0;
        this._nLvlTotal = 0;
        this._nProspectionTotal = 0;
        var _loc5 = false;
        if (this._aMembers.length != 0)
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
            {
                var _loc7 = this._aMembers[_loc6];
                var _loc8 = this["_piMember" + _loc3++];
                if (oMemberTarget && oMemberTarget.id == _loc7.id)
                {
                    _loc7 = oMemberTarget;
                    this._aMembers[_loc6] = oMemberTarget;
                } // end if
                _loc8.setData(_loc7);
                _loc8.isFollowing = _loc7.id == this._sFollowID;
                if (_loc8.isInGroup)
                {
                    this._nLvlTotal = this._nLvlTotal + _loc7.level;
                    this._nProspectionTotal = this._nProspectionTotal + _loc7.prospection;
                } // end if
            } // end while
            var _loc9 = true;
            while (_loc9)
            {
                _loc9 = false;
                var _loc10 = 0;
                
                while (++_loc10, _loc10 < dofus.Constants.MEMBERS_COUNT_IN_PARTY - 1)
                {
                    if (this._aMembers[_loc10].initiative < this._aMembers[_loc10 + 1].initiative)
                    {
                        var _loc11 = this._aMembers[_loc10];
                        this._aMembers[_loc10] = this._aMembers[_loc10 + 1];
                        this._aMembers[_loc10 + 1] = _loc11;
                        _loc9 = true;
                    } // end if
                    var _loc12 = this["_piMember" + _loc10];
                    _loc12._visible = !this._btnOpenClose.selected;
                    _loc12.setData(this._aMembers[_loc10]);
                    _loc12.isFollowing = this._aMembers[_loc10].id == this._sFollowID;
                    if (_loc12.isInGroup)
                    {
                        var _loc4 = _loc12;
                    } // end if
                } // end while
            } // end while
        } // end if
        var ref = this;
        this._mcInfo.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcInfo.onRollOut = function ()
        {
            ref.out({target: this});
        };
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnBlockJoinerExceptParty:
            {
                var _loc3 = !this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
                this.api.kernel.OptionsManager.setOption("FightGroupAutoLock", _loc3);
                break;
            } 
            default:
            {
                this._piMember0._visible = !this._btnOpenClose.selected;
                this._piMember1._visible = !this._btnOpenClose.selected;
                this._piMember2._visible = !this._btnOpenClose.selected;
                this._piMember3._visible = !this._btnOpenClose.selected;
                this._piMember4._visible = !this._btnOpenClose.selected;
                this._piMember5._visible = !this._btnOpenClose.selected;
                this._piMember6._visible = !this._btnOpenClose.selected;
                this._piMember7._visible = !this._btnOpenClose.selected;
                this._mcInfo._visible = !this._btnOpenClose.selected;
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnOpenClose:
            {
                this.gapi.showTooltip(this.api.lang.getText("PARTY_OPEN_CLOSE"), oEvent.target, 20);
                break;
            } 
            case this._mcInfo:
            {
                this.gapi.showTooltip("<b>" + this.api.lang.getText("INFORMATIONS") + "</b>\n" + this.api.lang.getText("TOTAL_LEVEL") + " : " + this._nLvlTotal + "\n" + this.api.lang.getText("TOTAL_DISCERNMENT") + " : " + this._nProspectionTotal, oEvent.target, 20);
                break;
            } 
            case this._btnBlockJoinerExceptParty:
            {
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINEREXCEPTPARTY"), oEvent.target, 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("followID", _loc1.__get__followID, function ()
    {
    });
    _loc1.addProperty("leaderID", _loc1.__get__leaderID, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Party = function ()
    {
        super();
    }).CLASS_NAME = "Party";
    _loc1._sLeaderID = "0";
    _loc1._sFollowID = "0";
} // end if
#endinitclip
