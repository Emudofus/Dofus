// Action script...

// [Initial MovieClip Action of sprite 20666]
#initclip 187
if (!dofus.graphics.gapi.ui.HistoryViewerOnCreate)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.HistoryViewerOnCreate = function ()
    {
        super();
    }).prototype;
    _loc1.__get__breed = function ()
    {
        return (this._nBreed);
    };
    _loc1.__set__breed = function (n)
    {
        this._nBreed = n;
        //return (this.breed());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.HistoryViewerOnCreate.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initText});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.initText = function ()
    {
        this._lblBreedHistory.text = this.api.lang.getText("HISTORY_CLASS_WORD");
        this._lblBreedName.text = this.api.lang.getClassText(this._nBreed).sn;
        this._txtHistoryDescription.text = this.api.lang.getClassText(this._nBreed).d;
        this._ldrClassBg.content._alpha = 50;
        this._ldrClassBg.contentPath = dofus.Constants.BREEDS_BACK_PATH + this._nBreed + ".swf";
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose.addEventListener("over", this);
        this._btnClose.addEventListener("out", this);
        this._bhClose.addEventListener("click", this);
        this._mcWindowBg.onRelease = function ()
        {
        };
        this._mcWindowBg.useHandCursor = false;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._bhClose:
            case this._btnClose:
            {
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnClose:
            {
                this.gapi.showTooltip(this.api.lang.getText("CLOSE"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("breed", _loc1.__get__breed, _loc1.__set__breed);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.HistoryViewerOnCreate = function ()
    {
        super();
    }).CLASS_NAME = "HistoryViewerOnCreate";
} // end if
#endinitclip
