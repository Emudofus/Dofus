// Action script...

// [Initial MovieClip Action of sprite 20681]
#initclip 202
if (!dofus.graphics.gapi.ui.Inventory)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Inventory = function ()
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
    _loc1.showCharacterPreview = function (bShow)
    {
        if (bShow)
        {
            this._winPreview._visible = true;
            this._svCharacterViewer._visible = true;
            this._mcItemSetViewerPlacer._x = this._mcBottomPlacer._x;
            this._mcItemSetViewerPlacer._y = this._mcBottomPlacer._y;
            this._isvItemSetViewer._x = this._mcBottomPlacer._x;
            this._isvItemSetViewer._y = this._mcBottomPlacer._y;
        }
        else
        {
            this._winPreview._visible = false;
            this._svCharacterViewer._visible = false;
            this._mcItemSetViewerPlacer._x = this._winPreview._x;
            this._mcItemSetViewerPlacer._y = this._winPreview._y;
            this._isvItemSetViewer._x = this._winPreview._x;
            this._isvItemSetViewer._y = this._winPreview._y;
        } // end else if
    };
    _loc1.showLivingItems = function (bShow)
    {
        this._livItemViewer._visible = bShow;
        this._winLivingItems._visible = bShow;
        if (bShow)
        {
            this._winPreview._visible = false;
            this._svCharacterViewer._visible = false;
            this._mcItemSetViewerPlacer._x = this._mcBottomPlacer._x;
            this._mcItemSetViewerPlacer._y = this._mcBottomPlacer._y;
            this._isvItemSetViewer._x = this._mcBottomPlacer._x;
            this._isvItemSetViewer._y = this._mcBottomPlacer._y;
        }
        else
        {
            this.showCharacterPreview(this.api.kernel.OptionsManager.getOption("CharacterPreview"));
        } // end else if
    };
    _loc1.showItemInfos = function (oItem)
    {
        if (oItem == undefined)
        {
            this.hideItemViewer(true);
            this.hideItemSetViewer(true);
        }
        else
        {
            this.hideItemViewer(false);
            var _loc3 = oItem.clone();
            if (_loc3.realGfx)
            {
                _loc3.gfx = _loc3.realGfx;
            } // end if
            this._itvItemViewer.itemData = _loc3;
            if (oItem.isFromItemSet)
            {
                var _loc4 = this.api.datacenter.Player.ItemSets.getItemAt(oItem.itemSetID);
                if (_loc4 == undefined)
                {
                    _loc4 = new dofus.datacenter.ItemSet(oItem.itemSetID, "", []);
                } // end if
                this.hideItemSetViewer(false);
                this._isvItemSetViewer.itemSet = _loc4;
            }
            else
            {
                this.hideItemSetViewer(true);
            } // end else if
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Inventory.CLASS_NAME);
        this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Items");
        this.showCharacterPreview(this.api.kernel.OptionsManager.getOption("CharacterPreview"));
        this.showLivingItems(false);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
        if (this.api.datacenter.Game.isFight)
        {
            this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
        } // end if
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this._winBg.onRelease = function ()
        {
        };
        this._winBg.useHandCursor = false;
        this._winLivingItems.onRelease = function ()
        {
        };
        this._winLivingItems.useHandCursor = false;
        this.addToQueue({object: this, method: this.hideEpisodicContent});
        this.addToQueue({object: this, method: this.initFilter});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.hideItemViewer(true);
        this.hideItemSetViewer(true);
        this._ctrShield = this._ctr15;
        this._ctrWeapon = this._ctr1;
        this._ctrMount = this._ctr16;
        this._mcTwoHandedLink._visible = false;
        this._mcTwoHandedLink.stop();
        this._mcTwoHandedCrossLeft._visible = false;
        this._mcTwoHandedCrossRight._visible = false;
        Mouse.addListener(this);
        this.api.datacenter.Player.addEventListener("kamaChanged", this);
        this.api.datacenter.Player.addEventListener("mountChanged", this);
        this.addToQueue({object: this, method: this.kamaChanged, params: [{value: this.api.datacenter.Player.Kama}]});
        this.addToQueue({object: this, method: this.mountChanged});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this.addToQueue({object: this, method: this.setSubComponentsStyle, params: [_loc2]});
    };
    _loc1.setSubComponentsStyle = function (oStyle)
    {
        this._itvItemViewer.styleName = oStyle.itenviewerstyle;
    };
    _loc1.hideEpisodicContent = function ()
    {
        if (this.api.datacenter.Basics.aks_current_regional_version < 20)
        {
            this._ctrMount._visible = false;
            this._mcMountCross._visible = false;
        }
        else
        {
            this._ctrMount._visible = true;
        } // end else if
    };
    _loc1.addListeners = function ()
    {
        this._cgGrid.addEventListener("dropItem", this);
        this._cgGrid.addEventListener("dragItem", this);
        this._cgGrid.addEventListener("selectItem", this);
        this._cgGrid.addEventListener("overItem", this);
        this._cgGrid.addEventListener("outItem", this);
        this._cgGrid.addEventListener("dblClickItem", this);
        this._btnFilterEquipement.addEventListener("click", this);
        this._btnFilterNonEquipement.addEventListener("click", this);
        this._btnFilterRessoureces.addEventListener("click", this);
        this._btnFilterQuest.addEventListener("click", this);
        this._btnFilterEquipement.addEventListener("over", this);
        this._btnFilterNonEquipement.addEventListener("over", this);
        this._btnFilterRessoureces.addEventListener("over", this);
        this._btnFilterQuest.addEventListener("over", this);
        this._btnFilterEquipement.addEventListener("out", this);
        this._btnFilterNonEquipement.addEventListener("out", this);
        this._btnFilterRessoureces.addEventListener("out", this);
        this._btnFilterQuest.addEventListener("out", this);
        this._btnClose.addEventListener("click", this);
        this._itvItemViewer.addEventListener("useItem", this);
        this._itvItemViewer.addEventListener("destroyItem", this);
        this._itvItemViewer.addEventListener("targetItem", this);
        this._cbTypes.addEventListener("itemSelected", this);
        for (var a in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
        {
            var _loc2 = dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[a];
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < _loc2.length)
            {
                var _loc4 = this[_loc2[_loc3]];
                _loc4.addEventListener("over", this);
                _loc4.addEventListener("out", this);
                if (_loc4.toolTipText == undefined)
                {
                    _loc4.toolTipText = this.api.lang.getText(_loc4 == this._ctrMount ? ("MOUNT") : ("INVENTORY_" + a.toUpperCase()));
                } // end if
            } // end while
        } // end of for...in
    };
    _loc1.initTexts = function ()
    {
        this._lblWeight.text = this.api.lang.getText("WEIGHT");
        this._winPreview.title = this.api.lang.getText("CHARACTER_PREVIEW", [this.api.datacenter.Player.Name]);
        this._winBg.title = this.api.lang.getText("INVENTORY");
        this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
        this._lblNoItem.text = this.api.lang.getText("SELECT_ITEM");
        this._winLivingItems.title = this.api.lang.getText("MANAGE_ITEM");
    };
    _loc1.initFilter = function ()
    {
        switch (this.api.datacenter.Basics.inventory_filter)
        {
            case "nonequipement":
            {
                this._btnFilterNonEquipement.selected = true;
                this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
                this._btnSelectedFilterButton = this._btnFilterNonEquipement;
                break;
            } 
            case "resources":
            {
                this._btnFilterRessoureces.selected = true;
                this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
                this._btnSelectedFilterButton = this._btnFilterRessoureces;
                break;
            } 
            case "quest":
            {
                this._btnFilterQuest.selected = true;
                this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
                this._btnSelectedFilterButton = this._btnFilterQuest;
                break;
            } 
            case "equipement":
            default:
            {
                this._btnFilterEquipement.selected = true;
                this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
                this._btnSelectedFilterButton = this._btnFilterEquipement;
                break;
            } 
        } // End of switch
    };
    _loc1.initData = function ()
    {
        this._svCharacterViewer.zoom = 250;
        this._svCharacterViewer.spriteData = (ank.battlefield.datacenter.Sprite)(this.api.datacenter.Player.data);
        this.dataProvider = this.api.datacenter.Player.Inventory;
    };
    _loc1.enabledFromSuperType = function (oItem)
    {
        var _loc3 = oItem.superType;
        if (_loc3 != undefined)
        {
            for (var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
            {
                for (var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
                {
                    var _loc4 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
                    _loc4.enabled = false;
                    _loc4.selected = false;
                } // end of for...in
            } // end of for...in
            var _loc5 = this.api.lang.getItemSuperTypeText(_loc3);
            if (_loc5)
            {
                for (var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3])
                {
                    var _loc6 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3][i]];
                    if (_loc3 == 9 && _loc6.contentPath == "")
                    {
                        continue;
                    } // end if
                    _loc6.enabled = true;
                    _loc6.selected = true;
                } // end of for...in
            }
            else
            {
                for (var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3])
                {
                    var _loc8 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3][i]];
                    if (_loc8.contentData == undefined)
                    {
                        var _loc7 = _loc8;
                        continue;
                    } // end if
                    if (_loc8.contentData.unicID == oItem.unicID)
                    {
                        return;
                    } // end if
                } // end of for...in
                if (_loc7 != undefined)
                {
                    _loc7.enabled = true;
                    _loc7.selected = true;
                } // end if
            } // end else if
            if (oItem.needTwoHands)
            {
                this._mcTwoHandedCrossLeft._visible = true;
                this._mcTwoHandedCrossRight._visible = false;
                this._ctrShield.content._alpha = 30;
                this._mcTwoHandedLink.play();
                this._mcTwoHandedLink._visible = true;
            } // end if
            if (_loc3 == 7 && this.api.datacenter.Player.weaponItem.needTwoHands)
            {
                this._mcTwoHandedCrossLeft._visible = false;
                this._mcTwoHandedCrossRight._visible = true;
                this._ctrWeapon.content._alpha = 30;
                this._mcTwoHandedLink.play();
                this._mcTwoHandedLink._visible = true;
            } // end if
        }
        else
        {
            for (var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
            {
                for (var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
                {
                    var _loc9 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
                    _loc9.enabled = true;
                    if (_loc9.selected)
                    {
                        _loc9.selected = false;
                    } // end if
                } // end of for...in
            } // end of for...in
            if (this.api.datacenter.Player.weaponItem.needTwoHands)
            {
                this._mcTwoHandedLink.gotoAndStop(1);
                this._mcTwoHandedLink._visible = true;
                this._mcTwoHandedCrossLeft._visible = true;
            } // end if
        } // end else if
    };
    _loc1.updateData = function (bOnlyGrid)
    {
        var _loc3 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
        this._nSelectedTypeID = _loc3 == undefined ? (0) : (_loc3);
        var _loc4 = new Object();
        if (!bOnlyGrid)
        {
            for (var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
            {
                for (var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
                {
                    _loc4[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]] = true;
                } // end of for...in
            } // end of for...in
        } // end if
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = new ank.utils.ExtendedArray();
        var _loc7 = new Object();
        for (var k in this._eaDataProvider)
        {
            var _loc8 = this._eaDataProvider[k];
            var _loc9 = _loc8.position;
            if (_loc9 != -1)
            {
                if (!bOnlyGrid)
                {
                    var _loc10 = this["_ctr" + _loc9];
                    _loc10.contentData = _loc8;
                    delete _loc4[_loc10._name];
                } // end if
                continue;
            } // end if
            if (this._aSelectedSuperTypes[_loc8.superType])
            {
                if (_loc8.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
                {
                    _loc5.push(_loc8);
                } // end if
                var _loc11 = _loc8.type;
                if (_loc7[_loc11] != true)
                {
                    _loc6.push({label: this.api.lang.getItemTypeText(_loc11).n, id: _loc11});
                    _loc7[_loc11] = true;
                } // end if
            } // end if
        } // end of for...in
        _loc6.sortOn("label");
        _loc6.splice(0, 0, {label: this.api.lang.getText("WITHOUT_TYPE_FILTER"), id: 0});
        this._cbTypes.dataProvider = _loc6;
        this.setType(this._nSelectedTypeID);
        this._cgGrid.dataProvider = _loc5;
        if (!bOnlyGrid)
        {
            for (var k in _loc4)
            {
                if (this[k] != this._ctrMount)
                {
                    this[k].contentData = undefined;
                } // end if
            } // end of for...in
        } // end if
        this.resetTwoHandClip();
    };
    _loc1.resetTwoHandClip = function ()
    {
        this._ctrShield.content._alpha = 100;
        this._ctrWeapon.content._alpha = 100;
        this._mcTwoHandedLink.gotoAndStop(1);
        if (this.api.datacenter.Player.weaponItem.needTwoHands)
        {
            this._mcTwoHandedLink._visible = true;
            this._mcTwoHandedCrossLeft._visible = true;
            this._mcTwoHandedCrossRight._visible = false;
        }
        else
        {
            this._mcTwoHandedLink._visible = false;
            this._mcTwoHandedCrossLeft._visible = false;
            this._mcTwoHandedCrossRight._visible = false;
        } // end else if
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
    _loc1.canMoveItem = function ()
    {
        var _loc2 = this.api.datacenter.Game.isRunning;
        var _loc3 = this.api.datacenter.Exchange != undefined;
        if (_loc2 || _loc3)
        {
            this.gapi.loadUIComponent("AskOk", "AskOkInventory", {title: this.api.lang.getText("INFORMATIONS"), text: this.api.lang.getText("CANT_MOVE_ITEM")});
        } // end if
        return (!(_loc2 || _loc3));
    };
    _loc1.askDestroy = function (oItem, nQuantity)
    {
        var _loc4 = this.gapi.loadUIComponent("AskYesNo", "AskYesNoDestroy", {title: this.api.lang.getText("QUESTION"), text: this.api.lang.getText("DO_U_DESTROY", [nQuantity, oItem.name]), params: {item: oItem, quantity: nQuantity}});
        _loc4.addEventListener("yes", this);
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._mcItvDescBg._visible = !bHide;
        this._mcItvIconBg._visible = !bHide;
    };
    _loc1.hideItemSetViewer = function (bHide)
    {
        if (bHide)
        {
            this._isvItemSetViewer.removeMovieClip();
        }
        else if (this._isvItemSetViewer == undefined)
        {
            this.attachMovie("ItemSetViewer", "_isvItemSetViewer", this.getNextHighestDepth(), {_x: this._mcItemSetViewerPlacer._x, _y: this._mcItemSetViewerPlacer._y});
        } // end else if
    };
    _loc1.kamaChanged = function (oEvent)
    {
        this._lblKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
    };
    _loc1.click = function (oEvent)
    {
        if (oEvent.target == this._btnClose)
        {
            this.callClose();
            return;
        } // end if
        if (this._mcArrowAnimation._visible)
        {
            this._mcArrowAnimation._visible = false;
        } // end if
        if (oEvent.target != this._btnSelectedFilterButton)
        {
            this.api.sounds.events.onInventoryFilterButtonClick();
            this._btnSelectedFilterButton.selected = false;
            this._btnSelectedFilterButton = oEvent.target;
            switch (oEvent.target._name)
            {
                case "_btnFilterEquipement":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                    this.api.datacenter.Basics.inventory_filter = "equipement";
                    break;
                } 
                case "_btnFilterNonEquipement":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
                    this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                    this.api.datacenter.Basics.inventory_filter = "nonequipement";
                    break;
                } 
                case "_btnFilterRessoureces":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
                    this._lblFilter.text = this.api.lang.getText("RESSOURECES");
                    this.api.datacenter.Basics.inventory_filter = "resources";
                    break;
                } 
                case "_btnFilterQuest":
                {
                    this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
                    this._lblFilter.text = this.api.lang.getText("QUEST_OBJECTS");
                    this.api.datacenter.Basics.inventory_filter = "quest";
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
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        this.updateData(false);
        this.hideItemViewer(true);
        this.hideItemSetViewer(true);
        this.showLivingItems(false);
        
    };
    _loc1.onMouseUp = function ()
    {
        this.addToQueue({object: this, method: this.enabledFromSuperType});
    };
    _loc1.dragItem = function (oEvent)
    {
        this.gapi.removeCursor();
        if (!this.canMoveItem())
        {
            return;
        } // end if
        if (oEvent.target.contentData == undefined)
        {
            return;
        } // end if
        if (oEvent.target.contentData.isCursed)
        {
            return;
        } // end if
        this.enabledFromSuperType(oEvent.target.contentData);
        this.gapi.setCursor(oEvent.target.contentData);
    };
    _loc1.dropItem = function (oEvent)
    {
        if (!this.canMoveItem())
        {
            return;
        } // end if
        var _loc3 = this.gapi.getCursor();
        if (_loc3 == undefined)
        {
            return;
        } // end if
        if (oEvent.target._parent == this)
        {
            var _loc4 = Number(oEvent.target._name.substr(4));
        }
        else
        {
            if (_loc3.position == -1)
            {
                this.resetTwoHandClip();
                return;
            } // end if
            _loc4 = -1;
        } // end else if
        if (_loc3.position == _loc4)
        {
            this.resetTwoHandClip();
            return;
        } // end if
        this.gapi.removeCursor();
        if (_loc3.Quantity > 1 && (_loc4 == -1 || _loc4 == 16))
        {
            var _loc5 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: _loc3.Quantity, max: _loc3.Quantity, params: {type: "move", position: _loc4, item: _loc3}});
            _loc5.addEventListener("validate", this);
        }
        else
        {
            this.api.network.Items.movement(_loc3.ID, _loc4);
        } // end else if
    };
    _loc1.selectItem = function (oEvent)
    {
        if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.target.contentData != undefined)
        {
            this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
        }
        else
        {
            this.showItemInfos(oEvent.target.contentData);
            this.showLivingItems(oEvent.target.contentData.skineable == true);
            if (oEvent.target.contentData.skineable)
            {
                this._livItemViewer.itemData = oEvent.target.contentData;
            } // end if
        } // end else if
    };
    _loc1.overItem = function (oEvent)
    {
        this.gapi.showTooltip(oEvent.target.contentData.name, oEvent.target, -20, undefined, oEvent.target.contentData.style + "ToolTip");
    };
    _loc1.outItem = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.dblClickItem = function (oEvent)
    {
        if (!this.canMoveItem())
        {
            return;
        } // end if
        var _loc3 = oEvent.target.contentData;
        if (_loc3 == undefined)
        {
            return;
        } // end if
        if (_loc3.position == -1)
        {
            if (_loc3.canUse && this.api.datacenter.Player.canUseObject)
            {
                this.api.network.Items.use(_loc3.ID);
            }
            else if (this.api.lang.getConfigText("DOUBLE_CLICK_TO_EQUIP"))
            {
                this.equipItem(_loc3);
            } // end else if
        }
        else
        {
            this.api.network.Items.movement(_loc3.ID, -1);
        } // end else if
    };
    _loc1.getFreeSlot = function (oItem)
    {
        var _loc3 = oItem.superType;
        for (var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3])
        {
            if (dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3][i] != "_ctr16")
            {
                if (this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3][i]].contentData == undefined)
                {
                    return (this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3][i]]);
                } // end if
            } // end if
        } // end of for...in
        return;
    };
    _loc1.equipItem = function (oItem)
    {
        if (oItem.position != -1)
        {
            return;
        } // end if
        var _loc3 = oItem.superType;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE.length)
        {
            if (dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE[_loc4] == _loc3)
            {
                return;
            } // end if
        } // end while
        var _loc5 = this.getFreeSlot(oItem);
        if (_loc5 != undefined)
        {
            var _loc6 = Number(_loc5._name.substr(4));
            this.cleanRideIfNecessary(_loc3);
            this.api.network.Items.movement(oItem.ID, _loc6);
        }
        else
        {
            var _loc8 = this.api.lang.getSlotsFromSuperType(oItem.superType);
            var _loc9 = getTimer();
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < _loc8.length)
            {
                if (this.api.kernel.GameManager.getLastModified(_loc8[_loc10]) < _loc9)
                {
                    _loc9 = this.api.kernel.GameManager.getLastModified(_loc8[_loc10]);
                    var _loc7 = _loc8[_loc10];
                } // end if
            } // end while
            if (this["_ctr" + _loc7].contentData.ID == undefined || _global.isNaN(this["_ctr" + _loc7].contentData.ID))
            {
                return;
            } // end if
            if (_loc7 == undefined || _global.isNaN(_loc7))
            {
                return;
            } // end if
            this.cleanRideIfNecessary(_loc3);
            this.api.network.Items.movement(this["_ctr" + _loc7].contentData.ID, -1);
            this.api.network.Items.movement(oItem.ID, _loc7);
        } // end else if
    };
    _loc1.cleanRideIfNecessary = function (nSuperType)
    {
        if (nSuperType == 12 && (!this.api.datacenter.Game.isFight && this.api.datacenter.Player.isRiding))
        {
            this.api.network.Mount.ride();
        } // end if
    };
    _loc1.dropDownItem = function ()
    {
        if (!this.canMoveItem())
        {
            return;
        } // end if
        var _loc2 = this.gapi.getCursor();
        if (!_loc2.canDrop)
        {
            this.gapi.loadUIComponent("AskOk", "AskOkCantDrop", {title: this.api.lang.getText("IMPOSSIBLE"), text: this.api.lang.getText("CANT_DROP_ITEM")});
            return;
        } // end if
        if (_loc2.Quantity > 1)
        {
            var _loc3 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: _loc2.Quantity, params: {type: "drop", item: _loc2}});
            _loc3.addEventListener("validate", this);
        }
        else if (this.api.kernel.OptionsManager.getOption("ConfirmDropItem"))
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CONFIRM_DROP_ITEM"), "CAUTION_YESNO", {name: "ConfirmDropOne", params: {item: _loc2}, listener: this});
        }
        else
        {
            this.api.network.Items.drop(_loc2.ID, 1);
        } // end else if
    };
    _loc1.validate = function (oEvent)
    {
        switch (oEvent.params.type)
        {
            case "destroy":
            {
                if (oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
                {
                    var _loc3 = Math.min(oEvent.value, oEvent.params.item.Quantity);
                    this.askDestroy(oEvent.params.item, _loc3);
                } // end if
                break;
            } 
            case "drop":
            {
                this.gapi.removeCursor();
                if (oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
                {
                    if (this.api.kernel.OptionsManager.getOption("ConfirmDropItem"))
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("CONFIRM_DROP_ITEM"), "CAUTION_YESNO", {name: "ConfirmDrop", params: {item: oEvent.params.item, minValue: oEvent.value}, listener: this});
                    }
                    else
                    {
                        this.api.network.Items.drop(oEvent.params.item.ID, Math.min(oEvent.value, oEvent.params.item.Quantity));
                    } // end if
                } // end else if
                break;
            } 
            case "move":
            {
                if (oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
                {
                    this.api.network.Items.movement(oEvent.params.item.ID, oEvent.params.position, Math.min(oEvent.value, oEvent.params.item.Quantity));
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.useItem = function (oEvent)
    {
        if (!oEvent.item.canUse || !this.api.datacenter.Player.canUseObject)
        {
            return;
        } // end if
        this.api.network.Items.use(oEvent.item.ID);
    };
    _loc1.destroyItem = function (oEvent)
    {
        if (oEvent.item.Quantity > 1)
        {
            var _loc3 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: oEvent.item.Quantity, params: {type: "destroy", item: oEvent.item}});
            _loc3.addEventListener("validate", this);
        }
        else
        {
            this.askDestroy(oEvent.item, 1);
        } // end else if
    };
    _loc1.targetItem = function (oEvent)
    {
        if (!oEvent.item.canTarget || !this.api.datacenter.Player.canUseObject)
        {
            return;
        } // end if
        this.api.kernel.GameManager.switchToItemTarget(oEvent.item);
        this.callClose();
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoConfirmDropOne":
            {
                this.api.network.Items.drop(oEvent.target.params.item.ID, 1);
                break;
            } 
            case "AskYesNoConfirmDrop":
            {
                this.api.network.Items.drop(oEvent.params.item.ID, Math.min(oEvent.params.minValue, oEvent.params.item.Quantity));
                break;
            } 
            default:
            {
                this.api.network.Items.destroy(oEvent.target.params.item.ID, oEvent.target.params.quantity);
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
                this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
                this.updateData();
                break;
            } 
        } // End of switch
    };
    _loc1.mountChanged = function (oEvent)
    {
        var _loc3 = this.api.datacenter.Player.mount;
        if (_loc3 != undefined)
        {
            this._ctrMount.contentPath = "UI_InventoryMountIcon";
            this._mcMountCross._visible = false;
        }
        else
        {
            this._ctrMount.contentPath = "";
            this._mcMountCross._visible = true;
        } // end else if
        this.hideEpisodicContent();
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
            case this._btnFilterQuest:
            {
                this.api.ui.showTooltip(this.api.lang.getText("QUEST_OBJECTS"), oEvent.target, -20);
                break;
            } 
            default:
            {
                this.api.ui.showTooltip(oEvent.target.toolTipText, oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.addProperty("dataProvider", function ()
    {
    }, _loc1.__set__dataProvider);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Inventory = function ()
    {
        super();
    }).CLASS_NAME = "Inventory";
    (_global.dofus.graphics.gapi.ui.Inventory = function ()
    {
        super();
    }).CONTAINER_BY_TYPE = {type1: ["_ctr0"], type2: ["_ctr1"], type3: ["_ctr2", "_ctr4"], type4: ["_ctr3"], type5: ["_ctr5"], type6: ["_ctrMount"], type8: ["_ctr1"], type9: ["_ctr8", "_ctrMount"], type10: ["_ctr6"], type11: ["_ctr7"], type12: ["_ctr8", "_ctr16"], type13: ["_ctr9", "_ctr10", "_ctr11", "_ctr12", "_ctr13", "_ctr14"], type7: ["_ctr15"]};
    (_global.dofus.graphics.gapi.ui.Inventory = function ()
    {
        super();
    }).SUPERTYPE_NOT_EQUIPABLE = [9, 14, 15, 16, 17, 18, 6, 19, 21, 20, 8, 22];
    (_global.dofus.graphics.gapi.ui.Inventory = function ()
    {
        super();
    }).FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, true, true, false, true, true, true, true, false];
    (_global.dofus.graphics.gapi.ui.Inventory = function ()
    {
        super();
    }).FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.Inventory = function ()
    {
        super();
    }).FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false];
    (_global.dofus.graphics.gapi.ui.Inventory = function ()
    {
        super();
    }).FILTER_QUEST = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true];
    _loc1._nSelectedTypeID = 0;
} // end if
#endinitclip
