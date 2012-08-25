// Action script...

// [Initial MovieClip Action of sprite 20562]
#initclip 83
if (!ank.battlefield.mc.Points)
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
    var _loc1 = (_global.ank.battlefield.mc.Points = function (pointsHandler, nID, nRefY, sValue, nColor)
    {
        super();
        this.initialize(pointsHandler, nID, nRefY, sValue, nColor);
    }).prototype;
    _loc1.initialize = function (pointsHandler, nID, nRefY, sValue, nColor)
    {
        this._pointsHandler = pointsHandler;
        this._nRefY = nRefY;
        this._nID = nID;
        this.createTextField("_tf", 10, 0, 0, 150, 100);
        this._tf.autoSize = "left";
        this._tf.embedFonts = true;
        this._tf.selectable = false;
        this._tf.textColor = nColor;
        this._tf.text = sValue;
        this._tf.setTextFormat(ank.battlefield.Constants.SPRITE_POINTS_TEXTFORMAT);
        this._tf._x = -this._tf.textWidth / 2;
        this._tf._y = -this._tf.textHeight / 2;
        this._visible = false;
        this._nI = 0;
        this._nSz = 100;
        this._nVy = -20;
        this._nY = nRefY;
    };
    _loc1.animate = function ()
    {
        this._visible = true;
        this.onEnterFrame = function ()
        {
            this._xscale = this._nT;
            this._yscale = this._nT;
            this._nT = 100 + this._nSz * Math.sin(this._nI = this._nI + 1.200000E+000);
            this._nSz = this._nSz * 8.500000E-001;
            this._nY = this._nY + (this._nVy = this._nVy * 7.000000E-001);
            this._y = this._nY;
            var _loc2 = this._nRefY - this._nY;
            if (_loc2 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
            {
                this.remove();
            } // end if
            if (!this._bFinished)
            {
                if (_loc2 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET - 2)
                {
                    this._bFinished = true;
                    this._pointsHandler.onAnimateFinished(this._nID);
                } // end if
            } // end if
        };
    };
    _loc1.remove = function ()
    {
        delete this.onEnterFrame;
        this.removeMovieClip();
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bFinished = false;
} // end if
#endinitclip
