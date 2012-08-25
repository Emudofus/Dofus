// Action script...

// [Initial MovieClip Action of sprite 20731]
#initclip 252
if (!dofus.graphics.gapi.ui.AskPrivateChat)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskPrivateChat = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.AskPrivateChat.CLASS_NAME);
        this.gapi.getUIComponent("Banner").chatAutoFocus = false;
    };
    _loc1.destroy = function ()
    {
        this.gapi.getUIComponent("Banner").chatAutoFocus = true;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
    };
    _loc1.initWindowContent = function ()
    {
        var _loc2 = this._winBackground.content;
        _loc2._txtMessage.maxChars = dofus.Constants.MAX_MESSAGE_LENGTH;
        _loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        _loc2._btnAddFriend.label = this.api.lang.getText("ADD_TO_FRIENDS");
        _loc2._btnSend.label = this.api.lang.getText("SEND");
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._btnAddFriend.addEventListener("click", this);
        _loc2._btnSend.addEventListener("click", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        Selection.setFocus(_loc2._txtMessage._tText);
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG")
        {
            this.click({target: this._winBackground.content._btnSend});
            return (false);
        } // end if
        return (true);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                this.dispatchEvent({type: "cancel", params: this.params});
                this.unloadThis();
                break;
            } 
            case "_btnSend":
            {
                var _loc3 = this._winBackground.content._txtMessage.text;
                _loc3 = new ank.utils.ExtendedString(_loc3).replace(String.fromCharCode(13), " ");
                this.dispatchEvent({type: "send", message: _loc3, params: this.params});
                this.unloadThis();
                break;
            } 
            case "_btnAddFriend":
            {
                this.dispatchEvent({type: "addfriend", params: this.params});
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskPrivateChat = function ()
    {
        super();
    }).CLASS_NAME = "AskPrivateChat";
} // end if
#endinitclip
