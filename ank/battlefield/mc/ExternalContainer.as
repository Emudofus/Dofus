// Action script...

// [Initial MovieClip Action of sprite 20534]
#initclip 55
if (!ank.battlefield.mc.ExternalContainer)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.mc)
    {
        _global.ank.battlefield.mc = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.mc.ExternalContainer = function ()
    {
        super();
    }).prototype;
    _loc1.initialize = function (sGroundFile)
    {
        this._sGroundFile = sGroundFile;
        this.clear();
    };
    _loc1.useCustomGroundGfxFile = function (bState)
    {
        if (bState)
        {
            this.InteractionCell = this.Ground.createEmptyMovieClip("InteractionCell", -400);
        } // end if
    };
    _loc1.clear = function ()
    {
        this.InteractionCell.removeMovieClip();
        this.createEmptyMovieClip("InteractionCell", 100);
        if (this.Ground == undefined)
        {
            this.createEmptyMovieClip("Ground", 200);
            this.Ground.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Ground"];
            if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
            {
                this._parent.onLoadInit(ank.battlefield.mc.ExternalContainer);
            }
            else
            {
                var _loc2 = new MovieClipLoader();
                _loc2.addListener(this._parent._parent);
                _loc2.loadClip(this._sGroundFile, this.Ground);
            } // end else if
        }
        else
        {
            if (ank.battlefield.Constants.USE_STREAMING_FILES || ank.battlefield.Constants.STREAMING_METHOD == "compact")
            {
                for (var s in this.Ground)
                {
                    if (typeof(this.Ground[s]) == "movieclip")
                    {
                        if (ank.battlefield.Constants.STREAMING_METHOD == "compact" && (this.Ground[s]._name == "InteractionCell" || this.Ground[s]._name == "Select"))
                        {
                            continue;
                        } // end if
                        this.Ground[s].unloadMovie();
                        this.Ground[s].removeMovieClip();
                    } // end if
                } // end of for...in
            } // end if
            this.Ground.clear();
        } // end else if
        if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
        {
            for (var s in this.Object1)
            {
                if (typeof(this.Object1[s]) == "movieclip")
                {
                    this.Object1[s].unloadMovie();
                    this.Object1[s].removeMovieClip();
                } // end if
            } // end of for...in
            this.Object1.clear();
        } // end if
        this.Object1.removeMovieClip();
        this.createEmptyMovieClip("Object1", 300);
        this.Object1.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Object1"];
        this.Grid.removeMovieClip();
        this.createEmptyMovieClip("Grid", 400);
        this.Grid.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Grid"];
        this.Zone.removeMovieClip();
        this.createEmptyMovieClip("Zone", 500);
        this.Zone.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Zone"];
        this.Select.removeMovieClip();
        this.createEmptyMovieClip("Select", 600);
        this.Select.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Select"];
        this.Pointer.removeMovieClip();
        this.createEmptyMovieClip("Pointer", 700);
        this.Pointer.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Pointer"];
        if (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
        {
            for (var s in this.Object2)
            {
                if (typeof(this.Object1[s]) == "movieclip")
                {
                    this.Object2[s].unloadMovie();
                    this.Object2[s].removeMovieClip();
                } // end if
            } // end of for...in
            this.Object2.clear();
        } // end if
        this.Object2.removeMovieClip();
        this.createEmptyMovieClip("Object2", 800);
        this.Object2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Object2"];
        this.Object2.__proto__ = MovieClip.prototype;
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
