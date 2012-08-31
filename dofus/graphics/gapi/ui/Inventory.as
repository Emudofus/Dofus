// Action script...

// [Initial MovieClip Action of sprite 824]
#initclip 33
class dofus.graphics.gapi.ui.Inventory extends ank.gapi.core.UIAdvancedComponent
{
    var _eaDataProvider, __get__dataProvider, _itvItemViewer, api, _isvItemSetViewer, gapi, unloadThis, _winBg, addToQueue, getStyle, _cgGrid, _btnFilterEquipement, _btnFilterNonEquipement, _btnFilterRessoureces, _btnFilterQuest, _btnClose, _pbWeight, _lblFilter, _lblNoItem, _lblWeight, _aSelectedSuperTypes, _btnSelectedFilterButton, __set__dataProvider, _mcItvDescBg, _mcItvIconBg, _mcItemSetViewerPlacer, getNextHighestDepth, attachMovie, _nCurrentWeight, _lblKama, _mcArrowAnimation;
    function Inventory()
    {
        super();
    } // End of the function
    function set dataProvider(eaDataProvider)
    {
        _eaDataProvider.removeEventListener("modelChanged", this);
        _eaDataProvider = eaDataProvider;
        _eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.dataProvider());
        null;
    } // End of the function
    function showItemInfos(oItem)
    {
        if (oItem == undefined)
        {
            this.hideItemViewer(true);
            this.hideItemSetViewer(true);
        }
        else
        {
            this.hideItemViewer(false);
            _itvItemViewer.__set__itemData(oItem);
            if (oItem.isFromItemSet)
            {
                var _loc3 = api.datacenter.Player.ItemSets.getItemAt(oItem.itemSetID);
                if (_loc3 == undefined)
                {
                    _loc3 = new dofus.datacenter.ItemSet(oItem.itemSetID, "", []);
                } // end if
                this.hideItemSetViewer(false);
                _isvItemSetViewer.__set__itemSet(_loc3);
            }
            else
            {
                this.hideItemSetViewer(true);
            } // end else if
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Inventory.CLASS_NAME);
        gapi.getUIComponent("Banner").setCurrentTab("Items");
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
        if (api.datacenter.Game.isFight)
        {
            gapi.getUIComponent("Banner").setCurrentTab("Spells");
        } // end if
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        _winBg.onRelease = function ()
        {
        };
        _winBg.useHandCursor = false;
        this.addToQueue({object: this, method: initFilter});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.hideItemViewer(true);
        this.hideItemSetViewer(true);
        Mouse.addListener(this);
        api.datacenter.Player.addEventListener("kamaChanged", this);
        api.datacenter.Player.addEventListener("currentWeightChanged", this);
        api.datacenter.Player.addEventListener("maxWeightChanged", this);
        this.addToQueue({object: this, method: kamaChanged, params: [{value: api.datacenter.Player.Kama}]});
        this.addToQueue({object: this, method: initTexts});
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        this.addToQueue({object: this, method: setSubComponentsStyle, params: [_loc2]});
    } // End of the function
    function setSubComponentsStyle(oStyle)
    {
        _itvItemViewer.__set__styleName(oStyle.itenviewerstyle);
    } // End of the function
    function addListeners()
    {
        _cgGrid.addEventListener("dropItem", this);
        _cgGrid.addEventListener("dragItem", this);
        _cgGrid.addEventListener("selectItem", this);
        _cgGrid.addEventListener("overItem", this);
        _cgGrid.addEventListener("outItem", this);
        _cgGrid.addEventListener("dblClickItem", this);
        _btnFilterEquipement.addEventListener("click", this);
        _btnFilterNonEquipement.addEventListener("click", this);
        _btnFilterRessoureces.addEventListener("click", this);
        _btnFilterQuest.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        _itvItemViewer.addEventListener("useItem", this);
        _itvItemViewer.addEventListener("destroyItem", this);
        _itvItemViewer.addEventListener("targetItem", this);
        _pbWeight.addEventListener("over", this);
        _pbWeight.addEventListener("out", this);
    } // End of the function
    function initTexts()
    {
        _winBg.title = api.lang.getText("INVENTORY");
        _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
        _lblNoItem.__set__text(api.lang.getText("SELECT_ITEM"));
        _lblWeight.__set__text(api.lang.getText("WEIGHT"));
    } // End of the function
    function initFilter()
    {
        switch (api.datacenter.Basics.inventory_filter)
        {
            case "nonequipement":
            {
                _btnFilterNonEquipement.__set__selected(true);
                _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
                _btnSelectedFilterButton = _btnFilterNonEquipement;
                break;
            } 
            case "resources":
            {
                _btnFilterRessoureces.__set__selected(true);
                _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
                _btnSelectedFilterButton = _btnFilterRessoureces;
                break;
            } 
            case "quest":
            {
                _btnFilterQuest.__set__selected(true);
                _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
                _btnSelectedFilterButton = _btnFilterQuest;
                break;
            } 
            case "equipement":
            default:
            {
                _btnFilterEquipement.__set__selected(true);
                _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
                _btnSelectedFilterButton = _btnFilterEquipement;
                break;
            } 
        } // End of switch
    } // End of the function
    function initData()
    {
        this.__set__dataProvider(api.datacenter.Player.Inventory);
        this.currentWeightChanged({value: api.datacenter.Player.currentWeight});
    } // End of the function
    function enabledFromSuperType(oItem)
    {
        var _loc3 = oItem.superType;
        if (_loc3 != undefined)
        {
            for (var _loc7 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
            {
                for (var _loc4 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[_loc7])
                {
                    var _loc2 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[_loc7][_loc4]];
                    _loc2.enabled = false;
                    _loc2.selected = false;
                } // end of for...in
            } // end of for...in
            var _loc8 = api.lang.getItemSuperTypeText(_loc3);
            if (_loc8)
            {
                for (var _loc4 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3])
                {
                    _loc2 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3][_loc4]];
                    _loc2.enabled = true;
                    _loc2.selected = true;
                } // end of for...in
            }
            else
            {
                var _loc5;
                for (var _loc4 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3])
                {
                    _loc2 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3][_loc4]];
                    if (_loc2.contentData == undefined)
                    {
                        _loc5 = _loc2;
                        continue;
                    } // end if
                    if (_loc2.contentData.unicID == oItem.unicID)
                    {
                        return;
                    } // end if
                } // end of for...in
                if (_loc5 != undefined)
                {
                    _loc5.enabled = true;
                    _loc5.selected = true;
                } // end if
            } // end else if
        }
        else
        {
            for (var _loc7 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
            {
                for (var _loc4 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[_loc7])
                {
                    _loc2 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[_loc7][_loc4]];
                    _loc2.enabled = true;
                    if (_loc2.selected)
                    {
                        _loc2.selected = false;
                    } // end if
                } // end of for...in
            } // end of for...in
        } // end else if
    } // End of the function
    function updateData(bOnlyGrid)
    {
        var _loc3 = new Object();
        if (!bOnlyGrid)
        {
            for (var _loc9 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
            {
                for (var _loc6 in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[_loc9])
                {
                    _loc3[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[_loc9][_loc6]] = true;
                } // end of for...in
            } // end of for...in
        } // end if
        var _loc7 = new ank.utils.ExtendedArray();
        for (var _loc9 in _eaDataProvider)
        {
            var _loc2 = _eaDataProvider[_loc9];
            var _loc4 = _loc2.position;
            if (_loc4 != -1)
            {
                if (!bOnlyGrid)
                {
                    var _loc5 = this["_ctr" + _loc4];
                    _loc5.contentData = _loc2;
                    delete _loc3[_loc5._name];
                } // end if
                continue;
            } // end if
            if (_aSelectedSuperTypes[_loc2.superType])
            {
                _loc7.push(_loc2);
            } // end if
        } // end of for...in
        _cgGrid.__set__dataProvider(_loc7);
        if (!bOnlyGrid)
        {
            for (var _loc9 in _loc3)
            {
                this[_loc9].contentData = undefined;
            } // end of for...in
        } // end if
    } // End of the function
    function canMoveItem()
    {
        var _loc2 = api.datacenter.Game.isRunning;
        var _loc3 = api.datacenter.Exchange != undefined;
        if (_loc2 || _loc3)
        {
            gapi.loadUIComponent("AskOk", "AskOkInventory", {title: api.lang.getText("INFORMATIONS"), text: api.lang.getText("CANT_MOVE_ITEM")});
        } // end if
        return (!(_loc2 || _loc3));
    } // End of the function
    function askDestroy(oItem, nQuantity)
    {
        var _loc2 = gapi.loadUIComponent("AskYesNo", "AskYesNoDestroy", {title: api.lang.getText("QUESTION"), text: api.lang.getText("DO_U_DESTROY", [nQuantity, oItem.name]), params: {item: oItem, quantity: nQuantity}});
        _loc2.addEventListener("yes", this);
    } // End of the function
    function hideItemViewer(bHide)
    {
        _itvItemViewer._visible = !bHide;
        _mcItvDescBg._visible = !bHide;
        _mcItvIconBg._visible = !bHide;
    } // End of the function
    function hideItemSetViewer(bHide)
    {
        if (bHide)
        {
            _isvItemSetViewer.removeMovieClip();
        }
        else if (_isvItemSetViewer == undefined)
        {
            this.attachMovie("ItemSetViewer", "_isvItemSetViewer", this.getNextHighestDepth(), {_x: _mcItemSetViewerPlacer._x, _y: _mcItemSetViewerPlacer._y});
        } // end else if
    } // End of the function
    function currentWeightChanged(oEvent)
    {
        var _loc3 = api.datacenter.Player.maxWeight;
        var _loc2 = oEvent.value;
        _nCurrentWeight = _loc2;
        _pbWeight.__set__maximum(_loc3);
        _pbWeight.__set__value(_loc2);
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_pbWeight":
            {
                var _loc3 = oEvent.target.maximum;
                gapi.showTooltip(String(_nCurrentWeight).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + String(_loc3).addMiddleChar(" ", 3), oEvent.target, -20);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function maxWeightChanged(oEvent)
    {
        _pbWeight.__set__maximum(oEvent.value);
    } // End of the function
    function kamaChanged(oEvent)
    {
        _lblKama.__set__text(String(oEvent.value).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3));
    } // End of the function
    function click(oEvent)
    {
        if (oEvent.target == _btnClose)
        {
            this.callClose();
            return;
        } // end if
        if (_mcArrowAnimation._visible)
        {
            _mcArrowAnimation._visible = false;
        } // end if
        if (oEvent.target != _btnSelectedFilterButton)
        {
            _btnSelectedFilterButton.__set__selected(false);
            _btnSelectedFilterButton = oEvent.target;
            switch (oEvent.target._name)
            {
                case "_btnFilterEquipement":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
                    _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
                    api.datacenter.Basics.inventory_filter = "equipement";
                    break;
                } 
                case "_btnFilterNonEquipement":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
                    _lblFilter.__set__text(api.lang.getText("NONEQUIPEMENT"));
                    api.datacenter.Basics.inventory_filter = "nonequipement";
                    break;
                } 
                case "_btnFilterRessoureces":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
                    _lblFilter.__set__text(api.lang.getText("RESSOURECES"));
                    api.datacenter.Basics.inventory_filter = "resources";
                    break;
                } 
                case "_btnFilterQuest":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
                    _lblFilter.__set__text(api.lang.getText("QUEST_OBJECTS"));
                    api.datacenter.Basics.inventory_filter = "quest";
                    break;
                } 
            } // End of switch
            this.updateData(true);
        }
        else
        {
            oEvent.target.selected = true;
        } // end else if
    } // End of the function
    function modelChanged(oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        this.updateData(false);
        this.hideItemViewer(true);
        this.hideItemSetViewer(true);
        
    } // End of the function
    function onMouseUp()
    {
        this.addToQueue({object: this, method: enabledFromSuperType});
    } // End of the function
    function dragItem(oEvent)
    {
        gapi.removeCursor();
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
        if (oEvent.target.contentData.canEquip)
        {
            this.enabledFromSuperType(oEvent.target.contentData);
        }
        else
        {
            this.enabledFromSuperType();
        } // end else if
        gapi.setCursor(oEvent.target.contentData);
    } // End of the function
    function dropItem(oEvent)
    {
        if (!this.canMoveItem())
        {
            return;
        } // end if
        var _loc2 = gapi.getCursor();
        if (_loc2 == undefined)
        {
            return;
        } // end if
        var _loc3;
        if (oEvent.target._parent == this)
        {
            _loc3 = Number(oEvent.target._name.substr(4));
        }
        else
        {
            if (_loc2.position == -1)
            {
                return;
            } // end if
            _loc3 = -1;
        } // end else if
        if (_loc2.position == _loc3)
        {
            return;
        } // end if
        gapi.removeCursor();
        if (_loc2.Quantity > 1 && _loc3 == -1)
        {
            var _loc4 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: _loc2.Quantity, params: {type: "move", position: _loc3, item: _loc2}});
            _loc4.addEventListener("validate", this);
        }
        else
        {
            api.network.Items.movement(_loc2.ID, _loc3);
        } // end else if
    } // End of the function
    function selectItem(oEvent)
    {
        this.showItemInfos(oEvent.target.contentData);
    } // End of the function
    function overItem(oEvent)
    {
        gapi.showTooltip(oEvent.target.contentData.name, oEvent.target, -20, undefined, oEvent.target.contentData.style + "ToolTip");
    } // End of the function
    function outItem(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function dblClickItem(oEvent)
    {
        if (!this.canMoveItem())
        {
            return;
        } // end if
        var _loc2 = oEvent.target.contentData;
        if (_loc2 == undefined)
        {
            return;
        } // end if
        if (_loc2.position == -1)
        {
            if (!_loc2.canUse || !api.datacenter.Player.canUseObject)
            {
                return;
            } // end if
            api.network.Items.use(_loc2.ID);
        }
        else
        {
            api.network.Items.movement(_loc2.ID, -1);
        } // end else if
    } // End of the function
    function dropDownItem()
    {
        if (!this.canMoveItem())
        {
            return;
        } // end if
        var _loc2 = gapi.getCursor();
        if (!_loc2.canDrop)
        {
            gapi.loadUIComponent("AskOk", "AskOkCantDrop", {title: api.lang.getText("IMPOSSIBLE"), text: api.lang.getText("CANT_DROP_ITEM")});
            return;
        } // end if
        if (_loc2.Quantity > 1)
        {
            var _loc3 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, params: {type: "drop", item: _loc2}});
            _loc3.addEventListener("validate", this);
        }
        else
        {
            api.network.Items.drop(_loc2.ID, 1);
        } // end else if
    } // End of the function
    function validate(oEvent)
    {
        switch (oEvent.params.type)
        {
            case "destroy":
            {
                if (oEvent.value > 0 && !isNaN(Number(oEvent.value)))
                {
                    var _loc3 = Math.min(oEvent.value, oEvent.params.item.Quantity);
                    this.askDestroy(oEvent.params.item, _loc3);
                } // end if
                break;
            } 
            case "drop":
            {
                gapi.removeCursor();
                if (oEvent.value > 0 && !isNaN(Number(oEvent.value)))
                {
                    api.network.Items.drop(oEvent.params.item.ID, Math.min(oEvent.value, oEvent.params.item.Quantity));
                } // end if
                break;
            } 
            case "move":
            {
                if (oEvent.value > 0 && !isNaN(Number(oEvent.value)))
                {
                    api.network.Items.movement(oEvent.params.item.ID, oEvent.params.position, Math.min(oEvent.value, oEvent.params.item.Quantity));
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    function useItem(oEvent)
    {
        if (!oEvent.item.canUse || !api.datacenter.Player.canUseObject)
        {
            return;
        } // end if
        api.network.Items.use(oEvent.item.ID);
    } // End of the function
    function destroyItem(oEvent)
    {
        if (oEvent.item.Quantity > 1)
        {
            var _loc3 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, params: {type: "destroy", item: oEvent.item}});
            _loc3.addEventListener("validate", this);
        }
        else
        {
            this.askDestroy(oEvent.item, 1);
        } // end else if
    } // End of the function
    function targetItem(oEvent)
    {
        if (!oEvent.item.canTarget || !api.datacenter.Player.canUseObject)
        {
            return;
        } // end if
        api.kernel.GameManager.switchToItemTarget(oEvent.item);
        this.callClose();
    } // End of the function
    function yes(oEvent)
    {
        api.network.Items.destroy(oEvent.target.params.item.ID, oEvent.target.params.quantity);
    } // End of the function
    static var CLASS_NAME = "Inventory";
    static var CONTAINER_BY_TYPE = {type1: ["_ctr0"], type2: ["_ctr1"], type3: ["_ctr2", "_ctr4"], type4: ["_ctr3"], type5: ["_ctr5"], type9: ["_ctr8"], type10: ["_ctr6"], type11: ["_ctr7"], type12: ["_ctr8"], type13: ["_ctr9", "_ctr10", "_ctr11", "_ctr12", "_ctr13", "_ctr14"]};
    static var FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, false, false, false, true, true, true, true, false];
    static var FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
    static var FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, true, true, false, false, false, false, false];
    static var FILTER_QUEST = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true];
} // End of Class
#endinitclip
