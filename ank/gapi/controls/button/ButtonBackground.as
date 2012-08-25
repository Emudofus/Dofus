// Action script...

// [Initial MovieClip Action of sprite 20904]
#initclip 169
if (!ank.gapi.controls.button.ButtonBackground)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    if (!ank.gapi.controls.button)
    {
        _global.ank.gapi.controls.button = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.button.ButtonBackground = function ()
    {
        super();
    }).prototype;
    _loc1.setSize = function (nWidth, nHeight, bBorderAspectRatio)
    {
        this.left_mc._x = this.left_mc._y = this.middle_mc._y = this.right_mc._y = 0;
        this.left_mc._height = this.middle_mc._height = this.right_mc._height = nHeight;
        if (bBorderAspectRatio)
        {
            this.left_mc._xscale = this.left_mc._yscale;
            this.right_mc._xscale = this.right_mc._yscale;
        } // end if
        this.middle_mc._x = this.left_mc == undefined ? (0) : (this.left_mc._width);
        this.middle_mc._width = nWidth - (this.left_mc == undefined ? (0) : (this.left_mc._width)) - (this.right_mc == undefined ? (0) : (this.right_mc._width));
        this.right_mc._x = nWidth - this.right_mc._width;
    };
    _loc1.setStyleColor = function (oStyle, sSuffixe)
    {
        var _loc4 = this.left_mc;
        for (var k in _loc4)
        {
            var _loc5 = k.split("_")[0];
            var _loc6 = oStyle[_loc5 + sSuffixe];
            if (_loc6 != undefined)
            {
                this.setMovieClipColor(_loc4[k], _loc6);
            } // end if
        } // end of for...in
        _loc4 = this.middle_mc;
        for (var k in _loc4)
        {
            var _loc7 = k.split("_")[0];
            var _loc8 = oStyle[_loc7 + sSuffixe];
            if (_loc8 != undefined)
            {
                this.setMovieClipColor(_loc4[k], _loc8);
            } // end if
        } // end of for...in
        _loc4 = this.right_mc;
        for (var k in _loc4)
        {
            var _loc9 = k.split("_")[0];
            var _loc10 = oStyle[_loc9 + sSuffixe];
            if (_loc10 != undefined)
            {
                this.setMovieClipColor(_loc4[k], _loc10);
            } // end if
        } // end of for...in
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
