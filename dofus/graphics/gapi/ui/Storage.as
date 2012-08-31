// Action script...

// [Initial MovieClip Action of sprite 1004]
#initclip 221
class dofus.graphics.gapi.ui.Storage extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, api, addToQueue, _btnClose, _ivInventoryViewer, _ivInventoryViewer2, _winInventory, _winInventory2, _itvItemViewer, _winItemViewer, __set__data;
    function Storage()
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
        super.init(false, dofus.graphics.gapi.ui.Storage.CLASS_NAME);
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
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _ivInventoryViewer.addEventListener("selectedItem", this);
        _ivInventoryViewer.addEventListener("dblClickItem", this);
        _ivInventoryViewer.addEventListener("dropItem", this);
        _ivInventoryViewer.addEventListener("dragKama", this);
        _ivInventoryViewer2.addEventListener("selectedItem", this);
        _ivInventoryViewer2.addEventListener("dblClickItem", this);
        _ivInventoryViewer2.addEventListener("dropItem", this);
        _ivInventoryViewer2.addEventListener("dragKama", this);
        if (_oData != undefined)
        {
            _oData.addEventListener("modelChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[Storage] il n\'y a pas de data");
        } // end else if
    } // End of the function
    function initTexts()
    {
        _winInventory.__set__title(api.datacenter.Player.data.name);
        _winInventory2.__set__title(api.lang.getText("STORAGE"));
    } // End of the function
    function initData()
    {
        _ivInventoryViewer.__set__dataProvider(api.datacenter.Player.Inventory);
        _ivInventoryViewer.__set__kamasProvider(api.datacenter.Player);
        _ivInventoryViewer2.__set__kamasProvider(_oData);
        this.modelChanged();
    } // End of the function
    function hideItemViewer(bHide)
    {
        _itvItemViewer._visible = !bHide;
        _winItemViewer._visible = !bHide;
    } // End of the function
    function click(oEvent)
    {
        this.callClose();
    } // End of the function
    function selectedItem(oEvent)
    {
        if (oEvent.item == undefined)
        {
            this.hideItemViewer(true);
        }
        else
        {
            this.hideItemViewer(false);
            _itvItemViewer.__set__itemData(oEvent.item);
            switch (oEvent.target._name)
            {
                case "_ivInventoryViewer":
                {
                    _ivInventoryViewer2.setFilter(_ivInventoryViewer.__get__currentFilterID());
                    break;
                } 
                case "_ivInventoryViewer2":
                {
                    _ivInventoryViewer.setFilter(_ivInventoryViewer2.__get__currentFilterID());
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function dblClickItem(oEvent)
    {
        var _loc4 = oEvent.item;
        if (_loc4 == undefined)
        {
            return;
        } // end if
        var _loc2 = Key.isDown(17) ? (_loc4.Quantity) : (1);
        switch (oEvent.target._name)
        {
            case "_ivInventoryViewer":
            {
                api.network.Exchange.movementItem(true, oEvent.item.ID, _loc2);
                break;
            } 
            case "_ivInventoryViewer2":
            {
                api.network.Exchange.movementItem(false, oEvent.item.ID, _loc2);
                break;
            } 
        } // End of switch
    } // End of the function
    function modelChanged(oEvent)
    {
        _ivInventoryViewer2.__set__dataProvider(_oData.inventory);
    } // End of the function
    function dropItem(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_ivInventoryViewer":
            {
                api.network.Exchange.movementItem(false, oEvent.item.ID, oEvent.quantity);
                break;
            } 
            case "_ivInventoryViewer2":
            {
                api.network.Exchange.movementItem(true, oEvent.item.ID, oEvent.quantity);
                break;
            } 
        } // End of switch
    } // End of the function
    function dragKama(oEvent)
    {
        switch (oEvent.target)
        {
            case _ivInventoryViewer:
            {
                api.network.Exchange.movementKama(oEvent.quantity);
                break;
            } 
            case _ivInventoryViewer2:
            {
                api.network.Exchange.movementKama(-oEvent.quantity);
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "Storage";
} // End of Class
#endinitclip
