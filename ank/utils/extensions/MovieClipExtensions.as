// Action script...

// [Initial MovieClip Action of sprite 20993]
#initclip 2
if (!ank.utils.extensions.MovieClipExtensions)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    if (!ank.utils.extensions)
    {
        _global.ank.utils.extensions = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.extensions.MovieClipExtensions = function ()
    {
        super();
    }).prototype;
    _loc1.attachClassMovie = function (className, instanceName, depth, argv)
    {
        var _loc6 = this.createEmptyMovieClip(instanceName, depth);
        _loc6.__proto__ = className.prototype;
        className.apply(_loc6, argv);
        return (_loc6);
    };
    _loc1.alignOnPixel = function ()
    {
        var _loc2 = new Object({x: 0, y: 0});
        this.localToGlobal(_loc2);
        _loc2.x = Math.floor(_loc2.x);
        _loc2.y = Math.floor(_loc2.y);
        this.globalToLocal(_loc2);
        this._x = this._x - _loc2.x;
        this._y = this._y - _loc2.y;
    };
    _loc1.playFirstChildren = function ()
    {
        for (var a in this)
        {
            if (this[a].__proto__ == MovieClip.prototype)
            {
                this[a].gotoAndPlay(1);
            } // end if
        } // end of for...in
    };
    _loc1.end = function (seq)
    {
        var _loc3 = this.getFirstParentProperty("_ACTION");
        if (seq == undefined)
        {
            seq = _loc3.sequencer;
        } // end if
        seq.onActionEnd();
    };
    _loc1.getFirstParentProperty = function (prop)
    {
        var _loc3 = 20;
        var _loc4 = this;
        while (_loc3 >= 0)
        {
            if (_loc4[prop] != undefined)
            {
                return (_loc4[prop]);
            } // end if
            _loc4 = _loc4._parent;
            --_loc3;
        } // end while
    };
    _loc1.getActionClip = function (Void)
    {
        return (this.getFirstParentProperty("_ACTION"));
    };
    _loc1.playAll = function (mc)
    {
        if (mc == undefined)
        {
            mc = this;
        } // end if
        mc.gotoAndPlay(1);
        for (var a in mc)
        {
            if (mc[a] instanceof MovieClip)
            {
                this.playAll(mc[a]);
            } // end if
        } // end of for...in
    };
    _loc1.stopAll = function (mc)
    {
        if (mc == undefined)
        {
            mc = this;
        } // end if
        mc.gotoAndStop(1);
        for (var a in mc)
        {
            if (mc[a] instanceof MovieClip)
            {
                this.stopAll(mc[a]);
            } // end if
        } // end of for...in
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
