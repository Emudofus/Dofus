// Action script...

// [Initial MovieClip Action of sprite 20844]
#initclip 109
if (!dofus.graphics.gapi.ui.Debug)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Debug = function ()
    {
        super();
    }).prototype;
    _loc1.setPrompt = function (sPrompt)
    {
        if (this._lblPrompt.text == undefined)
        {
            return;
        } // end if
        this._lblPrompt.text = sPrompt + " > ";
        this._tiCommandLine._x = this._lblPrompt._x + this._lblPrompt.textWidth + 2;
        this._lblPrompt.setPreferedSize("left");
    };
    _loc1.setLogsText = function (sLogs)
    {
        if (this._cLogs.text == undefined)
        {
            return;
        } // end if
        this._cLogs.text = sLogs;
    };
    _loc1.__set__command = function (sCommand)
    {
        this._sCommand = sCommand;
        if (this.initialized)
        {
            this.initCommand();
        } // end if
        //return (this.command());
    };
    _loc1.refresh = function ()
    {
        this.initData();
    };
    _loc1.clear = function ()
    {
        this.api.datacenter.Basics.aks_a_logs = "";
        this.setLogsText("");
    };
    _loc1.showFps = function ()
    {
        if (this._fps == undefined)
        {
            this.attachMovie("Fps", "_fps", this.getNextHighestDepth(), {_x: this._mcFpsPlacer._x, _y: this._mcFpsPlacer._y, _width: this._mcFpsPlacer._width, _height: this._mcFpsPlacer._height, styleName: "DofusFps"});
        }
        else
        {
            this._fps.removeMovieClip();
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Debug.CLASS_NAME);
        this.gapi.getUIComponent("Banner").chatAutoFocus = false;
    };
    _loc1.destroy = function ()
    {
        this.gapi.getUIComponent("Banner").chatAutoFocus = true;
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.applySizeIndex});
        this.addToQueue({object: this, method: this.initCommand});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClear.addEventListener("click", this);
        this._btnCopy.addEventListener("click", this);
        this._btnMinimize.addEventListener("click", this);
        this._cLogs.addEventListener("href", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.initFocus = function ()
    {
        this._tiCommandLine.setFocus();
        this._cLogs.selectable = true;
    };
    _loc1.initData = function ()
    {
        if (this._cLogs.text == undefined)
        {
            return;
        } // end if
        this._cLogs.text = this.api.datacenter.Basics.aks_a_logs;
        this.setPrompt(this.api.datacenter.Basics.aks_a_prompt);
    };
    _loc1.initCommand = function ()
    {
        this._tiCommandLine.text = this._sCommand;
        this.initFocus();
        this.addToQueue({objet: this, method: this.placeCursorAtTheEnd});
    };
    _loc1.placeCursorAtTheEnd = function ()
    {
        this._tiCommandLine.setFocus();
        Selection.setSelection(this._tiCommandLine.text.length, 1000);
    };
    _loc1.applySizeIndex = function ()
    {
        switch (this.api.kernel.OptionsManager.getOption("DebugSizeIndex"))
        {
            case 0:
            {
                this.maximize(dofus.graphics.gapi.ui.Debug.MIDDLE_SIZE);
                break;
            } 
            case 1:
            {
                this.minimize();
                break;
            } 
            case 2:
            {
                this.maximize(dofus.graphics.gapi.ui.Debug.BIG_SIZE);
                break;
            } 
        } // End of switch
        this.initFocus();
    };
    _loc1.minimize = function ()
    {
        this._cLogs._visible = false;
        this._srLogsBack.setSize(undefined, 20);
        this._srCommandLineBack._y = this._tiCommandLine._y = this._lblPrompt._y = this._cLogs._y;
    };
    _loc1.maximize = function (nHeight)
    {
        this._cLogs._visible = true;
        this._cLogs.setSize(undefined, nHeight);
        this._srLogsBack.setSize(undefined, nHeight + 20);
        this._srCommandLineBack._y = this._tiCommandLine._y = this._lblPrompt._y = this._cLogs._y + nHeight;
    };
    _loc1.onShortcut = function (sShortcut)
    {
        var _loc3 = true;
        switch (sShortcut)
        {
            case "HISTORY_UP":
            {
                this._tiCommandLine.text = this.api.kernel.DebugConsole.getHistoryUp().value;
                this.addToQueue({object: this, method: this.placeCursorAtTheEnd});
                _loc3 = false;
                break;
            } 
            case "HISTORY_DOWN":
            {
                this._tiCommandLine.text = this.api.kernel.DebugConsole.getHistoryDown().value;
                this.addToQueue({object: this, method: this.placeCursorAtTheEnd});
                _loc3 = false;
                break;
            } 
            case "TEAM_MESSAGE":
            {
                var _loc4 = this.api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
                _loc4 = _loc4 % 3;
                this.api.kernel.OptionsManager.setOption("DebugSizeIndex", _loc4);
                this.applySizeIndex();
                break;
            } 
            case "ACCEPT_CURRENT_DIALOG":
            {
                if (this._tiCommandLine.focused)
                {
                    var _loc5 = this._tiCommandLine.text;
                    if (_loc5.length == 0)
                    {
                        return (true);
                    } // end if
                    if (this._tiCommandLine.text != undefined)
                    {
                        this._tiCommandLine.text = "";
                    } // end if
                    this.api.kernel.DebugConsole.process(_loc5);
                }
                else
                {
                    this._tiCommandLine.setFocus();
                } // end else if
                _loc3 = false;
                break;
            } 
        } // End of switch
        return (_loc3);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
            case this._btnClear:
            {
                this.clear();
                break;
            } 
            case this._btnCopy:
            {
                System.setClipboard(this._cLogs.text);
                break;
            } 
            case this._btnMinimize:
            {
                var _loc3 = this.api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
                _loc3 = _loc3 % 3;
                this.api.kernel.OptionsManager.setOption("DebugSizeIndex", _loc3);
                this.applySizeIndex();
                break;
            } 
        } // End of switch
    };
    _loc1.href = function (oEvent)
    {
        var _loc3 = oEvent.params.split(",");
        switch (_loc3[0])
        {
            case "ShowPlayerPopupMenu":
            {
                this.api.kernel.GameManager.showPlayerPopupMenu(undefined, _loc3[1]);
                break;
            } 
            case "ExecCmd":
            {
                this._tiCommandLine.text = _loc3[1].split("%2C").join(",");
                if (_loc3[2] == "true" || _loc3[2] == true)
                {
                    this._tiCommandLine.setFocus();
                    this.onShortcut("ACCEPT_CURRENT_DIALOG");
                } // end if
            } 
        } // End of switch
    };
    _loc1.addProperty("command", function ()
    {
    }, _loc1.__set__command);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Debug = function ()
    {
        super();
    }).CLASS_NAME = "Debug";
    (_global.dofus.graphics.gapi.ui.Debug = function ()
    {
        super();
    }).MIDDLE_SIZE = 200;
    (_global.dofus.graphics.gapi.ui.Debug = function ()
    {
        super();
    }).BIG_SIZE = 370;
} // end if
#endinitclip
