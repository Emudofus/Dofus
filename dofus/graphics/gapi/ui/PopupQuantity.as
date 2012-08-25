// Action script...

// [Initial MovieClip Action of sprite 20612]
#initclip 133
if (!dofus.graphics.gapi.ui.PopupQuantity)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.PopupQuantity = function ()
    {
        super();
    }).prototype;
    _loc1.__set__value = function (nValue)
    {
        this._nValue = nValue;
        //return (this.value());
    };
    _loc1.__set__max = function (nMax)
    {
        this._nMax = nMax;
        //return (this.max());
    };
    _loc1.__set__min = function (nMin)
    {
        this._nMin = nMin;
        //return (this.min());
    };
    _loc1.__set__useAllStage = function (bUseAllStage)
    {
        this._bUseAllStage = bUseAllStage;
        //return (this.useAllStage());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.PopupQuantity.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._winBackground.addEventListener("complete", this);
        this._bgHidder.addEventListener("click", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.initWindowContent = function ()
    {
        var _loc2 = this._winBackground.content;
        _loc2._btnOk.addEventListener("click", this);
        _loc2._btnMax.addEventListener("click", this);
        _loc2._btnMin.addEventListener("click", this);
        _loc2._btnMax.label = this.api.lang.getText("MAX_WORD");
        _loc2._btnMin.label = this.api.lang.getText("MIN_WORD");
        _loc2._tiInput.restrict = "0-9";
        _loc2._tiInput.text = this._nValue;
        _loc2._tiInput.setFocus();
    };
    _loc1.placeWindow = function ()
    {
        var _loc2 = this._xmouse - this._winBackground.width;
        var _loc3 = this._ymouse - this._winBackground._height;
        var _loc4 = this._bUseAllStage ? (Stage.width) : (this.gapi.screenWidth);
        var _loc5 = this._bUseAllStage ? (Stage.height) : (this.gapi.screenHeight);
        if (_loc2 < 0)
        {
            _loc2 = 0;
        } // end if
        if (_loc3 < 0)
        {
            _loc3 = 0;
        } // end if
        if (_loc2 > _loc4 - this._winBackground.width)
        {
            _loc2 = _loc4 - this._winBackground.width;
        } // end if
        if (_loc3 > _loc5 - this._winBackground.height)
        {
            _loc3 = _loc5 - this._winBackground.height;
        } // end if
        this._winBackground._x = _loc2;
        this._winBackground._y = _loc3;
    };
    _loc1.validate = function ()
    {
        this.api.kernel.KeyManager.removeShortcutsListener(this);
        this.dispatchEvent({type: "validate", value: _global.parseInt(this._winBackground.content._tiInput.text, 10), params: this._oParams});
    };
    _loc1.complete = function (oEvent)
    {
        this.placeWindow();
        this.addToQueue({object: this, method: this.initWindowContent});
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOk":
            {
                this.validate();
                break;
            } 
            case "_btnMax":
            {
                this._winBackground.content._tiInput.text = this._nMax;
                this._winBackground.content._tiInput.setFocus();
                return;
            } 
            case "_btnMin":
            {
                this._winBackground.content._tiInput.text = this._nMin;
                this._winBackground.content._tiInput.setFocus();
                return;
            } 
            case "_bgHidder":
            {
                break;
            } 
        } // End of switch
        this.unloadThis();
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG")
        {
            this.validate();
            this.unloadThis();
            return (false);
        } // end if
        return (true);
    };
    _loc1.addProperty("useAllStage", function ()
    {
    }, _loc1.__set__useAllStage);
    _loc1.addProperty("value", function ()
    {
    }, _loc1.__set__value);
    _loc1.addProperty("max", function ()
    {
    }, _loc1.__set__max);
    _loc1.addProperty("min", function ()
    {
    }, _loc1.__set__min);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.PopupQuantity = function ()
    {
        super();
    }).CLASS_NAME = "PopupQuantity";
    _loc1._nValue = 0;
    _loc1._bUseAllStage = false;
    _loc1._nMax = 1;
    _loc1._nMin = 1;
} // end if
#endinitclip
