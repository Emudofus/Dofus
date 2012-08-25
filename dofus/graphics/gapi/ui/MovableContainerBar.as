// Action script...

// [Initial MovieClip Action of sprite 20621]
#initclip 142
if (!dofus.graphics.gapi.ui.MovableContainerBar)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.MovableContainerBar = function ()
    {
        super();
    }).prototype;
    _loc1.__get__containers = function ()
    {
        return (this._aContainers);
    };
    _loc1.__get__size = function ()
    {
        return (this._nContainerNumber);
    };
    _loc1.__set__size = function (n)
    {
        if (n < 0)
        {
            n = 0;
        } // end if
        if (n > this._nMaxContainer)
        {
            n = this._nMaxContainer;
        } // end if
        if (n != this._nContainerNumber)
        {
            this._nContainerNumber = n;
            this.move(this._x, this._y, true);
        } // end if
        //return (this.size());
    };
    _loc1.__get__maxContainer = function ()
    {
        return (this._nMaxContainer);
    };
    _loc1.__set__maxContainer = function (n)
    {
        this._nMaxContainer = n;
        if (this._nContainerNumber > n)
        {
            this.size = n;
        } // end if
        //return (this.maxContainer());
    };
    _loc1.__get__bounds = function ()
    {
        return (this._oBounds);
    };
    _loc1.__set__bounds = function (o)
    {
        this._oBounds = o;
        //return (this.bounds());
    };
    _loc1.__get__snap = function ()
    {
        return (this._nSnap);
    };
    _loc1.__set__snap = function (n)
    {
        this._nSnap = n;
        //return (this.snap());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MovableContainerBar.CLASS_NAME);
        this._nContainerNumber = 1;
        this._nMaxContainer = 5;
        this._bVertical = false;
        this._oBounds = {left: 0, top: 0, right: 800, bottom: 600};
        this._nSnap = 20;
        this._nOffsetX = 0;
        this._nOffsetY = 0;
    };
    _loc1.createChildren = function ()
    {
        Mouse.addListener(this);
        this._mcDragOne.onPress = this._mcDragTwo.onPress = function ()
        {
            if (this._parent._bTimerEnable != true)
            {
                this._parent.onMouseMove = this._parent._onMouseMove;
                this._parent._nOffsetX = _root._xmouse - this._parent._x;
                this._parent._nOffsetY = _root._ymouse - this._parent._y;
            } // end if
        };
        this._mcDragOne.onRelease = this._mcDragOne.onReleaseOutside = this._mcDragTwo.onRelease = this._mcDragTwo.onReleaseOutside = function ()
        {
            if (this._parent._bTimerEnable != true)
            {
                this._parent.onMouseMove = undefined;
                this._parent._nOffsetX = 0;
                this._parent._nOffsetY = 0;
                this._parent.dispatchEvent({type: "drop"});
                this._parent._bTimerEnable = true;
                ank.utils.Timer.setTimer(this._parent, "movablecontainerbar", this._parent, this._parent.onClickTimer, ank.gapi.Gapi.DBLCLICK_DELAY);
            }
            else
            {
                this._parent.onClickTimer();
                this._parent.dispatchEvent({type: "dblClick"});
            } // end else if
        };
        this._mcBackground.onRelease = function ()
        {
        };
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.drawBar = function ()
    {
        this._aContainers = new Array();
        this._mcContainers = this.createEmptyMovieClip("_mcContainers", 1);
        var _loc2 = new Object();
        _loc2.backgroundRenderer = "UI_BannerContainerBackground";
        _loc2.borderRenderer = "UI_BannerContainerBorder";
        _loc2.dragAndDrop = true;
        _loc2.enabled = true;
        _loc2.highlightFront = true;
        _loc2.highlightRenderer = "UI_BannerContainerHighLight";
        _loc2.margin = 1;
        _loc2.showLabel = false;
        _loc2.styleName = "InventoryGridContainer";
        switch (this._bVertical)
        {
            case true:
            {
                this._mcDragOne._x = 3;
                this._mcDragOne._y = 3;
                this._mcDragTwo._x = 3;
                this._mcDragTwo._y = 18 + this._nContainerNumber * (25 + 3);
                this._mcDragOne._width = this._mcDragTwo._width = 25;
                this._mcDragOne._height = this._mcDragTwo._height = 12;
                this._mcDragOne.styleName = "VerticalDragOneMovableBarStylizedRectangle";
                this._mcDragTwo.styleName = "VerticalDragTwoMovableBarStylizedRectangle";
                this._mcContainers._x = 3;
                this._mcContainers._y = 18;
                var _loc3 = 0;
                
                while (++_loc3, _loc3 < this._nContainerNumber)
                {
                    _loc2._y = (25 + 3) * _loc3;
                    var _loc4 = this._mcContainers.attachMovie("Container", "_ctr" + _loc3, _loc3, _loc2);
                    _loc4.setSize(25, 25);
                    this._aContainers.push(_loc4);
                } // end while
                this._mcBackground.setSize(31, 33 + this._nContainerNumber * (25 + 3));
                break;
            } 
            case false:
            {
                this._mcDragOne._x = 3;
                this._mcDragOne._y = 3;
                this._mcDragTwo._x = 18 + this._nContainerNumber * (25 + 3);
                this._mcDragTwo._y = 3;
                this._mcDragOne._width = this._mcDragTwo._width = 12;
                this._mcDragOne._height = this._mcDragTwo._height = 25;
                this._mcDragOne.styleName = "HorizontalDragOneMovableBarStylizedRectangle";
                this._mcDragTwo.styleName = "HorizontalDragTwoMovableBarStylizedRectangle";
                this._mcContainers._x = 18;
                this._mcContainers._y = 3;
                var _loc5 = 0;
                
                while (++_loc5, _loc5 < this._nContainerNumber)
                {
                    _loc2._x = (25 + 3) * _loc5;
                    var _loc6 = this._mcContainers.attachMovie("Container", "_ctr" + _loc5, _loc5, _loc2);
                    _loc6.setSize(25, 25);
                    this._aContainers.push(_loc6);
                } // end while
                this._mcBackground.setSize(33 + this._nContainerNumber * (25 + 3), 31);
                break;
            } 
        } // End of switch
        this.dispatchEvent({type: "drawBar"});
    };
    _loc1.autoDetectBarOrientation = function (x, y)
    {
        var _loc4 = y - this._oBounds.top;
        var _loc5 = this._oBounds.bottom - y;
        var _loc6 = x - this._oBounds.left;
        var _loc7 = this._oBounds.right - x;
        var _loc8 = this._bVertical;
        var _loc9 = 1000000;
        if (_loc4 < this._nSnap)
        {
            if (_loc4 < _loc9)
            {
                _loc9 = _loc4;
                _loc8 = false;
            } // end if
        } // end if
        if (_loc5 < this._nSnap)
        {
            if (_loc5 < _loc9)
            {
                _loc9 = _loc5;
                _loc8 = false;
            } // end if
        } // end if
        if (_loc6 < this._nSnap)
        {
            if (_loc6 < _loc9)
            {
                _loc9 = _loc6;
                _loc8 = true;
            } // end if
        } // end if
        if (_loc7 < this._nSnap)
        {
            if (_loc7 < _loc9)
            {
                _loc9 = _loc7;
                _loc8 = true;
            } // end if
        } // end if
        if (_loc8 != undefined && this._bVertical != _loc8)
        {
            this._bVertical = _loc8;
            return (true);
        } // end if
        return (false);
    };
    _loc1.snapBar = function ()
    {
        var _loc2 = this._x;
        var _loc3 = this._y;
        var _loc4 = this.getBounds();
        var _loc5 = _loc3 + _loc4.yMin - this._oBounds.top;
        var _loc6 = this._oBounds.bottom - _loc3 - _loc4.yMax;
        var _loc7 = _loc2 + _loc4.xMin - this._oBounds.left;
        var _loc8 = this._oBounds.right - _loc2 - _loc4.xMax;
        if (_loc5 < this._nSnap)
        {
            _loc3 = this._oBounds.top - _loc4.yMin;
        } // end if
        if (_loc6 < this._nSnap)
        {
            _loc3 = this._oBounds.bottom - _loc4.yMax;
        } // end if
        if (_loc7 < this._nSnap)
        {
            _loc2 = this._oBounds.left - _loc4.xMin;
        } // end if
        if (_loc8 < this._nSnap)
        {
            _loc2 = this._oBounds.right - _loc4.xMax;
        } // end if
        this._y = _loc3;
        this._x = _loc2;
    };
    _loc1.destroy = function ()
    {
        Mouse.removeListener(this);
    };
    _loc1.move = function (x, y, bForceDraw)
    {
        if (this.autoDetectBarOrientation(x, y) || bForceDraw)
        {
            this.drawBar();
        } // end if
        this._x = x;
        this._y = y;
        this.snapBar();
    };
    _loc1.setOptions = function (m, s, b, si, c)
    {
        this._nMaxContainer = m;
        this._nSnap = s;
        this._oBounds = b;
        this._nContainerNumber = si;
        this.move(c.x, c.y, true);
    };
    _loc1._onMouseMove = function ()
    {
        this.move(_root._xmouse - this._nOffsetX, _root._ymouse - this._nOffsetY);
    };
    _loc1.onClickTimer = function ()
    {
        ank.utils.Timer.removeTimer(this, "movablecontainerbar");
        this._bTimerEnable = false;
    };
    _loc1.onShortcut = function (shortcut)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._nContainerNumber)
        {
            if (shortcut == "MOVABLEBAR_SH" + _loc3)
            {
                this._aContainers[_loc3].notInChat = true;
                this._aContainers[_loc3].emulateClick();
                return (false);
            } // end if
        } // end while
        return (true);
    };
    _loc1.addProperty("snap", _loc1.__get__snap, _loc1.__set__snap);
    _loc1.addProperty("bounds", _loc1.__get__bounds, _loc1.__set__bounds);
    _loc1.addProperty("maxContainer", _loc1.__get__maxContainer, _loc1.__set__maxContainer);
    _loc1.addProperty("size", _loc1.__get__size, _loc1.__set__size);
    _loc1.addProperty("containers", _loc1.__get__containers, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MovableContainerBar = function ()
    {
        super();
    }).CLASS_NAME = "MovableContainerBar";
} // end if
#endinitclip
