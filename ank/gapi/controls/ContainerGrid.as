// Action script...

// [Initial MovieClip Action of sprite 209]
#initclip 34
class ank.gapi.controls.ContainerGrid extends ank.gapi.core.UIBasicComponent
{
    var __get__selectable, __get__visibleRowCount, __get__visibleColumnCount, _eaDataProvider, __get__dataProvider, __get__selectedIndex, _nSelectedIndex, _mcScrollContent, __get__scrollBar, __height, createEmptyMovieClip, _mcMask, drawRoundRect, attachMovie, _sbVertical, __width, _bInitialized, _bEnabled, getStyle, addToQueue, dispatchEvent, _target, __set__dataProvider, __set__scrollBar, __set__selectable, __set__selectedIndex, __get__selectedItem, __set__visibleColumnCount, __set__visibleRowCount;
    function ContainerGrid()
    {
        super();
    } // End of the function
    function set selectable(bSelectable)
    {
        _bSelectable = bSelectable;
        //return (this.selectable());
        null;
    } // End of the function
    function get selectable()
    {
        return (_bSelectable);
    } // End of the function
    function set visibleRowCount(nVisibleRowCount)
    {
        _nVisibleRowCount = nVisibleRowCount;
        //return (this.visibleRowCount());
        null;
    } // End of the function
    function get visibleRowCount()
    {
        return (_nVisibleRowCount);
    } // End of the function
    function set visibleColumnCount(nVisibleColumnCount)
    {
        _nVisibleColumnCount = nVisibleColumnCount;
        //return (this.visibleColumnCount());
        null;
    } // End of the function
    function get visibleColumnCount()
    {
        return (_nVisibleColumnCount);
    } // End of the function
    function set dataProvider(eaDataProvider)
    {
        _eaDataProvider = eaDataProvider;
        _eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        if (eaDataProvider.length <= _nVisibleRowCount * _nVisibleColumnCount)
        {
            this.setVPosition(0);
        } // end if
        //return (this.dataProvider());
        null;
    } // End of the function
    function set selectedIndex(nSelectedIndex)
    {
        this.setSelectedItem(nSelectedIndex);
        //return (this.selectedIndex());
        null;
    } // End of the function
    function get selectedIndex()
    {
        return (_nSelectedIndex);
    } // End of the function
    function get selectedItem()
    {
        return (_mcScrollContent["c" + _nSelectedIndex]);
    } // End of the function
    function set scrollBar(bScrollBar)
    {
        _bScrollBar = bScrollBar;
        //return (this.scrollBar());
        null;
    } // End of the function
    function get scrollBar()
    {
        return (_bScrollBar);
    } // End of the function
    function setVPosition(nPosition)
    {
        var _loc3 = Math.ceil(_eaDataProvider.length / _nVisibleColumnCount) - _nVisibleRowCount;
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
            this.setScrollBarProperties();
            var _loc4 = __height / _nVisibleRowCount;
            _mcScrollContent._y = -_nScrollPosition * _loc4;
        } // end if
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ContainerGrid.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcScrollContent", 10);
        this.createEmptyMovieClip("_mcMask", 20);
        this.drawRoundRect(_mcMask, 0, 0, 1, 1, 0, 0);
        _mcScrollContent.setMask(_mcMask);
        if (_bScrollBar)
        {
            this.attachMovie("ScrollBar", "_sbVertical", 30);
            _sbVertical.addEventListener("scroll", this);
        } // end if
        ank.utils.MouseEvents.addListener(this);
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        if (_bScrollBar)
        {
            _sbVertical.setSize(__height);
            _sbVertical.move(__width - _sbVertical.__get__width(), 0);
        } // end if
        _mcMask._width = __width - (_bScrollBar ? (_sbVertical.__get__width()) : (0));
        _mcMask._height = __height;
        this.setScrollBarProperties();
        _bInvalidateLayout = _bInitialized;
        this.layoutContent();
    } // End of the function
    function layoutContent()
    {
        if (!_bInvalidateLayout)
        {
            return;
        } // end if
        var _loc7 = (__width - (_bScrollBar ? (_sbVertical.__get__width()) : (0))) / _nVisibleColumnCount;
        var _loc6 = __height / _nVisibleRowCount;
        var _loc3 = 0;
        for (var _loc5 = 0; _loc5 < Math.max(_nVisibleRowCount, _nRowCount); ++_loc5)
        {
            for (var _loc4 = 0; _loc4 < _nVisibleColumnCount; ++_loc4)
            {
                var _loc2 = _mcScrollContent["c" + _loc3];
                if (_loc2 == undefined)
                {
                    _loc2 = (ank.gapi.controls.Container)(_mcScrollContent.attachMovie("Container", "c" + _loc3, _loc3));
                    _loc2.addEventListener("drag", this);
                    _loc2.addEventListener("drop", this);
                    _loc2.addEventListener("over", this);
                    _loc2.addEventListener("out", this);
                    _loc2.addEventListener("click", this);
                    _loc2.addEventListener("dblClick", this);
                } // end if
                _loc2._x = _loc7 * _loc4;
                _loc2._y = _loc6 * _loc5;
                _loc2.setSize(_loc7, _loc6);
                _loc2.__set__showLabel(_eaDataProvider[_loc3].label != undefined && _eaDataProvider[_loc3].label > 0);
                _loc2.__set__contentData(_eaDataProvider[_loc3]);
                if (_loc2.__get__selected())
                {
                    _loc2.__set__selected(false);
                } // end if
                _loc2.__set__enabled(_bEnabled);
                ++_loc3;
            } // end of for
        } // end of for
        _nSelectedIndex = undefined;
        _bInvalidateLayout = false;
    } // End of the function
    function draw()
    {
        _bInvalidateLayout = !_bInitialized;
        this.layoutContent();
        var _loc3 = this.getStyle();
        var _loc6 = _loc3.containerbackground;
        var _loc5 = _loc3.containerborder;
        var _loc7 = _loc3.containerhighlight;
        var _loc4 = _loc3.containermargin;
        for (var _loc8 in _mcScrollContent)
        {
            var _loc2 = _mcScrollContent[_loc8];
            _loc2.__set__backgroundRenderer(_loc6);
            _loc2.__set__borderRenderer(_loc5);
            _loc2.__set__highlightRenderer(_loc7);
            _loc2.__set__margin(_loc4);
            _loc2.__set__styleName(_loc3.containerstyle);
        } // end of for...in
        if (_bScrollBar)
        {
            _sbVertical.__set__styleName(_loc3.scrollbarstyle);
        } // end if
    } // End of the function
    function setEnabled()
    {
        for (var _loc2 in _mcScrollContent)
        {
            _mcScrollContent[_loc2].enabled = _bEnabled;
        } // end of for...in
        this.addToQueue({object: this, method: function ()
        {
            _sbVertical.enabled = _bEnabled;
        }});
    } // End of the function
    function setScrollBarProperties()
    {
        var _loc2 = _nRowCount - _nVisibleRowCount;
        var _loc3 = _nVisibleRowCount * (_loc2 / _nRowCount);
        _sbVertical.setScrollProperties(_loc3, 0, _loc2);
        _sbVertical.__set__scrollPosition(_nScrollPosition);
    } // End of the function
    function setSelectedItem(nIndex)
    {
        if (_nSelectedIndex != nIndex)
        {
            var _loc4 = _mcScrollContent["c" + _nSelectedIndex];
            var _loc2 = _mcScrollContent["c" + nIndex];
            if (_loc2.__get__contentData() == undefined)
            {
                return;
            } // end if
            _loc4.__set__selected(false);
            _loc2.__set__selected(true);
            _nSelectedIndex = nIndex;
        } // end if
    } // End of the function
    function modelChanged(oEvent)
    {
        var _loc2 = _nRowCount;
        _nRowCount = Math.ceil(_eaDataProvider.length / _nVisibleColumnCount);
        _bInvalidateLayout = true;
        this.layoutContent();
        this.draw();
        this.setScrollBarProperties();
    } // End of the function
    function scroll(oEvent)
    {
        this.setVPosition(oEvent.target.scrollPosition);
    } // End of the function
    function drag(oEvent)
    {
        this.dispatchEvent({type: "dragItem", target: oEvent.target});
    } // End of the function
    function drop(oEvent)
    {
        this.dispatchEvent({type: "dropItem", target: oEvent.target});
    } // End of the function
    function over(oEvent)
    {
        this.dispatchEvent({type: "overItem", target: oEvent.target});
    } // End of the function
    function out(oEvent)
    {
        this.dispatchEvent({type: "outItem", target: oEvent.target});
    } // End of the function
    function click(oEvent)
    {
        if (_bSelectable)
        {
            this.setSelectedItem(Number(oEvent.target._name.substr(1)));
        } // end if
        this.dispatchEvent({type: "selectItem", target: oEvent.target, owner: this});
    } // End of the function
    function dblClick(oEvent)
    {
        this.dispatchEvent({type: "dblClickItem", target: oEvent.target, owner: this});
    } // End of the function
    function onMouseWheel(nDelta, mc)
    {
        if (String(mc._target).indexOf(_target) != -1)
        {
            _sbVertical.scrollPosition = _sbVertical.scrollPosition - (nDelta > 0 ? (1) : (-1));
        } // end if
    } // End of the function
    static var CLASS_NAME = "ContainerGrid";
    var _nVisibleRowCount = 3;
    var _nVisibleColumnCount = 3;
    var _nRowCount = 1;
    var _bInvalidateLayout = false;
    var _bScrollBar = true;
    var _bSelectable = true;
    var _nScrollPosition = 0;
} // End of Class
#endinitclip
