// Action script...

// [Initial MovieClip Action of sprite 986]
#initclip 203
class dofus.graphics.gapi.ui.Exchange extends ank.gapi.core.UIAdvancedComponent
{
    var _eaDataProvider, __get__dataProvider, _eaLocalDataProvider, __get__localDataProvider, _eaDistantDataProvider, __get__distantDataProvider, _eaReadyDataProvider, __get__readyDataProvider, api, addToQueue, _btnFilterEquipement, _btnSelectedFilterButton, _btnPrivateChat, gapi, _cgGrid, _cgLocal, _cgDistant, _btnFilterNonEquipement, _btnFilterRessoureces, _btnClose, _btnValidate, _lblFilter, _winInventory, _winDistant, _lblKama, __set__dataProvider, __set__localDataProvider, __set__distantDataProvider, __set__readyDataProvider, _winLocal, setMovieClipTransform, _itvItemViewer, _winItemViewer, _lblLocalKama, _mcBlink, _lblDistantKama;
    function Exchange()
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
    function set readyDataProvider(eaReadyDataProvider)
    {
        _eaReadyDataProvider.removeEventListener("modelChange", this);
        _eaReadyDataProvider = eaReadyDataProvider;
        _eaReadyDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        //return (this.readyDataProvider());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Exchange.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        api.network.Exchange.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        _btnSelectedFilterButton = _btnFilterEquipement;
        this.addToQueue({object: this, method: initData});
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: initTexts});
        _btnPrivateChat._visible = api.datacenter.Exchange.distantPlayerID > 0;
        gapi.unloadLastUIAutoHideComponent();
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
        _btnPrivateChat.addEventListener("click", this);
    } // End of the function
    function initTexts()
    {
        _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
        _winInventory.__set__title(api.datacenter.Player.data.name);
        _winDistant.__set__title(api.datacenter.Sprites.getItemAt(api.datacenter.Exchange.distantPlayerID).name);
        _btnValidate.__set__label(api.lang.getText("ACCEPT"));
        _lblKama.__set__text(String(api.datacenter.Player.Kama).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3));
        _btnPrivateChat.__set__label(api.lang.getText("WISPER_MESSAGE"));
    } // End of the function
    function initData()
    {
        this.__set__dataProvider(api.datacenter.Exchange.inventory);
        this.__set__localDataProvider(api.datacenter.Exchange.localGarbage);
        this.__set__distantDataProvider(api.datacenter.Exchange.distantGarbage);
        this.__set__readyDataProvider(api.datacenter.Exchange.readyStates);
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
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    } // End of the function
    function updateDistantData()
    {
        _cgDistant.__set__dataProvider(_eaDistantDataProvider);
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    } // End of the function
    function updateReadyState()
    {
        var _loc2;
        _loc2 = _eaReadyDataProvider[0] ? (dofus.graphics.gapi.ui.Exchange.READY_COLOR) : (dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR);
        this.setMovieClipTransform(_winLocal, _loc2);
        this.setMovieClipTransform(_btnValidate, _loc2);
        this.setMovieClipTransform(_cgLocal, _loc2);
        _loc2 = _eaReadyDataProvider[1] ? (dofus.graphics.gapi.ui.Exchange.READY_COLOR) : (dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR);
        this.setMovieClipTransform(_winDistant, _loc2);
        this.setMovieClipTransform(_cgDistant, _loc2);
    } // End of the function
    function hideButtonValidate(bHide)
    {
        var _loc2 = bHide ? (dofus.graphics.gapi.ui.Exchange.READY_COLOR) : (dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR);
        this.setMovieClipTransform(_btnValidate, _loc2);
        _btnValidate.__set__enabled(!bHide);
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
    } // End of the function
    function validateKama(nQuantity)
    {
        if (nQuantity > api.datacenter.Player.Kama)
        {
            nQuantity = api.datacenter.Player.Kama;
        } // end if
        api.network.Exchange.movementKama(nQuantity);
    } // End of the function
    function askKamaQuantity()
    {
        var _loc2 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: api.datacenter.Exchange.localKama, params: {targetType: "kama"}});
        _loc2.addEventListener("validate", this);
    } // End of the function
    function modelChanged(oEvent)
    {
        switch (oEvent.target)
        {
            case _eaReadyDataProvider:
            {
                this.updateReadyState();
                break;
            } 
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
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnValidate":
            {
                api.network.Exchange.ready();
                break;
            } 
            case "_btnPrivateChat":
            {
                if (api.datacenter.Exchange.distantPlayerID > 0)
                {
                    api.kernel.GameManager.askPrivateMessage(api.datacenter.Sprites.getItemAt(api.datacenter.Exchange.distantPlayerID).name);
                } // end if
                break;
            } 
            default:
            {
                if (oEvent.target != _btnSelectedFilterButton)
                {
                    _btnSelectedFilterButton.__set__selected(false);
                    _btnSelectedFilterButton = oEvent.target;
                    switch (oEvent.target._name)
                    {
                        case "_btnFilterEquipement":
                        {
                            _aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
                            _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
                            break;
                        } 
                        case "_btnFilterNonEquipement":
                        {
                            _aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_NONEQUIPEMENT;
                            _lblFilter.__set__text(api.lang.getText("NONEQUIPEMENT"));
                            break;
                        } 
                        case "_btnFilterRessoureces":
                        {
                            _aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_RESSOURECES;
                            _lblFilter.__set__text(api.lang.getText("RESSOURECES"));
                            break;
                        } 
                    } // End of switch
                    this.updateData(true);
                    break;
                } // end if
                oEvent.target.selected = true;
            } 
        } // End of switch
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
                this.validateDrop("_cgLocal", _loc2, _loc3);
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
            case "kama":
            {
                this.validateKama(oEvent.value);
                break;
            } 
        } // End of switch
    } // End of the function
    function localKamaChange(oEvent)
    {
        _lblLocalKama.__set__text(String(oEvent.value).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3));
        _lblKama.__set__text(String(api.datacenter.Player.Kama - oEvent.value).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3));
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    } // End of the function
    function distantKamaChange(oEvent)
    {
        _mcBlink.play();
        _lblDistantKama.__set__text(String(oEvent.value).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3));
        this.hideButtonValidate(true);
        ank.utils.Timer.setTimer(this, "exchange", this, hideButtonValidate, dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE, [false]);
    } // End of the function
    static var CLASS_NAME = "Exchange";
    static var FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, false, false, false, true, true, true, true];
    static var FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false];
    static var FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, true, true, false, false, false, false];
    static var READY_COLOR = {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0};
    static var NON_READY_COLOR = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    static var DELAY_BEFORE_VALIDATE = 3000;
    var _nDistantReadyState = false;
    var _aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
} // End of Class
#endinitclip
