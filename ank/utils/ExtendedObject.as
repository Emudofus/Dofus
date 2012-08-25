// Action script...

// [Initial MovieClip Action of sprite 20791]
#initclip 56
if (!ank.utils.ExtendedObject)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.ExtendedObject = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.initialize = function (Void)
    {
        this.clear();
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.clear = function (Void)
    {
        this._items = new Object();
        this._count = 0;
        this.dispatchEvent({type: "modelChanged"});
    };
    _loc1.addItemAt = function (key, item)
    {
        if (this._items[key] == undefined)
        {
            ++this._count;
        } // end if
        this._items[key] = item;
        this.dispatchEvent({type: "modelChanged"});
    };
    _loc1.removeItemAt = function (key)
    {
        var _loc3 = this._items[key];
        delete this._items[key];
        --this._count;
        this.dispatchEvent({type: "modelChanged"});
        return (_loc3);
    };
    _loc1.removeAll = function (Void)
    {
        this.clear();
    };
    _loc1.removeAllExcept = function (key)
    {
        for (var k in this._items)
        {
            if (k == key)
            {
                continue;
            } // end if
            delete this._items[k];
        } // end of for...in
        this._count = 1;
        this.dispatchEvent({type: "modelChanged"});
    };
    _loc1.replaceItemAt = function (key, item)
    {
        if (this._items[key] == undefined)
        {
            return;
        } // end if
        this._items[key] = item;
        this.dispatchEvent({type: "modelChanged"});
    };
    _loc1.getLength = function (Void)
    {
        return (this._count);
    };
    _loc1.getItemAt = function (key)
    {
        return (this._items[key]);
    };
    _loc1.getItems = function (Void)
    {
        return (this._items);
    };
    _loc1.getKeys = function ()
    {
        var _loc2 = new Array();
        for (var k in this._items)
        {
            _loc2.push(k);
        } // end of for...in
        return (_loc2);
    };
    _loc1.getPropertyValues = function (sProperty)
    {
        var _loc3 = new Array();
        for (var k in this._items)
        {
            _loc3.push(this._items[k][sProperty]);
        } // end of for...in
        return (_loc3);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
