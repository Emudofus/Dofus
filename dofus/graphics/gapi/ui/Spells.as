// Action script...

// [Initial MovieClip Action of sprite 20618]
#initclip 139
if (!dofus.graphics.gapi.ui.Spells)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Spells = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Spells.CLASS_NAME);
        this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this._nSelectedSpellType = 0;
        this._mcSpellFullInfosPlacer._visible = false;
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.hideSpellBoostViewer(true);
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._dgSpells.addEventListener("itemRollOver", this);
        this._dgSpells.addEventListener("itemRollOut", this);
        this._dgSpells.addEventListener("itemDrag", this);
        this._dgSpells.addEventListener("itemSelected", this);
        this._cbType.addEventListener("itemSelected", this);
        this.api.datacenter.Player.addEventListener("bonusSpellsChanged", this);
        this.api.datacenter.Player.Spells.addEventListener("modelChanged", this);
    };
    _loc1.initData = function ()
    {
        this.updateBonus();
    };
    _loc1.initTexts = function ()
    {
        this._winBackground.title = this.api.lang.getText("YOUR_SPELLS");
        this._dgSpells.columnsNames = [this.api.lang.getText("NAME_BIG"), this.api.lang.getText("LEVEL")];
        this._lblBonusTitle.text = this.api.lang.getText("SPELL_BOOST_POINT");
        this._lblSpellType.text = this.api.lang.getText("SPELL_TYPE");
        var _loc2 = new ank.utils.ExtendedArray();
        _loc2.push({label: this.api.lang.getText("WITHOUT_TYPE_FILTER"), type: -2});
        _loc2.push({label: this.api.lang.getText("SPELL_TAB_GUILD"), type: 0});
        _loc2.push({label: this.api.lang.getText("SPELL_TAB_WATER"), type: 1});
        _loc2.push({label: this.api.lang.getText("SPELL_TAB_FIRE"), type: 2});
        _loc2.push({label: this.api.lang.getText("SPELL_TAB_EARTH"), type: 3});
        _loc2.push({label: this.api.lang.getText("SPELL_TAB_AIR"), type: 4});
        this._cbType.dataProvider = _loc2;
        this._cbType.selectedIndex = 1;
    };
    _loc1.updateSpells = function ()
    {
        var _loc2 = this.api.datacenter.Player.Spells;
        var _loc3 = new ank.utils.ExtendedArray();
        for (var k in _loc2)
        {
            var _loc4 = _loc2[k];
            if (_loc4.classID != -1 && (_loc4.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
            {
                _loc3.push(_loc4);
            } // end if
        } // end of for...in
        if (this.api.kernel.OptionsManager.getOption("SeeAllSpell") && this.api.datacenter.Basics.canUseSeeAllSpell)
        {
            var _loc5 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).s;
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5.length)
            {
                var _loc7 = _loc5[_loc6];
                var _loc8 = false;
                var _loc9 = 0;
                
                while (++_loc9, _loc9 < _loc3.length && !_loc8)
                {
                    _loc8 = _loc3[_loc9].ID == _loc7;
                } // end while
                var _loc10 = new dofus.datacenter.Spell(_loc7, 1);
                if (!_loc8 && (_loc10.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
                {
                    _loc3.push(_loc10);
                } // end if
            } // end while
        } // end if
        _loc3.sortOn("_minPlayerLevel", Array.NUMERIC);
        this._dgSpells.dataProvider = _loc3;
    };
    _loc1.updateBonus = function (nValue)
    {
        this._lblBonus.text = nValue == undefined ? (String(this.api.datacenter.Player.BonusPointsSpell)) : (String(nValue));
        this.updateSpells();
    };
    _loc1.hideSpellBoostViewer = function (bHide, oSpell)
    {
        this._sbvSpellBoostViewer._visible = !bHide;
        if (oSpell != undefined)
        {
            this._sbvSpellBoostViewer.spell = oSpell;
        } // end if
    };
    _loc1.showDetails = function (bShow)
    {
        this._sfivSpellFullInfosViewer.removeMovieClip();
        if (bShow)
        {
            this.attachMovie("SpellFullInfosViewer", "_sfivSpellFullInfosViewer", this.getNextHighestDepth(), {_x: this._mcSpellFullInfosPlacer._x, _y: this._mcSpellFullInfosPlacer._y});
            this._sfivSpellFullInfosViewer.addEventListener("close", this);
        } // end if
    };
    _loc1.boostSpell = function (oSpell)
    {
        this.api.sounds.events.onSpellsBoostButtonClick();
        if (this.canBoost(oSpell) != undefined)
        {
            var _loc3 = new dofus.datacenter.Spell(oSpell.ID, oSpell.level + 1);
            if (this.api.datacenter.Player.Level < _loc3.minPlayerLevel)
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("LEVEL_NEED_TO_BOOST", [_loc3.minPlayerLevel]), "ERROR_BOX");
                return (false);
            } // end if
            this.hideSpellBoostViewer(true);
            this.api.network.Spells.boost(oSpell.ID);
            this._sfivSpellFullInfosViewer.spell = _loc3;
            return (true);
        } // end if
        return (false);
    };
    _loc1.getCostForBoost = function (oSpell)
    {
        return (oSpell.level < oSpell.maxLevel ? (dofus.Constants.SPELL_BOOST_BONUS[oSpell.level]) : (-1));
    };
    _loc1.canBoost = function (oSpell)
    {
        if (oSpell != undefined)
        {
            if (this.getCostForBoost(oSpell) > this.api.datacenter.Player.BonusPointsSpell)
            {
                return (false);
            } // end if
            if (oSpell.level < oSpell.maxLevel)
            {
                return (true);
            } // end if
        } // end if
        return (false);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.itemDrag = function (oEvent)
    {
        if (oEvent.row.item == undefined)
        {
            return;
        } // end if
        if (this.api.datacenter.Player.Level < oEvent.row.item._minPlayerLevel)
        {
            return;
        } // end if
        this.gapi.removeCursor();
        this.gapi.setCursor(oEvent.row.item);
    };
    _loc1.itemRollOver = function (oEvent)
    {
    };
    _loc1.itemRollOut = function (oEvent)
    {
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._dgSpells:
            {
                if (oEvent.row.item != undefined)
                {
                    if (this._sfivSpellFullInfosViewer.spell.ID != oEvent.row.item.ID)
                    {
                        this.showDetails(true);
                        this._sfivSpellFullInfosViewer.spell = oEvent.row.item;
                    }
                    else
                    {
                        this.showDetails(false);
                    } // end if
                } // end else if
                break;
            } 
            case this._cbType:
            {
                this._nSelectedSpellType = oEvent.target.selectedItem.type;
                this.updateSpells();
                break;
            } 
        } // End of switch
    };
    _loc1.bonusSpellsChanged = function (oEvent)
    {
        this.updateBonus(oEvent.value);
    };
    _loc1.close = function (oEvent)
    {
        this.showDetails(false);
    };
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        this.updateSpells();
        this.hideSpellBoostViewer(true);
        
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Spells = function ()
    {
        super();
    }).CLASS_NAME = "Spells";
    (_global.dofus.graphics.gapi.ui.Spells = function ()
    {
        super();
    }).TAB_LIST = ["Guild", "Water", "Fire", "Earth", "Air"];
    (_global.dofus.graphics.gapi.ui.Spells = function ()
    {
        super();
    }).TAB_TITLE_LIST = ["SPELL_TAB_GUILD_TITLE", "SPELL_TAB_WATER_TITLE", "SPELL_TAB_FIRE_TITLE", "SPELL_TAB_EARTH_TITLE", "SPELL_TAB_AIR_TITLE"];
} // end if
#endinitclip
