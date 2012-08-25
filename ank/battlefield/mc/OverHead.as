// Action script...

// [Initial MovieClip Action of sprite 20561]
#initclip 82
if (!ank.battlefield.mc.OverHead)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.mc)
    {
        _global.ank.battlefield.mc = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.mc.OverHead = function (mcSprite, nZoom, mcBattlefield)
    {
        super();
        this._mcBattlefield = mcBattlefield;
        this._mcSprite = mcSprite;
        this._nZoom = nZoom == undefined ? (100) : (nZoom);
        this.initialize();
    }).prototype;
    _loc1.__get__top = function ()
    {
        return (ank.battlefield.mc.OverHead.TOP_Y * this._nZoom / 100);
    };
    _loc1.__get__bottom = function ()
    {
        return (ank.battlefield.mc.OverHead.BOTTOM_Y * this._nZoom / 100);
    };
    _loc1.__get__moderator = function ()
    {
        return (ank.battlefield.mc.OverHead.MODERATOR_Y * this._nZoom / 100);
    };
    _loc1.initialize = function ()
    {
        this._nCurrentItemID = 0;
        this.clear();
    };
    _loc1.clear = function ()
    {
        this._oLayers = new Object();
        this.clearView();
    };
    _loc1.clearView = function ()
    {
        this.createEmptyMovieClip("_mcItems", 10);
    };
    _loc1.setPosition = function (nItemsHeight, nMaxWidth)
    {
        var _loc4 = {x: this._parent._parent._x, y: this._parent._parent._y};
        this._parent._parent.localToGlobal(_loc4);
        this._x = this._mcSprite._x;
        this._y = this._mcSprite._y;
        var _loc5 = 100 / this._nZoom;
        var _loc6 = this.top;
        var _loc7 = this.moderator;
        nItemsHeight = nItemsHeight * _loc5;
        if (this._mcSprite._y < -_loc6 + nItemsHeight - _loc4.y + _loc7)
        {
            this._mcItems._y = this._mcItems._y + (this.bottom + nItemsHeight);
            var _loc8 = 0;
            for (var k in this._oLayers)
            {
                var _loc9 = this._mcItems["item" + _loc8];
                _loc9.reverseClip();
                ++_loc8;
            } // end of for...in
        }
        else
        {
            var _loc10 = Math.abs(_loc6);
            if (this._mcSprite._height > _loc10 + _loc7)
            {
                this._mcItems._y = this._mcItems._y + (_loc6 - _loc7);
            }
            else if (this._mcSprite._height < _loc10 - _loc7)
            {
                this._mcItems._y = this._mcItems._y + (_loc6 + _loc7);
            }
            else
            {
                this._mcItems._y = this._mcItems._y + _loc6;
            } // end else if
        } // end else if
        var _loc11 = nMaxWidth * _loc5 / 2;
        if (this._mcSprite._x < _loc11 - _loc4.x)
        {
            this._x = _loc11;
        } // end if
        if (this._mcSprite._x > this._mcBattlefield.screenWidth * _loc5 - _loc11 + _loc4.x)
        {
            this._x = this._mcBattlefield.screenWidth * _loc5 - _loc11;
        } // end if
    };
    _loc1.addItem = function (sLayerName, className, args, delay)
    {
        var _loc6 = new Object();
        _loc6.id = this._nCurrentItemID;
        _loc6.className = className;
        _loc6.args = args;
        if (delay != undefined)
        {
            ank.utils.Timer.setTimer(_loc6, "battlefield", this, this.removeItem, delay, [this._nCurrentItemID]);
        } // end if
        this._oLayers[sLayerName] = _loc6;
        ++this._nCurrentItemID;
        this.refresh();
    };
    _loc1.remove = function (Void)
    {
        this.swapDepths(1);
        this.removeMovieClip();
    };
    _loc1.refresh = function ()
    {
        this.clearView();
        var _loc2 = 0;
        var _loc3 = 0;
        var _loc4 = 0;
        for (var k in this._oLayers)
        {
            var _loc5 = this._oLayers[k];
            var _loc6 = this._mcItems.attachClassMovie(_loc5.className, "item" + _loc2, _loc2, _loc5.args);
            _loc3 = _loc3 - _loc6.height;
            _loc4 = Math.max(_loc4, _loc6.width);
            _loc6._y = _loc3;
            ++_loc2;
        } // end of for...in
        this.setPosition(Math.abs(_loc3), _loc4);
    };
    _loc1.removeLayer = function (layerName)
    {
        delete this._oLayers[layerName];
        this.refresh();
    };
    _loc1.removeItem = function (nItemID)
    {
        for (var _loc3 in this._oLayers)
        {
            if (this._oLayers[_loc3].id == nItemID)
            {
                delete this._oLayers[_loc3];
                this.refresh();
                break;
            } // end if
        } // end of for...in
    };
    _loc1.addProperty("top", _loc1.__get__top, function ()
    {
    });
    _loc1.addProperty("moderator", _loc1.__get__moderator, function ()
    {
    });
    _loc1.addProperty("bottom", _loc1.__get__bottom, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.battlefield.mc.OverHead = function (mcSprite, nZoom, mcBattlefield)
    {
        super();
        this._mcBattlefield = mcBattlefield;
        this._mcSprite = mcSprite;
        this._nZoom = nZoom == undefined ? (100) : (nZoom);
        this.initialize();
    }).TOP_Y = -50;
    (_global.ank.battlefield.mc.OverHead = function (mcSprite, nZoom, mcBattlefield)
    {
        super();
        this._mcBattlefield = mcBattlefield;
        this._mcSprite = mcSprite;
        this._nZoom = nZoom == undefined ? (100) : (nZoom);
        this.initialize();
    }).BOTTOM_Y = 10;
    (_global.ank.battlefield.mc.OverHead = function (mcSprite, nZoom, mcBattlefield)
    {
        super();
        this._mcBattlefield = mcBattlefield;
        this._mcSprite = mcSprite;
        this._nZoom = nZoom == undefined ? (100) : (nZoom);
        this.initialize();
    }).MODERATOR_Y = 15;
} // end if
#endinitclip
