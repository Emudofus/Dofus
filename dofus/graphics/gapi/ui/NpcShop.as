// Action script...

// [Initial MovieClip Action of sprite 823]
#initclip 32
class dofus.graphics.gapi.ui.NpcShop extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, api, addToQueue, gapi, _livInventory, _livInventory2, _btnSell, _btnBuy, _btnClose, _winInventory, _winInventory2, _ldrArtwork, _itvItemViewer, _winItemViewer, _oSelectedItem, _mcSellArrow, _mcBuyArrow, __set__data;
    function NpcShop()
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
        super.init(false, dofus.graphics.gapi.ui.NpcShop.CLASS_NAME);
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
        this.setSellMode(false);
        this.setBuyMode(false);
        gapi.unloadLastUIAutoHideComponent();
    } // End of the function
    function addListeners()
    {
        _livInventory.addEventListener("selectedItem", this);
        _livInventory2.addEventListener("selectedItem", this);
        _btnSell.addEventListener("click", this);
        _btnBuy.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        if (_oData != undefined)
        {
            _oData.addEventListener("modelChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[NpcShop] il n\'y a pas de data");
        } // end else if
    } // End of the function
    function initTexts()
    {
        _btnSell.__set__label(api.lang.getText("SELL"));
        _btnBuy.__set__label(api.lang.getText("BUY"));
        _winInventory.__set__title(api.datacenter.Player.data.name);
        _winInventory2.__set__title(_oData.name);
    } // End of the function
    function initData()
    {
        _livInventory.__set__dataProvider(api.datacenter.Player.Inventory);
        _livInventory.__set__kamasProvider(api.datacenter.Player);
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
    function setSellMode(bActive)
    {
        _btnSell._visible = bActive;
        _mcSellArrow._visible = bActive;
    } // End of the function
    function setBuyMode(bActive)
    {
        _btnBuy._visible = bActive;
        _mcBuyArrow._visible = bActive;
    } // End of the function
    function askQuantity(sType)
    {
        var _loc2 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, params: {type: sType}});
        _loc2.addEventListener("validate", this);
    } // End of the function
    function validateBuy(nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        if (api.datacenter.Player.Kama < _oSelectedItem.price * nQuantity)
        {
            gapi.loadUIComponent("AskOk", "AskOkRich", {title: api.lang.getText("ERROR_WORD"), text: api.lang.getText("NOT_ENOUGH_RICH")});
            return;
        } // end if
        api.network.Exchange.buy(_oSelectedItem.unicID, nQuantity);
    } // End of the function
    function validateSell(nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        if (nQuantity > _oSelectedItem.Quantity)
        {
            nQuantity = _oSelectedItem.Quantity;
        } // end if
        api.network.Exchange.sell(_oSelectedItem.ID, nQuantity);
        this.hideItemViewer(true);
        this.setSellMode(false);
        this.setBuyMode(false);
    } // End of the function
    function modelChanged(oEvent)
    {
        _livInventory2.__set__dataProvider(_oData.inventory);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBuy":
            {
                this.askQuantity("buy");
                break;
            } 
            case "_btnSell":
            {
                if (_oSelectedItem.Quantity > 1)
                {
                    this.askQuantity("sell");
                }
                else
                {
                    this.validateSell(1);
                } // end else if
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
            this.setSellMode(false);
            this.setBuyMode(false);
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
                    this.setSellMode(true);
                    this.setBuyMode(false);
                    _livInventory2.setFilter(_livInventory.__get__currentFilterID());
                    break;
                } 
                case "_livInventory2":
                {
                    this.setSellMode(false);
                    this.setBuyMode(true);
                    _livInventory.setFilter(_livInventory2.__get__currentFilterID());
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function validate(oEvent)
    {
        switch (oEvent.params.type)
        {
            case "sell":
            {
                this.validateSell(oEvent.value);
                break;
            } 
            case "buy":
            {
                this.validateBuy(oEvent.value);
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "NpcShop";
} // End of Class
#endinitclip
