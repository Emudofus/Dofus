// Action script...

// [Initial MovieClip Action of sprite 20686]
#initclip 207
if (!ank.battlefield.datacenter.Mount)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.datacenter)
    {
        _global.ank.battlefield.datacenter = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.datacenter.Mount = function (sGfxFile, sChevauchorGfxFile)
    {
        super();
        this.gfxFile = sGfxFile;
        this.chevauchorGfxFile = sChevauchorGfxFile;
    }).prototype;
    _loc1.__get__color1 = function ()
    {
        return (this._nColor1);
    };
    _loc1.__set__color1 = function (v)
    {
        this._nColor1 = v;
        //return (this.color1());
    };
    _loc1.__get__color2 = function ()
    {
        return (this._nColor2);
    };
    _loc1.__set__color2 = function (v)
    {
        this._nColor2 = v;
        //return (this.color2());
    };
    _loc1.__get__color3 = function ()
    {
        return (this._nColor3);
    };
    _loc1.__set__color3 = function (v)
    {
        this._nColor3 = v;
        //return (this.color3());
    };
    _loc1.addProperty("color2", _loc1.__get__color2, _loc1.__set__color2);
    _loc1.addProperty("color1", _loc1.__get__color1, _loc1.__set__color1);
    _loc1.addProperty("color3", _loc1.__get__color3, _loc1.__set__color3);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
