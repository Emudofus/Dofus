// Action script...

// [Initial MovieClip Action of sprite 1075]
#initclip 45
class dofus.graphics.gapi.controls.GridInventoryViewer extends dofus.graphics.gapi.controls.InventoryViewer
{
    var _cgGrid, _oDataViewer, addToQueue, api, _lblFilter, modelChanged, _oKamasProvider, kamaChanged, dispatchEvent, gapi;
    function GridInventoryViewer()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.GridInventoryViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _oDataViewer = _cgGrid;
        this.addToQueue({object: this, method: addListeners});
        super.createChildren();
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
    } // End of the function
    function addListeners()
    {
        super.addListeners();
        _cgGrid.addEventListener("dropItem", this);
        _cgGrid.addEventListener("dragItem", this);
        _cgGrid.addEventListener("selectItem", this);
        _cgGrid.addEventListener("overItem", this);
        _cgGrid.addEventListener("outItem", this);
        _cgGrid.addEventListener("dblClickItem", this);
    } // End of the function
    function initTexts()
    {
        _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
    } // End of the function
    function initData()
    {
        this.modelChanged();
        this.kamaChanged({value: _oKamasProvider.Kama});
    } // End of the function
    function validateDrop(targetGrid, oItem, nQuantity)
    {
        nQuantity = Number(nQuantity);
        if (nQuantity < 1 || isNaN(nQuantity))
        {
            return;
        } // end if
        if (nQuantity > oItem.Quantity)
        {
            nQuantity = oItem.Quantity;
        } // end if
        this.dispatchEvent({type: "dropItem", item: oItem, quantity: nQuantity});
    } // End of the function
    function validateKama(nQuantity)
    {
        nQuantity = Number(nQuantity);
        if (nQuantity < 1 || isNaN(nQuantity))
        {
            return;
        } // end if
        if (nQuantity > _oKamasProvider.Kama)
        {
            nQuantity = _oKamasProvider.Kama;
        } // end if
        this.dispatchEvent({type: "dragKama", quantity: nQuantity});
    } // End of the function
    function askKamaQuantity()
    {
        var _loc3 = _oKamasProvider.Kama != undefined ? (Number(_oKamasProvider.Kama)) : (0);
        var _loc2 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: _loc3, params: {targetType: "kama"}});
        _loc2.addEventListener("validate", this);
    } // End of the function
    function dragItem(oEvent)
    {
        if (oEvent.target.contentData == undefined)
        {
            return;
        } // end if
        gapi.removeCursor();
        gapi.setCursor(oEvent.target.contentData);
    } // End of the function
    function dropItem(oEvent)
    {
        var _loc3 = gapi.getCursor();
        if (_loc3 == undefined)
        {
            return;
        } // end if
        gapi.removeCursor();
        if (_loc3.Quantity > 1)
        {
            var _loc2 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, params: {targetType: "item", oItem: _loc3}});
            _loc2.addEventListener("validate", this);
        }
        else
        {
            this.validateDrop(_cgGrid, _loc3, 1);
        } // end else if
    } // End of the function
    function selectItem(oEvent)
    {
        this.dispatchEvent({type: "selectedItem", item: oEvent.target.contentData});
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
        this.dispatchEvent({type: oEvent.type, item: oEvent.target.contentData, target: this});
    } // End of the function
    function validate(oEvent)
    {
        switch (oEvent.params.targetType)
        {
            case "item":
            {
                this.validateDrop(_cgGrid, oEvent.params.oItem, oEvent.value);
                break;
            } 
            case "kama":
            {
                this.validateKama(oEvent.value);
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "GridInventoryViewer";
} // End of Class
#endinitclip
