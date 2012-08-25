// Action script...

// [Initial MovieClip Action of sprite 20873]
#initclip 138
if (!dofus.graphics.gapi.ui.ForgemagusCraft)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
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
        super.init(false, dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME);
        this.api.datacenter.Basics.aks_exchange_isForgemagus = true;
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
        this.api.datacenter.Basics.aks_exchange_isForgemagus = false;
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
        this.addToQueue({object: this, method: this.addListeners});
        this._btnSelectedFilterButton = this._btnFilterRessoureces;
        this.addToQueue({object: this, method: this.initData});
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: this.initTexts});
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
        this._ctrItem.addEventListener("dblClick", this);
        this._ctrItem.addEventListener("drag", this);
        this._ctrItem.addEventListener("drop", this);
        this._ctrItem.addEventListener("click", this);
        this._ctrSignature.addEventListener("dblClick", this);
        this._ctrSignature.addEventListener("drag", this);
        this._ctrSignature.addEventListener("drop", this);
        this._ctrSignature.addEventListener("click", this);
        this._ctrRune.addEventListener("dblClick", this);
        this._ctrRune.addEventListener("drag", this);
        this._ctrRune.addEventListener("drop", this);
        this._ctrRune.addEventListener("click", this);
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
        this._btnOneShot.addEventListener("click", this);
        this._btnLoop.addEventListener("click", this);
        this.api.datacenter.Exchange.addEventListener("localKamaChange", this);
        this.api.datacenter.Exchange.addEventListener("distantKamaChange", this);
        this.api.datacenter.Player.addEventListener("kamaChanged", this);
        this.addToQueue({object: this, method: this.kamaChanged, params: [{value: this.api.datacenter.Player.Kama}]});
        this._cbTypes.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
        this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
        this._lblItemTitle.text = this.api.lang.getText("FM_CRAFT_ITEM");
        this._lblRuneTitle.text = this.api.lang.getText("FM_CRAFT_RUNE");
        this._lblSignatureTitle.text = this.api.lang.getText("FM_CRAFT_SIGNATURE");
        this._btnOneShot.label = this.api.lang.getText("APPLY_ONE_RUNE");
        this._btnLoop.label = this.api.lang.getText("APPLY_MULTIPLE_RUNES");
    };
    _loc1.initData = function ()
    {
        this.dataProvider = this.api.datacenter.Exchange.inventory;
        this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
        this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
    };
    _loc1.updateData = function ()
    {
        if (this._bIsLooping)
        {
            return;
        } // end if
        var _loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
        this._ctrItem.contentData = this._ctrRune.contentData = this._ctrSignature.contentData = undefined;
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._eaLocalDataProvider.length)
        {
            var _loc3 = false;
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
            {
                if (dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc4] == this._eaLocalDataProvider[_loc2].unicID)
                {
                    this._ctrSignature.contentData = this._eaLocalDataProvider[_loc2];
                    _loc3 = true;
                    break;
                } // end if
            } // end while
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
            {
                if (dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc5] == this._eaLocalDataProvider[_loc2].type)
                {
                    this._ctrRune.contentData = this._eaLocalDataProvider[_loc2];
                    _loc3 = true;
                    break;
                } // end if
            } // end while
            if (!_loc3)
            {
                this._ctrItem.contentData = this._eaLocalDataProvider[_loc2];
                if (this._ctrItem.contentData != undefined)
                {
                    this.hideItemViewer(false);
                    this._itvItemViewer.itemData = this._ctrItem.contentData;
                } // end if
            } // end if
        } // end while
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
            case "_ctrItem":
            case "_ctrRune":
            case "_ctrSignature":
            {
                var _loc5 = false;
                var _loc6 = false;
                switch (sTargetGrid)
                {
                    case "_ctrItem":
                    {
                        if (this._nForgemagusItemType != oItem.type || !oItem.enhanceable)
                        {
                            return;
                        } // end if
                        var _loc7 = 0;
                        
                        while (++_loc7, _loc7 < this._eaLocalDataProvider.length)
                        {
                            var _loc8 = false;
                            var _loc9 = 0;
                            
                            while (++_loc9, _loc9 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
                            {
                                if (dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc9] == this._eaLocalDataProvider[_loc7].unicID)
                                {
                                    _loc8 = true;
                                } // end if
                            } // end while
                            var _loc10 = 0;
                            
                            while (++_loc10, _loc10 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
                            {
                                if (dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc10] == this._eaLocalDataProvider[_loc7].type)
                                {
                                    _loc8 = true;
                                } // end if
                            } // end while
                            if (!_loc8)
                            {
                                this.api.network.Exchange.movementItem(false, this._eaLocalDataProvider[_loc7].ID, this._eaLocalDataProvider[_loc7].Quantity);
                            } // end if
                        } // end while
                        _loc5 = true;
                        break;
                    } 
                    case "_ctrRune":
                    {
                        var _loc11 = 0;
                        
                        while (++_loc11, _loc11 < this._eaLocalDataProvider.length)
                        {
                            var _loc12 = 0;
                            
                            while (++_loc12, _loc12 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
                            {
                                if (dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc12] == this._eaLocalDataProvider[_loc11].type && this._eaLocalDataProvider[_loc11].unicID != oItem.unicID)
                                {
                                    this.api.network.Exchange.movementItem(false, this._eaLocalDataProvider[_loc11].ID, this._eaLocalDataProvider[_loc11].Quantity);
                                } // end if
                            } // end while
                        } // end while
                        break;
                    } 
                    case "_ctrSignature":
                    {
                        var _loc13 = 0;
                        
                        while (++_loc13, _loc13 < this._eaLocalDataProvider.length)
                        {
                            var _loc14 = 0;
                            
                            while (++_loc14, _loc14 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
                            {
                                if (dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc14] == this._eaLocalDataProvider[_loc13].unicID)
                                {
                                    this.api.network.Exchange.movementItem(false, this._eaLocalDataProvider[_loc13].ID, this._eaLocalDataProvider[_loc13].Quantity);
                                } // end if
                            } // end while
                        } // end while
                        if (this.getCurrentCraftLevel() < 100)
                        {
                            _loc6 = true;
                            this.api.kernel.showMessage(undefined, this.api.lang.getText("CRAFT_LEVEL_DOESNT_ALLOW_A_SIGNATURE"), "ERROR_CHAT");
                        } // end if
                        _loc5 = true;
                        break;
                    } 
                } // End of switch
                if (!_loc6)
                {
                    this.api.network.Exchange.movementItem(true, oItem.ID, _loc5 ? (1) : (nValue));
                } // end if
                break;
            } 
        } // End of switch
        if (this._bInvalidateDistant)
        {
            this.api.datacenter.Exchange.clearDistantGarbage();
            this._bInvalidateDistant = false;
        } // end if
    };
    _loc1.getCurrentCraftLevel = function ()
    {
        var _loc2 = this.api.datacenter.Player.Jobs;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < _loc2[_loc3].skills.length)
            {
                if ((dofus.datacenter.Skill)((dofus.datacenter.Job)(_loc2[_loc3]).skills[_loc4]).id == this._nSkillId)
                {
                    return ((dofus.datacenter.Job)(_loc2[_loc3]).level);
                } // end if
            } // end while
        } // end while
        return (0);
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
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.onCraftLoopEnd = function ()
    {
        this._bIsLooping = false;
        this._nCurrentQuantity = 1;
        this._btnLoop.label = this.api.lang.getText("APPLY_MULTIPLE_RUNES");
        this._btnOneShot.enabled = true;
    };
    _loc1.repeatCraft = function ()
    {
        var _loc2 = this._ctrRune.contentData.Quantity - 1;
        if (_loc2 <= 1)
        {
            return;
        } // end if
        this._bIsLooping = true;
        this.api.network.Exchange.repeatCraft(_loc2);
        this._btnLoop.label = this.api.lang.getText("STOP_WORD");
        this._btnOneShot.enabled = false;
    };
    _loc1.checkIsBaka = function ()
    {
        if (this._ctrItem.contentData == undefined || this._ctrRune.contentData == undefined)
        {
            this.api.kernel.showMessage(this.api.lang.getText("ERROR_WORD"), this.api.lang.getText("FM_ERROR_NO_ITEMS"), "ERROR_BOX");
            return (true);
        } // end if
        return (false);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
            case this._btnOneShot:
            {
                if (this.checkIsBaka())
                {
                    return;
                } // end if
                this.recordGarbage();
                this.setReady();
                break;
            } 
            case this._btnLoop:
            {
                if (this._bIsLooping)
                {
                    this.api.network.Exchange.stopRepeatCraft();
                    return;
                } // end if
                if (this.checkIsBaka())
                {
                    return;
                } // end if
                this.recordGarbage();
                this.setReady();
                this.addToQueue({object: this, method: this.repeatCraft});
                break;
            } 
            case this._ctrItem:
            case this._ctrRune:
            case this._ctrSignature:
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
                            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_EQUIPEMENT;
                            this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                            break;
                        } 
                        case "_btnFilterNonEquipement":
                        {
                            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_NONEQUIPEMENT;
                            this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                            break;
                        } 
                        case "_btnFilterRessoureces":
                        {
                            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_RESSOURECES;
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
                break;
            } 
        } // End of switch
    };
    _loc1.dblClick = function (oEvent)
    {
        oEvent.owner = this._cgLocal;
        this.dblClickItem(oEvent);
    };
    _loc1.drag = function (oEvent)
    {
        this.dragItem(oEvent);
    };
    _loc1.drop = function (oEvent)
    {
        var _loc3 = this.gapi.getCursor();
        if (_loc3 == undefined)
        {
            return;
        } // end if
        this.gapi.removeCursor();
        if (_loc3.position == -2)
        {
            return;
        } // end if
        if (!this.canDropInGarbage(_loc3))
        {
            return;
        } // end if
        var _loc4 = false;
        var _loc5 = false;
        switch (oEvent.target)
        {
            case this._ctrItem:
            {
                _loc5 = true;
                _loc4 = true;
                var _loc6 = 0;
                
                while (++_loc6, _loc6 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
                {
                    if (dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc6] == _loc3.type)
                    {
                        _loc4 = false;
                    } // end if
                } // end while
                var _loc7 = 0;
                
                while (++_loc7, _loc7 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
                {
                    if (dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc7] == _loc3.unicID)
                    {
                        _loc4 = false;
                    } // end if
                } // end while
                break;
            } 
            case this._ctrRune:
            {
                var _loc8 = 0;
                
                while (++_loc8, _loc8 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
                {
                    if (dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc8] == _loc3.type)
                    {
                        _loc4 = true;
                    } // end if
                } // end while
                break;
            } 
            case this._ctrSignature:
            {
                var _loc9 = 0;
                
                while (++_loc9, _loc9 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
                {
                    if (dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc9] == _loc3.unicID)
                    {
                        _loc4 = true;
                    } // end if
                } // end while
                _loc5 = true;
                break;
            } 
        } // End of switch
        if (!_loc4)
        {
            return;
        } // end if
        if (!_loc5 && _loc3.Quantity > 1)
        {
            var _loc10 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: _loc3.Quantity, params: {targetType: "item", oItem: _loc3, targetGrid: oEvent.target._name}});
            _loc10.addEventListener("validate", this);
        }
        else
        {
            this.validateDrop(oEvent.target._name, _loc3, 1);
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
                    var _loc6;
                    var _loc7 = 0;
                    
                    while (++_loc7, _loc7 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length && _loc6 == undefined)
                    {
                        if (dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc7] == _loc3.unicID)
                        {
                            _loc6 = "_ctrSignature";
                        } // end if
                    } // end while
                    var _loc8 = 0;
                    
                    while (++_loc8, _loc8 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length && _loc6 == undefined)
                    {
                        if (dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc8] == _loc3.type)
                        {
                            _loc6 = "_ctrRune";
                        } // end if
                    } // end while
                    if (_loc6 == undefined)
                    {
                        _loc6 = "_ctrItem";
                    } // end if
                    this.validateDrop(_loc6, _loc3, _loc4);
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
            default:
            {
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
                this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
                this.updateData();
                break;
            } 
        } // End of switch
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
    (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
    }).CLASS_NAME = "ForgemagusCraft";
    (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
    }).FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, true, true, false, true, true, true, true, false];
    (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
    }).FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
    }).FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
    }).GRID_CONTAINER_WIDTH = 38;
    (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
    }).TYPES_ALLOWED_AS_COMPONENT = [26, 78];
    (_global.dofus.graphics.gapi.ui.ForgemagusCraft = function ()
    {
        super();
        this._cgLocal._visible = false;
        this._cgDistant._visible = false;
    }).ITEMS_ALLOWED_AS_SIGNATURE = [7508];
    _loc1._bInvalidateDistant = false;
    _loc1._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_RESSOURECES;
    _loc1._nSelectedTypeID = 0;
    _loc1._nCurrentQuantity = 1;
} // end if
#endinitclip
