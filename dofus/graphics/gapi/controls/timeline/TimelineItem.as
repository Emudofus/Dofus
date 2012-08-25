// Action script...

// [Initial MovieClip Action of sprite 20720]
#initclip 241
if (!dofus.graphics.gapi.controls.timeline.TimelineItem)
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
    if (!dofus.graphics.gapi.controls.timeline)
    {
        _global.dofus.graphics.gapi.controls.timeline = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.timeline.TimelineItem = function ()
    {
        super();
    }).prototype;
    _loc1.__get__chrono = function ()
    {
        return (this._vcChrono);
    };
    _loc1.__get__sprite = function ()
    {
        return (this._ldrSprite);
    };
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        this.updateHealth();
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.timeline.TimelineItem.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.loadSprite, params: [this._oData.gfxFile]});
    };
    _loc1.loadSprite = function (sFile)
    {
        this._ldrSprite.contentPath = sFile;
        this._ldrSprite.addEventListener("initialization", this);
        this.api.colors.addSprite(this._ldrSprite, this._oData);
        this.updateHealth();
    };
    _loc1.updateHealth = function ()
    {
        this._mcHealth._yscale = this._oData._lp / this._oData._lpmax * 100;
    };
    _loc1.onRollOver = function ()
    {
        this._mcBackRect._alpha = 50;
        this._oData.mc.onRollOver();
        this._oData.mc.showEffects(true);
    };
    _loc1.onRollOut = function ()
    {
        this._mcBackRect._alpha = 100;
        this._oData.mc.onRollOut();
        this._oData.mc.showEffects(false);
    };
    _loc1.onRelease = function ()
    {
        if (this._oData.isVisible && (this.api.datacenter.Game.interactionType == 2 || this.api.datacenter.Game.interactionType == 3))
        {
            this._oData.mc.onRelease();
        }
        else
        {
            var _loc2 = this.gapi.getUIComponent("PlayerInfos");
            var _loc3 = _loc2 != undefined && this._oData != _loc2.data;
            this.gapi.loadUIComponent("PlayerInfos", "PlayerInfos", {data: this._oData}, {bForceLoad: _loc3});
        } // end else if
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.target.content;
        _loc3.attachMovie("staticR", "anim", 10);
        _loc3._x = 15;
        _loc3._y = 32;
        _loc3._xscale = -80;
        _loc3._yscale = 80;
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    _loc1.addProperty("sprite", _loc1.__get__sprite, function ()
    {
    });
    _loc1.addProperty("chrono", _loc1.__get__chrono, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.timeline.TimelineItem = function ()
    {
        super();
    }).CLASS_NAME = "Timeline";
} // end if
#endinitclip
