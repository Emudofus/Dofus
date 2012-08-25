// Action script...

// [Initial MovieClip Action of sprite 20620]
#initclip 141
if (!dofus.graphics.gapi.ui.AskCustomShortcut)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskCustomShortcut = function ()
    {
        super();
    }).prototype;
    _loc1.__set__ShortcutCode = function (sShortcutCode)
    {
        this._sShortcutCode = sShortcutCode;
        //return (this.ShortcutCode());
    };
    _loc1.__set__IsAlt = function (bIsAlt)
    {
        this._bIsAlt = bIsAlt;
        //return (this.IsAlt());
    };
    _loc1.__set__Description = function (sDescription)
    {
        this._sDescription = sDescription;
        this._winBackground.content._txtHelp.text = this._sDescription;
        //return (this.Description());
    };
    _loc1.destroy = function ()
    {
        this.api.ui.getUIComponent("Shortcuts").refresh();
        this.api.kernel.KeyManager.Broadcasting = true;
    };
    _loc1.initWindowContent = function ()
    {
        var _loc2 = this._winBackground.content;
        _loc2._txtHelp.text = this.api.lang.getText("SHORTCUTS_CUSTOM_HELP", [this._sDescription]);
        _loc2._btnOk.label = this.api.lang.getText("OK");
        _loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        _loc2._btnReset.label = this.api.lang.getText("DEFAUT");
        _loc2._btnOk.addEventListener("click", this);
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._btnReset.addEventListener("click", this);
        _loc2._btnNone.addEventListener("click", this);
        var _loc3 = this.api.kernel.KeyManager.getCurrentShortcut(this._sShortcutCode);
        if (this._bIsAlt)
        {
            _loc2._lblShortcut.text = _loc3.d2 == undefined ? (this.api.lang.getText("KEY_UNDEFINED")) : (_loc3.d2);
        }
        else
        {
            _loc2._lblShortcut.text = _loc3.d == undefined ? (this.api.lang.getText("KEY_UNDEFINED")) : (_loc3.d);
        } // end else if
        this.api.kernel.KeyManager.Broadcasting = false;
        Key.addListener(this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOk":
            {
                if (this._nKeyCode != undefined && !_global.isNaN(this._nKeyCode))
                {
                    this.api.kernel.KeyManager.setCustomShortcut(this._sShortcutCode, this._bIsAlt, this._nKeyCode, this._nCtrlCode, this._sAscii);
                } // end if
                this.unloadThis();
                break;
            } 
            case "_btnCancel":
            {
                this.unloadThis();
                break;
            } 
            case "_btnReset":
            {
                var _loc3 = this._winBackground.content;
                var _loc4 = this.api.kernel.KeyManager.getDefaultShortcut(this._sShortcutCode);
                if (!this._bIsAlt)
                {
                    this._nKeyCode = _loc4.k;
                    this._nCtrlCode = _loc4.c;
                    this._sAscii = _loc3._lblShortcut.text = _loc4.s == undefined ? (this.api.lang.getText("KEY_UNDEFINED")) : (_loc4.s);
                }
                else
                {
                    this._nKeyCode = _loc4.k2;
                    this._nCtrlCode = _loc4.c2;
                    this._sAscii = _loc3._lblShortcut.text = _loc4.s2 == undefined ? (this.api.lang.getText("KEY_UNDEFINED")) : (_loc4.s2);
                } // end else if
                break;
            } 
            case "_btnNone":
            {
                var _loc5 = this._winBackground.content;
                this._nKeyCode = -1;
                this._nCtrlCode = undefined;
                this._sAscii = _loc5._lblShortcut.text = this.api.lang.getText("KEY_UNDEFINED");
                break;
            } 
        } // End of switch
    };
    _loc1.onKeyUp = function ()
    {
        var _loc2 = Key.getCode();
        var _loc3 = Key.getAscii();
        if (_loc2 == Key.CONTROL || _loc2 == Key.SHIFT)
        {
            return;
        } // end if
        this._nKeyCode = _loc2;
        var _loc4 = 0;
        if (Key.isDown(Key.CONTROL))
        {
            _loc4 = _loc4 + 1;
        } // end if
        if (Key.isDown(Key.SHIFT))
        {
            _loc4 = _loc4 + 2;
        } // end if
        this._nCtrlCode = _loc4;
        var _loc5 = "";
        if (_loc3 > 32 && _loc3 < 256)
        {
            _loc5 = String.fromCharCode(_loc3);
        }
        else
        {
            _loc5 = this.api.lang.getKeyStringFromKeyCode(_loc2);
        } // end else if
        _loc5 = this.api.lang.getControlKeyString(_loc4) + _loc5;
        this._sAscii = this._winBackground.content._lblShortcut.text = _loc5;
    };
    _loc1.addProperty("ShortcutCode", function ()
    {
    }, _loc1.__set__ShortcutCode);
    _loc1.addProperty("Description", function ()
    {
    }, _loc1.__set__Description);
    _loc1.addProperty("IsAlt", function ()
    {
    }, _loc1.__set__IsAlt);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskCustomShortcut = function ()
    {
        super();
    }).CLASS_NAME = "AskCustomShortcut";
} // end if
#endinitclip
