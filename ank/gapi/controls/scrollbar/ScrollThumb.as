// Action script...

// [Initial MovieClip Action of sprite 20801]
#initclip 66
if (!ank.gapi.controls.scrollbar.ScrollThumb)
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
    if (!ank.gapi.controls.scrollbar)
    {
        _global.ank.gapi.controls.scrollbar = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.scrollbar.ScrollThumb = function ()
    {
        super();
    }).prototype;
    _loc1.__set__height = function (nHeight)
    {
        this.top_mc._y = 0;
        this.middle_mc._y = this.top_mc._height;
        this.middle_mc._height = nHeight - this.top_mc._height - this.bottom_mc._height;
        this.bottom_mc._y = this.middle_mc._y + this.middle_mc._height;
        //return (this.height());
    };
    _loc1.addProperty("height", function ()
    {
    }, _loc1.__set__height);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
