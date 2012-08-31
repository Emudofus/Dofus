// Action script...

// [Initial MovieClip Action of sprite 275]
#initclip 198
class ank.gapi.controls.DataGrid extends ank.gapi.core.UIBasicComponent
{
    var __get__titleHeight, _aColumnsWidths, __get__columnsWidths, _aColumnsNames, __get__columnsNames, _aColumnsProperties, __get__columnsProperties, __get__multipleSelection, __get__rowHeight, __get__cellRenderer, _lstList, __get__dataProvider, __get__enabled, attachMovie, createEmptyMovieClip, __height, __width, _mcTitle, getNextHighestDepth, getStyle, __get__initialized, drawRoundRect, dispatchEvent, __set__cellRenderer, __set__columnsNames, __set__columnsProperties, __set__columnsWidths, __set__dataProvider, __set__multipleSelection, __set__rowHeight, __set__titleHeight;
    function DataGrid()
    {
        super();
    } // End of the function
    function set titleHeight(nTitleHeight)
    {
        _nTitleHeight = nTitleHeight;
        //return (this.titleHeight());
        null;
    } // End of the function
    function get titleHeight()
    {
        return (_nTitleHeight);
    } // End of the function
    function set columnsWidths(aColumnsWidths)
    {
        _aColumnsWidths = aColumnsWidths;
        //return (this.columnsWidths());
        null;
    } // End of the function
    function get columnsWidths()
    {
        return (_aColumnsWidths);
    } // End of the function
    function set columnsNames(aColumnsNames)
    {
        _aColumnsNames = aColumnsNames;
        this.setLabels();
        //return (this.columnsNames());
        null;
    } // End of the function
    function get columnsNames()
    {
        return (_aColumnsNames);
    } // End of the function
    function set columnsProperties(aColumnsProperties)
    {
        _aColumnsProperties = aColumnsProperties;
        //return (this.columnsProperties());
        null;
    } // End of the function
    function get columnsProperties()
    {
        return (_aColumnsProperties);
    } // End of the function
    function set multipleSelection(bMultipleSelection)
    {
        _bMultipleSelection = bMultipleSelection;
        //return (this.multipleSelection());
        null;
    } // End of the function
    function get multipleSelection()
    {
        return (_bMultipleSelection);
    } // End of the function
    function set rowHeight(nRowHeight)
    {
        if (nRowHeight == 0)
        {
            return;
        } // end if
        _nRowHeight = nRowHeight;
        //return (this.rowHeight());
        null;
    } // End of the function
    function get rowHeight()
    {
        return (_nRowHeight);
    } // End of the function
    function set cellRenderer(sCellRenderer)
    {
        _sCellRenderer = sCellRenderer;
        //return (this.cellRenderer());
        null;
    } // End of the function
    function get cellRenderer()
    {
        return (_sCellRenderer);
    } // End of the function
    function set dataProvider(eaDataProvider)
    {
        _lstList.__set__dataProvider(eaDataProvider);
        //return (this.dataProvider());
        null;
    } // End of the function
    function get dataProvider()
    {
        //return (_lstList.dataProvider());
    } // End of the function
    function addItem(oItem)
    {
        _lstList.addItem(oItem);
    } // End of the function
    function addItemAt(oItem, nIndex)
    {
        _lstList.addItemAt(oItem, nIndex);
    } // End of the function
    function removeItemAt(oItem, nIndex)
    {
        _lstList.removeItemAt(oItem, nIndex);
    } // End of the function
    function removeAll()
    {
        _lstList.removeAll();
    } // End of the function
    function setVPosition(nPosition)
    {
        _lstList.setVPosition(nPosition);
    } // End of the function
    function sortOn(sPropName, nOption)
    {
        _lstList.sortOn(sPropName, nOption);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.DataGrid.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie("List", "_lstList", 10, {styleName: "none", multipleSelection: _bMultipleSelection, rowHeight: _nRowHeight, cellRenderer: _sCellRenderer, enabled: this.__get__enabled()});
        _lstList.addEventListener("itemSelected", this);
        _lstList.addEventListener("itemRollOver", this);
        _lstList.addEventListener("itemRollOut", this);
        _lstList.addEventListener("itemDragOver", this);
        _lstList.addEventListener("itemDragOut", this);
        this.createEmptyMovieClip("_mcTitle", 20);
    } // End of the function
    function arrange()
    {
        _lstList._y = _nTitleHeight;
        _lstList.setSize(__width, __height - _nTitleHeight);
        _mcTitle._width = __width;
        _mcTitle._height = _nTitleHeight;
        var _loc3 = 0;
        for (var _loc2 = 0; _loc2 < _aColumnsWidths.length; ++_loc2)
        {
            var _loc4 = _loc3 + _aColumnsWidths[_loc2] < __width ? (_aColumnsWidths[_loc2]) : (__width - _loc3);
            if (_aColumnsProperties[_loc2] != undefined)
            {
                var _loc5 = this.attachMovie("Button", "_btnTitle" + _loc2, this.getNextHighestDepth(), {_x: _loc3, styleName: "none", label: "", backgroundDown: "ButtonTransparentUp", backgroundUp: "ButtonTransparentUp", toggle: true, params: {index: _loc2}});
                _loc5.setSize(_loc4, _nTitleHeight);
                _loc5.addEventListener("click", this);
            } // end if
            var _loc6 = this.attachMovie("Label", "_lblTitle" + _loc2, this.getNextHighestDepth(), {_x: _loc3, styleName: this.getStyle().labelstyle, text: _aColumnsNames[_loc2]});
            _loc6.setSize(_loc4, _nTitleHeight);
            _loc3 = _loc3 + _loc4;
        } // end of for
    } // End of the function
    function draw()
    {
        var _loc4 = this.getStyle();
        _lstList.__set__styleName(_loc4.liststyle);
        if (this.__get__initialized())
        {
            var _loc3 = this.getStyle().labelstyle;
            for (var _loc2 = 0; _loc2 < _aColumnsWidths.length; ++_loc2)
            {
                this["_lblTitle" + _loc2].styleName = _loc3;
            } // end of for
        } // end if
        this.drawRoundRect(_mcTitle, 0, 0, 1, 1, 0, _loc4.titlebgcolor);
    } // End of the function
    function setLabels()
    {
        if (this.__get__initialized())
        {
            for (var _loc2 = 0; _loc2 < _aColumnsWidths.length; ++_loc2)
            {
                this["_lblTitle" + _loc2].text = _aColumnsNames[_loc2];
            } // end of for
        } // end if
    } // End of the function
    function click(oEvent)
    {
        var _loc4 = oEvent.target.params.index;
        var _loc2 = _aColumnsProperties[_loc4];
        var _loc3 = oEvent.target.selected ? (Array.CASEINSENSITIVE) : (Array.CASEINSENSITIVE | Array.DESCENDING);
        if (!isNaN(Number(_lstList.dataProvider[0][_loc2])))
        {
            _loc3 = _loc3 | Array.NUMERIC;
        } // end if
        this.sortOn(_loc2, _loc3);
    } // End of the function
    function itemSelected(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    function itemRollOver(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    function itemRollOut(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    function itemDragOver(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    function itemDragOut(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    static var CLASS_NAME = "DataGrid";
    var _nRowHeight = 20;
    var _nTitleHeight = 20;
    var _sCellRenderer = "DefaultCellRenderer";
    var _bMultipleSelection = false;
} // End of Class
#endinitclip
