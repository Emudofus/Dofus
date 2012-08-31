// Action script...

// [Initial MovieClip Action of sprite 944]
#initclip 156
class dofus.datacenter.House extends Object
{
    var _nID, _sName, _sDescription, _nPrice, __get__price, __get__localOwner, __get__ownerName, dispatchEvent, __get__isForSale, __get__isLocked, api, __get__description, __get__id, __set__isForSale, __set__isLocked, __set__localOwner, __get__name, __set__ownerName, __set__price;
    function House(nID)
    {
        super();
        this.initialize(nID);
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get name()
    {
        return (_sName);
    } // End of the function
    function get description()
    {
        return (_sDescription);
    } // End of the function
    function set price(nPrice)
    {
        _nPrice = Number(nPrice);
        //return (this.price());
        null;
    } // End of the function
    function get price()
    {
        return (_nPrice);
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
    function set ownerName(sOwnerName)
    {
        _sOwnerName = sOwnerName;
        //return (this.ownerName());
        null;
    } // End of the function
    function get ownerName()
    {
        if (typeof(_sOwnerName) == "string")
        {
            if (_sOwnerName.length > 0)
            {
                return (_sOwnerName);
            } // end if
        } // end if
        return (null);
    } // End of the function
    function set isForSale(bForSale)
    {
        _bForSale = bForSale;
        this.dispatchEvent({type: "forsale", value: bForSale});
        //return (this.isForSale());
        null;
    } // End of the function
    function get isForSale()
    {
        return (_bForSale);
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
    function initialize(nID)
    {
        api = _global.API;
        mx.events.EventDispatcher.initialize(this);
        _nID = nID;
        var _loc3 = api.lang.getHouseText(nID);
        _sName = _loc3.n;
        _sDescription = _loc3.d;
    } // End of the function
    var _bLocalOwner = false;
    var _sOwnerName = new String();
    var _bForSale = false;
    var _bLocked = false;
} // End of Class
#endinitclip
