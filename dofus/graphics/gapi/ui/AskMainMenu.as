// Action script...

// [Initial MovieClip Action of sprite 1008]
#initclip 227
class dofus.graphics.gapi.ui.AskMainMenu extends ank.gapi.ui.FlyWindow
{
    var api, _winBackground, unloadThis;
    function AskMainMenu()
    {
        super();
    } // End of the function
    function initWindowContent()
    {
        _winBackground.__set__title(api.lang.getText("MENU"));
        var _loc2 = _winBackground.__get__content();
        _loc2._btnChange.label = api.lang.getText("CHANGE_CHARACTER");
        _loc2._btnDisconnect.label = api.lang.getText("LOGOFF");
        _loc2._btnCancel.label = api.lang.getText("CANCEL_SMALL");
        _loc2._btnQuit.label = api.lang.getText("QUIT_DOFUS");
        _loc2._btnChange.addEventListener("click", this);
        _loc2._btnDisconnect.addEventListener("click", this);
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._btnQuit.addEventListener("click", this);
        this.setEnabledBtnQuit(System.capabilities.playerType == "StandAlone");
    } // End of the function
    function setEnabledBtnQuit(bEnable)
    {
        var _loc2 = _winBackground.content._btnQuit;
        _loc2.enabled = bEnable;
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnChange":
            {
                api.kernel.changeCharacter();
                break;
            } 
            case "_btnDisconnect":
            {
                api.kernel.disconnect();
                break;
            } 
            case "_btnQuit":
            {
                api.kernel.quit();
                break;
            } 
        } // End of switch
        this.unloadThis();
    } // End of the function
    static var CLASS_NAME = "AskMainMenu";
} // End of Class
#endinitclip
