// Action script...

// [Initial MovieClip Action of sprite 20745]
#initclip 10
if (!dofus.graphics.gapi.controls.Emblem)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.Emblem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__shadow = function (bShadow)
    {
        this._bShadow = bShadow;
        //return (this.shadow());
    };
    _loc1.__get__shadow = function ()
    {
        return (this._bShadow);
    };
    _loc1.__set__backID = function (nBackID)
    {
        this._sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + nBackID + ".swf";
        if (this.initialized)
        {
            this.layoutBack();
        } // end if
        //return (this.backID());
    };
    _loc1.__set__backColor = function (nBackColor)
    {
        this._nBackColor = nBackColor;
        if (this.initialized)
        {
            this.layoutBack();
        } // end if
        //return (this.backColor());
    };
    _loc1.__set__upID = function (nUpID)
    {
        this._sUpFile = dofus.Constants.EMBLEMS_UP_PATH + nUpID + ".swf";
        if (this.initialized)
        {
            this.layoutUp();
        } // end if
        //return (this.upID());
    };
    _loc1.__set__upColor = function (nUpColor)
    {
        this._nUpColor = nUpColor;
        if (this.initialized)
        {
            this.layoutUp();
        } // end if
        //return (this.upColor());
    };
    _loc1.__set__data = function (oData)
    {
        this._sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + oData.backID + ".swf";
        this._nBackColor = oData.backColor;
        this._sUpFile = dofus.Constants.EMBLEMS_UP_PATH + oData.upID + ".swf";
        this._nUpColor = oData.upColor;
        if (this.initialized)
        {
            this.layoutBack();
            this.layoutUp();
        } // end if
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.Emblem.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.layoutContent});
    };
    _loc1.initScale = function ()
    {
    };
    _loc1.addListeners = function ()
    {
        this._ldrEmblemBack.addEventListener("initialization", this);
        this._ldrEmblemUp.addEventListener("initialization", this);
    };
    _loc1.layoutContent = function ()
    {
        if (this._sBackFile != undefined)
        {
            if (this._bShadow)
            {
                this._ldrEmblemShadow.contentPath = this._sBackFile;
                var _loc2 = new Color(this._ldrEmblemShadow);
                _loc2.setRGB(16777215);
            } // end if
            this._ldrEmblemShadow._visible = this._bShadow;
            this.layoutBack();
            this.layoutUp();
        } // end if
    };
    _loc1.layoutBack = function ()
    {
        if (this._ldrEmblemBack.contentPath == this._sBackFile)
        {
            this.applyBackColor();
        }
        else
        {
            this._ldrEmblemBack.contentPath = this._sBackFile;
        } // end else if
    };
    _loc1.layoutUp = function ()
    {
        if (this._ldrEmblemUp.contentPath == this._sUpFile)
        {
            this.applyUpColor();
        }
        else
        {
            this._ldrEmblemUp.contentPath = this._sUpFile;
        } // end else if
    };
    _loc1.applyBackColor = function ()
    {
        this.setMovieClipColor(this._ldrEmblemBack.content.back, this._nBackColor);
    };
    _loc1.applyUpColor = function ()
    {
        this.setMovieClipColor(this._ldrEmblemUp.content, this._nUpColor);
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.target;
        switch (_loc3._name)
        {
            case "_ldrEmblemBack":
            {
                this.applyBackColor();
                break;
            } 
            case "_ldrEmblemUp":
            {
                this.applyUpColor();
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("backColor", function ()
    {
    }, _loc1.__set__backColor);
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    _loc1.addProperty("shadow", _loc1.__get__shadow, _loc1.__set__shadow);
    _loc1.addProperty("upColor", function ()
    {
    }, _loc1.__set__upColor);
    _loc1.addProperty("upID", function ()
    {
    }, _loc1.__set__upID);
    _loc1.addProperty("backID", function ()
    {
    }, _loc1.__set__backID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.Emblem = function ()
    {
        super();
    }).CLASS_NAME = "Emblem";
    _loc1._bShadow = false;
} // end if
#endinitclip
