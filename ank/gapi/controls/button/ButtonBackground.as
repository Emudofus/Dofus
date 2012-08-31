// Action script...

// [Initial MovieClip Action of sprite 164]
#initclip 8
class ank.gapi.controls.button.ButtonBackground extends ank.gapi.core.UIBasicComponent
{
    var left_mc, middle_mc, right_mc, setMovieClipColor;
    function ButtonBackground()
    {
        super();
    } // End of the function
    function setSize(nWidth, nHeight, bBorderAspectRatio)
    {
        left_mc._x = left_mc._y = middle_mc._y = right_mc._y = 0;
        left_mc._height = middle_mc._height = right_mc._height = nHeight;
        if (bBorderAspectRatio)
        {
            left_mc._xscale = left_mc._yscale;
            right_mc._xscale = right_mc._yscale;
        } // end if
        middle_mc._x = left_mc == undefined ? (0) : (left_mc._width);
        middle_mc._width = nWidth - (left_mc == undefined ? (0) : (left_mc._width)) - (right_mc == undefined ? (0) : (right_mc._width));
        right_mc._x = nWidth - right_mc._width;
    } // End of the function
    function setStyleColor(oStyle, sSuffixe)
    {
        var _loc2;
        _loc2 = left_mc;
        for (var _loc7 in _loc2)
        {
            var _loc5 = _loc7.split("_")[0];
            var _loc3 = oStyle[_loc5 + sSuffixe];
            if (_loc3 != undefined)
            {
                this.setMovieClipColor(_loc2[_loc7], _loc3);
            } // end if
        } // end of for...in
        _loc2 = middle_mc;
        for (var _loc7 in _loc2)
        {
            _loc5 = _loc7.split("_")[0];
            _loc3 = oStyle[_loc5 + sSuffixe];
            if (_loc3 != undefined)
            {
                this.setMovieClipColor(_loc2[_loc7], _loc3);
            } // end if
        } // end of for...in
        _loc2 = right_mc;
        for (var _loc7 in _loc2)
        {
            _loc5 = _loc7.split("_")[0];
            _loc3 = oStyle[_loc5 + sSuffixe];
            if (_loc3 != undefined)
            {
                this.setMovieClipColor(_loc2[_loc7], _loc3);
            } // end if
        } // end of for...in
    } // End of the function
} // End of Class
#endinitclip
