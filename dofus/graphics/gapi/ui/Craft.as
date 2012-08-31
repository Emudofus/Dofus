// Action script...

// [Initial MovieClip Action of sprite 984]
#initclip 201
class dofus.graphics.gapi.ui.Craft extends ank.gapi.core.UIAdvancedComponent
{
    var _nMaxItem, __get__maxItem, _eaDataProvider, __get__dataProvider, _eaLocalDataProvider, __get__localDataProvider, _eaDistantDataProvider, __get__distantDataProvider, gapi, api, _mcPlacer, getNextHighestDepth, _winCraftViewer, addToQueue, _btnFilterRessoureces, _btnSelectedFilterButton, _cgGrid, _cgLocal, _cgDistant, _btnFilterEquipement, _btnFilterNonEquipement, _btnClose, _btnValidate, _btnCraft, _btnMemoryRecall, _lblFilter, _winInventory, _winDistant, _lblNewObject, __set__dataProvider, __set__localDataProvider, __set__distantDataProvider, _winLocal, _nMaxRight, _nDistantToLocalWin, _nLocalWinToCgLocal, _nCgLocalWinLocal, _mcArrow, _nArrowToLocalWin, _nLblNewToDistantWin, _nCgDistantToDistantWin, _itvItemViewer, _winItemViewer, attachMovie, _cvCraftViewer, _aGarbageMemory, __set__maxItem;
    function Craft()
    {
        super();
    } // End of the function
    function set maxItem(nMaxItem)
    {
        _nMaxItem = Number(nMaxItem);
        //return (this.maxItem());
        null;
    } // End of the function
    function set dataProvider(eaDataProvider)
    {
        _eaDataProvider.removeEventListener("modelChange", this);
        _eaDataProvider = eaDataProvider;
        _eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.dataProvider());
        null;
    } // End of the function
    function set localDataProvider(eaLocalDataProvider)
    {
        _eaLocalDataProvider.removeEventListener("modelChange", this);
        _eaLocalDataProvider = eaLocalDataProvider;
        _eaLocalDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.localDataProvider());
        null;
    } // End of the function
    function set distantDataProvider(eaDistantDataProvider)
    {
        _eaDistantDataProvider.removeEventListener("modelChange", this);
        _eaDistantDataProvider = eaDistantDataProvider;
        _eaDistantDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.distantDataProvider());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Craft.CLASS_NAME);
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
    } // End of the function
    function callClose()
    {
        api.network.Exchange.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        _mcPlacer._visible = false;
        _winCraftViewer.swapDepths(this.getNextHighestDepth());
        this.showCraftViewer(false);
        this.showBottom(false);
        this.addToQueue({object: this, method: addListeners});
        _btnSelectedFilterButton = _btnFilterRessoureces;
        this.addToQueue({object: this, method: saveGridMaxSize});
        this.addToQueue({object: this, method: initData});
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: initGridWidth});
    } // End of the function
    function addListeners()
    {
        _cgGrid.addEventListener("dblClickItem", this);
        _cgGrid.addEventListener("dropItem", this);
        _cgGrid.addEventListener("dragItem", this);
        _cgGrid.addEventListener("selectItem", this);
        _cgLocal.addEventListener("dblClickItem", this);
        _cgLocal.addEventListener("dropItem", this);
        _cgLocal.addEventListener("dragItem", this);
        _cgLocal.addEventListener("selectItem", this);
        _cgDistant.addEventListener("selectItem", this);
        _btnFilterEquipement.addEventListener("click", this);
        _btnFilterNonEquipement.addEventListener("click", this);
        _btnFilterRessoureces.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        api.datacenter.Exchange.addEventListener("localKamaChange", this);
        api.datacenter.Exchange.addEventListener("distantKamaChange", this);
        _btnValidate.addEventListener("click", this);
        _btnCraft.addEventListener("click", this);
        _btnMemoryRecall.addEventListener("click", this);
    } // End of the function
    function initTexts()
    {
        _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
        _winInventory.__set__title(api.datacenter.Player.data.name);
        _winDistant.__set__title(api.datacenter.Sprites.getItemAt(api.datacenter.Exchange.distantPlayerID).name);
        _btnValidate.__set__label(api.lang.getText("COMBINE"));
        _btnCraft.__set__label(api.lang.getText("RECEIPTS"));
        _lblNewObject.__set__text(api.lang.getText("CRAFTED_ITEM"));
        _winCraftViewer.__set__title(api.lang.getText("RECEIPTS_FROM_JOB"));
    } // End of the function
    function initData()
    {
        this.__set__dataProvider(api.datacenter.Exchange.inventory);
        this.__set__localDataProvider(api.datacenter.Exchange.localGarbage);
        this.__set__distantDataProvider(api.datacenter.Exchange.distantGarbage);
    } // End of the function
    function saveGridMaxSize()
    {
        _nMaxRight = _winLocal._x + _winLocal.__get__width();
        _nDistantToLocalWin = _winLocal._x - _winDistant._x;
        _nLocalWinToCgLocal = _cgLocal._x - _winLocal._x;
        _nCgLocalWinLocal = _winLocal.__get__width() - _cgLocal.__get__width();
        _nArrowToLocalWin = _winLocal._x - _mcArrow._x;
        _nLblNewToDistantWin = _lblNewObject._x - _winDistant._x;
        _nCgDistantToDistantWin = _cgDistant._x - _winDistant._x;
    } // End of the function
    function showBottom(bShow)
    {
        _winLocal._visible = bShow;
        _mcArrow._visible = bShow;
        _winDistant._visible = bShow;
        _lblNewObject._visible = bShow;
        _cgDistant._visible = bShow;
        _cgLocal._visible = bShow;
    } // End of the function
    function initGridWidth()
    {
        _cgLocal.__set__visibleColumnCount(_nMaxItem);
        if (_nMaxItem == undefined)
        {
            _nMaxItem = 12;
        } // end if
        var _loc2 = dofus.graphics.gapi.ui.Craft.GRID_CONTAINER_WIDTH * _nMaxItem;
        var _loc3 = Math.max(304, _loc2);
        _cgLocal.setSize(_loc2);
        _cgLocal._x = _nMaxRight - _loc2 - _nCgLocalWinLocal / 2;
        _winLocal.setSize(_loc3 + _nCgLocalWinLocal);
        _winLocal._x = _nMaxRight - _loc3 - _nCgLocalWinLocal;
        _mcArrow._x = _winLocal._x - _nArrowToLocalWin;
        _winDistant._x = _winLocal._x - _nDistantToLocalWin;
        _lblNewObject._x = _winDistant._x + _nLblNewToDistantWin;
        _cgDistant._x = _winDistant._x + _nCgDistantToDistantWin;
        this.showBottom(true);
    } // End of the function
    function updateData()
    {
        var _loc4 = new ank.utils.ExtendedArray();
        for (var _loc5 in _eaDataProvider)
        {
            var _loc2 = _eaDataProvider[_loc5];
            var _loc3 = _loc2.position;
            if (_loc3 == -1 && _aSelectedSuperTypes[_loc2.superType])
            {
                _loc4.push(_loc2);
            } // end if
        } // end of for...in
        _cgGrid.__set__dataProvider(_loc4);
    } // End of the function
    function updateLocalData()
    {
        _cgLocal.__set__dataProvider(_eaLocalDataProvider);
    } // End of the function
    function updateDistantData()
    {
        _cgDistant.__set__dataProvider(_eaDistantDataProvider);
        _bInvalidateDistant = true;
    } // End of the function
    function hideItemViewer(bHide)
    {
        _itvItemViewer._visible = !bHide;
        _winItemViewer._visible = !bHide;
    } // End of the function
    function validateDrop(sTargetGrid, oItem, nValue)
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
                api.network.Exchange.movementItem(false, oItem.ID, nValue);
                break;
            } 
            case "_cgLocal":
            {
                api.network.Exchange.movementItem(true, oItem.ID, nValue);
                break;
            } 
        } // End of switch
        if (_bInvalidateDistant)
        {
            api.datacenter.Exchange.clearDistantGarbage();
            _bInvalidateDistant = false;
        } // end if
    } // End of the function
    function setReady()
    {
        if (api.datacenter.Exchange.localGarbage.length == 0)
        {
            return;
        } // end if
        api.network.Exchange.ready();
    } // End of the function
    function canDropInGarbage(oItem)
    {
        var _loc2 = api.datacenter.Exchange.localGarbage.findFirstItem("ID", oItem.ID);
        var _loc3 = api.datacenter.Exchange.localGarbage.length;
        if (_loc2.index == -1 && _loc3 >= _nMaxItem)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function showCraftViewer(bShow)
    {
        if (bShow)
        {
            var _loc2 = this.attachMovie("CraftViewer", "_cvCraftViewer", this.getNextHighestDepth());
            _loc2._x = _mcPlacer._x;
            _loc2._y = _mcPlacer._y;
            _loc2.job = api.datacenter.Player.currentJob;
        }
        else
        {
            _cvCraftViewer.removeMovieClip();
        } // end else if
        _winCraftViewer._visible = bShow;
        _btnCraft.__set__selected(bShow);
    } // End of the function
    function recordGarbage()
    {
        _aGarbageMemory = new Array();
        for (var _loc2 = 0; _loc2 < _eaLocalDataProvider.length; ++_loc2)
        {
            var _loc3 = _eaLocalDataProvider[_loc2];
            _aGarbageMemory.push({id: _loc3.ID, quantity: _loc3.Quantity});
        } // end of for
    } // End of the function
    function cleanGarbage()
    {
        for (var _loc2 = 0; _loc2 < _eaLocalDataProvider.length; ++_loc2)
        {
            var _loc3 = _eaLocalDataProvider[_loc2];
            api.network.Exchange.movementItem(false, _loc3.ID, _loc3.Quantity);
        } // end of for
    } // End of the function
    function recallGarbageMemory()
    {
        if (_aGarbageMemory == undefined || _aGarbageMemory.length == 0)
        {
            return;
        } // end if
        this.cleanGarbage();
        for (var _loc4 = 0; _loc4 < _aGarbageMemory.length; ++_loc4)
        {
            var _loc3 = _aGarbageMemory[_loc4];
            var _loc2 = _eaDataProvider.findFirstItem("ID", _loc3.id);
            if (_loc2.index != -1)
            {
                if (_loc2.item.Quantity >= _loc3.quantity)
                {
                    api.network.Exchange.movementItem(true, _loc2.item.ID, _loc3.quantity);
                }
                else
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CRAFT_NOT_ENOUGHT", [_loc2.item.name]), "ERROR_BOX", {name: "NotEnougth"});
                    return;
                } // end else if
                continue;
            } // end if
            api.kernel.showMessage(undefined, api.lang.getText("CRAFT_NO_RESOURCE"), "ERROR_BOX", {name: "NotEnougth"});
        } // end of for
    } // End of the function
    function modelChanged(oEvent)
    {
        switch (oEvent.target)
        {
            case _eaLocalDataProvider:
            {
                this.updateLocalData();
                break;
            } 
            case _eaDistantDataProvider:
            {
                this.updateDistantData();
                break;
            } 
            case _eaDataProvider:
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
    } // End of the function
    function click(oEvent)
    {
        if (oEvent.target == _btnClose)
        {
            this.callClose();
            return;
        } // end if
        if (oEvent.target == _btnValidate)
        {
            this.showCraftViewer(false);
            this.recordGarbage();
            this.setReady();
            return;
        } // end if
        if (oEvent.target == _btnCraft)
        {
            this.showCraftViewer(oEvent.target.selected);
            return;
        } // end if
        if (oEvent.target == _btnMemoryRecall)
        {
            this.recallGarbageMemory();
            return;
        } // end if
        if (oEvent.target != _btnSelectedFilterButton)
        {
            _btnSelectedFilterButton.__set__selected(false);
            _btnSelectedFilterButton = oEvent.target;
            switch (oEvent.target._name)
            {
                case "_btnFilterEquipement":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_EQUIPEMENT;
                    _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
                    break;
                } 
                case "_btnFilterNonEquipement":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_NONEQUIPEMENT;
                    _lblFilter.__set__text(api.lang.getText("NONEQUIPEMENT"));
                    break;
                } 
                case "_btnFilterRessoureces":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
                    _lblFilter.__set__text(api.lang.getText("RESSOURECES"));
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
    function dblClickItem(oEvent)
    {
        var _loc2 = oEvent.target.contentData;
        if (_loc2 == undefined)
        {
            return;
        } // end if
        var _loc3 = Key.isDown(17) ? (_loc2.Quantity) : (1);
        var _loc4 = oEvent.owner._name;
        switch (_loc4)
        {
            case "_cgGrid":
            {
                if (this.canDropInGarbage(_loc2))
                {
                    this.validateDrop("_cgLocal", _loc2, _loc3);
                } // end if
                break;
            } 
            case "_cgLocal":
            {
                this.validateDrop("_cgGrid", _loc2, _loc3);
                break;
            } 
        } // End of switch
    } // End of the function
    function dragItem(oEvent)
    {
        gapi.removeCursor();
        if (oEvent.target.contentData == undefined)
        {
            return;
        } // end if
        gapi.setCursor(oEvent.target.contentData);
    } // End of the function
    function dropItem(oEvent)
    {
        var _loc4 = gapi.getCursor();
        if (_loc4 == undefined)
        {
            return;
        } // end if
        gapi.removeCursor();
        var _loc2 = oEvent.target._parent._parent._name;
        switch (_loc2)
        {
            case "_cgGrid":
            {
                if (_loc4.position == -1)
                {
                    return;
                } // end if
                break;
            } 
            case "_cgLocal":
            {
                if (_loc4.position == -2)
                {
                    return;
                } // end if
                if (!this.canDropInGarbage(_loc4))
                {
                    return;
                } // end if
                break;
            } 
        } // End of switch
        if (_loc4.Quantity > 1)
        {
            var _loc3 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, params: {targetType: "item", oItem: _loc4, targetGrid: _loc2}});
            _loc3.addEventListener("validate", this);
        }
        else
        {
            this.validateDrop(_loc2, _loc4, 1);
        } // end else if
    } // End of the function
    function selectItem(oEvent)
    {
        if (oEvent.target.contentData == undefined)
        {
            this.hideItemViewer(true);
        }
        else
        {
            this.hideItemViewer(false);
            _itvItemViewer.__set__itemData(oEvent.target.contentData);
        } // end else if
    } // End of the function
    function validate(oEvent)
    {
        switch (oEvent.params.targetType)
        {
            case "item":
            {
                this.validateDrop(oEvent.params.targetGrid, oEvent.params.oItem, oEvent.value);
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "Craft";
    static var FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, false, false, false, true, true, true, true];
    static var FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false];
    static var FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, true, true, false, false, false, false];
    static var GRID_CONTAINER_WIDTH = 38;
    var _bInvalidateDistant = false;
    var _aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
} // End of Class
#endinitclip
