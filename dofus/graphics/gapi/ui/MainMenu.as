// Action script...

// [Initial MovieClip Action of sprite 20550]
#initclip 71
if (!dofus.graphics.gapi.ui.MainMenu)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.MainMenu = function ()
    {
        super();
    }).prototype;
    _loc1.__set__quitMode = function (sQuitMode)
    {
        this._sQuitMode = sQuitMode;
        if (this.initialized)
        {
            this.setQuitButtonStatus();
        } // end if
        //return (this.quitMode());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MainMenu.CLASS_NAME);
        this._btnBugs._visible = false;
        this._btnSubscribe._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.setQuitButtonStatus});
    };
    _loc1.addListeners = function ()
    {
        this._btnQuit.addEventListener("click", this);
        this._btnOptions.addEventListener("click", this);
        this._btnHelp.addEventListener("click", this);
        this._btnBugs.addEventListener("click", this);
        this._btnSubscribe.addEventListener("click", this);
        this._btnQuit.addEventListener("over", this);
        this._btnOptions.addEventListener("over", this);
        this._btnHelp.addEventListener("over", this);
        this._btnBugs.addEventListener("over", this);
        this._btnSubscribe.addEventListener("over", this);
        this._btnQuit.addEventListener("out", this);
        this._btnOptions.addEventListener("out", this);
        this._btnHelp.addEventListener("out", this);
        this._btnBugs.addEventListener("out", this);
        this._btnSubscribe.addEventListener("out", this);
    };
    _loc1.setQuitButtonStatus = function ()
    {
        this._btnQuit.enabled = this._sQuitMode != "no";
        if (dofus.Constants.BETAVERSION > 0)
        {
            this._mcBackground._x = 730;
            this._bBackgroundMoved = true;
            this._btnBugs._visible = true;
        }
        else if (!this.api.datacenter.Player.subscriber && !this.api.datacenter.Basics.aks_is_free_community)
        {
            this._mcBackground._x = 730;
            this._bBackgroundMoved = true;
            this._btnSubscribe._visible = true;
        }
        else
        {
            this._btnBugs._visible = false;
        } // end else if
    };
    _loc1.updateSubscribeButton = function ()
    {
        if (dofus.Constants.BETAVERSION == 0 && (!this.api.datacenter.Player.subscriber && !this.api.datacenter.Basics.aks_is_free_community))
        {
            if (!this._bBackgroundMoved)
            {
                this._mcBackground._x = 730;
                this._bBackgroundMoved = true;
            } // end if
            this._btnSubscribe._visible = true;
        }
        else if (!this._btnBugs._visible)
        {
            if (this._bBackgroundMoved)
            {
                this._mcBackground._x = 7.443000E+002;
                this._bBackgroundMoved = false;
            } // end if
            this._btnSubscribe._visible = false;
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnQuit:
            {
                if (this._sQuitMode == "quit")
                {
                    this.api.kernel.quit(false);
                }
                else if (this._sQuitMode == "menu")
                {
                    this.gapi.loadUIComponent("AskMainMenu", "AskMainMenu");
                } // end else if
                break;
            } 
            case this._btnOptions:
            {
                this.gapi.loadUIComponent("Options", "Options", {_y: this.gapi.screenHeight == 432 ? (-50) : (0)}, {bAlwaysOnTop: true});
                break;
            } 
            case this._btnHelp:
            {
                if (this.api.ui.getUIComponent("Banner") != undefined)
                {
                    this.gapi.loadUIComponent("KnownledgeBase", "KnownledgeBase");
                }
                else
                {
                    _root.getURL(this.api.lang.getConfigText("TUTORIAL_FILE"), "_blank");
                } // end else if
                break;
            } 
            case this._btnSubscribe:
            {
                _root.getURL(this.api.lang.getConfigText("PAY_LINK"), "_blank");
                break;
            } 
            case this._btnBugs:
            {
                _root.getURL(this.api.lang.getConfigText("BETA_BUGS_REPORT"), "_blank");
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnQuit:
            {
                this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_QUIT"), oEvent.target, 20, {bXLimit: true, bYLimit: true});
                break;
            } 
            case this._btnOptions:
            {
                this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_OPTIONS"), oEvent.target, 20, {bXLimit: true, bYLimit: true});
                break;
            } 
            case this._btnHelp:
            {
                if (this.api.ui.getUIComponent("Banner") != undefined)
                {
                    this.api.ui.showTooltip(this.api.lang.getText("KB_TITLE"), oEvent.target, 20, {bXLimit: true, bYLimit: true});
                }
                else
                {
                    this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_HELP"), oEvent.target, 20, {bXLimit: true, bYLimit: true});
                } // end else if
                break;
            } 
            case this._btnBugs:
            {
                this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_BUGS"), oEvent.target, 20, {bXLimit: true, bYLimit: true});
                break;
            } 
            case this._btnSubscribe:
            {
                this.api.ui.showTooltip(this.api.lang.getText("SUBSCRIPTION"), oEvent.target, 20, {bXLimit: true, bYLimit: true});
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.addProperty("quitMode", function ()
    {
    }, _loc1.__set__quitMode);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MainMenu = function ()
    {
        super();
    }).CLASS_NAME = "MainMenu";
    _loc1._sQuitMode = "no";
} // end if
#endinitclip
