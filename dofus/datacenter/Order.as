// Action script...

// [Initial MovieClip Action of sprite 911]
#initclip 123
class dofus.datacenter.Order extends Object
{
    var api, _nIndex, __get__index, _oOrderInfos, __get__alignment, __get__iconFile, __set__index, __get__name;
    function Order(nIndex)
    {
        super();
        api = _global.API;
        this.initialize(nIndex);
    } // End of the function
    function get index()
    {
        return (_nIndex);
    } // End of the function
    function set index(nIndex)
    {
        _nIndex = isNaN(nIndex) || nIndex == undefined ? (0) : (nIndex);
        //return (this.index());
        null;
    } // End of the function
    function get name()
    {
        return (_oOrderInfos.n);
    } // End of the function
    function get alignment()
    {
        return (new dofus.datacenter.Alignment(_oOrderInfos.a));
    } // End of the function
    function get iconFile()
    {
        return (dofus.Constants.ORDERS_PATH + _nIndex + ".swf");
    } // End of the function
    function initialize(nIndex)
    {
        _nIndex = nIndex;
        _oOrderInfos = api.lang.getAlignmentOrder(nIndex);
    } // End of the function
} // End of Class
#endinitclip
