// Action script...

// [Initial MovieClip Action of sprite 176]
#initclip 11
class ank.utils.ExtendedArray extends Array
{
    var length, splice;
    function ExtendedArray()
    {
        super();
        this.initialize();
    } // End of the function
    function removeEventListener()
    {
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function dispatchEvent()
    {
    } // End of the function
    function dispatchQueue()
    {
    } // End of the function
    function initialize(Void)
    {
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    function removeAll(Void)
    {
        this.splice(0, length);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    } // End of the function
    function push(value)
    {
        var _loc3 = super.push(value);
        this.dispatchEvent({type: "modelChanged", eventName: "addItem"});
        return (_loc3);
    } // End of the function
    function pop()
    {
        var _loc3 = super.pop();
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
        return (_loc3);
    } // End of the function
    function shift()
    {
        var _loc3 = super.shift();
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
        return (_loc3);
    } // End of the function
    function unshift(value)
    {
        var _loc3 = super.unshift(value);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
        return (_loc3);
    } // End of the function
    function reverse()
    {
        super.reverse();
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    } // End of the function
    function replaceAll(nStart, aNew)
    {
        aNew.splice(0, 0, nStart, length - nStart);
        splice.apply(this, aNew);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    } // End of the function
    function removeItems(nIndex, deleteCount)
    {
        this.splice(nIndex, deleteCount);
        this.dispatchEvent({type: "modelChanged", eventName: "updateAll"});
    } // End of the function
    function updateItem(nIndex, newValue)
    {
        this.splice(nIndex, 1, newValue);
        this.dispatchEvent({type: "modelChanged", eventName: "updateOne", updateIndex: nIndex});
    } // End of the function
    function findFirstItem(sPropName, propValue)
    {
        for (var _loc2 = 0; _loc2 < length; ++_loc2)
        {
            var _loc3 = this[_loc2];
            if (_loc3[sPropName] == propValue)
            {
                return ({index: _loc2, item: _loc3});
            } // end if
        } // end of for
        return ({index: -1});
    } // End of the function
} // End of Class
#endinitclip
