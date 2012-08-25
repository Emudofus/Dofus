// Action script...

// [Initial MovieClip Action of sprite 20709]
#initclip 230
if (!dofus.graphics.gapi.ui.AskMainMenu)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskMainMenu = function ()
    {
        super();
    }).prototype;
    _loc1.initWindowContent = function ()
    {
        this._winBackground.title = this.api.lang.getText("MENU");
        var _loc2 = this._winBackground.content;
        _loc2._btnChange.label = this.api.lang.getText("CHANGE_CHARACTER");
        _loc2._btnDisconnect.label = this.api.lang.getText("LOGOFF");
        _loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        _loc2._btnQuit.label = this.api.lang.getText("QUIT_DOFUS");
        _loc2._btnChange.addEventListener("click", this);
        _loc2._btnDisconnect.addEventListener("click", this);
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._btnQuit.addEventListener("click", this);
        this.setEnabledBtnQuit(System.capabilities.playerType == "StandAlone");
        this.setEnabledBtnChange(this.api.ui.getUIComponent("Banner") != undefined);
    };
    _loc1.setEnabledBtnChange = function (bEnable)
    {
        var _loc3 = this._winBackground.content._btnChange;
        _loc3.enabled = bEnable;
    };
    _loc1.setEnabledBtnQuit = function (bEnable)
    {
        var _loc3 = this._winBackground.content._btnQuit;
        _loc3.enabled = bEnable;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnChange":
            {
                this.api.kernel.changeServer();
                break;
            } 
            case "_btnDisconnect":
            {
                this.api.kernel.disconnect();
                break;
            } 
            case "_btnQuit":
            {
                this.api.kernel.quit();
                break;
            } 
        } // End of switch
        this.unloadThis();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskMainMenu = function ()
    {
        super();
    }).CLASS_NAME = "AskMainMenu";
} // end if
#endinitclip
