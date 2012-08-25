// Action script...

// [Initial MovieClip Action of sprite 20638]
#initclip 159
if (!dofus.graphics.gapi.ui.StringCourse)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.StringCourse = function ()
    {
        super();
    }).prototype;
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__set__level = function (sLevel)
    {
        this._sLevel = sLevel;
        //return (this.level());
    };
    _loc1.__set__gfx = function (sGfx)
    {
        this._sGfx = sGfx;
        //return (this.gfx());
    };
    _loc1.__set__colors = function (aColors)
    {
        this._colors = aColors;
        //return (this.colors());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.StringCourse.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.loadContent});
    };
    _loc1.loadContent = function ()
    {
        this._ldrStringCourse.addEventListener("error", this);
        this._ldrStringCourse.addEventListener("complete", this);
        this._ldrStringCourse.contentPath = this._sGfx;
    };
    _loc1.unloadContent = function ()
    {
        this._ldrStringCourse.contentPath = "";
        this._lblName.text = "";
        this._lblLevel.text = "";
    };
    _loc1.applyColor = function (mc, zone)
    {
        var _loc4 = this._colors[zone];
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
    _loc1.complete = function (oEvent)
    {
        this._lblName.text = this._sName;
        this._lblLevel.text = this._sLevel;
        var ref = this;
        this._ldrStringCourse.content.stringCourseColor = function (mc, z)
        {
            ref.applyColor(mc, z);
        };
        this._mcAnim.play();
    };
    _loc1.error = function (oEvent)
    {
        this.unloadThis();
    };
    _loc1.addProperty("colors", function ()
    {
    }, _loc1.__set__colors);
    _loc1.addProperty("gfx", function ()
    {
    }, _loc1.__set__gfx);
    _loc1.addProperty("level", function ()
    {
    }, _loc1.__set__level);
    _loc1.addProperty("name", function ()
    {
    }, _loc1.__set__name);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.StringCourse = function ()
    {
        super();
    }).CLASS_NAME = "StringCourse";
} // end if
#endinitclip
