// Action script...

// [Initial MovieClip Action of sprite 20602]
#initclip 123
if (!dofus.graphics.gapi.controls.InventoryViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__dataProvider = function (eaDataProvider)
    {
        this._eaDataProvider.removeEventListener("modelChanged", this);
        this._eaDataProvider = eaDataProvider;
        this._eaDataProvider.addEventListener("modelChanged", this);
        if (this.initialized)
        {
            this.modelChanged();
        } // end if
        //return (this.dataProvider());
    };
    _loc1.__get__dataProvider = function ()
    {
        return (this._eaDataProvider);
    };
    _loc1.__set__kamasProvider = function (oKamasProvider)
    {
        oKamasProvider.removeEventListener("kamaChanged", this);
        this._oKamasProvider = oKamasProvider;
        oKamasProvider.addEventListener("kamaChanged", this);
        if (this.initialized)
        {
            this.kamaChanged();
        } // end if
        //return (this.kamasProvider());
    };
    _loc1.__set__autoFilter = function (bAutoFilter)
    {
        this._bAutoFilter = bAutoFilter;
        //return (this.autoFilter());
    };
    _loc1.__set__filterAtStart = function (bFilterAtStart)
    {
        this._bFilterAtStart = bFilterAtStart;
        //return (this.filterAtStart());
    };
    _loc1.__get__currentFilterID = function ()
    {
        return (this._nCurrentFilterID);
    };
    _loc1.__get__customInventoryFilter = function ()
    {
        return (this._iifFilter);
    };
    _loc1.__set__customInventoryFilter = function (iif)
    {
        this._iifFilter = iif;
        if (this.initialized)
        {
            this.modelChanged();
        } // end if
        //return (this.customInventoryFilter());
    };
    _loc1.__get__selectedItem = function ()
    {
        return (this._oDataViewer.selectedIndex);
    };
    _loc1.setFilter = function (nFilter)
    {
        if (nFilter == this._nCurrentFilterID)
        {
            return;
        } // end if
        switch (nFilter)
        {
            case dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT:
            {
                this.click({target: this._btnFilterEquipement});
                this._btnFilterEquipement.selected = true;
                break;
            } 
            case dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT:
            {
                this.click({target: this._btnFilterNonEquipement});
                this._btnFilterNonEquipement.selected = true;
                break;
            } 
            case dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES:
            {
                this.click({target: this._btnFilterRessoureces});
                this._btnFilterRessoureces.selected = true;
                break;
            } 
        } // End of switch
    };
    _loc1.createChildren = function ()
    {
        if (this._bFilterAtStart)
        {
            if (this._bAutoFilter)
            {
                this.addToQueue({object: this, method: this.setPreferedFilter});
            }
            else
            {
                this.addToQueue({object: this, method: this.setFilter, params: [this.getDefaultFilter()]});
            } // end if
        } // end else if
    };
    _loc1.addListeners = function ()
    {
        this._btnFilterEquipement.addEventListener("click", this);
        this._btnFilterNonEquipement.addEventListener("click", this);
        this._btnFilterRessoureces.addEventListener("click", this);
        this._btnMoreChoice.addEventListener("click", this);
        this._btnFilterEquipement.addEventListener("over", this);
        this._btnFilterNonEquipement.addEventListener("over", this);
        this._btnFilterRessoureces.addEventListener("over", this);
        this._btnMoreChoice.addEventListener("over", this);
        this._btnFilterEquipement.addEventListener("out", this);
        this._btnFilterNonEquipement.addEventListener("out", this);
        this._btnFilterRessoureces.addEventListener("out", this);
        this._btnMoreChoice.addEventListener("out", this);
        this._cbTypes.addEventListener("itemSelected", this);
    };
    _loc1.getDefaultFilter = function ()
    {
        return (dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT);
    };
    _loc1.setPreferedFilter = function ()
    {
        var _loc2 = new Array({count: 0, id: dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT}, {count: 0, id: dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT}, {count: 0, id: dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES});
        for (var k in this._eaDataProvider)
        {
            var _loc3 = this._eaDataProvider[k].superType;
            if (dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT[_loc3])
            {
                ++_loc2[0].count;
            } // end if
            if (dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT[_loc3])
            {
                ++_loc2[1].count;
            } // end if
            if (dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES[_loc3])
            {
                ++_loc2[2].count;
            } // end if
        } // end of for...in
        _loc2.sortOn("count");
        this.setFilter(_loc2[2].id);
    };
    _loc1.updateData = function ()
    {
        var _loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name];
        this._nSelectedTypeID = _loc2 == undefined ? (0) : (_loc2);
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = new Object();
        for (var k in this._eaDataProvider)
        {
            var _loc6 = this._eaDataProvider[k];
            var _loc7 = _loc6.position;
            if (_loc7 == -1 && this._aSelectedSuperTypes[_loc6.superType])
            {
                if (_loc6.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
                {
                    if (this._iifFilter == null || this._iifFilter == undefined || this._iifFilter.isItemListed(_loc6))
                    {
                        _loc3.push(_loc6);
                    } // end if
                } // end if
                var _loc8 = _loc6.type;
                if (_loc5[_loc8] != true)
                {
                    _loc4.push({label: this.api.lang.getItemTypeText(_loc8).n, id: _loc8});
                    _loc5[_loc8] = true;
                } // end if
            } // end if
        } // end of for...in
        _loc4.sortOn("label");
        _loc4.splice(0, 0, {label: this.api.lang.getText("WITHOUT_TYPE_FILTER"), id: 0});
        this._cbTypes.dataProvider = _loc4;
        this.setType(this._nSelectedTypeID);
        this._oDataViewer.dataProvider = _loc3;
        this.sortInventory(this._sCurrentSort);
    };
    _loc1.setType = function (nTypeID)
    {
        var _loc3 = this._cbTypes.dataProvider;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            if (_loc3[_loc4].id == nTypeID)
            {
                this._cbTypes.selectedIndex = _loc4;
                return;
            } // end if
        } // end while
        this._nSelectedTypeID = 0;
        this._cbTypes.selectedIndex = this._nSelectedTypeID;
    };
    _loc1.showSearch = function ()
    {
        var _loc2 = this.gapi.loadUIComponent("InventorySearch", "InventorySearch", {_oDataProvider: this._oDataViewer.dataProvider});
        _loc2.addEventListener("selected", this);
    };
    _loc1.sortInventory = function (sField)
    {
        if (!sField)
        {
            return;
        } // end if
        this._oDataViewer.dataProvider.sortOn(sField, Array.NUMERIC);
        this._sCurrentSort = sField;
        this._nLastProviderLen = this._oDataViewer.dataProvider.length;
        this._nLastFilterID = this._nCurrentFilterID;
        this._oDataViewer.modelChanged();
    };
    _loc1.modelChanged = function ()
    {
        this.updateData();
    };
    _loc1.kamaChanged = function (oEvent)
    {
        if (oEvent.value == undefined)
        {
            this._lblKama.text = "0";
        }
        else
        {
            this._lblKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        if (oEvent.target == this._btnMoreChoice)
        {
            var _loc3 = this.api.ui.createPopupMenu();
            _loc3.addItem(this.api.lang.getText("INVENTORY_SEARCH"), this, this.showSearch);
            _loc3.addItem(this.api.lang.getText("INVENTORY_DATE_SORT"), this, this.sortInventory, ["_itemDateId"]);
            _loc3.addItem(this.api.lang.getText("INVENTORY_NAME_SORT"), this, this.sortInventory, ["_itemName"]);
            _loc3.addItem(this.api.lang.getText("INVENTORY_TYPE_SORT"), this, this.sortInventory, ["_itemType"]);
            _loc3.addItem(this.api.lang.getText("INVENTORY_LEVEL_SORT"), this, this.sortInventory, ["_itemLevel"]);
            _loc3.addItem(this.api.lang.getText("INVENTORY_POD_SORT"), this, this.sortInventory, ["_itemWeight"]);
            _loc3.addItem(this.api.lang.getText("INVENTORY_QTY_SORT"), this, this.sortInventory, ["_nQuantity"]);
            _loc3.show(_root._xmouse, _root._ymouse);
            return;
        } // end if
        if (oEvent.target != this._btnSelectedFilterButton)
        {
            this._btnSelectedFilterButton.selected = false;
            this._btnSelectedFilterButton = oEvent.target;
            switch (oEvent.target._name)
            {
                case "_btnFilterEquipement":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                    this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT;
                    break;
                } 
                case "_btnFilterNonEquipement":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                    this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT;
                    break;
                } 
                case "_btnFilterRessoureces":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES;
                    this._lblFilter.text = this.api.lang.getText("RESSOURECES");
                    this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES;
                    break;
                } 
            } // End of switch
            this.updateData();
        }
        else
        {
            oEvent.target.selected = true;
        } // end else if
    };
    _loc1.selected = function (oEvent)
    {
        var _loc3 = oEvent.value;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._oDataViewer.dataProvider.length)
        {
            if (_loc3 == this._oDataViewer.dataProvider[_loc4].unicID)
            {
                this._oDataViewer.setVPosition(Math.floor(_loc4 / this._oDataViewer.visibleColumnCount));
                this._oDataViewer.selectedIndex = _loc4;
            } // end if
        } // end while
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_cbTypes":
            {
                this._nSelectedTypeID = this._cbTypes.selectedItem.id;
                this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name] = this._nSelectedTypeID;
                this.updateData();
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnFilterEquipement:
            {
                this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"), oEvent.target, -20);
                break;
            } 
            case this._btnFilterNonEquipement:
            {
                this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"), oEvent.target, -20);
                break;
            } 
            case this._btnFilterRessoureces:
            {
                this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"), oEvent.target, -20);
                break;
            } 
            case this._btnMoreChoice:
            {
                this.api.ui.showTooltip(this.api.lang.getText("SEARCH_AND_SORT"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.addProperty("selectedItem", _loc1.__get__selectedItem, function ()
    {
    });
    _loc1.addProperty("customInventoryFilter", _loc1.__get__customInventoryFilter, _loc1.__set__customInventoryFilter);
    _loc1.addProperty("dataProvider", _loc1.__get__dataProvider, _loc1.__set__dataProvider);
    _loc1.addProperty("currentFilterID", _loc1.__get__currentFilterID, function ()
    {
    });
    _loc1.addProperty("kamasProvider", function ()
    {
    }, _loc1.__set__kamasProvider);
    _loc1.addProperty("filterAtStart", function ()
    {
    }, _loc1.__set__filterAtStart);
    _loc1.addProperty("autoFilter", function ()
    {
    }, _loc1.__set__autoFilter);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).CLASS_NAME = "InventoryViewer";
    (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).FILTER_ID_EQUIPEMENT = 0;
    (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, true, true, false, true, true, true, true, false];
    (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).FILTER_ID_NONEQUIPEMENT = 1;
    (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
    (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).FILTER_ID_RESSOURECES = 2;
    (_global.dofus.graphics.gapi.controls.InventoryViewer = function ()
    {
        super();
    }).FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false];
    _loc1._bAutoFilter = true;
    _loc1._bFilterAtStart = true;
    _loc1._nSelectedTypeID = 0;
    _loc1._nLastProviderLen = 0;
    _loc1._nLastFilterID = -1;
} // end if
#endinitclip
