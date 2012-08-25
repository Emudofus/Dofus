// Action script...

// [Initial MovieClip Action of sprite 20744]
#initclip 9
if (!ank.battlefield.mc.Container)
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
    var _loc1 = (_global.ank.battlefield.mc.Container = function (b, d, ofile)
    {
        super();
        if (b != undefined)
        {
            this.initialize(b, d, ofile);
        } // end if
    }).prototype;
    _loc1.initialize = function (b, d, ofile)
    {
        if (d == undefined)
        {
            ank.utils.Logger.err("pas de _oDatacenter !");
        } // end if
        this._mcBattlefield = b;
        this._oDatacenter = d;
        this._sObjectsFile = ofile;
        this.clear(true);
    };
    _loc1.clear = function (bForceReload)
    {
        this.maxDepth = 0;
        this.minDepth = -1000;
        this.zoom(100);
        if (this.ExternalContainer == undefined || bForceReload)
        {
            this.createEmptyMovieClip("ExternalContainer", 100);
            var _loc3 = new MovieClipLoader();
            _loc3.addListener(this._parent);
            if (bForceReload)
            {
                this.ExternalContainer.clear();
            } // end if
            _loc3.loadClip(this._sObjectsFile, this.ExternalContainer);
        }
        else
        {
            this.ExternalContainer.clear();
        } // end else if
        this.SpriteInfos.removeMovieClip();
        this.createEmptyMovieClip("SpriteInfos", 200);
        this.Points.removeMovieClip();
        this.createEmptyMovieClip("Points", 300);
        this.Text.removeMovieClip();
        this.createEmptyMovieClip("Text", 400);
        this.OverHead.removeMovieClip();
        this.createEmptyMovieClip("OverHead", 500);
        if (!this.LoadManager)
        {
            this.createEmptyMovieClip("LoadManager", 600);
        } // end if
    };
    _loc1.applyMask = function (bFilled)
    {
        var _loc3 = this._oDatacenter.Map.width - 1;
        var _loc4 = this._oDatacenter.Map.height - 1;
        if (bFilled == undefined)
        {
            bFilled = true;
        } // end if
        this.createEmptyMovieClip("_mcMask", 10);
        if (bFilled)
        {
            this._mcMask.beginFill(0);
            this._mcMask.moveTo(0, 0);
            this._mcMask.lineTo(_loc3 * ank.battlefield.Constants.CELL_WIDTH, 0);
            this._mcMask.lineTo(_loc3 * ank.battlefield.Constants.CELL_WIDTH, _loc4 * ank.battlefield.Constants.CELL_HEIGHT);
            this._mcMask.lineTo(0, _loc4 * ank.battlefield.Constants.CELL_HEIGHT);
            this._mcMask.lineTo(0, 0);
            this._mcMask.endFill();
        }
        else
        {
            this._mcMask.beginFill(0);
            this._mcMask.moveTo(-1000, -1000);
            this._mcMask.lineTo(-1000, -999);
            this._mcMask.lineTo(-999, -999);
            this._mcMask.lineTo(-999, -1000);
            this._mcMask.lineTo(-1000, -1000);
            this._mcMask.endFill();
        } // end else if
        this.setMask(this._mcMask);
    };
    _loc1.adjusteMap = function (Void)
    {
        this.zoomMap();
        this.center();
    };
    _loc1.setColor = function (oTransform)
    {
        if (oTransform == undefined)
        {
            oTransform = new Object();
            oTransform.ra = 100;
            oTransform.rb = 0;
            oTransform.ga = 100;
            oTransform.gb = 0;
            oTransform.ba = 100;
            oTransform.bb = 0;
        } // end if
        var _loc3 = new Color(this);
        _loc3.setTransform(oTransform);
    };
    _loc1.zoom = function (zFactor)
    {
        this._xscale = zFactor;
        this._yscale = zFactor;
    };
    _loc1.getZoom = function ()
    {
        return (this._xscale);
    };
    _loc1.setXY = function (x, y)
    {
        this._x = x;
        this._y = y;
    };
    _loc1.center = function (Void)
    {
        var _loc3 = this._xscale / 100;
        var _loc4 = this._yscale / 100;
        var _loc5 = (this._mcBattlefield.screenWidth - ank.battlefield.Constants.CELL_WIDTH * _loc3 * (this._oDatacenter.Map.width - 1)) / 2;
        var _loc6 = (this._mcBattlefield.screenHeight - ank.battlefield.Constants.CELL_HEIGHT * _loc4 * (this._oDatacenter.Map.height - 1)) / 2;
        this.setXY(_loc5, _loc6);
    };
    _loc1.zoomMap = function (Void)
    {
        var _loc3 = this.getZoomFactor();
        if (_loc3 == 100)
        {
            return (false);
        } // end if
        this.zoom(_loc3, false);
        return (true);
    };
    _loc1.getZoomFactor = function (Void)
    {
        var _loc3 = this._oDatacenter.Map.width;
        var _loc4 = this._oDatacenter.Map.height;
        var _loc5 = 0;
        if (_loc3 <= ank.battlefield.Constants.DEFAULT_MAP_WIDTH)
        {
            return (100);
        } // end if
        if (_loc4 <= ank.battlefield.Constants.DEFAULT_MAP_HEIGHT)
        {
            return (100);
        } // end if
        if (_loc4 > _loc3)
        {
            _loc5 = this._mcBattlefield.screenWidth / (ank.battlefield.Constants.CELL_WIDTH * (_loc3 - 1)) * 100;
        }
        else
        {
            _loc5 = this._mcBattlefield.screenHeight / (ank.battlefield.Constants.CELL_HEIGHT * (_loc4 - 1)) * 100;
        } // end else if
        return (_loc5);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
