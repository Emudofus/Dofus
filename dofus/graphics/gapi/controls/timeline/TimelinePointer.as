// Action script...

// [Initial MovieClip Action of sprite 20981]
#initclip 246
if (!dofus.graphics.gapi.controls.timeline.TimelinePointer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.timeline.TimelinePointer = function ()
    {
        super();
    }).prototype;
    _loc1.moveTween = function (destX, destScale)
    {
        var nDir = destX > this._x ? (1) : (-1);
        var i = 0;
        this._destX = destX;
        this.onEnterFrame = function ()
        {
            ++i;
            this._x = this._x + i * i * nDir;
            this._xscale = this._xscale + (destScale - this._xscale) / 2;
            this._yscale = this._yscale + (destScale - this._yscale) / 2;
            if (this._x * nDir > this._destX * nDir)
            {
                this._x = this._destX;
                this._xscale = destScale;
                this._yscale = destScale;
                delete this.onEnterFrame;
            } // end if
        };
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.timeline.TimelinePointer.CLASS_NAME);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.timeline.TimelinePointer = function ()
    {
        super();
    }).CLASS_NAME = "Timeline";
} // end if
#endinitclip
