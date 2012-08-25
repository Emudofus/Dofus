// Action script...

// [Initial MovieClip Action of sprite 20854]
#initclip 119
if (!dofus.graphics.gapi.ui.GuildMemberInfos)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.GuildMemberInfos = function ()
    {
        super();
    }).prototype;
    _loc1.__set__member = function (oMember)
    {
        this._oMember = oMember;
        this._oMemberClone = new Object();
        this._oMemberClone.rank = this._oMember.rank;
        this._oMemberClone.percentxp = this._oMember.percentxp;
        this._oMemberClone.rights = new dofus.datacenter.GuildRights(this._oMember.rights.value);
        //return (this.member());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.GuildMemberInfos.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
        this._cbRanks._visible = false;
        this._btnPercentXP._visible = false;
    };
    _loc1.initTexts = function ()
    {
        this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        this._btnModify.label = this.api.lang.getText("MODIFY");
        this._lblRank.text = this.api.lang.getText("GUILD_RANK");
        this._lblPercentXP.text = this.api.lang.getText("PERCENT_XP_FULL");
        this._lblRights.text = this.api.lang.getText("RIGHTS");
        this._lblRBoost.text = this.api.lang.getText("GUILD_RIGHTS_BOOST");
        this._lblRRights.text = this.api.lang.getText("GUILD_RIGHTS_RIGHTS");
        this._lblRInvit.text = this.api.lang.getText("GUILD_RIGHTS_INVIT");
        this._lblRBann.text = this.api.lang.getText("GUILD_RIGHTS_BANN");
        this._lblRPercentXP.text = this.api.lang.getText("GUILD_RIGHTS_PERCENTXP");
        this._lblROwnPercentXP.text = this.api.lang.getText("GUILD_RIGHT_MANAGE_OWN_XP");
        this._lblRRank.text = this.api.lang.getText("GUILD_RIGHTS_RANK");
        this._lblRHireTax.text = this.api.lang.getText("GUILD_RIGHTS_HIRETAX");
        this._lblRDefendTax.text = this.api.lang.getText("GUILD_RIGHTS_DEFENDTAX");
        this._lblRCollect.text = this.api.lang.getText("GUILD_RIGHTS_COLLECT");
        this._lblRCanUseMountPark.text = this.api.lang.getText("GUILD_RIGHTS_MOUNT_PARK_USE");
        this._lblRCanArrangeMountPark.text = this.api.lang.getText("GUILD_RIGHTS_MOUNT_PARK_ARRANGE");
        this._lblRCanManageOtherMount.text = this.api.lang.getText("GUILD_RIGHTS_MANAGE_OTHER_MOUNT");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnCancel.addEventListener("click", this);
        this._btnModify.addEventListener("click", this);
        this._btnPercentXP.addEventListener("click", this);
        this._cbRanks.addEventListener("itemSelected", this);
        this._btnRBoost.addEventListener("click", this);
        this._btnRRights.addEventListener("click", this);
        this._btnRInvit.addEventListener("click", this);
        this._btnRBann.addEventListener("click", this);
        this._btnRPercentXP.addEventListener("click", this);
        this._btnROwnPercentXP.addEventListener("click", this);
        this._btnRRank.addEventListener("click", this);
        this._btnRHireTax.addEventListener("click", this);
        this._btnRDefendTax.addEventListener("click", this);
        this._btnRCollect.addEventListener("click", this);
        this._bntRCanUseMountPark.addEventListener("click", this);
        this._btnRCanArrangeMountPark.addEventListener("click", this);
        this._btnRCanManageOtherMount.addEventListener("click", this);
    };
    _loc1.updateData = function ()
    {
        this._winBg.title = this._oMember.name + " (" + this.api.lang.getText("LEVEL_SMALL") + " " + this._oMember.level + ")";
        this._lblPercentXPValue.text = this._oMemberClone.percentxp + "%";
        var _loc2 = this.api.datacenter.Player.guildInfos.playerRights;
        this._cbRanks.enabled = _loc2.canManageRanks;
        this._btnPercentXP._visible = _loc2.canManageXPContitribution || _loc2.canManageOwnXPContitribution;
        var _loc3 = this._oMemberClone.rights;
        this._btnRBoost.selected = _loc3.canManageBoost;
        this._btnRRights.selected = _loc3.canManageRights;
        this._btnRInvit.selected = _loc3.canInvite;
        this._btnRBann.selected = _loc3.canBann;
        this._btnRPercentXP.selected = _loc3.canManageXPContitribution;
        this._btnRRank.selected = _loc3.canManageRanks;
        this._btnRHireTax.selected = _loc3.canHireTaxCollector;
        this._btnROwnPercentXP.selected = _loc3.canManageOwnXPContitribution;
        this._btnRCollect.selected = _loc3.canCollect;
        this._bntRCanUseMountPark.selected = _loc3.canUseMountPark;
        this._btnRCanArrangeMountPark.selected = _loc3.canArrangeMountPark;
        this._btnRCanManageOtherMount.selected = _loc3.canManageOtherMount;
        var _loc4 = _loc2.canManageRights && !_loc3.isBoss;
        this._btnRBoost.enabled = _loc4;
        this._btnRRights.enabled = _loc4;
        this._btnRInvit.enabled = _loc4;
        this._btnRBann.enabled = _loc4;
        this._btnRPercentXP.enabled = _loc4;
        this._btnRRank.enabled = _loc4;
        this._btnRHireTax.enabled = _loc4;
        this._btnROwnPercentXP.enabled = _loc4;
        this._btnRCollect.enabled = _loc4;
        this._bntRCanUseMountPark.enabled = _loc4;
        this._btnRCanArrangeMountPark.enabled = _loc4;
        this._btnRCanManageOtherMount.enabled = _loc4;
        this._btnModify.enabled = _loc2.isBoss || (_loc2.canManageRights || (_loc2.canManageRanks || (_loc2.canManageXPContitribution || _loc3.canManageOwnXPContitribution)));
        if (_loc2.canManageRanks)
        {
            this._cbRanks._visible = true;
            var _loc5 = this.api.lang.getRanks().slice();
            var _loc6 = new ank.utils.ExtendedArray();
            _loc5.sortOn("o", Array.NUMERIC);
            if (this.api.datacenter.Player.guildInfos.playerRights.isBoss)
            {
                _loc6.push({label: _loc5[0].n, id: _loc5[0].i});
                if (this._oMemberClone.rank == _loc5[0].i)
                {
                    this._cbRanks.selectedIndex = 0;
                } // end if
            } // end if
            var _loc7 = 1;
            
            while (++_loc7, _loc7 < _loc5.length)
            {
                _loc6.push({label: _loc5[_loc7].n, id: _loc5[_loc7].i});
                if (this._oMemberClone.rank == _loc5[_loc7].i)
                {
                    this._cbRanks.selectedIndex = _loc6.length - 1;
                } // end if
            } // end while
            this._cbRanks.dataProvider = _loc6;
        }
        else
        {
            this._lblRankValue.text = this.api.lang.getRankInfos(this._oMemberClone.rank).n;
        } // end else if
    };
    _loc1.setRank = function (nRank)
    {
        this._oMemberClone.rank = nRank;
        this._oMemberClone.rankOrder = this.api.lang.getRankInfos(nRank).o;
        this.updateData();
    };
    _loc1.setBoss = function ()
    {
        this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_GIVERIGHTS", [this._oMember.name]), "CAUTION_YESNO", {name: "GuildSetBoss", listener: this});
    };
    _loc1.itemSelected = function (oEvent)
    {
        if (this._cbRanks.selectedItem.id == 1)
        {
            this.setBoss();
        }
        else
        {
            this.setRank(this._cbRanks.selectedItem.id);
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            case "_btnClose":
            {
                this.unloadThis();
                break;
            } 
            case "_btnModify":
            {
                if (this._oMember.rank == this._oMemberClone.rank && (this._oMember.percentxp == this._oMemberClone.percentxp && this._oMember.rights.value == this._oMemberClone.rights.value))
                {
                    return;
                } // end if
                this._oMember.rank = this._oMemberClone.rank;
                this._oMember.rankOrder = this._oMemberClone.rankOrder;
                this._oMember.percentxp = this._oMemberClone.percentxp;
                this._oMember.rights.value = this._oMemberClone.rights.value;
                this.api.network.Guild.changeMemberProfil(this._oMember);
                this.api.datacenter.Player.guildInfos.setMembers();
                this.unloadThis();
                break;
            } 
            case "_btnPercentXP":
            {
                var _loc3 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: this._oMember.percentxp, max: 90, min: 0});
                _loc3.addEventListener("validate", this);
                break;
            } 
            case "_btnRBoost":
            {
                if (this._btnRBoost.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 2;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 2;
                } // end else if
                break;
            } 
            case "_btnRRights":
            {
                if (this._btnRRights.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 4;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 4;
                } // end else if
                break;
            } 
            case "_btnRInvit":
            {
                if (this._btnRInvit.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 8;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 8;
                } // end else if
                break;
            } 
            case "_btnRBann":
            {
                if (this._btnRBann.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 16;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 16;
                } // end else if
                break;
            } 
            case "_btnRPercentXP":
            {
                if (this._btnRPercentXP.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 32;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 32;
                } // end else if
                break;
            } 
            case "_btnRRank":
            {
                if (this._btnRRank.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 64;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 64;
                } // end else if
                break;
            } 
            case "_btnRHireTax":
            {
                if (this._btnRHireTax.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 128;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 128;
                } // end else if
                break;
            } 
            case "_btnROwnPercentXP":
            {
                if (this._btnROwnPercentXP.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 256;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 256;
                } // end else if
                break;
            } 
            case "_btnRCollect":
            {
                if (this._btnRCollect.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 512;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 512;
                } // end else if
                break;
            } 
            case "_bntRCanUseMountPark":
            {
                if (this._bntRCanUseMountPark.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 4096;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 4096;
                } // end else if
                break;
            } 
            case "_btnRCanArrangeMountPark":
            {
                if (this._btnRCanArrangeMountPark.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 8192;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 8192;
                } // end else if
                break;
            } 
            case "_btnRCanManageOtherMount":
            {
                if (this._btnRCanManageOtherMount.selected)
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value | 16384;
                }
                else
                {
                    this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 16384;
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.validate = function (oEvent)
    {
        var _loc3 = oEvent.value;
        if (_global.isNaN(_loc3))
        {
            return;
        } // end if
        if (_loc3 > 90)
        {
            return;
        } // end if
        if (_loc3 < 0)
        {
            return;
        } // end if
        this._oMemberClone.percentxp = _loc3;
        this.updateData();
    };
    _loc1.yes = function (oEvent)
    {
        this.setRank(1);
    };
    _loc1.addProperty("member", function ()
    {
    }, _loc1.__set__member);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.GuildMemberInfos = function ()
    {
        super();
    }).CLASS_NAME = "GuildMemberInfos";
} // end if
#endinitclip
