// Action script...

// [Initial MovieClip Action of sprite 20689]
#initclip 210
if (!dofus.graphics.gapi.ui.Tips)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Tips = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Tips.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.showTip});
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("TIPS");
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        this._lblTipsOnStart.text = this.api.lang.getText("SHOW_TIPS_ON_STARTUP");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._btnTipsOnStart.addEventListener("click", this);
        this._btnNext.addEventListener("click", this);
        this._btnPrevious.addEventListener("click", this);
        this._btnTipsOnStartTooltip.addEventListener("over", this);
        this._btnTipsOnStartTooltip.addEventListener("out", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
        _loc2._parentRef = this;
        _loc2.onStatus = function (oEvent)
        {
            if (oEvent.level == "status" && oEvent.code == "SharedObject.Flush.Success")
            {
                this._parentRef._btnTipsOnStart._visible = true;
                this._parentRef._lblTipsOnStart._visible = true;
                this._parentRef._btnTipsOnStart.enabled = true;
                this._parentRef._btnTipsOnStartTooltip._visible = false;
                this._parentRef._bSOEnabled = true;
            } // end if
        };
        if (SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).flush() != true)
        {
            this._btnTipsOnStart.enabled = false;
            this._btnTipsOnStart.selected = false;
            this._bSOEnabled = false;
        }
        else
        {
            this._btnTipsOnStartTooltip._visible = false;
            this._btnTipsOnStart.selected = this.api.kernel.OptionsManager.getOption("TipsOnStart");
        } // end else if
    };
    _loc1.showTip = function (nID)
    {
        var _loc3 = this.api.lang.getTips().length - 1;
        if (nID == undefined)
        {
            nID = random(_loc3);
        } // end if
        if (nID > _loc3)
        {
            nID = 0;
        } // end if
        if (nID < 0)
        {
            nID = _loc3;
        } // end if
        this._nCurrentID = nID;
        var _loc4 = this.api.lang.getTip(nID);
        if (_loc4 != undefined)
        {
            this._txtTip.text = _loc4;
        }
        else
        {
            this.unloadThis();
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            case "_btnTipsOnStart":
            {
                this.api.kernel.OptionsManager.setOption("TipsOnStart", oEvent.target.selected);
                break;
            } 
            case "_btnPrevious":
            {
                this.showTip(this._nCurrentID - 1);
                break;
            } 
            case "_btnNext":
            {
                this.showTip(this._nCurrentID + 1);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        if (this._bSOEnabled == false)
        {
            this.gapi.showTooltip("Les cookies flash doivent être activés pour accèder à cette fonctionnalité.", this._btnTipsOnStart, -30);
        } // end if
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Tips = function ()
    {
        super();
    }).CLASS_NAME = "Tips";
    _loc1._bSOEnabled = true;
    _loc1._nCurrentID = 0;
} // end if
#endinitclip
