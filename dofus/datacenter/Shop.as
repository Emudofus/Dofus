// Action script...

// [Initial MovieClip Action of sprite 935]
#initclip 147
class dofus.datacenter.Shop extends Object
{
    var _sName, __get__name, _sGfx, __get__gfx, _eaInventory, dispatchEvent, __get__inventory, __set__gfx, __set__inventory, __set__name;
    function Shop()
    {
        super();
    } // End of the function
    function Storage()
    {
        this.initialize();
    } // End of the function
    function set name(sName)
    {
        _sName = sName;
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        return (_sName);
    } // End of the function
    function set gfx(sGfx)
    {
        _sGfx = sGfx;
        //return (this.gfx());
        null;
    } // End of the function
    function get gfx()
    {
        return (_sGfx);
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
    function initialize()
    {
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
} // End of Class
#endinitclip
