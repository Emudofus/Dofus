// Action script...

// [Initial MovieClip Action of sprite 20671]
#initclip 192
if (!ank.gapi.controls.List)
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
    var _loc1 = (_global.ank.gapi.controls.List = function ()
    {
        super();
    }).prototype;
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
        if (sCellRenderer != undefined)
        {
            this._sCellRenderer = sCellRenderer;
        } // end if
        //return (this.cellRenderer());
    };
    _loc1.__get__cellRenderer = function ()
    {
        return (this._sCellRenderer);
    };
    _loc1.__set__dataProvider = function (ea)
    {
        delete this._nSelectedIndex;
        this._eaDataProvider = ea;
        this._eaDataProvider.addEventListener("modelChanged", this);
        var _loc3 = Math.ceil(this.__height / this._nRowHeight);
        if (ea.length <= _loc3)
        {
            this.setVPosition(0);
        } // end if
        this.modelChanged();
        //return (this.dataProvider());
    };
    _loc1.__get__dataProvider = function ()
    {
        return (this._eaDataProvider);
    };
    _loc1.__set__selectedIndex = function (nIndex)
    {
        var _loc3 = this._mcContent["row" + nIndex];
        this._nSelectedIndex = nIndex;
        this.layoutSelection(nIndex, _loc3);
        //return (this.selectedIndex());
    };
    _loc1.__get__selectedIndex = function ()
    {
        return (this._nSelectedIndex);
    };
    _loc1.__get__selectedItem = function ()
    {
        return (this._eaDataProvider[this._nSelectedIndex]);
    };
    _loc1.__set__autoScroll = function (bAutoScroll)
    {
        this._bAutoScroll = bAutoScroll;
        //return (this.autoScroll());
    };
    _loc1.__get__autoScroll = function ()
    {
        return (this._bAutoScroll);
    };
    _loc1.__set__dblClickEnabled = function (bDblClickEnabled)
    {
        this._bDblClickEnabled = bDblClickEnabled;
        //return (this.dblClickEnabled());
    };
    _loc1.__get__dblClickEnabled = function ()
    {
        return (this._bDblClickEnabled);
    };
    _loc1.addItem = function (oItem)
    {
        this._aRows.push({item: oItem, selected: false});
        this.setScrollBarProperties(true);
        this.layoutContent();
    };
    _loc1.addItemAt = function (oItem, nIndex)
    {
        this._aRows.splice(nIndex, 0, {item: oItem, selected: false});
        this.setScrollBarProperties(true);
        this.layoutContent();
    };
    _loc1.removeItemAt = function (oItem, nIndex)
    {
        this._aRows.splice(nIndex, 1);
        this.setScrollBarProperties(true);
        this.layoutContent();
    };
    _loc1.removeAll = function ()
    {
        this._aRows = new Array();
        this.setScrollBarProperties(true);
        this.layoutContent();
    };
    _loc1.setVPosition = function (nPosition, bForced)
    {
        var _loc4 = this._eaDataProvider.length - Math.floor(this.__height / this._nRowHeight);
        if (nPosition > _loc4)
        {
            nPosition = _loc4;
        } // end if
        if (nPosition < 0)
        {
            nPosition = 0;
        } // end if
        if (this._nScrollPosition != nPosition || bForced)
        {
            this._nScrollPosition = nPosition;
            this.setScrollBarProperties(bForced == true);
            this.layoutContent();
        } // end if
    };
    _loc1.sortOn = function (sPropName, nOption)
    {
        this._eaDataProvider.sortOn(sPropName, nOption);
        this.modelChanged();
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.List.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie("ScrollBar", "_sbVertical", 10, {styleName: this.styleName});
        this._sbVertical.addEventListener("scroll", this);
        this.createEmptyMovieClip("_mcContent", 20);
        this.createEmptyMovieClip("_mcMask", 30);
        this.drawRoundRect(this._mcMask, 0, 0, 100, 100, 0, 16711680);
        this._mcContent.setMask(this._mcMask);
        ank.utils.MouseEvents.addListener(this);
    };
    _loc1.size = function ()
    {
        super.size();
        this._bInvalidateScrollBar = true;
        this.arrange();
        if (this.initialized)
        {
            this.setVPosition(this._nScrollPosition, true);
        } // end if
    };
    _loc1.draw = function ()
    {
        if (this.styleName == "none")
        {
            return;
        } // end if
        var _loc2 = this.getStyle();
        for (var k in this._mcContent)
        {
            this._mcContent[k].styleName = this.styleName;
        } // end of for...in
        this._sbVertical.styleName = _loc2.scrollbarstyle;
    };
    _loc1.arrange = function ()
    {
        if (this._bInvalidateScrollBar)
        {
            this.setScrollBarProperties(false);
        } // end if
        if (this._sbVertical._visible)
        {
            this._sbVertical.setSize(this.__height);
            this._sbVertical._x = this.__width - this._sbVertical.width;
            this._sbVertical._y = 0;
        } // end if
        this._nMaskWidth = this._sbVertical._visible ? (this.__width - this._sbVertical.width) : (this.__width);
        this._mcMask._width = this._nMaskWidth;
        this._mcMask._height = this.__height;
        this._bInvalidateLayout = true;
        this.layoutContent();
    };
    _loc1.layoutContent = function ()
    {
        var _loc2 = Math.ceil(this.__height / this._nRowHeight);
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2)
        {
            var _loc4 = this._mcContent["row" + _loc3];
            if (_loc4 == undefined)
            {
                _loc4 = (ank.gapi.controls.list.SelectableRow)(this._mcContent.attachMovie("SelectableRow", "row" + _loc3, _loc3, {_x: 0, _y: _loc3 * this._nRowHeight, index: _loc3, styleName: this.styleName, enabled: this._bEnabled, gapi: this.gapi}));
                _loc4.setCellRenderer(this._sCellRenderer);
                _loc4.addEventListener("itemSelected", this);
                _loc4.addEventListener("itemdblClick", this);
                _loc4.addEventListener("itemRollOver", this);
                _loc4.addEventListener("itemRollOut", this);
                _loc4.addEventListener("itemDrag", this);
                _loc4.addEventListener("itemDrop", this);
            } // end if
            var _loc5 = _loc3 + this._nScrollPosition;
            if (this._bInvalidateLayout)
            {
                _loc4.setSize(this._nMaskWidth, this._nRowHeight);
            } // end if
            var _loc6 = this._aRows[_loc5];
            var _loc7 = _loc6.item;
            var _loc8 = typeof(_loc7) == "string" ? (_loc7) : (_loc7.label);
            var _loc9 = (_loc6.selected || _loc5 == this._nSelectedIndex) && _loc7 != undefined ? ("selected") : ("normal");
            _loc4.setValue(_loc8, _loc7, _loc9);
            _loc4.itemIndex = _loc5;
        } // end while
        this._bInvalidateLayout = false;
    };
    _loc1.addScrollBar = function (bArrange)
    {
        if (!this._sbVertical._visible)
        {
            this._sbVertical._visible = true;
            if (bArrange)
            {
                this.arrange();
            } // end if
        } // end if
    };
    _loc1.removeScrollBar = function (bArrange)
    {
        if (this._sbVertical._visible)
        {
            this._sbVertical._visible = false;
            if (bArrange)
            {
                this.arrange();
            } // end if
        } // end if
    };
    _loc1.setScrollBarProperties = function (bArrange)
    {
        this._bInvalidateScrollBar = false;
        var _loc3 = Math.floor(this.__height / this._nRowHeight);
        var _loc4 = this._aRows.length - _loc3;
        var _loc5 = _loc3 * (_loc4 / this._aRows.length);
        if (_loc3 >= this._aRows.length || this._aRows.length == 0)
        {
            this.removeScrollBar(bArrange);
        }
        else
        {
            this.addScrollBar(bArrange);
            this._sbVertical.setScrollProperties(_loc5, 0, _loc4);
            this._sbVertical.scrollPosition = this._nScrollPosition;
        } // end else if
    };
    _loc1.layoutSelection = function (nIndex, srRow)
    {
        if (nIndex == undefined)
        {
            nIndex = this._nSelectedIndex;
        } // end if
        var _loc4 = this._aRows[nIndex];
        var _loc5 = this._aRows[nIndex].selected;
        if (!this._bMultipleSelection)
        {
            var _loc6 = this._aRows.length;
            while (--_loc6 >= 0)
            {
                if (this._aRows[_loc6].selected)
                {
                    this._aRows[_loc6].selected = false;
                    this._mcContent["row" + (_loc6 - this._nScrollPosition)].setState("normal");
                } // end if
            } // end while
        } // end if
        if (_loc5 && this._bMultipleSelection)
        {
            _loc4.selected = false;
            srRow.setState("normal");
        }
        else
        {
            _loc4.selected = true;
            srRow.setState("selected");
        } // end else if
    };
    _loc1.modelChanged = function ()
    {
        this.selectedIndex = -1;
        this._aRows = new Array();
        var _loc2 = this._eaDataProvider.length;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2)
        {
            this._aRows[_loc3] = {item: this._eaDataProvider[_loc3], selected: false};
        } // end while
        if (this._bAutoScroll)
        {
            this.setVPosition(_loc2, true);
        }
        else
        {
            this.setScrollBarProperties(true);
            this.layoutContent();
        } // end else if
    };
    _loc1.scroll = function (oEvent)
    {
        this.setVPosition(oEvent.target.scrollPosition);
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.target.itemIndex;
        var _loc4 = oEvent.target;
        this._nSelectedIndex = _loc3;
        this.layoutSelection(_loc3, _loc4);
        this.dispatchEvent({type: "itemSelected", row: oEvent.target});
    };
    _loc1.itemdblClick = function (oEvent)
    {
        var _loc3 = oEvent.target.itemIndex;
        var _loc4 = oEvent.target;
        this._nSelectedIndex = _loc3;
        this.layoutSelection(_loc3, _loc4);
        this.dispatchEvent({type: "itemdblClick", row: oEvent.target});
    };
    _loc1.itemRollOver = function (oEvent)
    {
        this.dispatchEvent({type: "itemRollOver", row: oEvent.target});
    };
    _loc1.itemRollOut = function (oEvent)
    {
        this.dispatchEvent({type: "itemRollOut", row: oEvent.target});
    };
    _loc1.itemDrag = function (oEvent)
    {
        this.dispatchEvent({type: "itemDrag", row: oEvent.target});
    };
    _loc1.itemDrop = function (oEvent)
    {
        this.dispatchEvent({type: "itemDrop", row: oEvent.target});
    };
    _loc1.onMouseWheel = function (nDelta, mc)
    {
        if (String(mc._target).indexOf(this._target) != -1)
        {
            this.setVPosition(this._nScrollPosition - nDelta);
        } // end if
    };
    _loc1.addProperty("autoScroll", _loc1.__get__autoScroll, _loc1.__set__autoScroll);
    _loc1.addProperty("dblClickEnabled", _loc1.__get__dblClickEnabled, _loc1.__set__dblClickEnabled);
    _loc1.addProperty("dataProvider", _loc1.__get__dataProvider, _loc1.__set__dataProvider);
    _loc1.addProperty("multipleSelection", _loc1.__get__multipleSelection, _loc1.__set__multipleSelection);
    _loc1.addProperty("cellRenderer", _loc1.__get__cellRenderer, _loc1.__set__cellRenderer);
    _loc1.addProperty("selectedItem", _loc1.__get__selectedItem, function ()
    {
    });
    _loc1.addProperty("rowHeight", _loc1.__get__rowHeight, _loc1.__set__rowHeight);
    _loc1.addProperty("selectedIndex", _loc1.__get__selectedIndex, _loc1.__set__selectedIndex);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.List = function ()
    {
        super();
    }).CLASS_NAME = "List";
    _loc1._aRows = new Array();
    _loc1._nRowHeight = 20;
    _loc1._bInvalidateLayout = true;
    _loc1._bInvalidateScrollBar = true;
    _loc1._nScrollPosition = 0;
    _loc1._sCellRenderer = "DefaultCellRenderer";
    _loc1._bMultipleSelection = false;
    _loc1._bAutoScroll = false;
    _loc1._bDblClickEnabled = false;
} // end if
#endinitclip
