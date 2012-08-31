// Action script...

// [Initial MovieClip Action of sprite 1006]
#initclip 223
class dofus.graphics.gapi.ui.MainMenu extends ank.gapi.core.UIAdvancedComponent
{
    var __get__initialized, __get__quitMode, addToQueue, _btnQuit, _btnOptions, _btnHelp, api, gapi, __set__quitMode;
    function MainMenu()
    {
        super();
    } // End of the function
    function set quitMode(sQuitMode)
    {
        _sQuitMode = sQuitMode;
        if (this.__get__initialized())
        {
            this.setQuitButtonStatus();
        } // end if
        //return (this.quitMode());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.MainMenu.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: setQuitButtonStatus});
    } // End of the function
    function addListeners()
    {
        _btnQuit.addEventListener("click", this);
        _btnOptions.addEventListener("click", this);
        _btnHelp.addEventListener("click", this);
    } // End of the function
    function setQuitButtonStatus()
    {
        _btnQuit.__set__enabled(_sQuitMode != "no");
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target)
        {
            case _btnQuit:
            {
                if (_sQuitMode == "quit")
                {
                    api.kernel.quit(false);
                }
                else if (_sQuitMode == "menu")
                {
                    gapi.loadUIComponent("AskMainMenu", "AskMainMenu");
                } // end else if
                break;
            } 
            case _btnOptions:
            {
                gapi.loadUIComponent("Options", "Options", {_y: gapi.screenHeight == 432 ? (-50) : (0)}, {bAlwaysOnTop: true});
                break;
            } 
            case _btnHelp:
            {
                _root.getURL(api.lang.getConfigText("TUTORIAL_FILE"), "_blank");
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "MainMenu";
    var _sQuitMode = "no";
} // End of Class
#endinitclip
