// Action script...

// [Initial MovieClip Action of sprite 20777]
#initclip 42
if (!ank.utils.SWFLoader)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.SWFLoader = function ()
    {
        super();
        AsBroadcaster.initialize(this);
        this.initialize(0);
    }).prototype;
    _loc1.initialize = function (frame, args)
    {
        this.clear();
        this._frameStart = frame;
        this._aArgs = args;
    };
    _loc1.clear = function ()
    {
        this.createEmptyMovieClip("swf_mc", 10);
    };
    _loc1.remove = function ()
    {
        this.swf_mc.__proto__ = MovieClip.prototype;
        this.swf_mc.removeMovieClip();
    };
    _loc1.loadSWF = function (file, frame, args)
    {
        this.initialize(frame, args);
        var _loc5 = new MovieClipLoader();
        _loc5.addListener(this);
        _loc5.loadClip(file, this.swf_mc);
    };
    _loc1.onLoadComplete = function (mc)
    {
        this.broadcastMessage("onLoadComplete", mc, this._aArgs);
    };
    _loc1.onLoadInit = function (mc)
    {
        if (this._frameStart != undefined)
        {
            mc.gotoAndStop(this._frameStart);
        } // end if
        this.broadcastMessage("onLoadInit", mc, this._aArgs);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
