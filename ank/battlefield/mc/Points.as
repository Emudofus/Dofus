// Action script...

// [Initial MovieClip Action of sprite 869]
#initclip 81
class ank.battlefield.mc.Points extends MovieClip
{
    var _pointsHandler, _nID, _nRefY, createTextField, _tf, _visible, _y, removeMovieClip;
    function Points(pointsHandler, nID, nRefY, sValue, nColor)
    {
        super();
        this.initialize(pointsHandler, nID, nRefY, sValue, nColor);
    } // End of the function
    function initialize(pointsHandler, nID, nRefY, sValue, nColor)
    {
        _pointsHandler = pointsHandler;
        _nID = nID;
        _nRefY = nRefY;
        this.createTextField("_tf", 10, 0, 0, 150, 100);
        _tf.autoSize = "left";
        _tf.embedFonts = true;
        _tf.selectable = false;
        _tf.textColor = nColor;
        _tf.text = sValue;
        _tf.setTextFormat(ank.battlefield.Constants.SPRITE_POINTS_TEXTFORMAT);
        _visible = false;
    } // End of the function
    function animate()
    {
        _visible = true;
        function onEnterFrame()
        {
            _y = _y - 3;
            var _loc2 = _nRefY - _y;
            if (_loc2 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
            {
                this.remove();
            } // end if
            if (!_bFinished)
            {
                if (_loc2 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET - 10)
                {
                    _bFinished = true;
                    _pointsHandler.onAnimateFinished(_nID);
                } // end if
            } // end if
        } // End of the function
    } // End of the function
    function remove()
    {
        delete this.onEnterFrame;
        this.removeMovieClip();
    } // End of the function
    var _bFinished = false;
} // End of Class
#endinitclip
