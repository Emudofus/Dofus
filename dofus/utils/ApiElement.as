// Action script...

// [Initial MovieClip Action of sprite 829]
#initclip 41
class dofus.utils.ApiElement extends Object
{
    var _oAPI, __get__api, __set__api;
    function ApiElement()
    {
        super();
    } // End of the function
    function get api()
    {
        return (_oAPI);
    } // End of the function
    function set api(oApi)
    {
        _oAPI = oApi;
        //return (this.api());
        null;
    } // End of the function
    function initialize(oAPI)
    {
        _oAPI = oAPI;
    } // End of the function
    function addToQueue(oCall)
    {
        dofus.utils.ApiElement._aQueue.push(oCall);
        if (_root.onEnterFrame == undefined)
        {
            _root.onEnterFrame = runQueue;
        } // end if
    } // End of the function
    function runQueue()
    {
        var _loc2 = dofus.utils.ApiElement._aQueue.shift();
        _loc2.method.apply(_loc2.object, _loc2.params);
        if (dofus.utils.ApiElement._aQueue.length == 0)
        {
            delete _root.onEnterFrame;
        } // end if
    } // End of the function
    static var _aQueue = new Array();
} // End of Class
#endinitclip
