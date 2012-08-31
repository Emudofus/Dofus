// Action script...

// [Initial MovieClip Action of sprite 1014]
#initclip 235
class dofus.graphics.gapi.ui.Spells extends ank.gapi.core.UIAdvancedComponent
{
    var gapi, unloadThis, _mcSpellFullInfosPlacer, addToQueue, _btnBoost, _btnTab0, _btnTab1, _btnTab2, _btnTab3, _btnTab4, _btnClose, _cgGrid, _ctrBoost, api, _lblBonusTitle, _txtHowBoost, _nSelectedTabIndex, _lblBonus, _oSelectedSpell, _winBackground, _sivSpellInfosViewer, _sbvSpellBoostViewer, getNextHighestDepth, attachMovie, _sfivSpellFullInfosViewer, _lblCost;
    function Spells()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Spells.CLASS_NAME);
        gapi.getUIComponent("Banner").setCurrentTab("Spells");
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        _mcSpellFullInfosPlacer._visible = false;
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: selectTab, params: [0]});
        this.hideSpellInfosViewer(true);
        this.hideSpellBoostViewer(true);
        _btnBoost.__set__enabled(false);
    } // End of the function
    function addListeners()
    {
        _btnTab0.addEventListener("click", this);
        _btnTab1.addEventListener("click", this);
        _btnTab2.addEventListener("click", this);
        _btnTab3.addEventListener("click", this);
        _btnTab4.addEventListener("click", this);
        _btnBoost.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        _cgGrid.addEventListener("dragItem", this);
        _cgGrid.addEventListener("dropItem", this);
        _cgGrid.addEventListener("overItem", this);
        _cgGrid.addEventListener("outItem", this);
        _cgGrid.addEventListener("selectItem", this);
        _ctrBoost.addEventListener("drop", this);
        _ctrBoost.addEventListener("click", this);
        api.datacenter.Player.addEventListener("bonusSpellsChanged", this);
        api.datacenter.Player.Spells.addEventListener("modelChanged", this);
    } // End of the function
    function initData()
    {
        this.updateBonus();
    } // End of the function
    function initTexts()
    {
        _btnTab0.__set__label("   " + api.lang.getText("SPELL_TAB_GUILD"));
        _btnTab1.__set__label("   " + api.lang.getText("SPELL_TAB_WATER"));
        _btnTab2.__set__label("   " + api.lang.getText("SPELL_TAB_FIRE"));
        _btnTab3.__set__label("   " + api.lang.getText("SPELL_TAB_EARTH"));
        _btnTab4.__set__label("   " + api.lang.getText("SPELL_TAB_AIR"));
        _lblBonusTitle.__set__text(api.lang.getText("BONUS"));
        _txtHowBoost.__set__text(api.lang.getText("PLACE_SPELL_HERE"));
    } // End of the function
    function updateSpells()
    {
        var _loc3 = api.datacenter.Player.Spells;
        var _loc4 = new ank.utils.ExtendedArray();
        for (var _loc5 in _loc3)
        {
            var _loc2 = _loc3[_loc5];
            if (_loc2.classID == _nSelectedTabIndex)
            {
                _loc4.push(_loc2);
            } // end if
        } // end of for...in
        _cgGrid.__set__dataProvider(_loc4);
    } // End of the function
    function updateBonus(nValue)
    {
        _lblBonus.__set__text(nValue == undefined ? (api.datacenter.Player.BonusPointsSpell) : (nValue));
    } // End of the function
    function selectTab(nIndex)
    {
        delete this._oSelectedSpell;
        this.hideSpellInfosViewer(true);
        this.showDetails(false);
        var _loc3 = this["_btnTab" + _nSelectedTabIndex];
        var _loc2 = this["_btnTab" + nIndex];
        _loc3.selected = false;
        _loc3.enabled = true;
        _nSelectedTabIndex = nIndex;
        _loc2.enabled = false;
        if (!_loc2.selected)
        {
            _loc2.selected = true;
        } // end if
        _winBackground.__set__title(api.lang.getText(dofus.graphics.gapi.ui.Spells.TAB_TITLE_LIST[nIndex]));
        this.updateSpells();
    } // End of the function
    function hideSpellInfosViewer(bHide)
    {
        _sivSpellInfosViewer._visible = !bHide;
    } // End of the function
    function hideSpellBoostViewer(bHide)
    {
        _sbvSpellBoostViewer._visible = !bHide;
    } // End of the function
    function showDetails(bShow)
    {
        if (bShow)
        {
            if (_oSelectedSpell != undefined)
            {
                this.attachMovie("SpellFullInfosViewer", "_sfivSpellFullInfosViewer", this.getNextHighestDepth(), {_x: _mcSpellFullInfosPlacer._x, _y: _mcSpellFullInfosPlacer._y, spell: _oSelectedSpell});
            } // end if
            _sfivSpellFullInfosViewer.addEventListener("close", this);
        }
        else
        {
            _sfivSpellFullInfosViewer.removeMovieClip();
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnTab0":
            case "_btnTab1":
            case "_btnTab2":
            case "_btnTab3":
            case "_btnTab4":
            {
                this.selectTab(Number(oEvent.target._name.substr(7)));
                break;
            } 
            case "_btnBoost":
            {
                var _loc2 = _ctrBoost.__get__contentData();
                if (_loc2 != undefined)
                {
                    _ctrBoost.__set__contentData("");
                    this.hideSpellBoostViewer(true);
                    _btnBoost.__set__enabled(false);
                    _lblCost.__set__text("");
                    api.network.Spells.boost(_loc2.ID);
                } // end if
                break;
            } 
            case "_ctrBoost":
            {
                _ctrBoost.__set__contentData("");
                this.hideSpellBoostViewer(true);
                _btnBoost.__set__enabled(false);
                _lblCost.__set__text("");
                if (_oSelectedSpell != undefined)
                {
                    this.hideSpellInfosViewer(false);
                } // end if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    function dragItem(oEvent)
    {
        if (oEvent.target.contentData == undefined)
        {
            return;
        } // end if
        gapi.removeCursor();
        gapi.setCursor(oEvent.target.contentData);
    } // End of the function
    function drop(oEvent)
    {
        var _loc2 = gapi.getCursor();
        if (_loc2 == undefined)
        {
            return;
        } // end if
        gapi.removeCursor();
        var _loc3 = dofus.Constants.SPELL_BOOST_BONUS[_loc2.level];
        this.hideSpellBoostViewer(false);
        if (_loc2.level < _loc2.maxLevel)
        {
            this.hideSpellInfosViewer(true);
            _ctrBoost.__set__contentData(_loc2);
            _sbvSpellBoostViewer.__set__spell(_loc2);
            _btnBoost.__set__enabled(_loc3 <= api.datacenter.Player.BonusPointsSpell);
            _lblCost.__set__text(api.lang.getText("COST") + " : " + _loc3);
        }
        else
        {
            _ctrBoost.__set__contentData("");
            this.hideSpellBoostViewer(true);
            _btnBoost.__set__enabled(false);
            _lblCost.__set__text("");
        } // end else if
    } // End of the function
    function dropItem(oEvent)
    {
        gapi.removeCursor();
    } // End of the function
    function overItem(oEvent)
    {
        if (oEvent.target.contentData != undefined)
        {
            _sivSpellInfosViewer.__set__spell(oEvent.target.contentData);
            this.hideSpellInfosViewer(false);
            if (gapi.getCursor() == undefined)
            {
                gapi.hideTooltip();
                var _loc3 = {x: oEvent.target._x, y: oEvent.target._y - 20};
                oEvent.target._parent.localToGlobal(_loc3);
                var _loc5 = _loc3.x;
                var _loc4 = _loc3.y;
                gapi.showTooltip(oEvent.target.contentData.name, _loc5, _loc4, {bXLimit: true, bYLimit: false});
            } // end if
        } // end if
    } // End of the function
    function outItem(oEvent)
    {
        this.hideSpellInfosViewer(true);
        gapi.hideTooltip();
    } // End of the function
    function selectItem(oEvent)
    {
        _oSelectedSpell = oEvent.target.contentData;
        if (_oSelectedSpell != undefined)
        {
            if (_sfivSpellFullInfosViewer != undefined)
            {
                _sfivSpellFullInfosViewer.__set__spell(_oSelectedSpell);
            }
            else
            {
                this.showDetails(true);
            } // end if
        } // end else if
    } // End of the function
    function bonusSpellsChanged(oEvent)
    {
        this.updateBonus(oEvent.value);
    } // End of the function
    function close(oEvent)
    {
        this.showDetails(false);
        _cgGrid.selectedItem.selected = false;
    } // End of the function
    function modelChanged(oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        this.updateSpells();
        this.hideSpellInfosViewer(true);
        this.hideSpellBoostViewer(true);
        
    } // End of the function
    static var CLASS_NAME = "Spells";
    static var TAB_LIST = ["Guild", "Water", "Fire", "Earth", "Air"];
    static var TAB_TITLE_LIST = ["SPELL_TAB_GUILD_TITLE", "SPELL_TAB_WATER_TITLE", "SPELL_TAB_FIRE_TITLE", "SPELL_TAB_EARTH_TITLE", "SPELL_TAB_AIR_TITLE"];
} // End of Class
#endinitclip
