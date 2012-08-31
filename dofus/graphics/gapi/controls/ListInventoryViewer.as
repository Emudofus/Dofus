// Action script...

// [Initial MovieClip Action of sprite 814]
#initclip 12
class dofus.graphics.gapi.controls.ListInventoryViewer extends dofus.graphics.gapi.controls.InventoryViewer
{
    var __get__initialized, __get__displayKamas, __get__displayPrices, attachMovie, _mcLstPlacer, _lstInventory, _oDataViewer, addToQueue, api, _lblFilter, _oKamasProvider, kamaChanged, _lblKama, _mcKamaSymbol, dispatchEvent, __set__displayKamas, __set__displayPrices;
    function ListInventoryViewer()
    {
        super();
    } // End of the function
    function set displayKamas(bDisplayKama)
    {
        _bDisplayKama = bDisplayKama;
        if (this.__get__initialized())
        {
            this.showKamas(bDisplayKama);
        } // end if
        //return (this.displayKamas());
        null;
    } // End of the function
    function set displayPrices(bDisplayPrices)
    {
        if (this.__get__initialized())
        {
            ank.utils.Logger.err("[displayPrices] impossible après init");
            return;
        } // end if
        _bDisplayPrices = bDisplayPrices;
        //return (this.displayPrices());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.ListInventoryViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        var _loc3 = _bDisplayPrices ? ("ListInventoryViewerItem") : ("ListInventoryViewerItemNoPrice");
        this.attachMovie("List", "_lstInventory", 10, {styleName: "LightBrownList", cellRenderer: _loc3, rowHeight: 20});
        _lstInventory.move(_mcLstPlacer._x, _mcLstPlacer._y);
        _lstInventory.setSize(_mcLstPlacer._width, _mcLstPlacer._height);
        _oDataViewer = _lstInventory;
        this.showKamas(_bDisplayKama);
        this.addToQueue({object: this, method: addListeners});
        super.createChildren();
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
    } // End of the function
    function addListeners()
    {
        super.addListeners();
        _lstInventory.addEventListener("itemSelected", this);
    } // End of the function
    function initTexts()
    {
        _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
    } // End of the function
    function initData()
    {
        this.kamaChanged({value: _oKamasProvider.Kama});
    } // End of the function
    function showKamas(bShow)
    {
        _lblKama._visible = bShow;
        _mcKamaSymbol._visible = bShow;
    } // End of the function
    function itemSelected(oEvent)
    {
        this.dispatchEvent({type: "selectedItem", item: oEvent.target.item});
    } // End of the function
    static var CLASS_NAME = "ListInventoryViewer";
    var _bDisplayKama = true;
    var _bDisplayPrices = true;
} // End of Class
#endinitclip
