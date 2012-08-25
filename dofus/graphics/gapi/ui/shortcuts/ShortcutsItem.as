// Action script...

// [Initial MovieClip Action of sprite 20962]
#initclip 227
if (!dofus.graphics.gapi.ui.shortcuts.ShortcutsItem)
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
    if (!dofus.graphics.gapi.ui.shortcuts)
    {
        _global.dofus.graphics.gapi.ui.shortcuts = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.shortcuts.ShortcutsItem = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            if (oItem.c)
            {
                this._btnMain._visible = false;
                this._btnAlt._visible = false;
                this._rctCatBg._visible = true;
                this._lblDescription.styleName = "GrayLeftSmallBoldLabel";
                this._lblDescription.text = oItem.d;
            }
            else
            {
                var _loc5 = _global.API;
                this._btnMain._visible = true;
                this._btnAlt._visible = true;
                this._rctCatBg._visible = false;
                this._lblDescription.styleName = "BrownLeftSmallLabel";
                this._lblDescription.text = "    " + oItem.d;
                if (oItem.s.k != undefined)
                {
                    if (oItem.s.d == undefined || (oItem.s.d == "" || new ank.utils.ExtendedString(oItem.s.d).trim().toString() == ""))
                    {
                        this._btnMain.label = _loc5.lang.getControlKeyString(oItem.s.c) + _loc5.lang.getKeyStringFromKeyCode(oItem.s.k);
                    }
                    else
                    {
                        this._btnMain.label = oItem.s.d;
                    } // end else if
                }
                else
                {
                    this._btnMain.label = _loc5.lang.getText("KEY_UNDEFINED");
                } // end else if
                if (oItem.s.k2 != undefined)
                {
                    if (oItem.s.d2 == undefined || (oItem.s.d2 == "" || new ank.utils.ExtendedString(oItem.s.d2).trim().toString() == ""))
                    {
                        this._btnAlt.label = _loc5.lang.getControlKeyString(oItem.s.c2) + _loc5.lang.getKeyStringFromKeyCode(oItem.s.k2);
                    }
                    else
                    {
                        this._btnAlt.label = oItem.s.d2;
                    } // end else if
                }
                else
                {
                    this._btnAlt.label = _loc5.lang.getText("KEY_UNDEFINED");
                } // end else if
                this._btnMain.enabled = this._btnAlt.enabled = !oItem.l;
            } // end else if
            this._sShortcut = oItem.k;
        }
        else if (this._lblDescription.text != undefined)
        {
            this._lblDescription.styleName = "BrownLeftSmallLabel";
            this._lblDescription.text = "";
            this._rctCatBg._visible = false;
            this._btnMain._visible = false;
            this._btnMain.label = "";
            this._btnAlt._visible = false;
            this._btnAlt.label = "";
            this._sShortcut = undefined;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._rctCatBg._visible = false;
        this._btnMain._visible = false;
        this._btnAlt._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnMain.addEventListener("click", this);
        this._btnAlt.addEventListener("click", this);
    };
    _loc1.click = function (oEvent)
    {
        if (this._sShortcut == undefined)
        {
            return;
        } // end if
        var _loc3 = _global.API;
        switch (oEvent.target._name)
        {
            case "_btnMain":
            {
                _loc3.kernel.KeyManager.askCustomShortcut(this._sShortcut, false);
                break;
            } 
            case "_btnAlt":
            {
                _loc3.kernel.KeyManager.askCustomShortcut(this._sShortcut, true);
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
