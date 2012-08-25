// Action script...

// [Initial MovieClip Action of sprite 20661]
#initclip 182
if (!dofus.graphics.gapi.ui.SecureCraft)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).prototype;
    _loc1.__set__maxItem = function (nMaxItem)
    {
        this._nMaxItem = Number(nMaxItem);
        //return (this.maxItem());
    };
    _loc1.__set__skillId = function (nSkillId)
    {
        this._nSkillId = Number(nSkillId);
        this._nForgemagusItemType = _global.API.lang.getSkillForgemagus(this._nSkillId);
        //return (this.skillId());
    };
    _loc1.__get__isClient = function ()
    {
        return (this.api.datacenter.Basics.aks_exchange_echangeType == 13);
    };
    _loc1.__set__dataProvider = function (eaDataProvider)
    {
        this._eaDataProvider.removeEventListener("modelChange", this);
        this._eaDataProvider = eaDataProvider;
        this._eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged({target: this._eaDataProvider});
        //return (this.dataProvider());
    };
    _loc1.__set__localDataProvider = function (eaLocalDataProvider)
    {
        this._eaLocalDataProvider.removeEventListener("modelChange", this);
        this._eaLocalDataProvider = eaLocalDataProvider;
        this._eaLocalDataProvider.addEventListener("modelChanged", this);
        this.modelChanged({target: this._eaLocalDataProvider});
        //return (this.localDataProvider());
    };
    _loc1.__set__distantDataProvider = function (eaDistantDataProvider)
    {
        this._eaDistantDataProvider.removeEventListener("modelChange", this);
        this._eaDistantDataProvider = eaDistantDataProvider;
        this._eaDistantDataProvider.addEventListener("modelChanged", this);
        this.modelChanged({target: this._eaDistantDataProvider});
        //return (this.distantDataProvider());
    };
    _loc1.__set__coopDataProvider = function (eaCoopDataProvider)
    {
        this._eaCoopDataProvider.removeEventListener("modelChange", this);
        this._eaCoopDataProvider = eaCoopDataProvider;
        this._eaCoopDataProvider.addEventListener("modelChanged", this);
        this.modelChanged({target: this._eaCoopDataProvider});
        //return (this.coopDataProvider());
    };
    _loc1.__set__payDataProvider = function (eaPayDataProvider)
    {
        this._eaPayDataProvider.removeEventListener("modelChange", this);
        this._eaPayDataProvider = eaPayDataProvider;
        this._eaPayDataProvider.addEventListener("modelChanged", this);
        this.modelChanged({target: this._eaPayDataProvider});
        //return (this.payDataProvider());
    };
    _loc1.__set__payIfSuccessDataProvider = function (eaPayIfSuccessDataProvider)
    {
        this._eaPayIfSuccessDataProvider.removeEventListener("modelChange", this);
        this._eaPayIfSuccessDataProvider = eaPayIfSuccessDataProvider;
        this._eaPayIfSuccessDataProvider.addEventListener("modelChanged", this);
        this.modelChanged({target: this._eaPayIfSuccessDataProvider});
        //return (this.payIfSuccessDataProvider());
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
        super.init(false, dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.callClose = function ()
    {
        this.api.network.Exchange.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this._mcPlacer._visible = false;
        this._winCraftViewer.swapDepths(this.getNextHighestDepth());
        this.showPreview(undefined, false);
        this.showCraftViewer(false);
        this.addToQueue({object: this, method: this.addListeners});
        this._btnSelectedFilterButton = this._btnFilterRessoureces;
        this.addToQueue({object: this, method: this.saveGridMaxSize});
        this.addToQueue({object: this, method: this.initData});
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initGridWidth});
        this.api.datacenter.Player.addEventListener("kamaChanged", this);
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
        this._cgCoop.addEventListener("selectItem", this);
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
        this.api.datacenter.Exchange.addEventListener("payKamaChange", this);
        this.api.datacenter.Exchange.addEventListener("payIfSuccessKamaChange", this);
        this._btnValidate.addEventListener("click", this);
        this._btnCraft.addEventListener("click", this);
        this._btnPrivateMessage.addEventListener("click", this);
        this._btnPay.addEventListener("click", this);
        this._mcFiligrane.onRollOver = function ()
        {
            this._parent.over({target: this});
        };
        this._mcFiligrane.onRollOut = function ()
        {
            this._parent.out({target: this});
        };
        this._cbTypes.addEventListener("itemSelected", this);
        this._cgPay.addEventListener("selectItem", this);
        this._cgPayIfSuccess.addEventListener("selectItem", this);
        this._btnPrivateMessagePay.addEventListener("click", this);
        this._btnValidatePay.addEventListener("click", this);
        if (this.isClient)
        {
            this._cgPay.addEventListener("dblClickItem", this);
            this._cgPay.addEventListener("dropItem", this);
            this._cgPayIfSuccess.addEventListener("dblClickItem", this);
            this._cgPayIfSuccess.addEventListener("dropItem", this);
        } // end if
        this._mcPayIfSuccessHighlight.onRelease = function ()
        {
            this._parent.switchPayBar(2);
        };
        this._mcPayHighlight.onRelease = function ()
        {
            this._parent.switchPayBar(1);
        };
    };
    _loc1.initTexts = function ()
    {
        this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
        this._btnValidate.label = this.api.lang.getText("COMBINE");
        this._btnValidatePay.label = this.api.lang.getText("VALIDATE");
        this._btnCraft.label = this.api.lang.getText("RECEIPTS");
        this._btnPrivateMessage.label = this.api.lang.getText("WISPER_MESSAGE");
        this._btnPrivateMessagePay.label = this.api.lang.getText("WISPER_MESSAGE");
        this._btnPay.label = this.api.lang.getText("PAY");
        this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
        this._winCraftViewer.title = this.api.lang.getText("RECEIPTS_FROM_JOB");
        this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
        this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
        this._lblKama.text = new ank.utils.ExtendedString(this.api.datacenter.Player.Kama).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        this._mcPayKama._visible = this.isClient;
        this._mcPayIfSuccessKama._visible = this.isClient;
        this._lblPay.text = this.api.lang.getText("PAY");
        this._lblPayIfSuccess.text = this.api.lang.getText("GRANT_IF_SUCCESS");
    };
    _loc1.initData = function ()
    {
        this.dataProvider = this.api.datacenter.Exchange.inventory;
        this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
        this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
        this.coopDataProvider = this.api.datacenter.Exchange.coopGarbage;
        this.payDataProvider = this.api.datacenter.Exchange.payGarbage;
        this.payIfSuccessDataProvider = this.api.datacenter.Exchange.payIfSuccessGarbage;
        this.readyDataProvider = this.api.datacenter.Exchange.readyStates;
        this.switchToPayMode(false);
        this.switchPayBar(1);
        this.showPreview(undefined, false);
    };
    _loc1.updateInventory = function ()
    {
        this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
        this.dataProvider = this.api.datacenter.Exchange.inventory;
        this.switchToPayMode(false);
    };
    _loc1.saveGridMaxSize = function ()
    {
    };
    _loc1.initGridWidth = function ()
    {
        if (this._nMaxItem == undefined)
        {
            this._nMaxItem = 9;
        } // end if
        this._cgLocal.visibleColumnCount = this._nMaxItem;
        this._cgDistant.visibleColumnCount = this._nMaxItem;
        var _loc2 = dofus.graphics.gapi.ui.SecureCraft.GRID_CONTAINER_WIDTH * this._nMaxItem;
        this._cgLocal.setSize(_loc2);
        this._cgLocal._x = this._winLocal._x + this._winLocal.width - _loc2 - 10;
        this._cgDistant.setSize(_loc2);
        this._cgDistant._x = this._winDistant._x + 10;
    };
    _loc1.updateData = function ()
    {
        var _loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
                    var _loc8 = 0;
                    if (this._sCurrentDragTarget == "_cgPay")
                    {
                        _loc8 = this.getQtyIn(this._eaPayIfSuccessDataProvider, _loc6.unicID);
                    }
                    else if (this._sCurrentDragTarget == "_cgPayIfSuccess")
                    {
                        _loc8 = this.getQtyIn(this._eaPayDataProvider, _loc6.unicID);
                    }
                    else if (this._sCurrentDragTarget == "_cgGrid")
                    {
                        if (this._sCurrentDragSource == "_cgPay")
                        {
                            _loc8 = this.getQtyIn(this._eaPayIfSuccessDataProvider, _loc6.unicID);
                        }
                        else if (this._sCurrentDragSource == "_cgPayIfSuccess")
                        {
                            _loc8 = this.getQtyIn(this._eaPayDataProvider, _loc6.unicID);
                        } // end else if
                    } // end else if
                    _loc6.Quantity = _loc6.Quantity - _loc8;
                    _loc3.push(_loc6);
                }
                else if (this._nSelectedTypeID == dofus.graphics.gapi.ui.SecureCraft.FILTER_TYPE_ONLY_USEFUL && this.api.kernel.GameManager.isItemUseful(_loc6.unicID, this._nSkillId, this._nMaxItem))
                {
                    _loc3.push(_loc6);
                } // end else if
                var _loc9 = _loc6.type;
                if (_loc5[_loc9] != true)
                {
                    _loc4.push({label: this.api.lang.getItemTypeText(_loc9).n, id: _loc9});
                    _loc5[_loc9] = true;
                } // end if
            } // end if
        } // end of for...in
        _loc4.sortOn("label");
        _loc4.splice(0, 0, {label: this.api.lang.getText("TYPE_FILTER_ONLY_USEFUL"), id: dofus.graphics.gapi.ui.SecureCraft.FILTER_TYPE_ONLY_USEFUL});
        _loc4.splice(0, 0, {label: this.api.lang.getText("WITHOUT_TYPE_FILTER"), id: 0});
        this._cbTypes.dataProvider = _loc4;
        this.setType(this._nSelectedTypeID);
        this._cgGrid.dataProvider = _loc3;
    };
    _loc1.getQtyIn = function (eaFrom, nItemID)
    {
        for (var qtc in eaFrom)
        {
            if (eaFrom[qtc].unicID == nItemID)
            {
                return (eaFrom[qtc].Quantity);
            } // end if
        } // end of for...in
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
        this._bInvalidateCoop = true;
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "securecraft", this, this.hideButtonValidate, dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.updateCoopData = function ()
    {
        this._cgCoop.dataProvider = this._eaCoopDataProvider;
        this._mcFiligrane._visible = this._bFiligraneVisible = this._eaCoopDataProvider == undefined;
        var _loc2 = this._cgCoop.getContainer(0).contentData;
        if (_loc2 != undefined)
        {
            this.hideItemViewer(false);
            this._itvItemViewer.itemData = _loc2;
        } // end if
    };
    _loc1.updatePayData = function ()
    {
        this._cgPay.dataProvider = this._eaPayDataProvider;
        this.switchToPayMode(true);
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "securecraft", this, this.hideButtonValidate, dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.updatePayIfSuccessData = function ()
    {
        this._cgPayIfSuccess.dataProvider = this._eaPayIfSuccessDataProvider;
        this.switchToPayMode(true);
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "securecraft", this, this.hideButtonValidate, dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.updateDistantData = function ()
    {
        this._cgDistant.dataProvider = this._eaDistantDataProvider;
        this._bInvalidateCoop = true;
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "securecraft", this, this.hideButtonValidate, dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.updateReadyState = function ()
    {
        var _loc2 = this._eaReadyDataProvider[0] ? (dofus.graphics.gapi.ui.SecureCraft.READY_COLOR) : (dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR);
        this.setMovieClipTransform(this._winLocal, _loc2);
        this.setMovieClipTransform(this._btnValidate, _loc2);
        this.setMovieClipTransform(this._cgLocal, _loc2);
        _loc2 = this._eaReadyDataProvider[1] ? (dofus.graphics.gapi.ui.SecureCraft.READY_COLOR) : (dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR);
        this.setMovieClipTransform(this._winDistant, _loc2);
        this.setMovieClipTransform(this._cgDistant, _loc2);
    };
    _loc1.hideButtonValidate = function (bHide)
    {
        var _loc3 = bHide ? (dofus.graphics.gapi.ui.SecureCraft.READY_COLOR) : (dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR);
        this.setMovieClipTransform(this._btnValidate, _loc3);
        this._btnValidate.enabled = !bHide;
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._winItemViewer._visible = !bHide;
    };
    _loc1.validateDrop = function (sToGrid, oItem, nValue)
    {
        if (nValue < 1 || nValue == undefined)
        {
            return;
        } // end if
        if (nValue > oItem.Quantity)
        {
            nValue = oItem.Quantity;
        } // end if
        this._sCurrentDragTarget = sToGrid;
        switch (sToGrid)
        {
            case "_cgGrid":
            {
                if (!this._bPayMode)
                {
                    this.api.network.Exchange.movementItem(false, oItem.ID, nValue);
                }
                else
                {
                    this.api.network.Exchange.movementPayItem(this._nPayBar, false, oItem.ID, nValue);
                } // end else if
                break;
            } 
            case "_cgLocal":
            {
                this.api.network.Exchange.movementItem(true, oItem.ID, nValue);
                break;
            } 
            case "_cgPay":
            {
                this.api.network.Exchange.movementPayItem(1, true, oItem.ID, nValue);
                break;
            } 
            case "_cgPayIfSuccess":
            {
                this.api.network.Exchange.movementPayItem(2, true, oItem.ID, nValue);
                break;
            } 
        } // End of switch
        if (this._bInvalidateCoop)
        {
            this.api.datacenter.Exchange.clearCoopGarbage();
            this._bInvalidateCoop = false;
        } // end if
    };
    _loc1.setReady = function ()
    {
        var _loc2 = this.getTotalCraftInventory();
        if (_loc2.length == 0)
        {
            return;
        } // end if
        if (_loc2.length > this._nMaxItem)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_CRAFT_SLOT", [this._nMaxItem]), "ERROR_BOX", {name: "NotEnoughtCraftSlot"});
            return;
        } // end if
        this.api.network.Exchange.ready();
    };
    _loc1.canDropInGarbage = function (oItem)
    {
        var _loc3 = this.api.datacenter.Exchange.localGarbage.findFirstItem("ID", oItem.ID);
        var _loc4 = this.api.datacenter.Exchange.localGarbage.length;
        if (_loc3.index == -1 && _loc4 >= this._nMaxItem)
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.showCraftViewer = function (bShow)
    {
        if (bShow)
        {
            var _loc3 = this.attachMovie("CraftViewer", "_cvCraftViewer", this.getNextHighestDepth());
            _loc3._x = this._mcPlacer._x;
            _loc3._y = this._mcPlacer._y;
            _loc3.skill = new dofus.datacenter.Skill(this._nSkillId, this._nMaxItem);
        }
        else
        {
            this._cvCraftViewer.removeMovieClip();
        } // end else if
        this._winCraftViewer._visible = bShow;
        this._btnCraft.selected = bShow;
    };
    _loc1.recordGarbage = function ()
    {
        this._aGarbageMemory = new Array();
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._eaLocalDataProvider.length)
        {
            var _loc3 = this._eaLocalDataProvider[_loc2];
            this._aGarbageMemory.push({id: _loc3.ID, quantity: _loc3.Quantity});
        } // end while
    };
    _loc1.cleanGarbage = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._eaLocalDataProvider.length)
        {
            var _loc3 = this._eaLocalDataProvider[_loc2];
            this.api.network.Exchange.movementItem(false, _loc3.ID, _loc3.Quantity);
        } // end while
    };
    _loc1.recallGarbageMemory = function ()
    {
        if (this._aGarbageMemory == undefined || this._aGarbageMemory.length == 0)
        {
            return;
        } // end if
        this.cleanGarbage();
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._aGarbageMemory.length)
        {
            var _loc3 = this._aGarbageMemory[_loc2];
            var _loc4 = this._eaDataProvider.findFirstItem("ID", _loc3.id);
            if (_loc4.index != -1)
            {
                if (_loc4.item.Quantity >= _loc3.quantity)
                {
                    this.api.network.Exchange.movementItem(true, _loc4.item.ID, _loc3.quantity);
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CRAFT_NOT_ENOUGHT", [_loc4.item.name]), "ERROR_BOX", {name: "NotEnougth"});
                    return;
                } // end else if
                continue;
            } // end if
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CRAFT_NO_RESOURCE"), "ERROR_BOX", {name: "NotEnougth"});
        } // end while
    };
    _loc1.showPreview = function (item, b)
    {
        if (this._ctrPreview.contentPath == undefined)
        {
            return;
        } // end if
        this._mcFiligrane._visible = this._bFiligraneVisible = b;
        this._ctrPreview._visible = b;
        this._ctrPreview.contentPath = b ? (item.iconFile) : ("");
        this._mcFiligrane.itemName = item.name;
    };
    _loc1.updatePreview = function ()
    {
        var _loc2 = this.api.kernel.GameManager.analyseReceipts(this.getTotalCraftInventory(), this._nSkillId, this._nMaxItem);
        if (_loc2 != undefined)
        {
            this.showPreview(new dofus.datacenter.Item(-1, _loc2, 1, 0, "", 0), true);
        }
        else
        {
            this.showPreview(undefined, false);
        } // end else if
    };
    _loc1.getTotalCraftInventory = function ()
    {
        var _loc2 = this.api.kernel.GameManager;
        return (_loc2.mergeUnicItemInInventory(_loc2.mergeTwoInventory(this._eaLocalDataProvider, this._eaDistantDataProvider)));
    };
    _loc1.switchToPayMode = function (bShow)
    {
        if (bShow == undefined && this._bPayMode == undefined)
        {
            return;
        } // end if
        if (bShow == undefined)
        {
            this._bPayMode = !this._bPayMode;
        }
        else if (this._bPayMode != bShow)
        {
            this._bPayMode = bShow;
        }
        else
        {
            return;
        } // end else if
        this.gapi.removeCursor();
        this._winLocal._visible = !this._bPayMode;
        this._cgLocal._visible = !this._bPayMode;
        this._btnPrivateMessage._visible = !this._bPayMode;
        this._winDistant._visible = !this._bPayMode;
        this._cgDistant._visible = !this._bPayMode;
        this._btnPay._visible = !this._bPayMode;
        this._winCoop._visible = !this._bPayMode;
        this._lblNewObject._visible = !this._bPayMode;
        this._mcFiligrane._visible = this._bPayMode ? (false) : (this._bFiligraneVisible);
        this._ctrPreview._visible = this._bPayMode ? (false) : (this._bFiligraneVisible);
        this._cgCoop._visible = !this._bPayMode;
        this._btnCraft._visible = !this._bPayMode;
        this._btnValidate._visible = !this._bPayMode;
        this._mcArrow._visible = !this._bPayMode;
        this._winPay._visible = this._bPayMode;
        this._btnPrivateMessagePay._visible = this._bPayMode;
        this._btnValidatePay._visible = this._bPayMode;
        this._winItemViewer._y = this._bPayMode ? (83) : (56);
        this._itvItemViewer._y = this._bPayMode ? (87) : (60);
        this._mcBlinkPay._visible = this._bPayMode;
        this._cgPay._visible = this._bPayMode;
        this._lblPayKama._visible = this._bPayMode;
        this._mcPayKama._visible = this._bPayMode;
        this._lblPay._visible = this._bPayMode;
        this._btnPayKama._visible = this._bPayMode && this.isClient;
        this._mcBlinkPayIfSuccess._visible = this._bPayMode;
        this._cgPayIfSuccess._visible = this._bPayMode;
        this._lblPayIfSuccessKama._visible = this._bPayMode;
        this._mcPayIfSuccessKama._visible = this._bPayMode;
        this._lblPayIfSuccess._visible = this._bPayMode;
        this._btnPayIfSuccessKama._visible = this._bPayMode && this.isClient;
        this.switchPayBar();
    };
    _loc1.switchPayBar = function (nPayBar)
    {
        if (nPayBar != undefined)
        {
            this._nPayBar = nPayBar;
        } // end if
        this._mcPayHighlight._visible = this._bPayMode && this.isClient;
        this._mcPayIfSuccessHighlight._visible = this._bPayMode && this.isClient;
        this._mcPayHighlight._alpha = this._nPayBar == 1 ? (100) : (0);
        this._mcPayIfSuccessHighlight._alpha = this._nPayBar == 2 ? (100) : (0);
        if (this.isClient)
        {
            if (this._nPayBar == 1)
            {
                this._cgPayIfSuccess.removeEventListener("dragItem", this);
                this._cgPay.addEventListener("dragItem", this);
            }
            else
            {
                this._cgPay.removeEventListener("dragItem", this);
                this._cgPayIfSuccess.addEventListener("dragItem", this);
            } // end if
        } // end else if
    };
    _loc1.validateKama = function (nQuantity)
    {
        if (nQuantity > this.api.datacenter.Player.Kama)
        {
            nQuantity = this.api.datacenter.Player.Kama;
        } // end if
        this.api.network.Exchange.movementPayKama(this._nPayBar, nQuantity);
    };
    _loc1.askKamaQuantity = function (nPayBar)
    {
        this.switchPayBar(nPayBar);
        var _loc3 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: this.api.datacenter.Exchange.localKama, max: this.api.datacenter.Player.Kama, params: {targetType: "kama"}});
        _loc3.addEventListener("validate", this);
    };
    _loc1.canUseItemInCraft = function (oItem)
    {
        if (this._nForgemagusItemType == undefined || this.isNotForgemagus())
        {
            return (true);
        } // end if
        if (oItem.type == 78)
        {
            return (true);
        } // end if
        var _loc3 = false;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
        {
            if (dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc4] == oItem.unicID)
            {
                return (true);
            } // end if
        } // end while
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
        {
            if (dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc5] == oItem.type)
            {
                return (true);
            } // end if
        } // end while
        if (this._nForgemagusItemType != oItem.type || !oItem.enhanceable)
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.validCraft = function ()
    {
        this.showCraftViewer(false);
        this.recordGarbage();
        this.setReady();
    };
    _loc1.isNotForgemagus = function ()
    {
        return (_global.isNaN(this._nForgemagusItemType));
    };
    _loc1.addCraft = function (nTargetItemId)
    {
        if (this._nLastRegenerateTimer + dofus.graphics.gapi.ui.SecureCraft.NAME_GENERATION_DELAY < getTimer())
        {
            this.api.network.Account.getRandomCharacterName();
            this._nLastRegenerateTimer = getTimer();
        }
        else
        {
            return;
        } // end else if
        var _loc3 = this.api.lang.getSkillText(this._nSkillId).cl;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4];
            if (nTargetItemId == _loc5)
            {
                var _loc6 = this.api.lang.getCraftText(_loc5);
                var _loc8 = 0;
                var _loc9 = new Array();
                var _loc10 = 0;
                
                while (++_loc10, _loc10 < _loc6.length)
                {
                    var _loc11 = _loc6[_loc10];
                    var _loc12 = _loc11[0];
                    var _loc13 = _loc11[1];
                    var _loc7 = false;
                    var _loc14 = 0;
                    
                    while (++_loc14, _loc14 < this._eaDataProvider.length)
                    {
                        if (_loc12 == this._eaDataProvider[_loc14].unicID)
                        {
                            if (_loc13 <= this._eaDataProvider[_loc14].Quantity)
                            {
                                ++_loc8;
                                _loc7 = true;
                                _loc9.push({item: this._eaDataProvider[_loc14], qty: _loc13});
                                break;
                            } // end if
                        } // end if
                    } // end while
                    if (!_loc7)
                    {
                        break;
                    } // end if
                } // end while
                if (_loc7 && _loc6.length == _loc8)
                {
                    var _loc16 = new Array();
                    var _loc18 = 0;
                    
                    while (++_loc18, _loc18 < this._cgLocal.dataProvider.length)
                    {
                        var _loc15 = this._cgLocal.dataProvider[_loc18];
                        var _loc17 = _loc15.Quantity;
                        if (_loc17 < 1 || _loc17 == undefined)
                        {
                            continue;
                        } // end if
                        _loc16.push({Add: false, ID: _loc15.ID, Quantity: _loc17});
                    } // end while
                    var _loc19 = 0;
                    
                    while (++_loc19, _loc19 < _loc9.length)
                    {
                        _loc15 = _loc9[_loc19].item;
                        _loc17 = _loc9[_loc19].qty;
                        if (_loc17 < 1 || _loc17 == undefined)
                        {
                            continue;
                        } // end if
                        _loc16.push({Add: true, ID: _loc15.ID, Quantity: _loc17});
                    } // end while
                    this.api.network.Exchange.movementItems(_loc16);
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("DONT_HAVE_ALL_INGREDIENT"), "ERROR_BOX");
                } // end else if
                break;
            } // end if
        } // end while
    };
    _loc1.kamaChanged = function (oEvent)
    {
        this._lblKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
    };
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._eaLocalDataProvider:
            {
                this.updateLocalData();
                this.updatePreview();
                break;
            } 
            case this._eaDistantDataProvider:
            {
                this.updateDistantData();
                this.updatePreview();
                if (this._eaDistantDataProvider.length > 0)
                {
                    this._cgCoop.dataProvider = new ank.utils.ExtendedArray();
                } // end if
                break;
            } 
            case this._eaDataProvider:
            {
                this.updateData();
                this.updatePreview();
                break;
            } 
            case this._eaCoopDataProvider:
            {
                this.updateCoopData();
                this.updatePreview();
                break;
            } 
            case this._eaPayDataProvider:
            {
                this.updatePayData();
                break;
            } 
            case this._eaPayIfSuccessDataProvider:
            {
                this.updatePayIfSuccessData();
                break;
            } 
            case this._eaReadyDataProvider:
            {
                this.updateReadyState();
                break;
            } 
            default:
            {
                this.updateData();
                this.updateLocalData();
                this.updateDistantData();
                this.updateCoopData();
                this.updatePayData();
                this.updatePayIfSuccessData();
                this.updatePreview();
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnFilterEquipement":
            {
                this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"), oEvent.target, -20);
                break;
            } 
            case "_btnFilterNonEquipement":
            {
                this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"), oEvent.target, -20);
                break;
            } 
            case "_btnFilterRessoureces":
            {
                this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"), oEvent.target, -20);
                break;
            } 
            case "_mcFiligrane":
            {
                if (this._mcFiligrane.itemName != undefined)
                {
                    this.gapi.showTooltip(this._mcFiligrane.itemName, this._ctrPreview, -22);
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.click = function (oEvent)
    {
        if (oEvent.target == this._btnClose)
        {
            this.callClose();
            return;
        } // end if
        if (oEvent.target == this._btnValidate)
        {
            var _loc3 = this.api.kernel.GameManager.analyseReceipts(this.getTotalCraftInventory(), this._nSkillId, this._nMaxItem);
            if (_loc3 == undefined && (this.api.kernel.OptionsManager.getOption("AskForWrongCraft") && this.isNotForgemagus()))
            {
                this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("WRONG_CRAFT_CONFIRM"), "CAUTION_YESNO", {name: "confirmWrongCraft", listener: this});
            }
            else
            {
                this.validCraft();
            } // end else if
            return;
        } // end if
        if (oEvent.target == this._btnCraft)
        {
            this.showCraftViewer(oEvent.target.selected);
            return;
        } // end if
        if (oEvent.target == this._btnPrivateMessage || oEvent.target == this._btnPrivateMessagePay)
        {
            this.api.kernel.GameManager.askPrivateMessage(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name);
        } // end if
        if (oEvent.target == this._btnPay || oEvent.target == this._btnValidatePay)
        {
            this._sCurrentDragSource = undefined;
            this._sCurrentDragTarget = undefined;
            this.switchToPayMode();
        } // end if
        if (oEvent.target != this._btnSelectedFilterButton)
        {
            this._btnSelectedFilterButton.selected = false;
            this._btnSelectedFilterButton = oEvent.target;
            switch (oEvent.target._name)
            {
                case "_btnFilterEquipement":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_EQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                    break;
                } 
                case "_btnFilterNonEquipement":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_NONEQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                    break;
                } 
                case "_btnFilterRessoureces":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_RESSOURECES;
                    this._lblFilter.text = this.api.lang.getText("RESSOURECES");
                    break;
                } 
            } // End of switch
            this.updateData(true);
        }
        else
        {
            oEvent.target.selected = true;
        } // end else if
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
        this._sCurrentDragSource = _loc5;
        switch (_loc5)
        {
            case "_cgGrid":
            {
                if (!this.canDropInGarbage(_loc3))
                {
                    return;
                } // end if
                if (!this.canUseItemInCraft(_loc3))
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("WRONG_ITEM_TYPE"), "ERROR_CHAT");
                    return;
                } // end if
                if (!this._bPayMode)
                {
                    var _loc6 = "_cgLocal";
                }
                else if (this.isClient)
                {
                    _loc6 = this._nPayBar == 1 ? ("_cgPay") : ("_cgPayIfSuccess");
                }
                else
                {
                    return;
                } // end else if
                break;
            } 
            case "_cgLocal":
            {
                _loc6 = "_cgGrid";
                break;
            } 
            case "_cgPay":
            {
                this.switchPayBar(1);
                _loc6 = "_cgGrid";
                break;
            } 
            case "_cgPayIfSuccess":
            {
                this.switchPayBar(2);
                _loc6 = "_cgGrid";
                break;
            } 
        } // End of switch
        this.validateDrop(_loc6, _loc3, _loc4);
    };
    _loc1.dragItem = function (oEvent)
    {
        this.gapi.removeCursor();
        if (oEvent.target.contentData == undefined)
        {
            return;
        } // end if
        this._sCurrentDragSource = oEvent.target._parent._parent._name;
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
                if (!this._bPayMode)
                {
                    if (_loc3.position == -1)
                    {
                        return;
                    } // end if
                } // end if
                break;
            } 
            case "_cgLocal":
            {
                if (_loc3.position == -2)
                {
                    return;
                } // end if
                if (!this.canUseItemInCraft(_loc3))
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("WRONG_ITEM_TYPE"), "ERROR_CHAT");
                    return;
                } // end if
                if (!this.canDropInGarbage(_loc3))
                {
                    return;
                } // end if
                break;
            } 
            case "_cgPay":
            {
                if (this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")
                {
                    return;
                } // end if
                this.switchPayBar(1);
                break;
            } 
            case "_cgPayIfSuccess":
            {
                if (this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")
                {
                    return;
                } // end if
                this.switchPayBar(2);
                break;
            } 
        } // End of switch
        if (_loc3.Quantity > 1 && !(_loc4 == "_cgGrid" && (this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")))
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
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_cbTypes":
            {
                this._nSelectedTypeID = this._cbTypes.selectedItem.id;
                this.api.datacenter.Basics[dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
                this.updateData();
                break;
            } 
        } // End of switch
    };
    _loc1.localKamaChange = function (oEvent)
    {
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "securecraft", this, this.hideButtonValidate, dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.payKamaChange = function (oEvent)
    {
        this.switchToPayMode(true);
        this._mcBlinkPay.play();
        this._nKamaPayment = oEvent.value;
        if (_global.isNaN(this._nKamaPaymentIfSuccess) || this._nKamaPaymentIfSuccess == undefined)
        {
            this._nKamaPaymentIfSuccess = 0;
        } // end if
        if (this.isClient)
        {
            this._lblKama.text = new ank.utils.ExtendedString(this.api.datacenter.Player.Kama - this._nKamaPayment - this._nKamaPaymentIfSuccess).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        } // end if
        this._lblPayKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "securecraft", this, this.hideButtonValidate, dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.payIfSuccessKamaChange = function (oEvent)
    {
        this.switchToPayMode(true);
        this._mcBlinkPayIfSuccess.play();
        this._nKamaPaymentIfSuccess = oEvent.value;
        if (_global.isNaN(this._nKamaPayment) || this._nKamaPayment == undefined)
        {
            this._nKamaPayment = 0;
        } // end if
        if (this.isClient)
        {
            this._lblKama.text = new ank.utils.ExtendedString(this.api.datacenter.Player.Kama - this._nKamaPayment - this._nKamaPaymentIfSuccess).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        } // end if
        this._lblPayIfSuccessKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "securecraft", this, this.hideButtonValidate, dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE, [false]);
    };
    _loc1.yes = function ()
    {
        this.validCraft();
    };
    _loc1.addProperty("distantDataProvider", function ()
    {
    }, _loc1.__set__distantDataProvider);
    _loc1.addProperty("isClient", _loc1.__get__isClient, function ()
    {
    });
    _loc1.addProperty("readyDataProvider", function ()
    {
    }, _loc1.__set__readyDataProvider);
    _loc1.addProperty("coopDataProvider", function ()
    {
    }, _loc1.__set__coopDataProvider);
    _loc1.addProperty("dataProvider", function ()
    {
    }, _loc1.__set__dataProvider);
    _loc1.addProperty("payDataProvider", function ()
    {
    }, _loc1.__set__payDataProvider);
    _loc1.addProperty("skillId", function ()
    {
    }, _loc1.__set__skillId);
    _loc1.addProperty("maxItem", function ()
    {
    }, _loc1.__set__maxItem);
    _loc1.addProperty("payIfSuccessDataProvider", function ()
    {
    }, _loc1.__set__payIfSuccessDataProvider);
    _loc1.addProperty("localDataProvider", function ()
    {
    }, _loc1.__set__localDataProvider);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).CLASS_NAME = "SecureCraft";
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, true, true, false, true, true, true, true, false];
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).READY_COLOR = {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0};
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).NON_READY_COLOR = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).GRID_CONTAINER_WIDTH = 33;
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).DELAY_BEFORE_VALIDATE = 3000;
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).FILTER_TYPE_ONLY_USEFUL = 10000;
    _loc1._bInvalidateCoop = false;
    _loc1._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_RESSOURECES;
    _loc1._nSelectedTypeID = 0;
    _loc1._nLastRegenerateTimer = 0;
    (_global.dofus.graphics.gapi.ui.SecureCraft = function ()
    {
        super();
    }).NAME_GENERATION_DELAY = 1000;
} // end if
#endinitclip
