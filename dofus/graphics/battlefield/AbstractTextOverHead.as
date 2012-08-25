// Action script...

// [Initial MovieClip Action of sprite 20544]
#initclip 65
if (!dofus.graphics.battlefield.AbstractTextOverHead)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.battlefield)
    {
        _global.dofus.graphics.battlefield = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).prototype;
    _loc1.__get__height = function ()
    {
        return (Math.ceil(this._height));
    };
    _loc1.__get__width = function ()
    {
        return (Math.ceil(this._width));
    };
    _loc1.initialize = function ()
    {
        this.createEmptyMovieClip("_mcGfx", 10);
        this.createEmptyMovieClip("_mcTxtBackground", 20);
    };
    _loc1.drawBackground = function (nWidth, nHeight, nColor)
    {
        this.drawRoundRect(this._mcTxtBackground, -nWidth / 2, 0, nWidth, nHeight, 3, nColor, dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_ALPHA);
    };
    _loc1.drawGfx = function (sFile, nFrame)
    {
        this._mcGfx.attachClassMovie(ank.utils.SWFLoader, "_mcSwfLoader", 10);
        this._mcGfx._mcSwfLoader.loadSWF(sFile, nFrame);
    };
    _loc1.addPvpGfxEffect = function (nPvpGain, nFrame)
    {
        switch (nPvpGain)
        {
            case -1:
            {
                var _loc4 = 5.000000E-001;
                var _loc5 = new Array();
                _loc5 = _loc5.concat([_loc4, 0, 0, 0, 0]);
                _loc5 = _loc5.concat([0, _loc4, 0, 0, 0]);
                _loc5 = _loc5.concat([0, 0, _loc4, 0, 0]);
                _loc5 = _loc5.concat([0, 0, 0, 1, 0]);
                var _loc6 = new flash.filters.ColorMatrixFilter(_loc5);
                this._mcGfx.filters = new Array(_loc6);
                break;
            } 
            case 1:
            {
                switch (Math.floor((nFrame - 1) / 10))
                {
                    case 0:
                    {
                        var _loc7 = 11201279;
                        break;
                    } 
                    case 1:
                    {
                        _loc7 = 13369344;
                        break;
                    } 
                    case 2:
                    {
                        _loc7 = 0;
                        break;
                    } 
                } // End of switch
                var _loc8 = 5.000000E-001;
                var _loc9 = 10;
                var _loc10 = 10;
                var _loc11 = 2;
                var _loc12 = 3;
                var _loc13 = false;
                var _loc14 = false;
                var _loc15 = new flash.filters.GlowFilter(_loc7, _loc8, _loc9, _loc10, _loc11, _loc12, _loc13, _loc14);
                var _loc16 = new Array();
                _loc16.push(_loc15);
                this._mcGfx.filters = _loc16;
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("width", _loc1.__get__width, function ()
    {
    });
    _loc1.addProperty("height", _loc1.__get__height, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).BACKGROUND_ALPHA = 70;
    (_global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).BACKGROUND_COLOR = 0;
    (_global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).TEXT_SMALL_FORMAT = new TextFormat("Font1", 10, 16777215, false, false, false, null, null, "left", _global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).TEXT_FORMAT2 = new TextFormat("Font2", 9, 16777215, false, false, false, null, null, "center", _global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).TEXT_FORMAT = new TextFormat("Font2", 10, 16777215, false, false, false, null, null, "center");
    (_global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).CORNER_RADIUS = 0;
    (_global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).WIDTH_SPACER = 4;
    (_global.dofus.graphics.battlefield.AbstractTextOverHead = function ()
    {
        super();
    }).HEIGHT_SPACER = 4;
} // end if
#endinitclip
