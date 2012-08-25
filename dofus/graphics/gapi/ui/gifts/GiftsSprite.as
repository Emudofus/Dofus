// Action script...

// [Initial MovieClip Action of sprite 20964]
#initclip 229
if (!dofus.graphics.gapi.ui.gifts.GiftsSprite)
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
    if (!dofus.graphics.gapi.ui.gifts)
    {
        _global.dofus.graphics.gapi.ui.gifts = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.gifts.GiftsSprite = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        if (this.initialized)
        {
            this.addToQueue({object: this, method: this.updateData});
        } // end if
        //return (this.data());
    };
    _loc1.__get__data = function ()
    {
        return (this._oData);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.gifts.GiftsSprite.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._mcSelect._visible = false;
        this._mcSelect.stop();
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._ldrSprite.addEventListener("initialization", this);
        this._btnBack.addEventListener("click", this);
        this._btnBack.addEventListener("over", this);
        this._btnBack.addEventListener("out", this);
    };
    _loc1.updateData = function ()
    {
        if (this._oData != undefined)
        {
            this._lblName.text = this._oData.name;
            this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oData.Level;
            this._ldrSprite.contentPath = this._oData.gfxFile;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._ldrSprite.contentPath = "";
        } // end else if
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.clip;
        this.gapi.api.colors.addSprite(_loc3, this._oData);
        _loc3.attachMovie("staticF", "mcAnim", 10);
    };
    _loc1.click = function (oEvent)
    {
        if (this._bEnabled)
        {
            this.dispatchEvent({type: "onSpriteSelected", data: this._oData});
        } // end if
    };
    _loc1.over = function (oEvent)
    {
        if (this._bEnabled)
        {
            this._mcSelect._visible = true;
            this._mcSelect.play();
        } // end if
    };
    _loc1.out = function (oEvent)
    {
        if (this._bEnabled)
        {
            this._mcSelect._visible = false;
            this._mcSelect.stop();
        } // end if
    };
    _loc1.addProperty("data", _loc1.__get__data, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.gifts.GiftsSprite = function ()
    {
        super();
    }).CLASS_NAME = "Gifts";
} // end if
#endinitclip
