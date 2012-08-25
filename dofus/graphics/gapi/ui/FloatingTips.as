// Action script...

// [Initial MovieClip Action of sprite 20526]
#initclip 47
if (!dofus.graphics.gapi.ui.FloatingTips)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.FloatingTips = function ()
    {
        super();
    }).prototype;
    _loc1.__get__bounds = function ()
    {
        return (this._oBounds);
    };
    _loc1.__set__bounds = function (oValue)
    {
        this._oBounds = oValue;
        //return (this.bounds());
    };
    _loc1.__get__snap = function ()
    {
        return (this._nSnap);
    };
    _loc1.__set__snap = function (nValue)
    {
        this._nSnap = nValue;
        //return (this.snap());
    };
    _loc1.__get__tip = function ()
    {
        return (this._nTipID);
    };
    _loc1.__set__tip = function (nValue)
    {
        this._nTipID = nValue;
        this.refreshData();
        //return (this.tip());
    };
    _loc1.__get__position = function ()
    {
        return (new com.ankamagames.types.Point(this._x, this._y));
    };
    _loc1.__set__position = function (pValue)
    {
        this._x = pValue.x;
        this._y = pValue.y;
        //return (this.position());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.FloatingTips.CLASS_NAME);
        this._oBounds = {left: 0, top: 0, right: this.gapi.screenWidth, bottom: this.gapi.screenHeight};
        this._nSnap = 20;
    };
    _loc1.destroy = function ()
    {
        Mouse.removeListener(this);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.refreshData});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._taTipsContent.addEventListener("href", this);
        Mouse.addListener(this);
        var myself = this;
        this._winBackground.onPress = function ()
        {
            myself.drag();
        };
        this._winBackground.onRelease = this._winBackground.onReleaseOutside = function ()
        {
            myself.drop();
        };
        this._mcLearnMoreButton.onRelease = function ()
        {
            myself.click({target: myself._mcLearnMoreButton});
        };
    };
    _loc1.initTexts = function ()
    {
        this._winBackground.title = this.api.lang.getText("TIPS_WORD");
        this._lblLearnMore.text = this.api.lang.getText("LEARN_MORE");
    };
    _loc1.refreshData = function ()
    {
        if (this._taTipsContent.text == undefined)
        {
            return;
        } // end if
        this._taTipsContent.text = "<p class=\'body\'>" + this.api.lang.getKnownledgeBaseTip(this._nTipID).c + "</p>";
    };
    _loc1.move = function (nX, nY)
    {
        this._x = nX;
        this._y = nY;
        this.snapWindow();
        this.api.kernel.OptionsManager.setOption("FloatingTipsCoord", new com.ankamagames.types.Point(this._x, this._y));
    };
    _loc1.snapWindow = function ()
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
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.unloadThis();
                break;
            } 
            case "_mcLearnMoreButton":
            {
                this.api.ui.loadUIComponent("KnownledgeBase", "KnownledgeBase", {article: this.api.lang.getKnownledgeBaseTip(this._nTipID).l});
                break;
            } 
        } // End of switch
    };
    _loc1.drag = function ()
    {
        this._nOffsetX = _root._xmouse - this._x;
        this._nOffsetY = _root._ymouse - this._y;
        this._bDraggin = true;
    };
    _loc1.drop = function ()
    {
        this._bDraggin = false;
    };
    _loc1.onMouseMove = function ()
    {
        if (this._bDraggin)
        {
            this.move(_root._xmouse - this._nOffsetX, _root._ymouse - this._nOffsetY);
        } // end if
    };
    _loc1.href = function (oEvent)
    {
        this.api.kernel.TipsManager.onLink(oEvent);
    };
    _loc1.addProperty("tip", _loc1.__get__tip, _loc1.__set__tip);
    _loc1.addProperty("bounds", _loc1.__get__bounds, _loc1.__set__bounds);
    _loc1.addProperty("snap", _loc1.__get__snap, _loc1.__set__snap);
    _loc1.addProperty("position", _loc1.__get__position, _loc1.__set__position);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.FloatingTips = function ()
    {
        super();
    }).CLASS_NAME = "FloatingTips";
    (_global.dofus.graphics.gapi.ui.FloatingTips = function ()
    {
        super();
    }).MINIMUM_ALPHA_VALUE = 40;
    _loc1._bDraggin = false;
    _loc1._nOffsetX = 0;
    _loc1._nOffsetY = 0;
} // end if
#endinitclip
