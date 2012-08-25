// Action script...

// [Initial MovieClip Action of sprite 20606]
#initclip 127
if (!dofus.graphics.gapi.ui.KeyCode)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.KeyCode = function ()
    {
        super();
    }).prototype;
    _loc1.__set__title = function (sTitle)
    {
        this.addToQueue({object: this, method: function ()
        {
            this._winCode.title = sTitle;
        }});
        //return (this.title());
    };
    _loc1.__set__changeType = function (nChangeType)
    {
        this._nChangeType = nChangeType;
        //return (this.changeType());
    };
    _loc1.__set__slotsCount = function (nSlotsCount)
    {
        if (nSlotsCount > 8)
        {
            ank.utils.Logger.err("[slotsCount] doit être au max 8");
            return;
        } // end if
        this._nSlotsCount = nSlotsCount;
        this._aKeyCode = new Array();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < nSlotsCount)
        {
            this._aKeyCode[_loc3] = "_";
        } // end while
        //return (this.slotsCount());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.KeyCode.CLASS_NAME);
        this.gapi.getUIComponent("Banner").chatAutoFocus = false;
    };
    _loc1.destroy = function ()
    {
        this.gapi.getUIComponent("Banner").chatAutoFocus = true;
    };
    _loc1.callClose = function ()
    {
        this.api.network.Key.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.drawCodeSlots();
        this.selectNextSlot();
        this._mcSlotPlacer._visible = false;
        this._btnNoCode._visible = false;
    };
    _loc1.addListeners = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 10)
        {
            var _loc3 = this["_ctrSymbol" + _loc2];
            _loc3.addEventListener("drag", this);
            _loc3.addEventListener("click", this);
            _loc3.addEventListener("dblClick", this);
            _loc3.params = {index: _loc2};
        } // end while
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        this.api.kernel.KeyManager.addKeysListener("onKeys", this);
        this._btnValidate.addEventListener("click", this);
        this._btnNoCode.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        switch (this._nChangeType)
        {
            case 0:
            {
                this._btnValidate.label = this.api.lang.getText("UNLOCK");
                this._txtDescription.text = this.api.lang.getText("UNLOCK_INFOS");
                break;
            } 
            case 1:
            {
                this._btnValidate.label = this.api.lang.getText("CHANGE");
                this._btnNoCode.label = this.api.lang.getText("NO_CODE");
                this._txtDescription.text = this.api.lang.getText("LOCK_INFOS");
                break;
            } 
        } // End of switch
    };
    _loc1.initData = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 10)
        {
            this["_ctrSymbol" + _loc2].contentData = {iconFile: "UI_KeyCodeSymbol" + _loc2, value: String(_loc2)};
        } // end while
        switch (this._nChangeType)
        {
            case 0:
            {
                this._btnNoCode._visible = false;
                break;
            } 
            case 1:
            {
                this._btnNoCode._visible = true;
                break;
            } 
        } // End of switch
    };
    _loc1.drawCodeSlots = function ()
    {
        this._mcSlots.removeMovieClip();
        this.createEmptyMovieClip("_mcSlots", 10);
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._nSlotsCount)
        {
            var _loc3 = this._mcSlots.attachMovie("Container", "_ctrCode" + _loc2, _loc2, {_x: _loc2 * dofus.graphics.gapi.ui.KeyCode.CODE_SLOT_WIDTH, backgroundRenderer: "UI_KeyCodeContainer", dragAndDrop: true, highlightRenderer: "UI_KeyCodeHighlight", styleName: "none", enabled: true, _width: 30, _height: 30});
            _loc3.addEventListener("drop", this);
            _loc3.addEventListener("drag", this);
            _loc3.params = {index: _loc2};
        } // end while
        this._mcSlots._x = this._mcSlotPlacer._x - this._mcSlots._width;
        this._mcSlots._y = this._mcSlotPlacer._y;
    };
    _loc1.selectPreviousSlot = function ()
    {
        var _loc2 = this._nCurrentSelectedSlot;
        --this._nCurrentSelectedSlot;
        if (this._nCurrentSelectedSlot < 0)
        {
            this._nCurrentSelectedSlot = this._nSlotsCount - 1;
        } // end if
        this.selectSlot(_loc2, this._nCurrentSelectedSlot);
    };
    _loc1.selectNextSlot = function ()
    {
        var _loc2 = this._nCurrentSelectedSlot;
        this._nCurrentSelectedSlot = ++this._nCurrentSelectedSlot % this._nSlotsCount;
        this.selectSlot(_loc2, this._nCurrentSelectedSlot);
    };
    _loc1.selectSlot = function (nLastSlotID, nSlotID)
    {
        var _loc4 = this._mcSlots["_ctrCode" + nLastSlotID];
        _loc4.selected = false;
        this._mcSlots["_ctrCode" + nSlotID].selected = true;
    };
    _loc1.setKeyInCurrentSlot = function (nKey)
    {
        var _loc3 = this._mcSlots["_ctrCode" + this._nCurrentSelectedSlot];
        var _loc4 = this["_ctrSymbol" + nKey];
        _loc3.contentData = _loc4.contentData;
        this._aKeyCode[this._nCurrentSelectedSlot] = nKey;
        this.selectNextSlot();
    };
    _loc1.validate = function ()
    {
        var _loc2 = true;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aKeyCode.length)
        {
            if (this._aKeyCode[_loc3] != "_")
            {
                _loc2 = false;
                continue;
            } // end if
        } // end while
        this.api.network.Key.sendKey(this._nChangeType, _loc2 ? ("-") : (this._aKeyCode.join("")));
    };
    _loc1.dblClick = function (oEvent)
    {
        this.click(oEvent);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnNoCode":
            {
                this.api.network.Key.sendKey(this._nChangeType, "-");
                break;
            } 
            case "_btnValidate":
            {
                this.validate();
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            default:
            {
                this.setKeyInCurrentSlot(oEvent.target.params.index);
                break;
            } 
        } // End of switch
    };
    _loc1.drop = function (oEvent)
    {
        var _loc3 = this.gapi.getCursor();
        if (_loc3 == undefined)
        {
            return;
        } // end if
        this.gapi.removeCursor();
        oEvent.target.contentData = _loc3;
        this._aKeyCode[oEvent.target.params.index] = _loc3.value;
    };
    _loc1.drag = function (oEvent)
    {
        this.gapi.removeCursor();
        var _loc3 = oEvent.target.contentData;
        if (_loc3 == undefined)
        {
            return;
        } // end if
        this.gapi.setCursor(_loc3);
        if (oEvent.target._parent != this)
        {
            oEvent.target.contentData = undefined;
            this._aKeyCode[oEvent.target.params.index] = "_";
        } // end if
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (Selection.getFocus() != null)
        {
            return (true);
        } // end if
        if (sShortcut == "CODE_CLEAR")
        {
            this.setKeyInCurrentSlot();
            return (false);
        } // end if
        if (sShortcut == "CODE_NEXT")
        {
            this.selectNextSlot();
            return (false);
        } // end if
        if (sShortcut == "CODE_PREVIOUS")
        {
            this.selectPreviousSlot();
            return (false);
        } // end if
        if (sShortcut == "ACCEPT_CURRENT_DIALOG")
        {
            this.validate();
            return (false);
        } // end if
        return (true);
    };
    _loc1.onKeys = function (sKey)
    {
        if (Selection.getFocus() != null)
        {
            return;
        } // end if
        var _loc3 = sKey.charCodeAt(0) - 48;
        if (_loc3 < 0 || _loc3 > 9)
        {
            return;
        } // end if
        this.setKeyInCurrentSlot(_loc3);
    };
    _loc1.addProperty("slotsCount", function ()
    {
    }, _loc1.__set__slotsCount);
    _loc1.addProperty("changeType", function ()
    {
    }, _loc1.__set__changeType);
    _loc1.addProperty("title", function ()
    {
    }, _loc1.__set__title);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.KeyCode = function ()
    {
        super();
    }).CLASS_NAME = "KeyCode";
    (_global.dofus.graphics.gapi.ui.KeyCode = function ()
    {
        super();
    }).CODE_SLOT_WIDTH = 40;
    _loc1._aKeyCode = new Array();
    _loc1._nCurrentSelectedSlot = -1;
} // end if
#endinitclip
