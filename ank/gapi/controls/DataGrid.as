// Action script...

// [Initial MovieClip Action of sprite 20960]
#initclip 225
if (!ank.gapi.controls.DataGrid)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.DataGrid = function ()
    {
        super();
    }).prototype;
    _loc1.__set__titleHeight = function (nTitleHeight)
    {
        this._nTitleHeight = nTitleHeight;
        //return (this.titleHeight());
    };
    _loc1.__get__titleHeight = function ()
    {
        return (this._nTitleHeight);
    };
    _loc1.__set__columnsWidths = function (aColumnsWidths)
    {
        this._aColumnsWidths = aColumnsWidths;
        //return (this.columnsWidths());
    };
    _loc1.__get__columnsWidths = function ()
    {
        return (this._aColumnsWidths);
    };
    _loc1.__set__columnsNames = function (aColumnsNames)
    {
        this._aColumnsNames = aColumnsNames;
        this.setLabels();
        //return (this.columnsNames());
    };
    _loc1.__get__columnsNames = function ()
    {
        return (this._aColumnsNames);
    };
    _loc1.__set__columnsProperties = function (aColumnsProperties)
    {
        this._aColumnsProperties = aColumnsProperties;
        //return (this.columnsProperties());
    };
    _loc1.__get__columnsProperties = function ()
    {
        return (this._aColumnsProperties);
    };
    _loc1.__set__multipleSelection = function (bMultipleSelection)
    {
        this._bMultipleSelection = bMultipleSelection;
        //return (this.multipleSelection());
    };
    _loc1.__get__multipleSelection = function ()
    {
        return (this._bMultipleSelection);
    };
    _loc1.__set__rowHeight = function (nRowHeight)
    {
        if (nRowHeight == 0)
        {
            return;
        } // end if
        this._nRowHeight = nRowHeight;
        //return (this.rowHeight());
    };
    _loc1.__get__rowHeight = function ()
    {
        return (this._nRowHeight);
    };
    _loc1.__set__cellRenderer = function (sCellRenderer)
    {
        this._sCellRenderer = sCellRenderer;
        //return (this.cellRenderer());
    };
    _loc1.__get__cellRenderer = function ()
    {
        return (this._sCellRenderer);
    };
    _loc1.__set__dataProvider = function (eaDataProvider)
    {
        this._lstList.dataProvider = eaDataProvider;
        //return (this.dataProvider());
    };
    _loc1.__get__dataProvider = function ()
    {
        return (this._lstList.dataProvider);
    };
    _loc1.__set__selectedIndex = function (nIndex)
    {
        this._lstList.selectedIndex = nIndex;
        //return (this.selectedIndex());
    };
    _loc1.__get__selectedIndex = function ()
    {
        return (this._lstList.selectedIndex);
    };
    _loc1.__get__selectedItem = function ()
    {
        return (this._lstList.selectedItem);
    };
    _loc1.addItem = function (oItem)
    {
        this._lstList.addItem(oItem);
    };
    _loc1.addItemAt = function (oItem, nIndex)
    {
        this._lstList.addItemAt(oItem, nIndex);
    };
    _loc1.removeItemAt = function (oItem, nIndex)
    {
        this._lstList.removeItemAt(oItem, nIndex);
    };
    _loc1.removeAll = function ()
    {
        this._lstList.removeAll();
    };
    _loc1.setVPosition = function (nPosition)
    {
        this._lstList.setVPosition(nPosition);
    };
    _loc1.sortOn = function (sPropName, nOption)
    {
        this._lstList.selectedIndex = -1;
        this._lstList.sortOn(sPropName, nOption);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.DataGrid.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie("List", "_lstList", 10, {styleName: "none", multipleSelection: this._bMultipleSelection, rowHeight: this._nRowHeight, cellRenderer: this._sCellRenderer, enabled: this.enabled});
        this._lstList.addEventListener("itemSelected", this);
        this._lstList.addEventListener("itemdblClick", this);
        this._lstList.addEventListener("itemRollOver", this);
        this._lstList.addEventListener("itemRollOut", this);
        this._lstList.addEventListener("itemDrag", this);
        this.createEmptyMovieClip("_mcTitle", 20);
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._lstList._y = this._nTitleHeight;
        this._lstList.setSize(this.__width, this.__height - this._nTitleHeight);
        this._mcTitle._width = this.__width;
        this._mcTitle._height = this._nTitleHeight;
        var _loc2 = 0;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aColumnsWidths.length)
        {
            var _loc4 = _loc2 + this._aColumnsWidths[_loc3] < this.__width ? (this._aColumnsWidths[_loc3]) : (this.__width - _loc2);
            if (this._aColumnsProperties[_loc3] != undefined)
            {
                var _loc5 = this.attachMovie("Button", "_btnTitle" + _loc3, this.getNextHighestDepth(), {_x: _loc2, styleName: "none", label: "", backgroundDown: "ButtonTransparentUp", backgroundUp: "ButtonTransparentUp", toggle: true, params: {index: _loc3}});
                _loc5.setSize(_loc4, this._nTitleHeight);
                _loc5.addEventListener("click", this);
            } // end if
            this["_lblTitle" + _loc3].removeMovieClip();
            var _loc6 = this.attachMovie("Label", "_lblTitle" + _loc3, this.getNextHighestDepth(), {_x: _loc2, styleName: this.getStyle().labelstyle, text: this._aColumnsNames[_loc3]});
            _loc6.setSize(_loc4, this._nTitleHeight);
            _loc2 = _loc2 + _loc4;
        } // end while
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._lstList.styleName = _loc2.liststyle;
        if (this.initialized)
        {
            var _loc3 = this.getStyle().labelstyle;
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < this._aColumnsWidths.length)
            {
                this["_lblTitle" + _loc4].styleName = _loc3;
            } // end while
        } // end if
        this.drawRoundRect(this._mcTitle, 0, 0, 1, 1, 0, _loc2.titlebgcolor);
        this._mcTitle._alpha = _loc2.titlebgcolor == -1 ? (0) : (100);
    };
    _loc1.setLabels = function ()
    {
        if (this.initialized)
        {
            var _loc2 = 0;
            
            while (++_loc2, _loc2 < this._aColumnsWidths.length)
            {
                this["_lblTitle" + _loc2].text = this._aColumnsNames[_loc2];
            } // end while
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = oEvent.target.params.index;
        var _loc4 = this._aColumnsProperties[_loc3];
        var _loc5 = oEvent.target.selected ? (Array.CASEINSENSITIVE) : (Array.CASEINSENSITIVE | Array.DESCENDING);
        if (!_global.isNaN(Number(this._lstList.dataProvider[0][_loc4])))
        {
            _loc5 = _loc5 | Array.NUMERIC;
        } // end if
        this.sortOn(_loc4, _loc5);
    };
    _loc1.itemSelected = function (oEvent)
    {
        oEvent.list = oEvent.target;
        oEvent.target = this;
        this.dispatchEvent(oEvent);
    };
    _loc1.itemRollOver = function (oEvent)
    {
        this.dispatchEvent(oEvent);
    };
    _loc1.itemRollOut = function (oEvent)
    {
        this.dispatchEvent(oEvent);
    };
    _loc1.itemDrag = function (oEvent)
    {
        this.dispatchEvent(oEvent);
    };
    _loc1.itemdblClick = function (oEvent)
    {
        this.dispatchEvent(oEvent);
    };
    _loc1.addProperty("titleHeight", _loc1.__get__titleHeight, _loc1.__set__titleHeight);
    _loc1.addProperty("columnsProperties", _loc1.__get__columnsProperties, _loc1.__set__columnsProperties);
    _loc1.addProperty("dataProvider", _loc1.__get__dataProvider, _loc1.__set__dataProvider);
    _loc1.addProperty("multipleSelection", _loc1.__get__multipleSelection, _loc1.__set__multipleSelection);
    _loc1.addProperty("columnsNames", _loc1.__get__columnsNames, _loc1.__set__columnsNames);
    _loc1.addProperty("cellRenderer", _loc1.__get__cellRenderer, _loc1.__set__cellRenderer);
    _loc1.addProperty("columnsWidths", _loc1.__get__columnsWidths, _loc1.__set__columnsWidths);
    _loc1.addProperty("selectedItem", _loc1.__get__selectedItem, function ()
    {
    });
    _loc1.addProperty("rowHeight", _loc1.__get__rowHeight, _loc1.__set__rowHeight);
    _loc1.addProperty("selectedIndex", _loc1.__get__selectedIndex, _loc1.__set__selectedIndex);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.DataGrid = function ()
    {
        super();
    }).CLASS_NAME = "DataGrid";
    _loc1._nRowHeight = 20;
    _loc1._nTitleHeight = 20;
    _loc1._sCellRenderer = "DefaultCellRenderer";
    _loc1._bMultipleSelection = false;
} // end if
#endinitclip
