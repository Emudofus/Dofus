// Action script...

// [Initial MovieClip Action of sprite 20975]
#initclip 240
if (!dofus.graphics.gapi.ui.Exchange)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).prototype;
    _loc1.__set__dataProvider = function (eaDataProvider)
    {
        this._eaDataProvider.removeEventListener("modelChanged", this);
        this._eaDataProvider = eaDataProvider;
        this._eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.dataProvider());
    };
    _loc1.__set__localDataProvider = function (eaLocalDataProvider)
    {
        this._eaLocalDataProvider.removeEventListener("modelChange", this);
        this._eaLocalDataProvider = eaLocalDataProvider;
        this._eaLocalDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.localDataProvider());
    };
    _loc1.__set__distantDataProvider = function (eaDistantDataProvider)
    {
        this._eaDistantDataProvider.removeEventListener("modelChange", this);
        this._eaDistantDataProvider = eaDistantDataProvider;
        this._eaDistantDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.distantDataProvider());
    };
    _loc1.__set__readyDataProvider = function (eaReadyDataProvider)
    {
        this._eaReadyDataProvider.removeEventListener("modelChange", this);
        this._eaReadyDataProvider = eaReadyDataProvider;
        this._eaReadyDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.readyDataProvider());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Exchange.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Exchange.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this._btnSelectedFilterButton = this._btnFilterEquipement;
        this.addToQueue({object: this, method: this.initData});
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: this.initTexts});
        this._btnPrivateChat._visible = this.api.datacenter.Exchange.distantPlayerID > 0;
        this.gapi.unloadLastUIAutoHideComponent();
    };
    _loc1.addListeners = function ()
    {
        this._cgGrid.addEventListener("dblClickItem", this);
        this._cgGrid.addEventListener("dropItem", this);
        this._cgGrid.addEventListener("dragItem", this);
        this._cgGrid.addEventListener("selectItem", this);
        this._cgLocal.addEventListener("dblClickItem", this);
        this._cgLocal.addEventListener("dropItem", this);
        this._cgLocal.addEventListener("dragItem", this);
        this._cgLocal.addEventListener("selectItem", this);
        this._cgDistant.addEventListener("selectItem", this);
        this._btnFilterEquipement.addEventListener("click", this);
        this._btnFilterNonEquipement.addEventListener("click", this);
        this._btnFilterRessoureces.addEventListener("click", this);
        this._btnFilterEquipement.addEventListener("over", this);
        this._btnFilterNonEquipement.addEventListener("over", this);
        this._btnFilterRessoureces.addEventListener("over", this);
        this._btnFilterEquipement.addEventListener("out", this);
        this._btnFilterNonEquipement.addEventListener("out", this);
        this._btnFilterRessoureces.addEventListener("out", this);
        this._btnClose.addEventListener("click", this);
        this.api.datacenter.Exchange.addEventListener("localKamaChange", this);
        this.api.datacenter.Exchange.addEventListener("distantKamaChange", this);
        this._btnValidate.addEventListener("click", this);
        this._btnPrivateChat.addEventListener("click", this);
        this._cbTypes.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
        this._btnValidate.label = this.api.lang.getText("ACCEPT");
        this._lblKama.text = new ank.utils.ExtendedString(this.api.datacenter.Player.Kama).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        this._btnPrivateChat.label = this.api.lang.getText("WISPER_MESSAGE");
    };
    _loc1.initData = function ()
    {
        this.dataProvider = this.api.datacenter.Exchange.inventory;
        this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
        this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
        this.readyDataProvider = this.api.datacenter.Exchange.readyStates;
    };
    _loc1.updateData = function ()
    {
        var _loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
                    _loc3.push(_loc6);
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
        this._cgGrid.dataProvider = _loc3;
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
    _loc1.updateLocalData = function ()
    {
        this._cgLocal.dataProvider = this._eaLocalDataProvider;
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, this.hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.updateDistantData = function ()
    {
        this._cgDistant.dataProvider = this._eaDistantDataProvider;
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, this.hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.updateReadyState = function ()
    {
        var _loc2 = this._eaReadyDataProvider[0] ? (dofus.graphics.gapi.ui.Exchange.READY_COLOR) : (dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR);
        this.setMovieClipTransform(this._winLocal, _loc2);
        this.setMovieClipTransform(this._btnValidate, _loc2);
        this.setMovieClipTransform(this._cgLocal, _loc2);
        _loc2 = this._eaReadyDataProvider[1] ? (dofus.graphics.gapi.ui.Exchange.READY_COLOR) : (dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR);
        this.setMovieClipTransform(this._winDistant, _loc2);
        this.setMovieClipTransform(this._cgDistant, _loc2);
    };
    _loc1.hideButtonValidate = function (bHide)
    {
        var _loc3 = bHide ? (dofus.graphics.gapi.ui.Exchange.READY_COLOR) : (dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR);
        this.setMovieClipTransform(this._btnValidate, _loc3);
        this._btnValidate.enabled = !bHide;
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._winItemViewer._visible = !bHide;
    };
    _loc1.validateDrop = function (sTargetGrid, oItem, nValue)
    {
        if (nValue < 1 || nValue == undefined)
        {
            return;
        } // end if
        if (nValue > oItem.Quantity)
        {
            nValue = oItem.Quantity;
        } // end if
        switch (sTargetGrid)
        {
            case "_cgGrid":
            {
                this.api.network.Exchange.movementItem(false, oItem.ID, nValue);
                break;
            } 
            case "_cgLocal":
            {
                this.api.network.Exchange.movementItem(true, oItem.ID, nValue);
                break;
            } 
        } // End of switch
    };
    _loc1.validateKama = function (nQuantity)
    {
        if (nQuantity > this.api.datacenter.Player.Kama)
        {
            nQuantity = this.api.datacenter.Player.Kama;
        } // end if
        this.api.network.Exchange.movementKama(nQuantity);
    };
    _loc1.askKamaQuantity = function ()
    {
        var _loc2 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: this.api.datacenter.Exchange.localKama, max: this.api.datacenter.Player.Kama, min: 0, params: {targetType: "kama"}});
        _loc2.addEventListener("validate", this);
    };
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._eaReadyDataProvider:
            {
                this.updateReadyState();
                break;
            } 
            case this._eaLocalDataProvider:
            {
                this.updateLocalData();
                break;
            } 
            case this._eaDistantDataProvider:
            {
                this.updateDistantData();
                break;
            } 
            case this._eaDataProvider:
            {
                this.updateData();
                break;
            } 
            default:
            {
                this.updateData();
                this.updateLocalData();
                this.updateDistantData();
                break;
            } 
        } // End of switch
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
            case "_btnValidate":
            {
                this.api.network.Exchange.ready();
                break;
            } 
            case "_btnPrivateChat":
            {
                if (this.api.datacenter.Exchange.distantPlayerID > 0)
                {
                    this.api.kernel.GameManager.askPrivateMessage(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name);
                } // end if
                break;
            } 
            default:
            {
                if (oEvent.target != this._btnSelectedFilterButton)
                {
                    this._btnSelectedFilterButton.selected = false;
                    this._btnSelectedFilterButton = oEvent.target;
                    switch (oEvent.target._name)
                    {
                        case "_btnFilterEquipement":
                        {
                            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
                            this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                            break;
                        } 
                        case "_btnFilterNonEquipement":
                        {
                            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_NONEQUIPEMENT;
                            this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                            break;
                        } 
                        case "_btnFilterRessoureces":
                        {
                            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_RESSOURECES;
                            this._lblFilter.text = this.api.lang.getText("RESSOURECES");
                            break;
                        } 
                    } // End of switch
                    this.updateData(true);
                    break;
                } // end if
                oEvent.target.selected = true;
            } 
        } // End of switch
    };
    _loc1.dblClickItem = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 == undefined)
        {
            return;
        } // end if
        var _loc4 = Key.isDown(Key.CONTROL) ? (_loc3.Quantity) : (1);
        var _loc5 = oEvent.owner._name;
        switch (_loc5)
        {
            case "_cgGrid":
            {
                this.validateDrop("_cgLocal", _loc3, _loc4);
                break;
            } 
            case "_cgLocal":
            {
                this.validateDrop("_cgGrid", _loc3, _loc4);
                break;
            } 
        } // End of switch
    };
    _loc1.dragItem = function (oEvent)
    {
        this.gapi.removeCursor();
        if (oEvent.target.contentData == undefined)
        {
            return;
        } // end if
        this.gapi.setCursor(oEvent.target.contentData);
    };
    _loc1.dropItem = function (oEvent)
    {
        var _loc3 = this.gapi.getCursor();
        if (_loc3 == undefined)
        {
            return;
        } // end if
        this.gapi.removeCursor();
        var _loc4 = oEvent.target._parent._parent._name;
        switch (_loc4)
        {
            case "_cgGrid":
            {
                if (_loc3.position == -1)
                {
                    return;
                } // end if
                break;
            } 
            case "_cgLocal":
            {
                if (_loc3.position == -2)
                {
                    return;
                } // end if
                break;
            } 
        } // End of switch
        if (_loc3.Quantity > 1)
        {
            var _loc5 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: _loc3.Quantity, params: {targetType: "item", oItem: _loc3, targetGrid: _loc4}});
            _loc5.addEventListener("validate", this);
        }
        else
        {
            this.validateDrop(_loc4, _loc3, 1);
        } // end else if
    };
    _loc1.selectItem = function (oEvent)
    {
        if (oEvent.target.contentData == undefined)
        {
            this.hideItemViewer(true);
        }
        else
        {
            if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
            {
                this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
                return;
            } // end if
            this.hideItemViewer(false);
            this._itvItemViewer.itemData = oEvent.target.contentData;
        } // end else if
    };
    _loc1.validate = function (oEvent)
    {
        switch (oEvent.params.targetType)
        {
            case "item":
            {
                this.validateDrop(oEvent.params.targetGrid, oEvent.params.oItem, oEvent.value);
                break;
            } 
            case "kama":
            {
                this.validateKama(oEvent.value);
                break;
            } 
        } // End of switch
    };
    _loc1.localKamaChange = function (oEvent)
    {
        this._lblLocalKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        this._lblKama.text = new ank.utils.ExtendedString(this.api.datacenter.Player.Kama - oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, this.hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.distantKamaChange = function (oEvent)
    {
        this._mcBlink.play();
        this._lblDistantKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, this.hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_cbTypes":
            {
                this._nSelectedTypeID = this._cbTypes.selectedItem.id;
                this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
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
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.addProperty("localDataProvider", function ()
    {
    }, _loc1.__set__localDataProvider);
    _loc1.addProperty("dataProvider", function ()
    {
    }, _loc1.__set__dataProvider);
    _loc1.addProperty("distantDataProvider", function ()
    {
    }, _loc1.__set__distantDataProvider);
    _loc1.addProperty("readyDataProvider", function ()
    {
    }, _loc1.__set__readyDataProvider);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).CLASS_NAME = "Exchange";
    (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, true, true, false, true, true, true, true, false];
    (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).READY_COLOR = {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0};
    (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).NON_READY_COLOR = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    (_global.dofus.graphics.gapi.ui.Exchange = function ()
    {
        super();
    }).DELAY_BEFORE_VALIDATE = 3000;
    _loc1._nDistantReadyState = false;
    _loc1._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
    _loc1._nSelectedTypeID = 0;
} // end if
#endinitclip
