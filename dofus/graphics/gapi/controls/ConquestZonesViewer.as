// Action script...

// [Initial MovieClip Action of sprite 20822]
#initclip 87
if (!dofus.graphics.gapi.controls.ConquestZonesViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ConquestZonesViewer = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ConquestZonesViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._lblFilter.text = this.api.lang.getText("FILTER");
        this._lblAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"), null, false);
        this._lblAreaTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"), null, true);
        this._lblAreaDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
        this._lblVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"), null, false);
        this._lblVillageTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"), null, true);
        this._lblVillageDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_DOOR_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
    };
    _loc1.addListeners = function ()
    {
        var ref = this;
        this._mcGotAreasInteractivity.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcGotAreasInteractivity.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcGotVillagesInteractivity.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcGotVillagesInteractivity.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this.api.datacenter.Conquest.addEventListener("worldDataChanged", this);
        this._cbFilter.addEventListener("itemSelected", this);
    };
    _loc1.refreshAreaList = function ()
    {
        var _loc2 = this.api.datacenter.Conquest.worldDatas;
        var _loc3 = this._cbFilter.selectedItem.value;
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = new String();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc2.areas.length)
        {
            if (_loc3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS && !_loc2.areas[_loc6].fighting)
            {
                continue;
            } // end if
            if (_loc3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS && !_loc2.areas[_loc6].isCapturable())
            {
                continue;
            } // end if
            if (_loc3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS && !_loc2.areas[_loc6].isVulnerable())
            {
                continue;
            } // end if
            if (_loc3 >= 0 && _loc2.areas[_loc6].alignment != _loc3)
            {
                continue;
            } // end if
            if (_loc5 != _loc2.areas[_loc6].areaName)
            {
                _loc4.push({area: _loc2.areas[_loc6].areaId});
                _loc5 = _loc2.areas[_loc6].areaName;
            } // end if
            _loc4.push(_loc2.areas[_loc6]);
        } // end while
        this._lstAreas.dataProvider = _loc4;
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.datacenter.Conquest.worldDatas;
        this._lblGotAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"), "f", false) + " : " + _loc2.ownedAreas + " / " + _loc2.possibleAreas + " / " + _loc2.totalAreas;
        this._lblGotVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"), "m", false) + " : " + _loc2.ownedVillages + " / " + _loc2.totalVillages;
        this.refreshAreaList();
        this._lstVillages.dataProvider = _loc2.villages;
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = this.api.lang.getAlignments();
        for (var s in _loc4)
        {
            if (_loc4[s].c)
            {
                _loc3.push({label: this.api.lang.getText("CONQUEST_ALIGNED_AREAS", [_loc4[s].n]), value: s});
            } // end if
        } // end of for...in
        _loc3.push({label: this.api.lang.getText("CONQUEST_HOSTILE_AREAS"), value: dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS});
        _loc3.push({label: this.api.lang.getText("CONQUEST_CAPTURABLE_AREAS"), value: dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS});
        _loc3.push({label: this.api.lang.getText("CONQUEST_VULNERALE_AREAS"), value: dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS});
        _loc3.push({label: this.api.lang.getText("CONQUEST_ALL_AREAS"), value: dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_ALL_AREAS});
        this._cbFilter.dataProvider = _loc3;
        this._cbFilter.selectedIndex = _loc3.findFirstItem("value", this.api.kernel.OptionsManager.getOption("ConquestFilter")).index;
    };
    _loc1.over = function (event)
    {
        var _loc3 = this.api.datacenter.Conquest.worldDatas;
        switch (event.target)
        {
            case this._mcGotAreasInteractivity:
            {
                this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_ZONES", [_loc3.ownedAreas, _loc3.possibleAreas, _loc3.ownedVillages, _loc3.totalAreas]), this._mcGotAreasInteractivity, -55);
                break;
            } 
            case this._mcGotVillagesInteractivity:
            {
                this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_VILLAGES", [_loc3.ownedVillages, _loc3.totalVillages]), this._mcGotVillagesInteractivity, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (event)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.worldDataChanged = function (event)
    {
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.itemSelected = function (event)
    {
        this.api.kernel.OptionsManager.setOption("ConquestFilter", this._cbFilter.selectedItem.value);
        this.refreshAreaList();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ConquestZonesViewer = function ()
    {
        super();
    }).CLASS_NAME = "ConquestZonesViewer";
    (_global.dofus.graphics.gapi.controls.ConquestZonesViewer = function ()
    {
        super();
    }).FILTER_VULNERALE_AREAS = -4;
    (_global.dofus.graphics.gapi.controls.ConquestZonesViewer = function ()
    {
        super();
    }).FILTER_CAPTURABLE_AREAS = -3;
    (_global.dofus.graphics.gapi.controls.ConquestZonesViewer = function ()
    {
        super();
    }).FILTER_ALL_AREAS = -2;
    (_global.dofus.graphics.gapi.controls.ConquestZonesViewer = function ()
    {
        super();
    }).FILTER_HOSTILE_AREAS = -1;
} // end if
#endinitclip
