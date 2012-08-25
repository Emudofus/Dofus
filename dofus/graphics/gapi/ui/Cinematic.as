// Action script...

// [Initial MovieClip Action of sprite 20531]
#initclip 52
if (!dofus.graphics.gapi.ui.Cinematic)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Cinematic = function ()
    {
        super();
    }).prototype;
    _loc1.__set__file = function (sFile)
    {
        this._sFile = sFile;
        //return (this.file());
    };
    _loc1.__set__sequencer = function (oSequencer)
    {
        this._oSequencer = oSequencer;
        //return (this.sequencer());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Cinematic.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        _root._quality = this._sOldQuality;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.loadFile});
    };
    _loc1.startCinematic = function (mcCinematic)
    {
        mcCinematic.gotoAndPlay(1);
    };
    _loc1.addListeners = function ()
    {
        this._ldrLoader.addEventListener("initialization", this);
        this._ldrLoader.addEventListener("complete", this);
        this._btnCancel.addEventListener("click", this);
        this._btnCancel.addEventListener("over", this);
        this._btnCancel.addEventListener("out", this);
    };
    _loc1.loadFile = function ()
    {
        this._ldrLoader.contentPath = this._sFile;
        this._sOldQuality = _root._quality;
        _root._quality = "MEDIUM";
        this._lblWhite.text = this.api.lang.getText("LOADING");
    };
    _loc1.initialization = function (oEvent)
    {
        this._lblWhite._visible = false;
        oEvent.target.content.cinematic = this;
        this.addToQueue({object: this, method: this.startCinematic, params: [oEvent.target.content]});
    };
    _loc1.complete = function (oEvent)
    {
        oEvent.target.stop();
        oEvent.target.content.stop();
        oEvent.target.content.cinematic.stop();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnCancel:
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("LEAVE_CINEMATIC"), "CAUTION_YESNO", {name: "Cinematic", listener: this});
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnCancel:
            {
                this.gapi.showTooltip(this.api.lang.getText("CANCEL_CINEMATIC"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.onCinematicFinished = function ()
    {
        this.dispatchEvent({type: "cinematicFinished"});
        this._oSequencer.onActionEnd();
        _root._quality = this._sOldQuality;
        this.unloadThis();
    };
    _loc1.onSubtitle = function (tfSubtitle, nSubtitle)
    {
        for (var _loc4 = this._sFile.substring(0, this._sFile.toLowerCase().indexOf(".swf")); _loc4.indexOf("/") > -1; _loc4 = _loc4.substr(_loc4.indexOf("/") + 1))
        {
        } // end of for
        var _loc5 = Number(_loc4);
        var _loc6 = this.api.lang.getSubtitle(_loc5, nSubtitle);
        if (_loc6 != undefined)
        {
            tfSubtitle.text = _loc6;
        } // end if
    };
    _loc1.yes = function (oEvent)
    {
        this.onCinematicFinished();
    };
    _loc1.addProperty("sequencer", function ()
    {
    }, _loc1.__set__sequencer);
    _loc1.addProperty("file", function ()
    {
    }, _loc1.__set__file);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Cinematic = function ()
    {
        super();
    }).CLASS_NAME = "Cinematic";
} // end if
#endinitclip
