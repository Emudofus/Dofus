// Action script...

// [Initial MovieClip Action of sprite 20922]
#initclip 187
if (!dofus.graphics.gapi.controls.guildmembersviewer.GuildMembersViewerMember)
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
    if (!dofus.graphics.gapi.controls.guildmembersviewer)
    {
        _global.dofus.graphics.gapi.controls.guildmembersviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.guildmembersviewer.GuildMembersViewerMember = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = oItem;
            var _loc5 = this._mcList.gapi.api.datacenter.Player.guildInfos.playerRights;
            this._lblName.text = oItem.name;
            this._lblRank.text = this._mcList.gapi.api.lang.getRankInfos(oItem.rank).n;
            this._lblLevel.text = oItem.level;
            this._lblPercentXP.text = oItem.percentxp + "%";
            this._lblWinXP.text = oItem.winxp;
            this._btnBann._visible = oItem.isLocalPlayer || _loc5.canBann;
            this._btnProfil._visible = oItem.isLocalPlayer || (_loc5.canManageRights || (_loc5.canManageXPContitribution || _loc5.canManageRanks));
            this._ldrGuild.contentPath = dofus.Constants.GUILDS_MINI_PATH + oItem.gfx + ".swf";
            this._mcFight._visible = oItem.state == 2;
            this._mcOffline._visible = oItem.state == 0;
            this._mcOver.hint = oItem.lastConnection;
            this._ldrAlignement.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + oItem.alignement + ".swf";
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblRank.text = "";
            this._lblLevel.text = "";
            this._lblPercentXP.text = "";
            this._lblWinXP.text = "";
            this._btnBann._visible = false;
            this._btnProfil._visible = false;
            this._ldrGuild.contentPath = "";
            this._ldrAlignement.contentPath = "";
            this._mcFight._visible = false;
            this._mcOffline._visible = false;
            delete this._mcOver.onRollOver;
            delete this._mcOver.onRollOut;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._btnBann._visible = false;
        this._btnProfil._visible = false;
        this._mcFight._visible = false;
        this._mcOffline._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnBann.addEventListener("click", this);
        this._btnProfil.addEventListener("click", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBann":
            {
                var _loc3 = this._mcList.gapi.api;
                var _loc4 = _loc3.datacenter.Player.guildInfos.members.length;
                if (this._oItem.rights.isBoss && _loc4 > 1)
                {
                    this._mcList.gapi.api.kernel.showMessage(undefined, _loc3.lang.getText("GUILD_BOSS_CANT_BE_BANN"), "ERROR_BOX");
                }
                else if (this._oItem.isLocalPlayer)
                {
                    this._mcList.gapi.api.kernel.showMessage(undefined, _loc3.lang.getText("DO_U_DELETE_YOU") + (_loc4 > 1 ? ("") : ("\n" + _loc3.lang.getText("DELETE_GUILD_CAUTION"))), "CAUTION_YESNO", {name: "DeleteMember", listener: this, params: {name: this._oItem.name}});
                }
                else
                {
                    this._mcList.gapi.api.kernel.showMessage(undefined, _loc3.lang.getText("DO_U_DELETE_MEMBER", [this._oItem.name]), "CAUTION_YESNO", {name: "DeleteMember", listener: this, params: {name: this._oItem.name}});
                } // end else if
                break;
            } 
            case "_btnProfil":
            {
                this._mcList.gapi.loadUIComponent("GuildMemberInfos", "GuildMemberInfos", {member: this._oItem});
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        this._mcList.gapi.api.network.Guild.bann(oEvent.params.name);
    };
    _loc1.over = function (oEvent)
    {
        if (this._oItem.state != 0)
        {
            return;
        } // end if
        var _loc3 = this._mcList.gapi.api;
        var _loc4 = this._oItem.lastConnection;
        var _loc5 = Math.floor(_loc4 / (24 * 31));
        _loc4 = _loc4 - _loc5 * 24 * 31;
        var _loc6 = Math.floor(_loc4 / 24);
        _loc4 = _loc4 - _loc6 * 24;
        var _loc7 = _loc4;
        if (_loc5 < 0)
        {
            _loc5 = 0;
            _loc6 = 0;
            _loc7 = 0;
        } // end if
        var _loc8 = " " + _loc3.lang.getText("AND") + " ";
        var _loc9 = "";
        if (_loc5 > 0 && _loc6 != 0)
        {
            var _loc10 = ank.utils.PatternDecoder.combine(_loc3.lang.getText("MONTHS"), "m", _loc5 == 1);
            var _loc11 = ank.utils.PatternDecoder.combine(_loc3.lang.getText("DAYS"), "m", _loc6 == 1);
            _loc9 = _loc9 + (_loc5 + " " + _loc10 + _loc8 + _loc6 + " " + _loc11);
        }
        else if (_loc6 != 0)
        {
            var _loc12 = ank.utils.PatternDecoder.combine(_loc3.lang.getText("DAYS"), "m", _loc6 == 1);
            _loc9 = _loc9 + (_loc6 + " " + _loc12);
        }
        else
        {
            _loc9 = _loc9 + _loc3.lang.getText("A_CONNECTED_TODAY");
        } // end else if
        _loc3.ui.showTooltip(_loc3.lang.getText("GUILD_LAST_CONNECTION", [_loc9]), this._mcOver, -20);
    };
    _loc1.out = function (oEvent)
    {
        this._mcList.gapi.api.ui.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
    _loc1.ftgt = 150;
} // end if
#endinitclip
