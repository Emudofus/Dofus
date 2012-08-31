// Action script...

// [Initial MovieClip Action of sprite 934]
#initclip 146
class dofus.datacenter.Exchange extends Object
{
    var _eaInventory, __get__inventory, _eaLocalGarbage, _eaDistantGarbage, _eaReadyStates, _nDistantPlayerID, dispatchEvent, __get__localKama, __get__distantKama, __get__distantGarbage, __set__distantKama, __get__distantPlayerID, __set__inventory, __get__localGarbage, __set__localKama, __get__readyStates;
    function Exchange(nDistantPlayerID)
    {
        super();
        this.initialize(nDistantPlayerID);
    } // End of the function
    function set inventory(eaInventory)
    {
        _eaInventory = eaInventory;
        //return (this.inventory());
        null;
    } // End of the function
    function get inventory()
    {
        return (_eaInventory);
    } // End of the function
    function get localGarbage()
    {
        return (_eaLocalGarbage);
    } // End of the function
    function get distantGarbage()
    {
        return (_eaDistantGarbage);
    } // End of the function
    function get readyStates()
    {
        return (_eaReadyStates);
    } // End of the function
    function get distantPlayerID()
    {
        return (_nDistantPlayerID);
    } // End of the function
    function set localKama(nLocalKama)
    {
        _nLocalKama = nLocalKama;
        this.dispatchEvent({type: "localKamaChange", value: nLocalKama});
        //return (this.localKama());
        null;
    } // End of the function
    function get localKama()
    {
        return (_nLocalKama);
    } // End of the function
    function set distantKama(nDistantKama)
    {
        _nDistantKama = nDistantKama;
        this.dispatchEvent({type: "distantKamaChange", value: nDistantKama});
        //return (this.distantKama());
        null;
    } // End of the function
    function get distantKama()
    {
        return (_nDistantKama);
    } // End of the function
    function initialize(nDistantPlayerID)
    {
        mx.events.EventDispatcher.initialize(this);
        _nDistantPlayerID = nDistantPlayerID;
        _eaLocalGarbage = new ank.utils.ExtendedArray();
        _eaDistantGarbage = new ank.utils.ExtendedArray();
        _eaReadyStates = new ank.utils.ExtendedArray();
        _eaReadyStates[0] = false;
        _eaReadyStates[1] = false;
    } // End of the function
    function clearLocalGarbage()
    {
        _eaLocalGarbage.removeAll();
    } // End of the function
    function clearDistantGarbage()
    {
        _eaDistantGarbage.removeAll();
    } // End of the function
    var _nLocalKama = 0;
    var _nDistantKama = 0;
} // End of Class
#endinitclip
