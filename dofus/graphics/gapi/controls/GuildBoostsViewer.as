// Action script...

// [Initial MovieClip Action of sprite 1043]
#initclip 10
class dofus.graphics.gapi.controls.GuildBoostsViewer extends ank.gapi.core.UIAdvancedComponent
{
    var addToQueue, _btnBoostPercentRes, _btnBoostPercentKamas, _btnBoostProbObjects, _btnHireTaxCollector, _lstSpells, api, _lblLP, _lblBonus, _lblPercentRes, _lblPercentKamas, _lblProbObjects, _lblBoostPoints, _lblLevel, _lblTaxSpells, _lblTaxCharacteristics, gapi, _lblLPValue, _lblBonusValue, _lblPercentResValue, _lblPercentKamasValue, _lblProbObjectsValue, _lblTaxCount, _lblBoostPointsValue;
    function GuildBoostsViewer()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.GuildBoostsViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        _btnBoostPercentRes._visible = false;
        _btnBoostPercentKamas._visible = false;
        _btnBoostProbObjects._visible = false;
        _btnHireTaxCollector._visible = false;
    } // End of the function
    function addListeners()
    {
        _lstSpells.addEventListener("itemSelected", this);
        _btnBoostPercentRes.addEventListener("click", this);
        _btnBoostPercentKamas.addEventListener("click", this);
        _btnBoostProbObjects.addEventListener("click", this);
        _btnHireTaxCollector.addEventListener("click", this);
        _btnBoostPercentRes.addEventListener("over", this);
        _btnBoostPercentKamas.addEventListener("over", this);
        _btnBoostProbObjects.addEventListener("over", this);
        _btnHireTaxCollector.addEventListener("over", this);
        _btnBoostPercentRes.addEventListener("out", this);
        _btnBoostPercentKamas.addEventListener("out", this);
        _btnBoostProbObjects.addEventListener("out", this);
        _btnHireTaxCollector.addEventListener("out", this);
    } // End of the function
    function initTexts()
    {
        _lblLP.__set__text(api.lang.getText("LIFEPOINTS"));
        _lblBonus.__set__text(api.lang.getText("DAMAGES_BONUS"));
        _lblPercentRes.__set__text(api.lang.getText("PERCENT_RESOURCES"));
        _lblPercentKamas.__set__text(api.lang.getText("PERCENT_KAMAS"));
        _lblProbObjects.__set__text(api.lang.getText("TAX_OBJECT_PROBABILITY"));
        _lblBoostPoints.__set__text(api.lang.getText("GUILD_BONUSPOINTS"));
        _lblLevel.__set__text(api.lang.getText("LEVEL_SMALL"));
        _lblTaxSpells.__set__text(api.lang.getText("GUILD_TAXSPELLS"));
        _lblTaxCharacteristics.__set__text(api.lang.getText("GUILD_TAXCHARACTERISTICS"));
        _btnHireTaxCollector.__set__label(api.lang.getText("HIRE_TAXCOLLECTOR"));
    } // End of the function
    function updateData()
    {
        gapi.hideTooltip();
        var _loc2 = api.datacenter.Player.guildInfos;
        _lblLPValue.__set__text(_loc2.taxLp);
        _lblBonusValue.__set__text(_loc2.taxBonus);
        _lblPercentResValue.__set__text(_loc2.taxPercentRes + "%");
        _lblPercentKamasValue.__set__text(_loc2.taxPercentKamas + "%");
        _lblProbObjectsValue.__set__text(_loc2.taxProbObjects + "%");
        _lblTaxCount.__set__text(api.lang.getText("GUILD_TAX_COUNT", [_loc2.taxCount, _loc2.taxCountMax]));
        _lblBoostPointsValue.__set__text(ank.utils.PatternDecoder.combine(api.lang.getText("POINTS", [_loc2.boostPoints]), "m", _loc2.boostPoints < 2));
        _lstSpells.__set__dataProvider(_loc2.taxSpells);
        var _loc3 = _loc2.playerRights.canManageBoost && _loc2.boostPoints > 0;
        _btnBoostPercentRes._visible = _loc3 && _loc2.canBoost("r");
        _btnBoostPercentKamas._visible = _loc3 && _loc2.canBoost("k");
        _btnBoostProbObjects._visible = _loc3 && _loc2.canBoost("o");
        _btnHireTaxCollector.__set__enabled(_loc2.playerRights.canHireTaxCollector && _loc2.taxCount < _loc2.taxCountMax && !api.datacenter.Player.cantInteractWithTaxCollector);
        _btnHireTaxCollector._visible = true;
    } // End of the function
    function itemSelected(oEvent)
    {
        gapi.loadUIComponent("SpellInfos", "SpellInfos", {spell: oEvent.target.item});
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBoostPercentRes":
            {
                api.network.Guild.boostCharacteristic("r");
                break;
            } 
            case "_btnBoostPercentKamas":
            {
                api.network.Guild.boostCharacteristic("k");
                break;
            } 
            case "_btnBoostProbObjects":
            {
                api.network.Guild.boostCharacteristic("o");
                break;
            } 
            case "_btnHireTaxCollector":
            {
                var _loc2 = api.datacenter.Player;
                if (_loc2.guildInfos.taxcollectorHireCost < _loc2.Kama)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("DO_YOU_HIRE_TAXCOLLECTOR", [_loc2.guildInfos.taxcollectorHireCost]), "CAUTION_YESNO", {name: "GuildTaxCollector", listener: this});
                }
                else
                {
                    api.kernel.showMessage("undefined", api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"), "ERROR_BOX");
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBoostPercentRes":
            {
                var _loc3 = api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("r");
                var _loc4 = api.lang.getGuildBoostsMax("r");
                gapi.showTooltip(api.lang.getText("COST") + " : " + _loc3.cost + " " + api.lang.getText("FOR") + " " + _loc3.count + "% (max :" + _loc4 + ")", oEvent.target, -20);
                break;
            } 
            case "_btnBoostPercentKamas":
            {
                _loc3 = api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("k");
                _loc4 = api.lang.getGuildBoostsMax("k");
                gapi.showTooltip(api.lang.getText("COST") + " : " + _loc3.cost + " " + api.lang.getText("FOR") + " " + _loc3.count + "% (max :" + _loc4 + ")", oEvent.target, -20);
                break;
            } 
            case "_btnBoostProbObjects":
            {
                _loc3 = api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("o");
                _loc4 = api.lang.getGuildBoostsMax("o");
                gapi.showTooltip(api.lang.getText("COST") + " : " + _loc3.cost + " " + api.lang.getText("FOR") + " " + _loc3.count + "% (max :" + _loc4 + ")", oEvent.target, -20);
                break;
            } 
            case "_btnHireTaxCollector":
            {
                gapi.showTooltip(api.lang.getText("COST") + " : " + api.datacenter.Player.guildInfos.taxcollectorHireCost + " " + api.lang.getText("KAMAS"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function yes(oEvent)
    {
        api.network.Guild.hireTaxCollector();
    } // End of the function
    static var CLASS_NAME = "GuildBoostsViewer";
} // End of Class
#endinitclip
