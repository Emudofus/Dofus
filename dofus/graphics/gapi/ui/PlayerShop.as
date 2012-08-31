// Action script...

// [Initial MovieClip Action of sprite 822]
#initclip 31
class dofus.graphics.gapi.ui.PlayerShop extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, api, addToQueue, _livInventory, _livInventory2, _btnBuy, _btnClose, _winInventory, _winInventory2, _ldrArtwork, _itvItemViewer, _winItemViewer, _oSelectedItem, _mcBuyArrow, gapi, __set__data;
    function PlayerShop()
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
        super.init(false, dofus.graphics.gapi.ui.PlayerShop.CLASS_NAME);
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
        this.setBuyMode(false);
    } // End of the function
    function addListeners()
    {
        _livInventory.addEventListener("selectedItem", this);
        _livInventory2.addEventListener("selectedItem", this);
        _btnBuy.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        if (_oData != undefined)
        {
            _oData.addEventListener("modelChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
        } // end else if
    } // End of the function
    function initTexts()
    {
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
    function setBuyMode(bActive)
    {
        _btnBuy._visible = bActive;
        _mcBuyArrow._visible = bActive;
    } // End of the function
    function askQuantity()
    {
        var _loc2 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1});
        _loc2.addEventListener("validate", this);
    } // End of the function
    function validateBuy(nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        nQuantity = Math.min(_oSelectedItem.Quantity, nQuantity);
        if (api.datacenter.Player.Kama < _oSelectedItem.price * nQuantity)
        {
            gapi.loadUIComponent("AskOk", "AskOkRich", {title: api.lang.getText("ERROR_WORD"), text: api.lang.getText("NOT_ENOUGH_RICH")});
            return;
        } // end if
        api.network.Exchange.buy(_oSelectedItem.ID, nQuantity);
        this.hideItemViewer(true);
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
                if (_oSelectedItem.Quantity > 1)
                {
                    this.askQuantity();
                }
                else
                {
                    this.validateBuy(1);
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
                    this.setBuyMode(false);
                    _livInventory2.setFilter(_livInventory.__get__currentFilterID());
                    break;
                } 
                case "_livInventory2":
                {
                    this.setBuyMode(true);
                    _livInventory.setFilter(_livInventory2.__get__currentFilterID());
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function validate(oEvent)
    {
        this.validateBuy(oEvent.value);
    } // End of the function
    static var CLASS_NAME = "PlayerShop";
} // End of Class
#endinitclip
