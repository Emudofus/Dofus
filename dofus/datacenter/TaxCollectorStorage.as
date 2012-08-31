// Action script...

// [Initial MovieClip Action of sprite 937]
#initclip 149
class dofus.datacenter.TaxCollectorStorage extends dofus.datacenter.Shop
{
    var initialize, _nKamas, dispatchEvent, __get__Kama, __set__Kama;
    function TaxCollectorStorage()
    {
        super();
        this.initialize();
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
} // End of Class
#endinitclip
