// Action script...

// [Initial MovieClip Action of sprite 1018]
#initclip 239
class dofus.graphics.gapi.ui.HouseSale extends ank.gapi.core.UIAdvancedComponent
{
    var _oHouse, __get__house, api, addToQueue, _btnCancel, _txtPrice, _btnValidate, _btnClose, _txtDescription, _mcPrice, _lblPrice, _winBackground, gapi, __set__house;
    function HouseSale()
    {
        super();
    } // End of the function
    function set house(oHouse)
    {
        _oHouse = oHouse;
        //return (this.house());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.HouseSale.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        api.network.Houses.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        _btnCancel._visible = false;
        _txtPrice.tabIndex = 0;
        _txtPrice.restrict = "0-9";
    } // End of the function
    function addListeners()
    {
        _btnCancel.addEventListener("click", this);
        _btnValidate.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        Key.addListener(this);
    } // End of the function
    function initData()
    {
        if (_oHouse == undefined)
        {
            return;
        } // end if
        _txtDescription.__set__text(_oHouse.name + "\n\n" + _oHouse.description);
        _txtPrice.text = _oHouse.price;
        if (_oHouse.localOwner)
        {
            _btnCancel._visible = _oHouse.price != 0;
            _mcPrice._visible = true;
            Selection.setFocus(_txtPrice);
        }
        else
        {
            _txtPrice.editable = false;
            _txtPrice.selectable = false;
            _mcPrice._visible = false;
        } // end else if
    } // End of the function
    function initTexts()
    {
        _lblPrice.__set__text(api.lang.getText("PRICE") + " :");
        if (_oHouse.localOwner)
        {
            _winBackground.__set__title(api.lang.getText("HOUSE_SALE"));
            _btnCancel.__set__label(api.lang.getText("CANCEL_THE_SALE"));
            _btnValidate.__set__label(api.lang.getText("VALIDATE"));
        }
        else
        {
            _winBackground.__set__title(api.lang.getText("HOUSE_PURCHASE"));
            _btnValidate.__set__label(api.lang.getText("BUY"));
        } // end else if
    } // End of the function
    function onKeyDown()
    {
        if (Key.getCode() == 13 && Selection.getFocus()._name == "_txtPrice")
        {
            this.click({target: this._btnValidate});
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                if (_oHouse.localOwner)
                {
                    api.network.Houses.sell(0);
                } // end if
                break;
            } 
            case "_btnValidate":
            {
                if (_oHouse.localOwner)
                {
                    api.network.Houses.sell(_txtPrice.text);
                }
                else
                {
                    if (_oHouse.price <= 0)
                    {
                        return;
                    } // end if
                    if (_oHouse.price > api.datacenter.Player.Kama)
                    {
                        gapi.loadUIComponent("AskOk", "AskOkNotRich", {title: api.lang.getText("ERROR_WORD"), text: api.lang.getText("NOT_ENOUGH_RICH")});
                    }
                    else
                    {
                        var _loc2 = gapi.loadUIComponent("AskYesNo", "AskYesNoBuy", {title: api.lang.getText("HOUSE_PURCHASE"), text: api.lang.getText("DO_U_BUY_HOUSE", [_oHouse.name, _oHouse.price])});
                        _loc2.addEventListener("yes", this);
                    } // end else if
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
    function yes()
    {
        api.network.Houses.buy(_oHouse.price);
    } // End of the function
    static var CLASS_NAME = "HouseSale";
} // End of Class
#endinitclip
