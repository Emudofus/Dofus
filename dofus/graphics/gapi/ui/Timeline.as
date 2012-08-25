// Action script...

// [Initial MovieClip Action of sprite 20988]
#initclip 253
if (!dofus.graphics.gapi.ui.Timeline)
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
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.Timeline = function ()
    {
        super();
    }).prototype;
    _loc1.update = function ()
    {
        this._tl.update();
    };
    _loc1.nextTurn = function (id, bWithoutTween)
    {
        this._tl.nextTurn(id, bWithoutTween);
    };
    _loc1.__get__timelineControl = function ()
    {
        return (this._tl);
    };
    _loc1.hideItem = function (id)
    {
        this._tl.hideItem(id);
    };
    _loc1.showItem = function (id)
    {
        this._tl.showItem(id);
    };
    _loc1.startChrono = function (nDuration)
    {
        this._tl.startChrono(nDuration);
    };
    _loc1.stopChrono = function ()
    {
        this._tl.stopChrono();
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Timeline.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
    };
    _loc1.addProperty("timelineControl", _loc1.__get__timelineControl, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Timeline = function ()
    {
        super();
    }).CLASS_NAME = "Timeline";
} // end if
#endinitclip
