// Action script...

// [Initial MovieClip Action of sprite 20554]
#initclip 75
if (!ank.gapi.controls.list.SelectableRow)
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
    if (!ank.gapi.controls.list)
    {
        _global.ank.gapi.controls.list = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.list.SelectableRow = function ()
    {
        super();
    }).prototype;
    _loc1.__set__itemIndex = function (nItemIndex)
    {
        this._nItemIndex = nItemIndex;
        //return (this.itemIndex());
    };
    _loc1.__get__itemIndex = function ()
    {
        return (this._nItemIndex);
    };
    _loc1.__get__item = function ()
    {
        return (this._oItem);
    };
    _loc1.__set__index = function (nIndex)
    {
        this._nIndex = nIndex;
        //return (this.index());
    };
    _loc1.__get__index = function ()
    {
        return (this._nIndex);
    };
    _loc1.setCellRenderer = function (link)
    {
        this.cellRenderer_mc.removeMovieClip();
        this.attachMovie(link, "cellRenderer_mc", 100, {styleName: this.getStyle().cellrendererstyle, list: this._parent._parent, row: this});
    };
    _loc1.setState = function (sState)
    {
        this.cellRenderer_mc.setState(sState);
        switch (sState)
        {
            case "selected":
            {
                this.selected_mc._visible = true;
                break;
            } 
            case "normal":
            {
                this.selected_mc._visible = false;
                break;
            } 
        } // End of switch
    };
    _loc1.setValue = function (sSuggested, oItem, sState)
    {
        this._bUsed = oItem != undefined;
        this._oItem = oItem;
        this.cellRenderer_mc.setValue(this._bUsed, sSuggested, oItem);
        this.setState(sState);
    };
    _loc1.select = function ()
    {
        this.bg_mc.onRelease();
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("selected_mc", -10);
        this.createEmptyMovieClip("over_mc", -20);
        this.createEmptyMovieClip("bg_mc", -30);
        this.bg_mc.trackAsMenu = true;
        this.over_mc._visible = false;
        this.selected_mc._visible = false;
        this.bg_mc.useHandCursor = false;
        this.bg_mc.onRollOver = function ()
        {
            if (this._parent._bUsed && this._parent._bEnabled)
            {
                this._parent.over_mc._visible = true;
                this._parent.dispatchEvent({type: "itemRollOver", target: this._parent});
                this._parent._sLastMouseAction = "RollOver";
            } // end if
        };
        this.bg_mc.onRollOut = this.bg_mc.onReleaseOutside = function ()
        {
            if (this._parent._bUsed && this._parent._bEnabled)
            {
                this._parent.dispatchEvent({type: "itemRollOut", target: this._parent});
                this._parent._sLastMouseAction = "RollOut";
            } // end if
            this._parent.over_mc._visible = false;
        };
        this.bg_mc.onPress = function ()
        {
            this._parent._sLastMouseAction = "Press";
        };
        this.bg_mc.onRelease = function ()
        {
            if (this._parent._bUsed && this._parent._bEnabled)
            {
                if (this._parent._sLastMouseAction == "DragOver")
                {
                    this._parent.dispatchEvent({type: "itemDrop"});
                }
                else if (getTimer() - this._parent._nLastClickTime < ank.gapi.Gapi.DBLCLICK_DELAY && !this._parent._bDblClickEnabled)
                {
                    ank.utils.Timer.removeTimer(this._parent, "selectablerow");
                    this._parent.dispatchEvent({type: "itemdblClick"});
                }
                else if (this._parent._bDblClickEnabled)
                {
                    ank.utils.Timer.setTimer(this._parent, "selectablerow", this._parent, this._parent.dispatchEvent, ank.gapi.Gapi.DBLCLICK_DELAY, [{type: "itemSelected"}]);
                }
                else
                {
                    this._parent.dispatchEvent({type: "itemSelected"});
                } // end else if
                this._parent._sLastMouseAction = "Release";
                this._parent._nLastClickTime = getTimer();
            } // end if
        };
        this.bg_mc.onDragOver = function ()
        {
            if (this._parent._bUsed && this._parent._bEnabled)
            {
                this._parent.over_mc._visible = true;
                this._parent.dispatchEvent({type: "itemRollOver", target: this._parent});
                this._parent._sLastMouseAction = "DragOver";
            } // end if
        };
        this.bg_mc.onDragOut = function ()
        {
            if (this._parent._bUsed && this._parent._bEnabled)
            {
                if (this._parent._sLastMouseAction == "Press")
                {
                    this._parent.dispatchEvent({type: "itemDrag"});
                } // end if
                this._parent._sLastMouseAction = "DragOut";
                this._parent.dispatchEvent({type: "itemRollOut", target: this._parent});
            } // end if
            this._parent.over_mc._visible = false;
        };
    };
    _loc1.size = function ()
    {
        super.size();
        this.cellRenderer_mc.setSize(this.__width, this.__height);
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this.over_mc._width = this.selected_mc._width = this.bg_mc._width = this.__width;
        this.over_mc._height = this.selected_mc._height = this.bg_mc._height = this.__height;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        var _loc3 = _loc2.cellbgcolor;
        var _loc4 = _loc2.cellselectedcolor;
        var _loc5 = _loc2.cellovercolor;
        this.over_mc.clear();
        this.selected_mc.clear();
        this.bg_mc.clear();
        this.drawRoundRect(this.over_mc, 0, 0, 1, 1, 0, _loc5, _loc5 == -1 ? (0) : (100));
        this.drawRoundRect(this.selected_mc, 0, 0, 1, 1, 0, _loc4, _loc4 == -1 ? (0) : (100));
        this.drawRoundRect(this.bg_mc, 0, 0, 1, 1, 0, typeof(_loc3) == "object" ? (Number(_loc3[this._nIndex % _loc3.length])) : (Number(_loc3)), _loc3 == -1 ? (0) : (100));
        this.cellRenderer_mc.styleName = _loc2.cellrendererstyle;
    };
    _loc1.addProperty("index", _loc1.__get__index, _loc1.__set__index);
    _loc1.addProperty("item", _loc1.__get__item, function ()
    {
    });
    _loc1.addProperty("itemIndex", _loc1.__get__itemIndex, _loc1.__set__itemIndex);
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bDblClickEnabled = false;
} // end if
#endinitclip
