// Action script...

// [Initial MovieClip Action of sprite 20755]
#initclip 20
if (!dofus.graphics.gapi.ui.AskYesNoIgnore)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskYesNoIgnore = function ()
    {
        super();
    }).prototype;
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        //return (this.text());
    };
    _loc1.__get__text = function ()
    {
        return (this._sText);
    };
    _loc1.__set__player = function (sPlayer)
    {
        this._sPlayer = sPlayer;
        //return (this.player());
    };
    _loc1.__get__player = function ()
    {
        return (this._sPlayer);
    };
    _loc1.callClose = function ()
    {
        this.dispatchEvent({type: "no", params: this.params});
        return (true);
    };
    _loc1.initWindowContent = function ()
    {
        var _loc2 = this._winBackground.content;
        _loc2._txtText.text = this._sText;
        _loc2._txtIgnore.text = "<u><font color=\'" + 255 + "\'><a href=\'asfunction:onHref,\'>" + this.api.lang.getText("POPUP_ADD_IGNORE", [this._sPlayer]) + "</a></font></u>";
        _loc2._txtIgnore.addEventListener("href", this);
        _loc2._btnYes.label = this.api.lang.getText("YES");
        _loc2._btnNo.label = this.api.lang.getText("NO");
        _loc2._btnYes.addEventListener("click", this);
        _loc2._btnNo.addEventListener("click", this);
        _loc2._txtText.addEventListener("change", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnYes":
            {
                this.dispatchEvent({type: "yes", params: this.params});
                break;
            } 
            case "_btnNo":
            {
                this.dispatchEvent({type: "no", params: this.params});
                break;
            } 
        } // End of switch
        this.unloadThis();
    };
    _loc1.change = function (oEvent)
    {
        var _loc3 = this._winBackground.content;
        _loc3._btnYes._y = _loc3._txtText._y + _loc3._txtText.height + 20;
        _loc3._btnNo._y = _loc3._txtText._y + _loc3._txtText.height + 20;
        _loc3._txtIgnore._y = _loc3._btnNo._y + _loc3._btnNo.height + 10;
        this._winBackground.setPreferedSize();
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG")
        {
            this.click({target: this._winBackground.content._btnYes});
            return (false);
        } // end if
        return (true);
    };
    _loc1.href = function (oEvent)
    {
        this.params.player = this._sPlayer;
        this.dispatchEvent({type: "ignore", params: this.params});
        this.unloadThis();
    };
    _loc1.addProperty("player", _loc1.__get__player, _loc1.__set__player);
    _loc1.addProperty("text", _loc1.__get__text, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskYesNoIgnore = function ()
    {
        super();
    }).CLASS_NAME = "AskYesNoIgnore";
} // end if
#endinitclip
