// Action script...

// [Initial MovieClip Action of sprite 1069]
#initclip 39
class dofus.graphics.gapi.controls.guildmembersviewer.GuildMembersViewerMember extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _oItem, _lblName, _lblRank, _lblLevel, _lblPercentXP, _lblWinXP, _btnBann, _btnProfil, _ldrGuild, _mcFight, _mcOffline, addToQueue, __set__list;
    function GuildMembersViewerMember()
    {
        super();
    } // End of the function
    function set list(mcList)
    {
        _mcList = mcList;
        //return (this.list());
        null;
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _oItem = oItem;
            var _loc3 = _mcList.gapi.api.datacenter.Player.guildInfos.playerRights;
            _lblName.__set__text(oItem.name);
            _lblRank.__set__text(_mcList.gapi.api.lang.getRankInfos(oItem.rank).n);
            _lblLevel.__set__text(oItem.level);
            _lblPercentXP.__set__text(oItem.percentxp + "%");
            _lblWinXP.__set__text(oItem.winxp);
            _btnBann._visible = oItem.isLocalPlayer || _loc3.canBann;
            _btnProfil._visible = oItem.isLocalPlayer || _loc3.canManageRights || _loc3.canManageXPContitribution || _loc3.canManageRanks;
            _ldrGuild.__set__contentPath(dofus.Constants.GUILDS_MINI_PATH + oItem.gfx + ".swf");
            _mcFight._visible = oItem.state == 2;
            _mcOffline._visible = oItem.state == 0;
        }
        else
        {
            _lblName.__set__text("");
            _lblRank.__set__text("");
            _lblLevel.__set__text("");
            _lblPercentXP.__set__text("");
            _lblWinXP.__set__text("");
            _btnBann._visible = false;
            _btnProfil._visible = false;
            _ldrGuild.__set__contentPath("");
            _mcFight._visible = false;
            _mcOffline._visible = false;
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _btnBann.addEventListener("click", this);
        _btnProfil.addEventListener("click", this);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBann":
            {
                var _loc2 = _mcList.gapi.api;
                var _loc3 = _loc2.datacenter.Player.guildInfos.members.length;
                if (_oItem.rights.isBoss && _loc3 > 1)
                {
                    _mcList.gapi.api.kernel.showMessage(undefined, _loc2.lang.getText("GUILD_BOSS_CANT_BE_BANN"), "ERROR_BOX");
                }
                else if (_oItem.isLocalPlayer)
                {
                    _mcList.gapi.api.kernel.showMessage(undefined, _loc2.lang.getText("DO_U_DELETE_YOU") + (_loc3 > 1 ? ("") : ("\n" + _loc2.lang.getText("DELETE_GUILD_CAUTION"))), "CAUTION_YESNO", {name: "DeleteMember", listener: this, params: {name: _oItem.name}});
                }
                else
                {
                    _mcList.gapi.api.kernel.showMessage(undefined, _loc2.lang.getText("DO_U_DELETE_MEMBER", [_oItem.name]), "CAUTION_YESNO", {name: "DeleteMember", listener: this, params: {name: _oItem.name}});
                } // end else if
                break;
            } 
            case "_btnProfil":
            {
                _mcList.gapi.loadUIComponent("GuildMemberInfos", "GuildMemberInfos", {member: _oItem});
                break;
            } 
        } // End of switch
    } // End of the function
    function yes(oEvent)
    {
        _mcList.gapi.api.network.Guild.bann(oEvent.params.name);
    } // End of the function
} // End of Class
#endinitclip
