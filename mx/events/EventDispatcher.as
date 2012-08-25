// Action script...

// [Initial MovieClip Action of sprite 20959]
#initclip 224
if (!mx.events.EventDispatcher)
{
    if (!mx)
    {
        _global.mx = new Object();
    } // end if
    if (!mx.events)
    {
        _global.mx.events = new Object();
    } // end if
    var _loc1 = (_global.mx.events.EventDispatcher = function ()
    {
    }).prototype;
    (_global.mx.events.EventDispatcher = function ()
    {
    })._removeEventListener = function (queue, event, handler)
    {
        if (queue != undefined)
        {
            var _loc5 = queue.length;
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5)
            {
                var _loc7 = queue[_loc6];
                if (_loc7 == handler)
                {
                    queue.splice(_loc6, 1);
                    return;
                } // end if
            } // end while
        } // end if
    };
    (_global.mx.events.EventDispatcher = function ()
    {
    }).initialize = function (object)
    {
        if (mx.events.EventDispatcher._fEventDispatcher == undefined)
        {
            mx.events.EventDispatcher._fEventDispatcher = new mx.events.EventDispatcher();
        } // end if
        object.__proto__.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
        object.__proto__.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
        object.__proto__.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
        object.__proto__.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
    };
    _loc1.dispatchQueue = function (queueObj, eventObj)
    {
        var _loc4 = "__q_" + eventObj.type;
        var _loc5 = queueObj[_loc4];
        if (_loc5 != undefined)
        {
            for (var _loc6 in _loc5)
            {
                var _loc7 = _loc5[_loc6];
                var _loc8 = typeof(_loc7);
                if (_loc8 == "object" || _loc8 == "movieclip")
                {
                    if (_loc7.handleEvent == undefined)
                    {
                        _loc7[eventObj.type](eventObj);
                    }
                    else
                    {
                        _loc7.handleEvent(eventObj);
                    } // end else if
                    continue;
                } // end if
                _loc7.apply(queueObj, [eventObj]);
            } // end of for...in
        } // end if
    };
    _loc1.dispatchEvent = function (eventObj)
    {
        if (eventObj.target == undefined)
        {
            eventObj.target = this;
        } // end if
        this[eventObj.type + "Handler"](eventObj);
        this.dispatchQueue(this, eventObj);
    };
    _loc1.addEventListener = function (event, handler)
    {
        var _loc4 = "__q_" + event;
        if (this[_loc4] == undefined)
        {
            this[_loc4] = new Array();
        } // end if
        _global.ASSetPropFlags(this, _loc4, 1);
        mx.events.EventDispatcher._removeEventListener(this[_loc4], event, handler);
        this[_loc4].push(handler);
    };
    _loc1.removeEventListener = function (event, handler)
    {
        var _loc4 = "__q_" + event;
        mx.events.EventDispatcher._removeEventListener(this[_loc4], event, handler);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.mx.events.EventDispatcher = function ()
    {
    })._fEventDispatcher = undefined;
} // end if
#endinitclip
