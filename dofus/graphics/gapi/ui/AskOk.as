// Action script...

// [Initial MovieClip Action of sprite 20517]
#initclip 38
if (!dofus.graphics.gapi.ui.AskOk)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskOk = function ()
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
    _loc1.initWindowContent = function ()
    {
        var _loc2 = this._winBackground.content;
        _loc2._btnOk.addEventListener("click", this);
        _loc2._txtText.addEventListener("change", this);
        _loc2._txtText.text = this._sText;
        _loc2._btnOk.label = this.api.lang.getText("OK");
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.click = function (oEvent)
    {
        this.api.kernel.KeyManager.removeShortcutsListener(this);
        this.dispatchEvent({type: "ok"});
        this.unloadThis();
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
            Selection.setFocus();
            this.click();
            return (false);
        } // end if
        return (true);
    };
    _loc1.addProperty("text", _loc1.__get__text, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskOk = function ()
    {
        super();
    }).CLASS_NAME = "AskOk";
} // end if
#endinitclip
