// Action script...

// [Initial MovieClip Action of sprite 20653]
#initclip 174
if (!ank.gapi.controls.ContainerGrid)
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
    var _loc1 = (_global.ank.gapi.controls.ContainerGrid = function ()
    {
        super();
    }).prototype;
    _loc1.__set__selectable = function (bSelectable)
    {
        this._bSelectable = bSelectable;
        //return (this.selectable());
    };
    _loc1.__get__selectable = function ()
    {
        return (this._bSelectable);
    };
    _loc1.__set__visibleRowCount = function (nVisibleRowCount)
    {
        this._nVisibleRowCount = nVisibleRowCount;
        //return (this.visibleRowCount());
    };
    _loc1.__get__visibleRowCount = function ()
    {
        return (this._nVisibleRowCount);
    };
    _loc1.__set__visibleColumnCount = function (nVisibleColumnCount)
    {
        this._nVisibleColumnCount = nVisibleColumnCount;
        //return (this.visibleColumnCount());
    };
    _loc1.__get__visibleColumnCount = function ()
    {
        return (this._nVisibleColumnCount);
    };
    _loc1.__set__dataProvider = function (eaDataProvider)
    {
        this._eaDataProvider = eaDataProvider;
        this._eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        var _loc3 = this.getMaxRow();
        if (this._nScrollPosition > _loc3)
        {
            this.setVPosition(_loc3);
        } // end if
        //return (this.dataProvider());
    };
    _loc1.__get__dataProvider = function ()
    {
        return (this._eaDataProvider);
    };
    _loc1.__set__selectedIndex = function (nSelectedIndex)
    {
        this.setSelectedItem(nSelectedIndex);
        //return (this.selectedIndex());
    };
    _loc1.__get__selectedIndex = function ()
    {
        return (this._nSelectedIndex);
    };
    _loc1.__get__selectedItem = function ()
    {
        return (this._mcScrollContent["c" + this._nSelectedIndex]);
    };
    _loc1.__set__scrollBar = function (bScrollBar)
    {
        this._bScrollBar = bScrollBar;
        //return (this.scrollBar());
    };
    _loc1.__get__scrollBar = function ()
    {
        return (this._bScrollBar);
    };
    _loc1.setVPosition = function (nPosition)
    {
        var _loc3 = this.getMaxRow();
        if (nPosition > _loc3)
        {
            nPosition = _loc3;
        } // end if
        if (nPosition < 0)
        {
            nPosition = 0;
        } // end if
        if (this._nScrollPosition != nPosition)
        {
            this._nScrollPosition = nPosition;
            this.setScrollBarProperties();
            var _loc4 = this.__height / this._nVisibleRowCount;
            this.layoutContent();
        } // end if
    };
    _loc1.getContainer = function (nIndex)
    {
        return ((ank.gapi.controls.Container)(this._mcScrollContent["c" + nIndex]));
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ContainerGrid.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcScrollContent", 10);
        this.createEmptyMovieClip("_mcMask", 20);
        this.drawRoundRect(this._mcMask, 0, 0, 1, 1, 0, 0);
        this._mcScrollContent.setMask(this._mcMask);
        if (this._bScrollBar)
        {
            this.attachMovie("ScrollBar", "_sbVertical", 30);
            this._sbVertical.addEventListener("scroll", this);
        } // end if
        ank.utils.MouseEvents.addListener(this);
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        if (this._bScrollBar)
        {
            this._sbVertical.setSize(this.__height);
            this._sbVertical.move(this.__width - this._sbVertical.width, 0);
        } // end if
        this._mcMask._width = this.__width - (this._bScrollBar ? (this._sbVertical.width) : (0));
        this._mcMask._height = this.__height;
        this.setScrollBarProperties();
        this._bInvalidateLayout = this._bInitialized;
        this.layoutContent();
    };
    _loc1.layoutContent = function ()
    {
        var _loc2 = (this.__width - (this._bScrollBar ? (this._sbVertical.width) : (0))) / this._nVisibleColumnCount;
        var _loc3 = this.__height / this._nVisibleRowCount;
        var _loc4 = 0;
        if (!this._bInvalidateLayout)
        {
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < this._nVisibleRowCount)
            {
                var _loc6 = 0;
                
                while (++_loc6, _loc6 < this._nVisibleColumnCount)
                {
                    var _loc7 = this._mcScrollContent["c" + _loc4];
                    if (_loc7 == undefined)
                    {
                        _loc7 = (ank.gapi.controls.Container)(this._mcScrollContent.attachMovie("Container", "c" + _loc4, _loc4, {margin: this._nStyleMargin}));
                        _loc7.addEventListener("drag", this);
                        _loc7.addEventListener("drop", this);
                        _loc7.addEventListener("over", this);
                        _loc7.addEventListener("out", this);
                        _loc7.addEventListener("click", this);
                        _loc7.addEventListener("dblClick", this);
                    } // end if
                    _loc7._x = _loc2 * _loc6;
                    _loc7._y = _loc3 * _loc5;
                    _loc7.setSize(_loc2, _loc3);
                    ++_loc4;
                } // end while
            } // end while
        } // end if
        var _loc8 = 0;
        _loc4 = this._nScrollPosition * this._nVisibleColumnCount;
        var _loc9 = 0;
        
        while (++_loc9, _loc9 < this._nVisibleRowCount)
        {
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < this._nVisibleColumnCount)
            {
                var _loc11 = this._mcScrollContent["c" + _loc8];
                _loc11.showLabel = this._eaDataProvider[_loc4].label != undefined && this._eaDataProvider[_loc4].label > 0;
                _loc11.contentData = this._eaDataProvider[_loc4];
                _loc11.id = _loc4;
                if (_loc4 == this._nSelectedIndex)
                {
                    _loc11.selected = true;
                }
                else
                {
                    _loc11.selected = false;
                } // end else if
                _loc11.enabled = this._bEnabled;
                ++_loc4;
                ++_loc8;
            } // end while
        } // end while
        if (!this._bInvalidateLayout)
        {
        } // end if
        this._bInvalidateLayout = false;
    };
    _loc1.draw = function ()
    {
        this._bInvalidateLayout = !this._bInitialized;
        this.layoutContent();
        var _loc2 = this.getStyle();
        var _loc3 = _loc2.containerbackground;
        var _loc4 = _loc2.containerborder;
        var _loc5 = _loc2.containerhighlight;
        this._nStyleMargin = _loc2.containermargin;
        for (var k in this._mcScrollContent)
        {
            var _loc6 = this._mcScrollContent[k];
            _loc6.backgroundRenderer = _loc3;
            _loc6.borderRenderer = _loc4;
            _loc6.highlightRenderer = _loc5;
            _loc6.margin = this._nStyleMargin;
            _loc6.styleName = _loc2.containerstyle;
        } // end of for...in
        if (this._bScrollBar)
        {
            this._sbVertical.styleName = _loc2.scrollbarstyle;
        } // end if
    };
    _loc1.setEnabled = function ()
    {
        for (var k in this._mcScrollContent)
        {
            this._mcScrollContent[k].enabled = this._bEnabled;
        } // end of for...in
        this.addToQueue({object: this, method: function ()
        {
            this._sbVertical.enabled = this._bEnabled;
        }});
    };
    _loc1.getMaxRow = function ()
    {
        return (Math.ceil(this._eaDataProvider.length / this._nVisibleColumnCount) - this._nVisibleRowCount);
    };
    _loc1.setScrollBarProperties = function ()
    {
        var _loc2 = this._nRowCount - this._nVisibleRowCount;
        var _loc3 = this._nVisibleRowCount * (_loc2 / this._nRowCount);
        this._sbVertical.setScrollProperties(_loc3, 0, _loc2);
        this._sbVertical.scrollPosition = this._nScrollPosition;
    };
    _loc1.getItemById = function (nIndex)
    {
        var _loc3 = 0;
        var _loc4 = 0;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._nVisibleRowCount)
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < this._nVisibleColumnCount)
            {
                var _loc7 = this._mcScrollContent["c" + _loc3];
                if (nIndex == _loc7.id)
                {
                    return (_loc7);
                } // end if
                ++_loc3;
            } // end while
        } // end while
    };
    _loc1.setSelectedItem = function (nIndex)
    {
        var _loc3 = 0;
        var _loc4 = 0;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._nVisibleRowCount)
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < this._nVisibleColumnCount)
            {
                var _loc7 = this._mcScrollContent["c" + _loc3];
                if (nIndex == _loc7.id)
                {
                    nIndex = _loc3;
                    _loc4 = _loc7.id;
                } // end if
                ++_loc3;
            } // end while
        } // end while
        if (this._nSelectedIndex != _loc4)
        {
            var _loc8 = this.getItemById(this._nSelectedIndex);
            var _loc9 = this._mcScrollContent["c" + nIndex];
            if (_loc9.contentData == undefined)
            {
                return;
            } // end if
            _loc8.selected = false;
            _loc9.selected = true;
            this._nSelectedIndex = _loc4;
        } // end if
    };
    _loc1.modelChanged = function (oEvent)
    {
        var _loc3 = this._nRowCount;
        this._nRowCount = Math.ceil(this._eaDataProvider.length / this._nVisibleColumnCount);
        this._bInvalidateLayout = true;
        this.layoutContent();
        this.draw();
        this.setScrollBarProperties();
    };
    _loc1.scroll = function (oEvent)
    {
        this.setVPosition(oEvent.target.scrollPosition);
    };
    _loc1.drag = function (oEvent)
    {
        this.dispatchEvent({type: "dragItem", target: oEvent.target});
    };
    _loc1.drop = function (oEvent)
    {
        this.dispatchEvent({type: "dropItem", target: oEvent.target});
    };
    _loc1.over = function (oEvent)
    {
        this.dispatchEvent({type: "overItem", target: oEvent.target});
    };
    _loc1.out = function (oEvent)
    {
        this.dispatchEvent({type: "outItem", target: oEvent.target});
    };
    _loc1.click = function (oEvent)
    {
        if (this._bSelectable)
        {
            this.setSelectedItem(oEvent.target.id);
        } // end if
        this.dispatchEvent({type: "selectItem", target: oEvent.target, owner: this});
    };
    _loc1.dblClick = function (oEvent)
    {
        this.dispatchEvent({type: "dblClickItem", target: oEvent.target, owner: this});
    };
    _loc1.onMouseWheel = function (nDelta, mc)
    {
        if (String(mc._target).indexOf(this._target) != -1)
        {
            this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - (nDelta > 0 ? (1) : (-1));
        } // end if
    };
    _loc1.addProperty("selectedItem", _loc1.__get__selectedItem, function ()
    {
    });
    _loc1.addProperty("selectedIndex", _loc1.__get__selectedIndex, _loc1.__set__selectedIndex);
    _loc1.addProperty("dataProvider", _loc1.__get__dataProvider, _loc1.__set__dataProvider);
    _loc1.addProperty("visibleRowCount", _loc1.__get__visibleRowCount, _loc1.__set__visibleRowCount);
    _loc1.addProperty("selectable", _loc1.__get__selectable, _loc1.__set__selectable);
    _loc1.addProperty("scrollBar", _loc1.__get__scrollBar, _loc1.__set__scrollBar);
    _loc1.addProperty("visibleColumnCount", _loc1.__get__visibleColumnCount, _loc1.__set__visibleColumnCount);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ContainerGrid = function ()
    {
        super();
    }).CLASS_NAME = "ContainerGrid";
    _loc1._nVisibleRowCount = 3;
    _loc1._nVisibleColumnCount = 3;
    _loc1._nRowCount = 1;
    _loc1._bInvalidateLayout = false;
    _loc1._bScrollBar = true;
    _loc1._bSelectable = true;
    _loc1._nScrollPosition = 0;
    _loc1._nStyleMargin = 0;
} // end if
#endinitclip
