// Action script...

// [Initial MovieClip Action of sprite 171]
#initclip 13
class ank.gapi.controls.List extends ank.gapi.core.UIBasicComponent
{
    var __get__multipleSelection, __get__rowHeight, __get__cellRenderer, _nSelectedIndex, _eaDataProvider, __height, __get__dataProvider, _mcContent, __get__selectedIndex, __get__styleName, attachMovie, _sbVertical, createEmptyMovieClip, _mcMask, drawRoundRect, getStyle, styleName, __width, _nMaskWidth, _bEnabled, dispatchEvent, _target, __set__cellRenderer, __set__dataProvider, __set__multipleSelection, __set__rowHeight, __set__selectedIndex, __get__selectedItem;
    function List()
    {
        super();
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
        delete this._nSelectedIndex;
        _eaDataProvider = eaDataProvider;
        _eaDataProvider.addEventListener("modelChanged", this);
        var _loc2 = Math.ceil(__height / _nRowHeight);
        if (eaDataProvider.length <= _loc2)
        {
            this.setVPosition(0);
        } // end if
        this.modelChanged();
        //return (this.dataProvider());
        null;
    } // End of the function
    function get dataProvider()
    {
        return (_eaDataProvider);
    } // End of the function
    function set selectedIndex(nIndex)
    {
        var _loc3 = _mcContent["row" + nIndex];
        _nSelectedIndex = nIndex;
        this.layoutSelection(nIndex, _loc3);
        //return (this.selectedIndex());
        null;
    } // End of the function
    function get selectedIndex()
    {
        return (_nSelectedIndex);
    } // End of the function
    function get selectedItem()
    {
        return (_eaDataProvider[_nSelectedIndex]);
    } // End of the function
    function addItem(oItem)
    {
        _aRows.push({item: oItem, selected: false});
        this.setScrollBarProperties(true);
        this.layoutContent();
    } // End of the function
    function addItemAt(oItem, nIndex)
    {
        _aRows.splice(nIndex, 0, {item: oItem, selected: false});
        this.setScrollBarProperties(true);
        this.layoutContent();
    } // End of the function
    function removeItemAt(oItem, nIndex)
    {
        _aRows.splice(nIndex, 1);
        this.setScrollBarProperties(true);
        this.layoutContent();
    } // End of the function
    function removeAll()
    {
        _aRows = new Array();
        this.setScrollBarProperties(true);
        this.layoutContent();
    } // End of the function
    function setVPosition(nPosition)
    {
        var _loc3 = _eaDataProvider.length - Math.floor(__height / _nRowHeight);
        if (nPosition > _loc3)
        {
            nPosition = _loc3;
        } // end if
        if (nPosition < 0)
        {
            nPosition = 0;
        } // end if
        if (_nScrollPosition != nPosition)
        {
            _nScrollPosition = nPosition;
            this.setScrollBarProperties(false);
            this.layoutContent();
        } // end if
    } // End of the function
    function sortOn(sPropName, nOption)
    {
        _eaDataProvider.sortOn(sPropName, nOption);
        this.modelChanged();
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.List.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie("ScrollBar", "_sbVertical", 10, {styleName: this.__get__styleName()});
        _sbVertical.addEventListener("scroll", this);
        this.createEmptyMovieClip("_mcContent", 20);
        this.createEmptyMovieClip("_mcMask", 30);
        this.drawRoundRect(_mcMask, 0, 0, 100, 100, 0, 16711680);
        _mcContent.setMask(_mcMask);
        ank.utils.MouseEvents.addListener(this);
    } // End of the function
    function size()
    {
        super.size();
        _bInvalidateScrollBar = true;
        this.arrange();
    } // End of the function
    function draw()
    {
        if (this.__get__styleName() == "none")
        {
            return;
        } // end if
        var _loc3 = this.getStyle();
        for (var _loc2 in _mcContent)
        {
            _mcContent[_loc2].styleName = styleName;
        } // end of for...in
        _sbVertical.__set__styleName(_loc3.scrollbarstyle);
    } // End of the function
    function arrange()
    {
        if (_bInvalidateScrollBar)
        {
            this.setScrollBarProperties(false);
        } // end if
        if (_sbVertical._visible)
        {
            _sbVertical.setSize(__height);
            _sbVertical._x = __width - _sbVertical.__get__width();
            _sbVertical._y = 0;
        } // end if
        _nMaskWidth = _sbVertical._visible ? (__width - _sbVertical.__get__width()) : (__width);
        _mcMask._width = _nMaskWidth;
        _mcMask._height = __height;
        _bInvalidateLayout = true;
        this.layoutContent();
    } // End of the function
    function layoutContent()
    {
        var _loc12 = Math.ceil(__height / _nRowHeight);
        for (var _loc3 = 0; _loc3 < _loc12; ++_loc3)
        {
            var _loc2 = _mcContent["row" + _loc3];
            if (_loc2 == undefined)
            {
                _loc2 = (ank.gapi.controls.list.SelectableRow)(_mcContent.attachMovie("SelectableRow", "row" + _loc3, _loc3, {_x: 0, _y: _loc3 * _nRowHeight, index: _loc3, styleName: this.__get__styleName(), enabled: _bEnabled}));
                _loc2.setCellRenderer(_sCellRenderer);
                _loc2.addEventListener("itemSelected", this);
                _loc2.addEventListener("itemRollOver", this);
                _loc2.addEventListener("itemRollOut", this);
                _loc2.addEventListener("itemDragOver", this);
                _loc2.addEventListener("itemDragOut", this);
            } // end if
            var _loc5 = _loc3 + _nScrollPosition;
            if (_bInvalidateLayout)
            {
                _loc2.setSize(_nMaskWidth, _nRowHeight);
            } // end if
            var _loc6 = _aRows[_loc5];
            var _loc4 = _loc6.item;
            _loc2.setValue(typeof(_loc4) == "string" ? (_loc4) : (_loc4.label), _loc4, _loc6.selected || _loc5 == _nSelectedIndex ? ("selected") : ("normal"));
            _loc2.__set__itemIndex(_loc5);
        } // end of for
        _bInvalidateLayout = false;
    } // End of the function
    function addScrollBar(bArrange)
    {
        if (!_sbVertical._visible)
        {
            _sbVertical._visible = true;
            if (bArrange)
            {
                this.arrange();
            } // end if
        } // end if
    } // End of the function
    function removeScrollBar(bArrange)
    {
        if (_sbVertical._visible)
        {
            _sbVertical._visible = false;
            if (bArrange)
            {
                this.arrange();
            } // end if
        } // end if
    } // End of the function
    function setScrollBarProperties(bArrange)
    {
        _bInvalidateScrollBar = false;
        var _loc2 = Math.floor(__height / _nRowHeight);
        var _loc3 = _aRows.length - _loc2;
        var _loc4 = _loc2 * (_loc3 / _aRows.length);
        if (_loc2 >= _aRows.length || _aRows.length == 0)
        {
            this.removeScrollBar(bArrange);
        }
        else
        {
            this.addScrollBar(bArrange);
            _sbVertical.setScrollProperties(_loc4, 0, _loc3);
            _sbVertical.__set__scrollPosition(_nScrollPosition);
        } // end else if
    } // End of the function
    function layoutSelection(nIndex, srRow)
    {
        if (nIndex == undefined)
        {
            nIndex = _nSelectedIndex;
        } // end if
        var _loc7 = srRow.__get__item();
        var _loc3 = _aRows[nIndex];
        var _loc6 = _aRows[nIndex].selected;
        if (!_bMultipleSelection)
        {
            var _loc2 = _aRows.length;
            while (--_loc2 >= 0)
            {
                if (_aRows[_loc2].selected)
                {
                    _aRows[_loc2].selected = false;
                    _mcContent["row" + (_loc2 - _nScrollPosition)].setState("normal");
                } // end if
            } // end while
        } // end if
        if (_loc6 && _bMultipleSelection)
        {
            _loc3.selected = false;
            srRow.setState("normal");
        }
        else
        {
            _loc3.selected = true;
            srRow.setState("selected");
        } // end else if
    } // End of the function
    function modelChanged()
    {
        _aRows = new Array();
        var _loc5 = _eaDataProvider.length;
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            _aRows[_loc2] = {item: _eaDataProvider[_loc2], selected: false};
        } // end of for
        this.setScrollBarProperties(true);
        this.layoutContent();
    } // End of the function
    function scroll(oEvent)
    {
        this.setVPosition(oEvent.target.scrollPosition);
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.itemIndex;
        var _loc4 = oEvent.target;
        _nSelectedIndex = _loc2;
        this.layoutSelection(_loc2, _loc4);
        this.dispatchEvent({type: "itemSelected", target: oEvent.target});
    } // End of the function
    function itemRollOver(oEvent)
    {
        this.dispatchEvent({type: "itemRollOver", target: oEvent.target});
    } // End of the function
    function itemRollOut(oEvent)
    {
        this.dispatchEvent({type: "itemRollOut", target: oEvent.target});
    } // End of the function
    function itemDragOver(oEvent)
    {
        this.dispatchEvent({type: "itemDragOver", target: oEvent.target});
    } // End of the function
    function itemDragOut(oEvent)
    {
        this.dispatchEvent({type: "itemDragOut", target: oEvent.target});
    } // End of the function
    function onMouseWheel(nDelta, mc)
    {
        if (String(mc._target).indexOf(_target) != -1)
        {
            this.setVPosition(_nScrollPosition - nDelta);
        } // end if
    } // End of the function
    static var CLASS_NAME = "List";
    var _aRows = new Array();
    var _nRowHeight = 20;
    var _bInvalidateLayout = true;
    var _bInvalidateScrollBar = true;
    var _nScrollPosition = 0;
    var _sCellRenderer = "DefaultCellRenderer";
    var _bMultipleSelection = false;
} // End of Class
#endinitclip
