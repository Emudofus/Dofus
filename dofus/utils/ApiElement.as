// Action script...

// [Initial MovieClip Action of sprite 20494]
#initclip 15
if (!dofus.utils.ApiElement)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.ApiElement = function ()
    {
        super();
    }).prototype;
    _loc1.__get__api = function ()
    {
        return (_global.API);
    };
    _loc1.__set__api = function (oApi)
    {
        this._oAPI = oApi;
        //return (this.api());
    };
    _loc1.initialize = function (oAPI)
    {
        this._oAPI = oAPI;
    };
    _loc1.addToQueue = function (oCall)
    {
        dofus.utils.ApiElement._aQueue.push(oCall);
        if (_root.onEnterFrame == undefined)
        {
            _root.onEnterFrame = this.runQueue;
        } // end if
    };
    _loc1.runQueue = function ()
    {
        var _loc2 = dofus.utils.ApiElement._aQueue.shift();
        _loc2.method.apply(_loc2.object, _loc2.params);
        if (dofus.utils.ApiElement._aQueue.length == 0)
        {
            delete _root.onEnterFrame;
        } // end if
    };
    _loc1.addProperty("api", _loc1.__get__api, _loc1.__set__api);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.utils.ApiElement = function ()
    {
        super();
    })._aQueue = new Array();
} // end if
#endinitclip
