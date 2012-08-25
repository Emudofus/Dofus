// Action script...

// [Initial MovieClip Action of sprite 20935]
#initclip 200
if (!dofus.graphics.gapi.ui.AskAlertServer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskAlertServer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        //return (this.text());
    };
    _loc1.__set__hideNext = function (bHideNext)
    {
        this._bHideNext = bHideNext;
        //return (this.hideNext());
    };
    _loc1.initWindowContent = function ()
    {
        var c = this._winBackground.content;
        c._btnClose.addEventListener("click", this);
        c._btnHideNext.addEventListener("click", this);
        c._txtText.text = this._sText;
        c._btnClose.label = this.api.lang.getText("CLOSE");
        c._lblHideNext.text = this.api.lang.getText("ALERT_HIDENEXT");
        SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).onStatus = function (oEvent)
        {
            if (oEvent.level == "status" && oEvent.code == "SharedObject.Flush.Success")
            {
                c._btnHideNext._visible = true;
                c._lblHideNext._visible = true;
                c._btnHideNext.enabled = true;
                c._btnHideNext.selected = false;
            } // end if
        };
        if (SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).flush() != true)
        {
            c._btnHideNext.enabled = false;
            c._btnHideNext.selected = false;
            c._btnHideNext._visible = false;
            c._lblHideNext._visible = false;
        }
        else
        {
            c._btnHideNext.selected = this._bHideNext;
        } // end else if
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.api.kernel.KeyManager.removeShortcutsListener(this);
                this.dispatchEvent({type: "close", hideNext: this._bHideNext});
                this.unloadThis();
                break;
            } 
            case "_btnHideNext":
            {
                this._bHideNext = oEvent.target.selected;
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        var _loc3 = this._winBackground.content;
        _loc3._btnOk._y = _loc3._txtText._y + _loc3._txtText.height + 20;
        this._winBackground.setPreferedSize();
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG")
        {
            this.click(this._winBackground.content._btnClose);
            return (false);
        } // end if
        return (true);
    };
    _loc1.addProperty("hideNext", function ()
    {
    }, _loc1.__set__hideNext);
    _loc1.addProperty("text", function ()
    {
    }, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskAlertServer = function ()
    {
        super();
    }).CLASS_NAME = "AskAlertServer";
    _loc1._bHideNext = false;
} // end if
#endinitclip
