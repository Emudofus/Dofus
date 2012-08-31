// Action script...

// [Initial MovieClip Action of sprite 1045]
#initclip 12
class dofus.graphics.gapi.ui.GuildMemberInfos extends ank.gapi.core.UIAdvancedComponent
{
    var _oMember, _oMemberClone, __get__member, addToQueue, _btnRank, _btnPercentXP, api, _btnCancel, _btnModify, _lblRank, _lblPercentXP, _lblRights, _lblRBoost, _lblRRights, _lblRInvit, _lblRBann, _lblRPercentXP, _lblRRank, _lblRHireTax, _lblRDefendTax, _lblRCollectKamas, _lblRCollectObjects, _lblRCollectResources, _btnClose, _btnRBoost, _btnRRights, _btnRInvit, _btnRBann, _btnRPercentXP, _btnRRank, _btnRHireTax, _btnRDefendTax, _btnRCollectKamas, _btnRCollectObjects, _btnRCollectResources, _winBg, _lblRankValue, _lblPercentXPValue, unloadThis, gapi, __set__member;
    function GuildMemberInfos()
    {
        super();
    } // End of the function
    function set member(oMember)
    {
        _oMember = oMember;
        _oMemberClone = new Object();
        _oMemberClone.rank = _oMember.rank;
        _oMemberClone.percentxp = _oMember.percentxp;
        _oMemberClone.rights = new dofus.datacenter.GuildRights(_oMember.rights.value);
        //return (this.member());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.GuildMemberInfos.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: updateData});
        _btnRank._visible = false;
        _btnPercentXP._visible = false;
    } // End of the function
    function initTexts()
    {
        _btnCancel.__set__label(api.lang.getText("CANCEL_SMALL"));
        _btnModify.__set__label(api.lang.getText("MODIFY"));
        _lblRank.__set__text(api.lang.getText("GUILD_RANK"));
        _lblPercentXP.__set__text(api.lang.getText("PERCENT_XP_FULL"));
        _lblRights.__set__text(api.lang.getText("RIGHTS"));
        _lblRBoost.__set__text(api.lang.getText("GUILD_RIGHTS_BOOST"));
        _lblRRights.__set__text(api.lang.getText("GUILD_RIGHTS_RIGHTS"));
        _lblRInvit.__set__text(api.lang.getText("GUILD_RIGHTS_INVIT"));
        _lblRBann.__set__text(api.lang.getText("GUILD_RIGHTS_BANN"));
        _lblRPercentXP.__set__text(api.lang.getText("GUILD_RIGHTS_PERCENTXP"));
        _lblRRank.__set__text(api.lang.getText("GUILD_RIGHTS_RANK"));
        _lblRHireTax.__set__text(api.lang.getText("GUILD_RIGHTS_HIRETAX"));
        _lblRDefendTax.__set__text(api.lang.getText("GUILD_RIGHTS_DEFENDTAX"));
        _lblRCollectKamas.__set__text(api.lang.getText("GUILD_RIGHTS_COLLECTKAMAS"));
        _lblRCollectObjects.__set__text(api.lang.getText("GUILD_RIGHTS_COLLECTOBJ"));
        _lblRCollectResources.__set__text(api.lang.getText("GUILD_RIGHTS_COLLECTRES"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnCancel.addEventListener("click", this);
        _btnModify.addEventListener("click", this);
        _btnRank.addEventListener("click", this);
        _btnPercentXP.addEventListener("click", this);
        _btnRBoost.addEventListener("click", this);
        _btnRRights.addEventListener("click", this);
        _btnRInvit.addEventListener("click", this);
        _btnRBann.addEventListener("click", this);
        _btnRPercentXP.addEventListener("click", this);
        _btnRRank.addEventListener("click", this);
        _btnRHireTax.addEventListener("click", this);
        _btnRDefendTax.addEventListener("click", this);
        _btnRCollectKamas.addEventListener("click", this);
        _btnRCollectObjects.addEventListener("click", this);
        _btnRCollectResources.addEventListener("click", this);
    } // End of the function
    function updateData()
    {
        _winBg.__set__title(_oMember.name + " (" + api.lang.getText("LEVEL_SMALL") + " " + _oMember.level + ")");
        _lblRankValue.__set__text(api.lang.getRankInfos(_oMemberClone.rank).n);
        _lblPercentXPValue.__set__text(_oMemberClone.percentxp + "%");
        var _loc4 = api.datacenter.Player.guildInfos.playerRights;
        _btnRank._visible = _loc4.canManageRanks;
        _btnPercentXP._visible = _loc4.canManageXPContitribution;
        var _loc3 = _oMemberClone.rights;
        _btnRBoost.__set__selected(_loc3.canManageBoost);
        _btnRRights.__set__selected(_loc3.canManageRights);
        _btnRInvit.__set__selected(_loc3.canInvite);
        _btnRBann.__set__selected(_loc3.canBann);
        _btnRPercentXP.__set__selected(_loc3.canManageXPContitribution);
        _btnRRank.__set__selected(_loc3.canManageRanks);
        _btnRHireTax.__set__selected(_loc3.canHireTaxCollector);
        _btnRDefendTax.__set__selected(_loc3.canDefendTaxCollector);
        _btnRCollectKamas.__set__selected(_loc3.canCollectKamas);
        _btnRCollectObjects.__set__selected(_loc3.canCollectObjects);
        _btnRCollectResources.__set__selected(_loc3.canCollectResources);
        var _loc2 = _loc4.canManageRights && !_loc3.isBoss;
        _btnRank.__set__enabled(_loc2);
        _btnRBoost.__set__enabled(_loc2);
        _btnRRights.__set__enabled(_loc2);
        _btnRInvit.__set__enabled(_loc2);
        _btnRBann.__set__enabled(_loc2);
        _btnRPercentXP.__set__enabled(_loc2);
        _btnRRank.__set__enabled(_loc2);
        _btnRHireTax.__set__enabled(_loc2);
        _btnRDefendTax.__set__enabled(_loc2);
        _btnRCollectKamas.__set__enabled(_loc2);
        _btnRCollectObjects.__set__enabled(_loc2);
        _btnRCollectResources.__set__enabled(_loc2);
        _btnModify.__set__enabled(_loc4.isBoss || _loc4.canManageRights || _loc4.canManageRanks || _loc4.canManageXPContitribution);
    } // End of the function
    function setRank(nRank)
    {
        _oMemberClone.rank = nRank;
        _oMemberClone.rankOrder = api.lang.getRankInfos(nRank).o;
        this.updateData();
    } // End of the function
    function setBoss()
    {
        api.kernel.showMessage(undefined, api.lang.getText("DO_U_GIVERIGHTS", [_oMember.name]), "CAUTION_YESNO", {name: "GuildSetBoss", listener: this});
    } // End of the function
    function click(oEvent)
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
                if (_oMember.rank == _oMemberClone.rank && _oMember.percentxp == _oMemberClone.percentxp && _oMember.rights.value == _oMemberClone.rights.value)
                {
                    return;
                } // end if
                _oMember.rank = _oMemberClone.rank;
                _oMember.rankOrder = _oMemberClone.rankOrder;
                _oMember.percentxp = _oMemberClone.percentxp;
                _oMember.rights.value = _oMemberClone.rights.value;
                api.network.Guild.changeMemberProfil(_oMember);
                api.datacenter.Player.guildInfos.setMembers();
                this.unloadThis();
                break;
            } 
            case "_btnRank":
            {
                var _loc4 = api.lang.getRanks().slice();
                _loc4.sortOn("o", Array.NUMERIC);
                var _loc5 = api.ui.createPopupMenu();
                if (api.datacenter.Player.guildInfos.playerRights.isBoss)
                {
                    _loc5.addItem(_loc4[0].n, this, setBoss);
                } // end if
                for (var _loc3 = 1; _loc3 < _loc4.length; ++_loc3)
                {
                    _loc5.addItem(_loc4[_loc3].n, this, setRank, [_loc4[_loc3].i]);
                } // end of for
                _loc5.show(_root._xmouse, _root._ymouse);
                break;
            } 
            case "_btnPercentXP":
            {
                var _loc6 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: _oMember.percentxp});
                _loc6.addEventListener("validate", this);
                break;
            } 
            case "_btnRBoost":
            {
                if (_btnRBoost.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 2;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 2;
                } // end else if
                break;
            } 
            case "_btnRRights":
            {
                if (_btnRRights.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 4;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 4;
                } // end else if
                break;
            } 
            case "_btnRInvit":
            {
                if (_btnRInvit.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 8;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 8;
                } // end else if
                break;
            } 
            case "_btnRBann":
            {
                if (_btnRBann.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 16;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 16;
                } // end else if
                break;
            } 
            case "_btnRPercentXP":
            {
                if (_btnRPercentXP.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 32;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 32;
                } // end else if
                break;
            } 
            case "_btnRRank":
            {
                if (_btnRRank.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 64;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 64;
                } // end else if
                break;
            } 
            case "_btnRHireTax":
            {
                if (_btnRHireTax.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 128;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 128;
                } // end else if
                break;
            } 
            case "_btnRDefendTax":
            {
                if (_btnRDefendTax.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 256;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 256;
                } // end else if
                break;
            } 
            case "_btnRCollectKamas":
            {
                if (_btnRCollectKamas.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 512;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 512;
                } // end else if
                break;
            } 
            case "_btnRCollectObjects":
            {
                if (_btnRCollectObjects.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 1024;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 1024;
                } // end else if
                break;
            } 
            case "_btnRCollectResources":
            {
                if (_btnRCollectResources.__get__selected())
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value | 2048;
                }
                else
                {
                    _oMemberClone.rights.value = _oMemberClone.rights.value ^ 2048;
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function validate(oEvent)
    {
        var _loc2 = oEvent.value;
        if (isNaN(_loc2))
        {
            return;
        } // end if
        if (_loc2 > 100)
        {
            return;
        } // end if
        if (_loc2 < 0)
        {
            return;
        } // end if
        _oMemberClone.percentxp = _loc2;
        this.updateData();
    } // End of the function
    function yes(oEvent)
    {
        this.setRank(1);
    } // End of the function
    static var CLASS_NAME = "GuildMemberInfos";
} // End of Class
#endinitclip
