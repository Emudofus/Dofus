// Action script...

// [Initial MovieClip Action of sprite 20694]
#initclip 215
if (!dofus.graphics.gapi.ui.PlayerInfos)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.PlayerInfos = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.__get__data = function ()
    {
        return (this._oData);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.PlayerInfos.CLASS_NAME);
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
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
    };
    _loc1.initData = function ()
    {
        if (this._oData != undefined)
        {
            this._winBackground.title = this.api.lang.getText("EFFECTS") + " " + this._oData.name + " (" + this.api.lang.getText("LEVEL_SMALL") + this._oData.Level + ")";
            this._lstEffects.dataProvider = this._oData.EffectsManager.getEffects();
        } // end if
    };
    _loc1.quit = function ()
    {
        this.unloadThis();
    };
    _loc1.click = function (oEvent)
    {
        this.unloadThis();
    };
    _loc1.addProperty("data", _loc1.__get__data, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.PlayerInfos = function ()
    {
        super();
    }).CLASS_NAME = "PlayerInfos";
} // end if
#endinitclip
