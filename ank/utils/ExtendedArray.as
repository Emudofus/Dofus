// Action script...

// [Initial MovieClip Action of sprite 20747]
#initclip 12
if (!ank.utils.ExtendedArray)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.ExtendedArray = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.removeEventListener = function ()
    {
    };
    _loc1.addEventListener = function ()
    {
    };
    _loc1.dispatchEvent = function ()
    {
    };
    _loc1.dispatchQueue = function ()
    {
    };
    _loc1.initialize = function (Void)
    {
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.createFromArray = function (aData)
    {
        this.splice(0, this.length);
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aData.length)
        {
            this.push(aData[_loc3]);
        } // end while
    };
    _loc1.removeAll = function (Void)
    {
        this.splice(0, this.length);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    };
    _loc1.push = function (value)
    {
        var _loc4 = super.push(value);
        this.dispatchEvent({type: "modelChanged", eventName: "addItem"});
        return (_loc4);
    };
    _loc1.pop = function ()
    {
        var _loc3 = super.pop();
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
        return (_loc3);
    };
    _loc1.shift = function ()
    {
        var _loc3 = super.shift();
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
        return (_loc3);
    };
    _loc1.unshift = function (value)
    {
        var _loc4 = super.unshift(value);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
        return (_loc4);
    };
    _loc1.reverse = function ()
    {
        super.reverse();
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    };
    _loc1.replaceAll = function (nStart, aNew)
    {
        var _loc4 = [nStart, 0];
        for (var k in aNew)
        {
            _loc4.push(aNew[k]);
        } // end of for...in
        this.splice.apply(this, _loc4);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    };
    _loc1.removeItems = function (nIndex, deleteCount)
    {
        this.splice(nIndex, deleteCount);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    };
    _loc1.updateItem = function (nIndex, newValue)
    {
        this.splice(nIndex, 1, newValue);
        this.dispatchEvent({type: "modelChanged", eventName: "updateOne", updateIndex: nIndex});
    };
    _loc1.findFirstItem = function (sPropName, propValue)
    {
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this.length)
        {
            var _loc5 = this[_loc4];
            if (_loc5[sPropName] == propValue)
            {
                return ({index: _loc4, item: _loc5});
            } // end if
        } // end while
        return ({index: -1});
    };
    _loc1.clone = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this.length)
        {
            _loc2.push(this[_loc3].clone());
        } // end while
        return (_loc2);
    };
    _loc1.shuffle = function ()
    {
        var _loc2 = this.clone();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            var _loc4 = _loc2[_loc3];
            var _loc5 = random(_loc2.length);
            _loc2[_loc3] = _loc2[_loc5];
            _loc2[_loc5] = _loc4;
        } // end while
        return (_loc2);
    };
    _loc1.bubbleSortOn = function (prop, flags)
    {
        if ((flags & Array.ASCENDING) == 0 && (flags & Array.DESCENDING) == 0)
        {
            flags = flags | Array.ASCENDING;
        } // end if
        
        while ()
        {
            var _loc4 = false;
            var _loc5 = 1;
            
            while (++_loc5, _loc5 < this.length)
            {
                if ((flags & Array.ASCENDING) > 0 && this[_loc5 - 1][prop] > this[_loc5][prop] || (flags & Array.DESCENDING) > 0 && this[_loc5 - 1][prop] < this[_loc5][prop])
                {
                    var _loc6 = this[_loc5 - 1];
                    this[_loc5 - 1] = this[_loc5];
                    this[_loc5] = _loc6;
                    _loc4 = true;
                } // end if
            } // end while
        } // end while
    };
    _loc1.concat = function (oArray)
    {
        var _loc4 = super.concat(oArray);
        var _loc5 = new ank.utils.ExtendedArray();
        _loc5.createFromArray(_loc4);
        return (_loc5);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
