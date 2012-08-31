// Action script...

// [Initial MovieClip Action of sprite 1039]
#initclip 6
class dofus.graphics.gapi.ui.Guild extends ank.gapi.core.UIAdvancedComponent
{
    var __get__currentTab, gapi, api, unloadThis, addToQueue, _mcPlacer, _mcCaution, _lblValid, _btnTabMembers, _btnTabBoosts, _btnTabTaxCollectors, _lblXP, _btnClose, _pbXP, _eEmblem, _winBg, _mcTabViewer, getNextHighestDepth, attachMovie, _lblLevel, value, maximum, _parent, _y, __set__currentTab;
    function Guild()
    {
        super();
    } // End of the function
    function set currentTab(sTab)
    {
        _sCurrentTab = sTab;
        //return (this.currentTab());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Guild.CLASS_NAME);
    } // End of the function
    function destroy()
    {
        gapi.unloadUIComponent("GuildMemberInfos");
        gapi.hideTooltip();
        api.datacenter.Player.guildInfos.removeEventListener("modelChanged", this);
        this.checkIfLocalPlayerIsDefender();
        if (_sCurrentTab == "TaxCollectors")
        {
            api.network.Guild.leaveTaxInterface();
        } // end if
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: setCurrentTab, params: [_sCurrentTab]});
        _mcPlacer._visible = false;
        _mcCaution._visible = _lblValid._visible = false;
    } // End of the function
    function initTexts()
    {
        _btnTabMembers.__set__label(api.lang.getText("GUILD_MEMBERS"));
        _btnTabBoosts.__set__label(api.lang.getText("GUILD_BOOSTS"));
        _btnTabTaxCollectors.__set__label(api.lang.getText("GUILD_TAXCOLLECTORS"));
        _lblXP.__set__text(api.lang.getText("EXPERIMENT"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnTabMembers.addEventListener("click", this);
        _btnTabBoosts.addEventListener("click", this);
        _btnTabTaxCollectors.addEventListener("click", this);
        api.datacenter.Player.guildInfos.addEventListener("modelChanged", this);
        _pbXP.addEventListener("over", this);
        _pbXP.addEventListener("out", this);
    } // End of the function
    function initData()
    {
        var _loc3 = api.datacenter.Player.guildInfos;
        var _loc2 = _loc3.emblem;
        _eEmblem.__set__backID(_loc2.backID);
        _eEmblem.__set__backColor(_loc2.backColor);
        _eEmblem.__set__upID(_loc2.upID);
        _eEmblem.__set__upColor(_loc2.upColor);
        _winBg.__set__title(api.lang.getText("GUILD") + " \'" + _loc3.name + "\'");
        api.network.Guild.getInfosGeneral();
    } // End of the function
    function updateCurrentTabInformations()
    {
        _mcTabViewer.removeMovieClip();
        switch (_sCurrentTab)
        {
            case "Members":
            {
                this.attachMovie("GuildMembersViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: _mcPlacer._x, _y: _mcPlacer._y});
                api.datacenter.Player.guildInfos.members.removeAll();
                api.network.Guild.getInfosMembers();
                break;
            } 
            case "Boosts":
            {
                this.attachMovie("GuildBoostsViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: _mcPlacer._x, _y: _mcPlacer._y});
                api.network.Guild.getInfosBoosts();
                break;
            } 
            case "TaxCollectors":
            {
                this.attachMovie("TaxCollectorsViewer", "_mcTabViewer", this.getNextHighestDepth(), {_x: _mcPlacer._x, _y: _mcPlacer._y});
                api.datacenter.Player.guildInfos.taxCollectors.removeAll();
                api.network.Guild.getInfosTaxCollector();
                break;
            } 
        } // End of switch
    } // End of the function
    function setCurrentTab(sNewTab)
    {
        if (_sCurrentTab == "TaxCollectors")
        {
            api.network.Guild.leaveTaxInterface();
        } // end if
        var _loc2 = this["_btnTab" + _sCurrentTab];
        var _loc3 = this["_btnTab" + sNewTab];
        _loc2.__set__selected(true);
        _loc2.__set__enabled(true);
        _loc3.__set__selected(false);
        _loc3.__set__enabled(false);
        _sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    } // End of the function
    function checkIfLocalPlayerIsDefender()
    {
        var _loc2 = api.datacenter.Player.guildInfos;
        if (_loc2.isLocalPlayerDefender)
        {
            api.network.Guild.leaveTaxCollector(_loc2.defendedTaxCollectorID);
            api.kernel.showMessage(api.lang.getText("INFORMATIONS"), api.lang.getText("AUTO_DISJOIN_TAX"), "ERROR_BOX");
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnTabMembers":
            {
                this.setCurrentTab("Members");
                break;
            } 
            case "_btnTabBoosts":
            {
                if (api.datacenter.Player.guildInfos.isValid)
                {
                    this.setCurrentTab("Boosts");
                }
                else
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                    oEvent.target.selected = true;
                } // end else if
                break;
            } 
            case "_btnTabTaxCollectors":
            {
                if (api.datacenter.Player.guildInfos.isValid)
                {
                    this.setCurrentTab("TaxCollectors");
                }
                else
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                    oEvent.target.selected = true;
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_pbXP":
            {
                gapi.showTooltip(String(_pbXP.__get__value()).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + String(_pbXP.__get__maximum()).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), _pbXP, -20);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function modelChanged(oEvent)
    {
        switch (oEvent.eventName)
        {
            case "general":
            {
                var _loc2 = api.datacenter.Player.guildInfos;
                _lblLevel.__set__text(api.lang.getText("LEVEL") + " " + _loc2.level);
                _pbXP.__set__minimum(_loc2.xpmin);
                _pbXP.__set__maximum(_loc2.xpmax);
                _pbXP.__set__value(_loc2.xp);
                _pbXP.onRollOver = function ()
                {
                    _parent.gapi.showTooltip(value + " / " + maximum, this, -20);
                };
                _pbXP.onRollOut = function ()
                {
                    _parent.gapi.hideTooltip();
                };
                if (_loc2.isValid)
                {
                    _y = 0;
                    _mcCaution._visible = _lblValid._visible = false;
                }
                else
                {
                    _y = -20;
                    _mcCaution._visible = _lblValid._visible = true;
                    _lblValid.__set__text(api.lang.getText("GUILD_INVALID_INFOS"));
                } // end else if
                break;
            } 
            case "members":
            {
                if (_sCurrentTab == "Members")
                {
                    _mcTabViewer.members = api.datacenter.Player.guildInfos.members;
                } // end if
                break;
            } 
            case "boosts":
            {
                if (_sCurrentTab == "Boosts")
                {
                    _mcTabViewer.updateData();
                } // end if
                break;
            } 
            case "taxcollectors":
            {
                if (_sCurrentTab == "TaxCollectors")
                {
                    _mcTabViewer.taxCollectors = api.datacenter.Player.guildInfos.taxCollectors;
                } // end if
                break;
            } 
            case "noboosts":
            case "notaxcollectors":
            {
                api.kernel.showMessage(undefined, api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"), "ERROR_BOX");
                this.setCurrentTab("Members");
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "Guild";
    var _sCurrentTab = "Members";
} // End of Class
#endinitclip
