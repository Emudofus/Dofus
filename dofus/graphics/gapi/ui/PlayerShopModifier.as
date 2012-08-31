// Action script...

// [Initial MovieClip Action of sprite 812]
#initclip 6
class dofus.graphics.gapi.ui.PlayerShopModifier extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, gapi, api, addToQueue, _txtQuantity, _txtPrice, _livInventory, _livInventory2, _btnAdd, _btnRemove, _btnModify, _btnClose, _btnOffline, _lblQuantity, _lblPrice, _winInventory, _winInventory2, _itvItemViewer, _winItemViewer, _mcQuantity, _mcPrice, _oSelectedItem, _mcSellArrow, _oDefaultButton, _mcBuyArrow, __set__data;
    function PlayerShopModifier()
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
        super.init(false, dofus.graphics.gapi.ui.PlayerShopModifier.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        gapi.hideTooltip();
        api.network.Exchange.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        this.hideItemViewer(true);
        this.setAddMode(false);
        this.setModifyMode(false);
        _txtQuantity.restrict = "0-9";
        _txtPrice.restrict = "0-9";
    } // End of the function
    function addListeners()
    {
        _livInventory.addEventListener("selectedItem", this);
        _livInventory2.addEventListener("selectedItem", this);
        _btnAdd.addEventListener("click", this);
        _btnRemove.addEventListener("click", this);
        _btnModify.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        _btnOffline.addEventListener("click", this);
        _btnOffline.addEventListener("over", this);
        _btnOffline.addEventListener("out", this);
        if (_oData != undefined)
        {
            _oData.addEventListener("modelChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
        } // end else if
        Key.addListener(this);
    } // End of the function
    function initTexts()
    {
        _btnAdd.__set__label(api.lang.getText("PUT_ON_SELL"));
        _btnRemove.__set__label(api.lang.getText("REMOVE"));
        _btnModify.__set__label(api.lang.getText("MODIFY"));
        _lblQuantity.text = api.lang.getText("QUANTITY") + " :";
        _lblPrice.text = api.lang.getText("UNIT_PRICE") + " :";
        _winInventory.__set__title(api.datacenter.Player.data.name);
        _winInventory2.__set__title(api.lang.getText("SHOP_STOCK"));
    } // End of the function
    function initData()
    {
        _livInventory.__set__dataProvider(api.datacenter.Player.Inventory);
        _livInventory.__set__kamasProvider(api.datacenter.Player);
        this.modelChanged();
    } // End of the function
    function hideItemViewer(bHide)
    {
        _itvItemViewer._visible = !bHide;
        _winItemViewer._visible = !bHide;
        _mcQuantity._visible = !bHide;
        _mcPrice._visible = !bHide;
        _lblQuantity._visible = !bHide;
        _lblPrice._visible = !bHide;
        _txtQuantity._visible = !bHide;
        _txtPrice._visible = !bHide;
        if (bHide)
        {
            _oSelectedItem = undefined;
        } // end if
    } // End of the function
    function setAddMode(bActive)
    {
        _btnAdd._visible = bActive;
        _mcSellArrow._visible = bActive;
        _mcQuantity._visible = bActive;
        _txtQuantity.editable = true;
        _txtQuantity.selectable = true;
        _txtPrice.tabIndex = 0;
        _txtQuantity.tabIndex = 1;
        _oDefaultButton = _btnAdd;
    } // End of the function
    function setModifyMode(bActive)
    {
        _btnRemove._visible = bActive;
        _btnModify._visible = bActive;
        _mcBuyArrow._visible = bActive;
        _mcQuantity._visible = false;
        _txtQuantity.editable = false;
        _txtQuantity.selectable = false;
        _txtPrice.tabIndex = 0;
        _txtQuantity.tabIndex = undefined;
        _oDefaultButton = _btnModify;
    } // End of the function
    function addToShop(oItem, nQuantity, nPrice)
    {
        api.network.Exchange.movementItem(true, oItem.ID, nQuantity, nPrice);
    } // End of the function
    function remove(oItem)
    {
        api.network.Exchange.movementItem(false, oItem.ID, oItem.Quantity);
    } // End of the function
    function modify(oItem, nPrice)
    {
        api.network.Exchange.movementItem(true, oItem.ID, 0, nPrice);
    } // End of the function
    function onKeyDown()
    {
        if (Key.isDown(13) && _oSelectedItem != undefined)
        {
            this.click({target: _oDefaultButton});
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnRemove":
            {
                this.remove(_oSelectedItem);
                this.hideItemViewer(true);
                this.setModifyMode(false);
                break;
            } 
            case "_btnModify":
            {
                var _loc3 = Number(_txtPrice.text);
                if (isNaN(_loc3))
                {
                    gapi.loadUIComponent("AskOk", "AksOkBadPrice", {title: api.lang.getText("ERROR_WORD"), text: api.lang.getText("ERROR_INVALID_PRICE")});
                }
                else
                {
                    this.modify(_oSelectedItem, _loc3);
                    this.hideItemViewer(true);
                    this.setModifyMode(false);
                } // end else if
                break;
            } 
            case "_btnAdd":
            {
                _loc3 = Number(_txtPrice.text);
                var _loc2 = Number(_txtQuantity.text);
                if (isNaN(_loc3))
                {
                    gapi.loadUIComponent("AskOk", "AksOkBadPrice", {title: api.lang.getText("ERROR_WORD"), text: api.lang.getText("ERROR_INVALID_PRICE")});
                }
                else if (isNaN(_loc2) || _loc2 == 0)
                {
                    gapi.loadUIComponent("AskOk", "AksOkBadQuantity", {title: api.lang.getText("ERROR_WORD"), text: api.lang.getText("ERROR_INVALID_QUANTITY")});
                }
                else
                {
                    _loc2 = Math.min(_oSelectedItem.Quantity, _loc2);
                    this.addToShop(_oSelectedItem, _loc2, _loc3);
                    this.hideItemViewer(true);
                    this.setAddMode(false);
                } // end else if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnOffline":
            {
                this.callClose();
                api.kernel.GameManager.offlineExchange();
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOffline":
            {
                gapi.showTooltip(api.lang.getText("MERCHANT_MODE"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function selectedItem(oEvent)
    {
        if (oEvent.item == undefined)
        {
            this.hideItemViewer(true);
            this.setAddMode(false);
            this.setModifyMode(false);
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
                    _txtQuantity.text = oEvent.item.Quantity;
                    _txtPrice.text = "";
                    this.setModifyMode(false);
                    this.setAddMode(true);
                    _livInventory2.setFilter(_livInventory.__get__currentFilterID());
                    break;
                } 
                case "_livInventory2":
                {
                    _txtQuantity.text = oEvent.item.Quantity;
                    _txtPrice.text = oEvent.item.price;
                    this.setAddMode(false);
                    this.setModifyMode(true);
                    _livInventory.setFilter(_livInventory2.__get__currentFilterID());
                    break;
                } 
            } // End of switch
            Selection.setFocus(_txtPrice);
        } // end else if
    } // End of the function
    function modelChanged(oEvent)
    {
        _livInventory2.__set__dataProvider(_oData.inventory);
    } // End of the function
    static var CLASS_NAME = "PlayerShopModifier";
} // End of Class
#endinitclip
