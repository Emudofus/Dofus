// Action script...

// [Initial MovieClip Action of sprite 820]
#initclip 29
class dofus.graphics.gapi.ui.TaxCollectorStorage extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, api, addToQueue, _livInventory, _livInventory2, _btnGetItem, _btnGetKamas, _btnClose, _winInventory, _winInventory2, _ldrArtwork, _itvItemViewer, _winItemViewer, _oSelectedItem, _mcBuyArrow, gapi, __set__data;
    function TaxCollectorStorage()
    {
        super();
    } // End of the function
    function set data(oData)
    {
        _oData = oData;
        //return (this.data());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.TaxCollectorStorage.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        api.network.Exchange.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        this.hideItemViewer(true);
        this.setGetItemMode(false);
    } // End of the function
    function addListeners()
    {
        _livInventory.addEventListener("selectedItem", this);
        _livInventory2.addEventListener("selectedItem", this);
        _btnGetItem.addEventListener("click", this);
        _btnGetKamas.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        if (_oData != undefined)
        {
            _oData.addEventListener("modelChanged", this);
            _oData.addEventListener("kamaChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[TaxCollectorShop] il n\'y a pas de data");
        } // end else if
    } // End of the function
    function initTexts()
    {
        _btnGetItem.__set__label(api.lang.getText("GET_ITEM"));
        _winInventory.__set__title(api.datacenter.Player.data.name);
        _winInventory2.__set__title(_oData.name);
    } // End of the function
    function initData()
    {
        _livInventory.__set__dataProvider(api.datacenter.Player.Inventory);
        _livInventory.__set__kamasProvider(api.datacenter.Player);
        _livInventory2.__set__kamasProvider(_oData);
        _ldrArtwork.__set__contentPath(dofus.Constants.ARTWORKS_BIG_PATH + _oData.gfx + ".swf");
        this.modelChanged();
    } // End of the function
    function hideItemViewer(bHide)
    {
        _itvItemViewer._visible = !bHide;
        _winItemViewer._visible = !bHide;
        if (bHide)
        {
            _oSelectedItem = undefined;
        } // end if
    } // End of the function
    function setGetItemMode(bActive)
    {
        var _loc2 = false;
        var _loc3 = api.datacenter.Player.guildInfos.playerRights;
        switch (_oSelectedItem.superType)
        {
            case 9:
            {
                _loc2 = _loc3.canCollectResources;
                break;
            } 
            default:
            {
                _loc2 = _loc3.canCollectObjects;
                break;
            } 
        } // End of switch
        _btnGetItem._visible = bActive && _loc2;
        _mcBuyArrow._visible = bActive;
    } // End of the function
    function askQuantity(nQuantity, oParams)
    {
        var _loc2 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: nQuantity, params: oParams});
        _loc2.addEventListener("validate", this);
    } // End of the function
    function validateGetItem(nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        nQuantity = Math.min(_oSelectedItem.Quantity, nQuantity);
        api.network.Exchange.movementItem(false, _oSelectedItem.ID, nQuantity);
        this.hideItemViewer(true);
        this.setGetItemMode(false);
    } // End of the function
    function validateKamas(nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        nQuantity = Math.min(_oData.Kama, nQuantity);
        api.network.Exchange.movementKama(-nQuantity);
        this.hideItemViewer(true);
        this.setGetItemMode(false);
    } // End of the function
    function modelChanged(oEvent)
    {
        _livInventory2.__set__dataProvider(_oData.inventory);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnGetItem":
            {
                if (_oSelectedItem.Quantity > 1)
                {
                    this.askQuantity(_oSelectedItem.Quantity, {type: "item"});
                }
                else
                {
                    this.validateGetItem(1);
                } // end else if
                break;
            } 
            case "_btnGetKamas":
            {
                if (api.datacenter.Player.guildInfos.playerRights.canCollectKamas)
                {
                    if (_oData.Kama > 0)
                    {
                        this.askQuantity(_oData.Kama, {type: "kamas"});
                    } // end if
                } // end if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    function selectedItem(oEvent)
    {
        if (oEvent.item == undefined)
        {
            this.hideItemViewer(true);
            this.setGetItemMode(false);
        }
        else
        {
            _oSelectedItem = oEvent.item;
            this.hideItemViewer(false);
            _itvItemViewer.__set__itemData(oEvent.item);
            switch (oEvent.target._name)
            {
                case "_livInventory":
                {
                    this.setGetItemMode(false);
                    _livInventory2.setFilter(_livInventory.__get__currentFilterID());
                    break;
                } 
                case "_livInventory2":
                {
                    this.setGetItemMode(true);
                    _livInventory.setFilter(_livInventory2.__get__currentFilterID());
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function validate(oEvent)
    {
        switch (oEvent.target.params.type)
        {
            case "item":
            {
                this.validateGetItem(oEvent.value);
                break;
            } 
            case "kamas":
            {
                this.validateKamas(oEvent.value);
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "TaxCollectorStorage";
} // End of Class
#endinitclip
