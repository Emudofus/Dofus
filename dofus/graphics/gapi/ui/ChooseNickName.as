// Action script...

// [Initial MovieClip Action of sprite 20972]
#initclip 237
if (!dofus.graphics.gapi.ui.ChooseNickName)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.ChooseNickName = function ()
    {
        super();
    }).prototype;
    _loc1.__set__nickAlreadyUsed = function (bUsed)
    {
        this._lblError._visible = bUsed;
        if (bUsed)
        {
            this.state = 1;
        }
        else
        {
            this.state = 0;
        } // end else if
        //return (this.nickAlreadyUsed());
    };
    _loc1.__set__state = function (nState)
    {
        this._nState = nState;
        switch (this._nState)
        {
            case 0:
            {
                this._mcNickBg._visible = true;
                this._lblError._visible = false;
                this._tiNickName._visible = true;
                this._txtHelp._visible = true;
                this._txtHelp2._visible = false;
                this._tiNickName.setFocus();
                this._txtHelp.text = this.api.lang.getText("CHOOSE_NICKNAME_HELP");
                break;
            } 
            case 1:
            {
                this._mcNickBg._visible = true;
                this._lblError._visible = true;
                this._tiNickName._visible = true;
                this._txtHelp._visible = true;
                this._txtHelp2._visible = false;
                this._tiNickName.setFocus();
                this._txtHelp.text = this.api.lang.getText("CHOOSE_NICKNAME_HELP");
                break;
            } 
            case 2:
            {
                this._mcNickBg._visible = false;
                this._lblError._visible = false;
                this._tiNickName._visible = false;
                this._txtHelp._visible = false;
                this._txtHelp2._visible = true;
                this._txtHelp2.text = this.api.lang.getText("DO_CHOOSE_NICKNAME", [this._tiNickName.text]);
                break;
            } 
        } // End of switch
        //return (this.state());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ChooseNickName.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initInterface});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.initTexts = function ()
    {
        this._btnOk.label = this.api.lang.getText("OK");
        this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        this._lblError.text = this.api.lang.getText("NICKNAME_ALREADY_USED");
        this._lblTitle.text = this.api.lang.getText("CHOOSE_NICKNAME");
    };
    _loc1.addListeners = function ()
    {
        this._btnOk.addEventListener("click", this);
        this._btnCancel.addEventListener("click", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        this.api.kernel.StreamingDisplayManager.onNicknameChoice();
    };
    _loc1.initInterface = function ()
    {
        this.state = 0;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOk":
            {
                var _loc3 = this._tiNickName.text;
                if (_loc3.length > 2)
                {
                    if (_loc3.toUpperCase() == this.api.datacenter.Player.login.toUpperCase())
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("NICKNAME_EQUALS_LOGIN"), "ERROR_BOX");
                    }
                    else
                    {
                        if (this._nState == 2)
                        {
                            this.api.network.Account.setNickName(this._tiNickName.text);
                            return;
                        }
                        else
                        {
                            this.state = 2;
                        } // end else if
                        return;
                    } // end if
                } // end else if
                break;
            } 
            case "_btnCancel":
            {
                if (this._nState == 2)
                {
                    this.state = 0;
                    return;
                } // end if
                this.api.network.disconnect(false, false);
                this.api.kernel.manualLogon();
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" || sShortcut == "CTRL_STATE_CHANGED_OFF")
        {
            this.click({target: this._btnOk});
            return (false);
        } // end if
        return (true);
    };
    _loc1.addProperty("state", function ()
    {
    }, _loc1.__set__state);
    _loc1.addProperty("nickAlreadyUsed", function ()
    {
    }, _loc1.__set__nickAlreadyUsed);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ChooseNickName = function ()
    {
        super();
    }).CLASS_NAME = "ChooseNickName";
    _loc1.isConfirming = false;
} // end if
#endinitclip
