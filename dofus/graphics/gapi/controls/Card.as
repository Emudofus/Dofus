// Action script...

// [Initial MovieClip Action of sprite 20485]
#initclip 6
if (!dofus.graphics.gapi.controls.Card)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.Card = function ()
    {
        super();
    }).prototype;
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__set__background = function (nBackground)
    {
        this._nBackground = nBackground;
        //return (this.background());
    };
    _loc1.__set__gfxFile = function (sGfxFile)
    {
        this._sGfxFile = sGfxFile;
        //return (this.gfxFile());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.Card.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initData = function ()
    {
        this._lblName.text = this._sName;
        this._ldrBack.contentPath = dofus.Constants.CARDS_PATH + this._nBackground + ".swf";
        this._ldrGfx.contentPath = this._sGfxFile;
    };
    _loc1.addProperty("gfxFile", function ()
    {
    }, _loc1.__set__gfxFile);
    _loc1.addProperty("background", function ()
    {
    }, _loc1.__set__background);
    _loc1.addProperty("name", function ()
    {
    }, _loc1.__set__name);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.Card = function ()
    {
        super();
    }).CLASS_NAME = "Card";
} // end if
#endinitclip
