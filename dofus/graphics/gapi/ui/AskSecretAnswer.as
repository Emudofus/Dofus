// Action script...

// [Initial MovieClip Action of sprite 20896]
#initclip 161
if (!dofus.graphics.gapi.ui.AskSecretAnswer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskSecretAnswer = function ()
    {
        super();
    }).prototype;
    _loc1.__get__charToDelete = function ()
    {
        return (this._char);
    };
    _loc1.__set__charToDelete = function (c)
    {
        this._char = c;
        //return (this.charToDelete());
    };
    _loc1.initWindowContent = function ()
    {
        var _loc2 = this._winBackground.content;
        _loc2._txtHelp.text = this.api.lang.getText("DELETING_CHARACTER_ANSWER") + "\r\n" + _global.unescape(this.api.datacenter.Basics.aks_secret_question);
        _loc2._btnOk.label = this.api.lang.getText("OK");
        _loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        _loc2._btnOk.addEventListener("click", this);
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._tiNickName.setFocus();
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOk":
            {
                var _loc3 = this._winBackground.content._tiNickName.text;
                if (_loc3.length > 0)
                {
                    this.api.kernel.showMessage(this.api.lang.getText("DELETE_WORD"), this.api.lang.getText("DO_U_DELETE_A", [this._char.name]), "CAUTION_YESNO", {name: "SecretAnswer", params: {nickname: _loc3}, listener: this});
                } // end if
                break;
            } 
            case "_btnCancel":
            {
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" && this.api.ui.getUIComponent("AskYesNoSecretAnswer") == undefined)
        {
            this.click({target: this._winBackground.content._btnOk});
            return (false);
        } // end if
        return (true);
    };
    _loc1.yes = function (oEvent)
    {
        this.api.network.Account.deleteCharacter(this._char.id, oEvent.params.nickname);
        this.unloadThis();
    };
    _loc1.no = function (oEvent)
    {
        this.unloadThis();
    };
    _loc1.addProperty("charToDelete", _loc1.__get__charToDelete, _loc1.__set__charToDelete);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskSecretAnswer = function ()
    {
        super();
    }).CLASS_NAME = "AskSecretAnswer";
    _loc1.isConfirming = false;
} // end if
#endinitclip
