// Action script...

// [Initial MovieClip Action of sprite 20586]
#initclip 107
if (!dofus.graphics.gapi.controls.BannerSpriteInfos)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.BannerSpriteInfos = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oSprite = oData;
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.BannerSpriteInfos.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._ldrSprite.addEventListener("initialization", this);
        this._ldrSprite.addEventListener("complete", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblRes.text = this.api.lang.getText("RESISTANCES");
    };
    _loc1.initData = function ()
    {
        this._lblName.text = this._oSprite.name;
        this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oSprite.Level;
        this._lblLP.text = _global.isNaN(this._oSprite.LP) ? ("") : (this._oSprite.LP);
        this._lblAP.text = _global.isNaN(this._oSprite.AP) ? ("") : (String(Math.max(0, this._oSprite.AP)));
        this._lblMP.text = _global.isNaN(this._oSprite.MP) ? ("") : (String(Math.max(0, this._oSprite.MP)));
        this._lblAverageDamages.text = this._oSprite.averageDamages;
        this._ldrSprite.contentPath = this._oSprite.artworkFile;
        var _loc2 = this._oSprite.resistances;
        this._lblNeutral.text = _loc2[0] == undefined ? ("0%") : (_loc2[0] + "%");
        this._lblEarth.text = _loc2[1] == undefined ? ("0%") : (_loc2[1] + "%");
        this._lblFire.text = _loc2[2] == undefined ? ("0%") : (_loc2[2] + "%");
        this._lblWater.text = _loc2[3] == undefined ? ("0%") : (_loc2[3] + "%");
        this._lblAir.text = _loc2[4] == undefined ? ("0%") : (_loc2[4] + "%");
        this._lblDodgeAP.text = _loc2[5] == undefined ? ("0%") : (_loc2[5] + "%");
        this._lblDodgeMP.text = _loc2[6] == undefined ? ("0%") : (_loc2[6] + "%");
    };
    _loc1.applyColor = function (mc, zone)
    {
        var _loc4 = 0;
        switch (zone)
        {
            case 1:
            {
                _loc4 = this._oSprite.color1;
                break;
            } 
            case 2:
            {
                _loc4 = this._oSprite.color2;
                break;
            } 
            case 3:
            {
                _loc4 = this._oSprite.color3;
                break;
            } 
        } // End of switch
        if (_loc4 == -1 || _loc4 == undefined)
        {
            return;
        } // end if
        var _loc5 = (_loc4 & 16711680) >> 16;
        var _loc6 = (_loc4 & 65280) >> 8;
        var _loc7 = _loc4 & 255;
        var _loc8 = new Color(mc);
        var _loc9 = new Object();
        _loc9 = {ra: 0, ga: 0, ba: 0, rb: _loc5, gb: _loc6, bb: _loc7};
        _loc8.setTransform(_loc9);
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.target.content;
        var _loc4 = _loc3._mcMask;
        _loc3._x = -_loc4._x;
        _loc3._y = -_loc4._y;
        this._ldrSprite._xscale = 10000 / _loc4._xscale;
        this._ldrSprite._yscale = 10000 / _loc4._yscale;
    };
    _loc1.complete = function (oEvent)
    {
        var ref = this;
        this._ldrSprite.content.stringCourseColor = function (mc, z)
        {
            ref.applyColor(mc, z);
        };
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.BannerSpriteInfos = function ()
    {
        super();
    }).CLASS_NAME = "BannerSpriteInfos";
} // end if
#endinitclip
