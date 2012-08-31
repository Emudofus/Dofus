// Action script...

// [Initial MovieClip Action of sprite 910]
#initclip 122
class dofus.datacenter.Specialization extends Object
{
    var api, _nIndex, __get__index, _oSpecInfos, _eaFeats, __get__alignment, __get__description, __get__feats, __set__index, __get__name, __get__order;
    function Specialization(nIndex)
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
        return (_oSpecInfos.n);
    } // End of the function
    function get description()
    {
        return (_oSpecInfos.d);
    } // End of the function
    function get order()
    {
        return (new dofus.datacenter.Order(_oSpecInfos.o));
    } // End of the function
    function get alignment()
    {
        return (new dofus.datacenter.Alignment(order.alignment.index, _oSpecInfos.av));
    } // End of the function
    function get feats()
    {
        return (_eaFeats);
    } // End of the function
    function initialize(nIndex)
    {
        _nIndex = nIndex;
        _oSpecInfos = api.lang.getAlignmentSpecialization(nIndex);
        _eaFeats = new ank.utils.ExtendedArray();
        var _loc3 = _oSpecInfos.f;
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            _eaFeats.push(new dofus.datacenter.Feat(_loc3[_loc2][0], _loc3[_loc2][1], _loc3[_loc2][2]));
        } // end of for
    } // End of the function
} // End of Class
#endinitclip
