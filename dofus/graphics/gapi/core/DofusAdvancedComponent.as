// Action script...

// [Initial MovieClip Action of sprite 20484]
#initclip 5
if (!dofus.graphics.gapi.core.DofusAdvancedComponent)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.core)
    {
        _global.dofus.graphics.gapi.core = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.core.DofusAdvancedComponent = function ()
    {
        super();
    }).prototype;
    _loc1.__get__api = function ()
    {
        return (_global.API);
    };
    _loc1.__set__api = function (a)
    {
        super.__set__api(a);
        //return (this.api());
    };
    _loc1.init = function (bDontHideBoundingBox, sClassName)
    {
        super.init(bDontHideBoundingBox, sClassName);
    };
    _loc1.addProperty("api", _loc1.__get__api, _loc1.__set__api);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
