// Action script...

// [Initial MovieClip Action of sprite 833]
#initclip 45
class ank.utils.ExtendedObject extends Object
{
    var _items, _count, dispatchEvent;
    function ExtendedObject()
    {
        super();
        this.initialize();
    } // End of the function
    function initialize(Void)
    {
        this.clear();
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    function clear(Void)
    {
        _items = new Object();
        _count = 0;
        this.dispatchEvent({type: "modelChanged"});
    } // End of the function
    function addItemAt(key, item)
    {
        _items[key] = item;
        ++_count;
        this.dispatchEvent({type: "modelChanged"});
    } // End of the function
    function removeItemAt(key)
    {
        var _loc2 = _items[key];
        delete _items[key];
        --_count;
        this.dispatchEvent({type: "modelChanged"});
        return (_loc2);
    } // End of the function
    function removeAll(Void)
    {
        this.clear();
    } // End of the function
    function removeAllExcept(key)
    {
        for (var _loc3 in _items)
        {
            if (_loc3 == key)
            {
                continue;
            } // end if
            delete _items[_loc3];
        } // end of for...in
        _count = 1;
        this.dispatchEvent({type: "modelChanged"});
    } // End of the function
    function replaceItemAt(key, item)
    {
        if (_items[key] == undefined)
        {
            return;
        } // end if
        _items[key] = item;
        this.dispatchEvent({type: "modelChanged"});
    } // End of the function
    function getLength(Void)
    {
        return (_count);
    } // End of the function
    function getItemAt(key)
    {
        return (_items[key]);
    } // End of the function
    function getItems(Void)
    {
        return (_items);
    } // End of the function
    function getKeys(Void)
    {
        var _loc2 = new Array();
        for (var _loc3 in _items)
        {
            _loc2.push(_loc3);
        } // end of for...in
        return (_loc2);
    } // End of the function
    function getPropertyValues(sProperty)
    {
        var _loc2 = new Array();
        for (var _loc4 in _items)
        {
            _loc2.push(_items[_loc4][sProperty]);
        } // end of for...in
        return (_loc2);
    } // End of the function
} // End of Class
#endinitclip
