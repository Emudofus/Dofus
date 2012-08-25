// Action script...

// [Initial MovieClip Action of sprite 20879]
#initclip 144
if (!dofus.graphics.gapi.ui.Craft)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } // end if
    }).prototype;
    _loc1.__set__maxItem = function (nMaxItem)
    {
        this._nMaxItem = Number(nMaxItem);
        //return (this.maxItem());
    };
    _loc1.__set__skillId = function (nSkillId)
    {
        this._nSkillId = Number(nSkillId);
        this._btnTries._visible = false;
        this._btnApplyRunes._visible = false;
        if (_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = true;
        } // end if
        this._btnCraft._visible = true;
        this._btnMemoryRecall._visible = true;
        this._btnValidate._visible = true;
        //return (this.skillId());
    };
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
        this._eaLocalDataProvider.removeEventListener("modelChanged", this);
        this._eaLocalDataProvider = eaLocalDataProvider;
        this._eaLocalDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.localDataProvider());
    };
    _loc1.__set__distantDataProvider = function (eaDistantDataProvider)
    {
        this._eaDistantDataProvider.removeEventListener("modelChanged", this);
        this._eaDistantDataProvider = eaDistantDataProvider;
        this._eaDistantDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.distantDataProvider());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Craft.CLASS_NAME);
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
        this._bMakeAll = false;
        this._mcPlacer._visible = false;
        this.showPreview(undefined, false);
        this._winCraftViewer.swapDepths(this.getNextHighestDepth());
        this.showCraftViewer(false);
        this.showBottom(false);
        this.addToQueue({object: this, method: this.addListeners});
        this._btnSelectedFilterButton = this._btnFilterRessoureces;
        this.addToQueue({object: this, method: this.saveGridMaxSize});
        this.addToQueue({object: this, method: this.initData});
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initGridWidth});
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
        this._btnQuantity.addEventListener("click", this);
        this._btnTries.addEventListener("click", this);
        this._btnApplyRunes.addEventListener("click", this);
        this.api.datacenter.Exchange.addEventListener("localKamaChange", this);
        this.api.datacenter.Exchange.addEventListener("distantKamaChange", this);
        this._btnValidate.addEventListener("click", this);
        this._btnCraft.addEventListener("click", this);
        this._btnMemoryRecall.addEventListener("click", this);
        this._ctrPreview.addEventListener("over", this);
        this._ctrPreview.addEventListener("out", this);
        this._cbTypes.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
        this._btnValidate.label = this.api.lang.getText("COMBINE");
        this._btnCraft.label = this.api.lang.getText("RECEIPTS");
        this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": 1";
        this._btnApplyRunes.label = this.api.lang.getText("APPLY_ONE_RUNE");
        this._btnTries.label = this.api.lang.getText("TRIES_WORD") + ": 1";
        this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
        this._winCraftViewer.title = this.api.lang.getText("RECEIPTS_FROM_JOB");
        this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
    };
    _loc1.initData = function ()
    {
        this.dataProvider = this.api.datacenter.Exchange.inventory;
        this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
        this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
    };
    _loc1.saveGridMaxSize = function ()
    {
        this._nMaxRight = this._winLocal._x + this._winLocal.width;
        this._nDistantToLocalWin = this._winLocal._x - this._winDistant._x;
        this._nLocalWinToCgLocal = this._cgLocal._x - this._winLocal._x;
        this._nCgLocalWinLocal = this._winLocal.width - this._cgLocal.width;
        this._nArrowToLocalWin = this._winLocal._x - this._mcArrow._x;
        this._nLblNewToDistantWin = this._lblNewObject._x - this._winDistant._x;
        this._nCgDistantToDistantWin = this._cgDistant._x - this._winDistant._x;
    };
    _loc1.showBottom = function (bShow)
    {
        this._winLocal._visible = bShow;
        this._mcArrow._visible = bShow;
        this._winDistant._visible = bShow;
        this._lblNewObject._visible = bShow;
        this._cgDistant._visible = bShow;
        this._cgLocal._visible = bShow;
    };
    _loc1.initGridWidth = function ()
    {
        this._cgLocal.visibleColumnCount = this._nMaxItem;
        if (this._nMaxItem == undefined)
        {
            this._nMaxItem = 12;
        } // end if
        var _loc2 = dofus.graphics.gapi.ui.Craft.GRID_CONTAINER_WIDTH * this._nMaxItem;
        var _loc3 = Math.max(304, _loc2);
        this._cgLocal.setSize(_loc2);
        this._cgLocal._x = this._nMaxRight - _loc2 - this._nCgLocalWinLocal / 2;
        this._winLocal.setSize(_loc3 + this._nCgLocalWinLocal);
        this._winLocal._x = this._nMaxRight - _loc3 - this._nCgLocalWinLocal;
        this._mcArrow._x = this._winLocal._x - this._nArrowToLocalWin;
        this._winDistant._x = this._winLocal._x - this._nDistantToLocalWin;
        this._lblNewObject._x = this._winDistant._x + this._nLblNewToDistantWin;
        this._cgDistant._x = this._winDistant._x + this._nCgDistantToDistantWin;
        this._ctrPreview._x = this._cgDistant._x;
        this._mcFiligrane._x = this._cgDistant._x;
        this.showBottom(true);
    };
    _loc1.updateData = function ()
    {
        if (this._bIsLooping)
        {
            return;
        } // end if
        var _loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Craft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
                }
                else if (this._nSelectedTypeID == dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL && this.api.kernel.GameManager.isItemUseful(_loc6.unicID, this._nSkillId, this._nMaxItem))
                {
                    _loc3.push(_loc6);
                } // end else if
                var _loc8 = _loc6.type;
                if (_loc5[_loc8] != true)
                {
                    _loc4.push({label: this.api.lang.getItemTypeText(_loc8).n, id: _loc8});
                    _loc5[_loc8] = true;
                } // end if
            } // end if
        } // end of for...in
        _loc4.sortOn("label");
        _loc4.splice(0, 0, {label: this.api.lang.getText("TYPE_FILTER_ONLY_USEFUL"), id: dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL});
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
    };
    _loc1.updateDistantData = function ()
    {
        this._cgDistant.dataProvider = this._eaDistantDataProvider;
        var _loc2 = this._cgDistant.getContainer(0).contentData;
        if (_loc2 != undefined)
        {
            this.hideItemViewer(false);
            this._itvItemViewer.itemData = _loc2;
        } // end if
        this._bInvalidateDistant = true;
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
        if (this._bInvalidateDistant)
        {
            this.api.datacenter.Exchange.clearDistantGarbage();
            this._bInvalidateDistant = false;
        } // end if
    };
    _loc1.setReady = function ()
    {
        if (this.api.datacenter.Exchange.localGarbage.length == 0)
        {
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
    _loc1.addCraft = function (nTargetItemId)
    {
        if (this._nLastRegenerateTimer + dofus.graphics.gapi.ui.Craft.NAME_GENERATION_DELAY < getTimer())
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
                var _loc11 = 0;
                
                while (++_loc11, _loc11 < _loc6.length)
                {
                    var _loc12 = _loc6[_loc11];
                    var _loc13 = _loc12[0];
                    var _loc14 = _loc12[1];
                    var _loc7 = false;
                    var _loc15 = 0;
                    
                    while (++_loc15, _loc15 < this._eaDataProvider.length)
                    {
                        var _loc10 = this._eaDataProvider[_loc15];
                        if (_loc13 == _loc10.unicID)
                        {
                            if (_loc14 <= _loc10.Quantity && _loc10.position == -1)
                            {
                                ++_loc8;
                                _loc7 = true;
                                _loc9.push({item: _loc10, qty: _loc14});
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
                    var _loc17 = new Array();
                    var _loc19 = 0;
                    
                    while (++_loc19, _loc19 < this._cgLocal.dataProvider.length)
                    {
                        var _loc16 = this._cgLocal.dataProvider[_loc19];
                        var _loc18 = _loc16.Quantity;
                        if (_loc18 < 1 || _loc18 == undefined)
                        {
                            continue;
                        } // end if
                        _loc17.push({Add: false, ID: _loc16.ID, Quantity: _loc18});
                    } // end while
                    var _loc20 = 0;
                    
                    while (++_loc20, _loc20 < _loc9.length)
                    {
                        _loc16 = _loc9[_loc20].item;
                        _loc18 = _loc9[_loc20].qty;
                        if (_loc18 < 1 || _loc18 == undefined)
                        {
                            continue;
                        } // end if
                        _loc17.push({Add: true, ID: _loc16.ID, Quantity: _loc18});
                    } // end while
                    this.api.network.Exchange.movementItems(_loc17);
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("DONT_HAVE_ALL_INGREDIENT"), "ERROR_BOX");
                } // end else if
                break;
            } // end if
        } // end while
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
            return (false);
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
                    return (false);
                } // end else if
                continue;
            } // end if
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CRAFT_NO_RESOURCE"), "ERROR_BOX", {name: "NotEnougth"});
            return (false);
        } // end while
        return (true);
    };
    _loc1.nextCraft = function ()
    {
        ank.utils.Timer.setTimer(this, "doNextCraft", this, this.doNextCraft, 250);
    };
    _loc1.doNextCraft = function ()
    {
        if (this.recallGarbageMemory() == false)
        {
            this.stopMakeAll();
        } // end if
    };
    _loc1.stopMakeAll = function ()
    {
        ank.utils.Timer.removeTimer(this, "doNextCraft");
        this._bMakeAll = false;
        this._cgLocal.dataProvider = this.api.datacenter.Exchange.localGarbage;
        this.updateData();
        this.updateDistantData();
    };
    _loc1.showPreview = function (item, b)
    {
        if (this._ctrPreview.contentPath == undefined)
        {
            return;
        } // end if
        this._mcFiligrane._visible = b;
        this._ctrPreview._visible = b;
        this._ctrPreview.contentPath = b ? (item.iconFile) : ("");
        this._mcFiligrane.itemName = item.name;
    };
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._eaLocalDataProvider:
            {
                if (this._bMakeAll)
                {
                    if (this._eaLocalDataProvider.length == 0)
                    {
                        this.nextCraft();
                    }
                    else if (this._aGarbageMemory.length != undefined && this._aGarbageMemory.length == this._eaLocalDataProvider.length)
                    {
                        this.setReady();
                    } // end else if
                }
                else
                {
                    this.updateLocalData();
                    var _loc3 = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider), this._nSkillId, this._nMaxItem);
                    if (_loc3 != undefined)
                    {
                        this.showPreview(new dofus.datacenter.Item(-1, _loc3, 1, 0, "", 0), true);
                    }
                    else
                    {
                        this.showPreview(undefined, false);
                    } // end else if
                } // end else if
                break;
            } 
            case this._eaDistantDataProvider:
            {
                if (!this._bMakeAll && !this._bIsLooping)
                {
                    this.updateDistantData();
                } // end if
                break;
            } 
            case this._eaDataProvider:
            {
                if (!this._bMakeAll && !this._bIsLooping)
                {
                    this.updateData();
                } // end if
                break;
            } 
            default:
            {
                if (!this._bMakeAll && !this._bIsLooping)
                {
                    this.updateData();
                    this.updateLocalData();
                    this.updateDistantData();
                } // end if
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
            case this._ctrPreview:
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
    _loc1.onCraftLoopEnd = function ()
    {
        this._bIsLooping = false;
        this._btnValidate.label = this.api.lang.getText("COMBINE");
        this._nCurrentQuantity = 1;
        this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": 1";
        this._btnTries.label = this.api.lang.getText("TRIES_WORD") + ": 1";
        this._btnApplyRunes.label = this.api.lang.getText("APPLY_ONE_RUNE");
        this.updateData();
    };
    _loc1.repeatCraft = function ()
    {
        this._bIsLooping = true;
        this._btnValidate.label = this._btnApplyRunes.label = this.api.lang.getText("STOP_WORD");
        this.api.network.Exchange.repeatCraft(this._nCurrentQuantity - 1);
    };
    _loc1.click = function (oEvent)
    {
        if (oEvent.target == this._btnClose)
        {
            this.callClose();
            return;
        } // end if
        if (oEvent.target == this._btnQuantity)
        {
            var _loc3 = 99;
            var _loc4 = 0;
            var _loc5 = 10000000;
            var _loc8 = 0;
            
            while (++_loc8, _loc8 < this._eaLocalDataProvider.length)
            {
                var _loc7 = false;
                var _loc9 = 0;
                
                while (++_loc9, _loc9 < this._eaDataProvider.length)
                {
                    if (this._eaLocalDataProvider[_loc8].ID == this._eaDataProvider[_loc9].ID)
                    {
                        _loc7 = true;
                        var _loc6 = Math.floor(this._eaDataProvider[_loc9].Quantity / this._eaLocalDataProvider[_loc8].Quantity);
                        if (_loc6 < _loc5)
                        {
                            _loc5 = _loc6;
                        } // end if
                    } // end if
                } // end while
                if (!_loc7)
                {
                    break;
                } // end if
            } // end while
            if (_loc7)
            {
                _loc4 = 1;
                _loc3 = _loc5 + 1;
                if (_loc4 > _loc5)
                {
                    _loc4 = _loc5;
                } // end if
            }
            else
            {
                _loc3 = 0;
                _loc4 = 0;
            } // end else if
            var _loc10 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: _loc3, params: {targetType: "repeat"}});
            _loc10.addEventListener("validate", this);
            return;
        } // end if
        if (oEvent.target == this._btnTries)
        {
            var _loc11 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: 99, params: {targetType: "tries"}});
            _loc11.addEventListener("validate", this);
            return;
        } // end if
        if (oEvent.target == this._btnValidate || oEvent.target == this._btnApplyRunes)
        {
            if (this._bIsLooping)
            {
                this.api.network.Exchange.stopRepeatCraft();
                return;
            } // end if
            if (this._eaLocalDataProvider.length == 0)
            {
                return;
            } // end if
            var _loc12 = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider), this._nSkillId, this._nMaxItem);
            if (_loc12 == undefined && this.api.kernel.OptionsManager.getOption("AskForWrongCraft"))
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
        if (oEvent.target == this._btnMemoryRecall)
        {
            this.api.network.Exchange.replayCraft();
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
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_EQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                    break;
                } 
                case "_btnFilterNonEquipement":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_NONEQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                    break;
                } 
                case "_btnFilterRessoureces":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
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
    _loc1.validCraft = function ()
    {
        if (this._nCurrentQuantity > 1)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CRAFT_LOOP_START", [this._nCurrentQuantity]), "INFO_CHAT");
            this.showCraftViewer(false);
            this.recordGarbage();
            this.setReady();
            this.addToQueue({object: this, method: this.repeatCraft});
        }
        else
        {
            this.showCraftViewer(false);
            this.recordGarbage();
            this.setReady();
        } // end else if
    };
    _loc1.updateForgemagusResult = function (oItem)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        _loc3.push(oItem);
        this.distantDataProvider = _loc3;
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
                if (this.canDropInGarbage(_loc3))
                {
                    this.validateDrop("_cgLocal", _loc3, _loc4);
                } // end if
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
                if (!this.canDropInGarbage(_loc3))
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
            case "repeat":
            {
                var _loc3 = Number(oEvent.value);
                if (_loc3 < 1 || (_loc3 == undefined || _global.isNaN(_loc3)))
                {
                    _loc3 = 1;
                } // end if
                this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": " + _loc3;
                this._nCurrentQuantity = _loc3;
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
                this.api.datacenter.Basics[dofus.graphics.gapi.ui.Craft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
                this.updateData();
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function ()
    {
        this.validCraft();
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
    _loc1.addProperty("skillId", function ()
    {
    }, _loc1.__set__skillId);
    _loc1.addProperty("maxItem", function ()
    {
    }, _loc1.__set__maxItem);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } } // end if
    }).CLASS_NAME = "Craft";
    (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } } } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } } } // end if
    }).FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, true, true, false, true, true, true, true, false];
    (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } } } } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } } } } // end if
    }).FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } } } } } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } } } } } // end if
    }).FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } } } } } } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } } } } } } // end if
    }).GRID_CONTAINER_WIDTH = 38;
    (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } } } } } } } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } } } } } } } // end if
    }).FILTER_TYPE_ONLY_USEFUL = 10000;
    _loc1._bInvalidateDistant = false;
    _loc1._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
    _loc1._nSelectedTypeID = 0;
    _loc1._nCurrentQuantity = 1;
    _loc1._nLastRegenerateTimer = 0;
    (_global.dofus.graphics.gapi.ui.Craft = function ()
    {
        super();
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
        {
            this._btnQuantity._visible = false;
        } } } } } } } } // end if
        if (!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
        {
            this._btnTries._visible = false;
        } } } } } } } } // end if
    }).NAME_GENERATION_DELAY = 1000;
} // end if
#endinitclip
