// Action script...

// [Initial MovieClip Action of sprite 936]
#initclip 148
class dofus.datacenter.Storage extends Object
{
    var __get__localOwner, dispatchEvent, __get__isLocked, _eaInventory, __get__inventory, _nKamas, __get__Kama, __set__Kama, __set__inventory, __set__isLocked, __set__localOwner;
    function Storage()
    {
        super();
        this.initialize();
    } // End of the function
    function set localOwner(bLocalOwner)
    {
        _bLocalOwner = bLocalOwner;
        //return (this.localOwner());
        null;
    } // End of the function
    function get localOwner()
    {
        return (_bLocalOwner);
    } // End of the function
    function set isLocked(bLocked)
    {
        _bLocked = bLocked;
        this.dispatchEvent({type: "locked", value: bLocked});
        //return (this.isLocked());
        null;
    } // End of the function
    function get isLocked()
    {
        return (_bLocked);
    } // End of the function
    function set inventory(eaInventory)
    {
        _eaInventory = eaInventory;
        this.dispatchEvent({type: "modelChanged"});
        //return (this.inventory());
        null;
    } // End of the function
    function get inventory()
    {
        return (_eaInventory);
    } // End of the function
    function set Kama(nKamas)
    {
        _nKamas = nKamas;
        this.dispatchEvent({type: "kamaChanged", value: nKamas});
        //return (this.Kama());
        null;
    } // End of the function
    function get Kama()
    {
        return (_nKamas);
    } // End of the function
    function initialize()
    {
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    var _bLocalOwner = false;
    var _bLocked = false;
} // End of Class
#endinitclip
