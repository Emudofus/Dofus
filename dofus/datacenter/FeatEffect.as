// Action script...

// [Initial MovieClip Action of sprite 913]
#initclip 125
class dofus.datacenter.FeatEffect extends Object
{
    var api, _nIndex, __get__index, _aParams, _sFeatEffectInfos, __get__params, __get__description, __set__index, __set__params;
    function FeatEffect(nIndex, aParams)
    {
        super();
        api = _global.API;
        this.initialize(nIndex, aParams);
    } // End of the function
    function get index()
    {
        return (_nIndex);
    } // End of the function
    function set index(nIndex)
    {
        _nIndex = nIndex;
        //return (this.index());
        null;
    } // End of the function
    function get description()
    {
        return (ank.utils.PatternDecoder.getDescription(_sFeatEffectInfos, _aParams));
    } // End of the function
    function set params(aParams)
    {
        _aParams = aParams;
        //return (this.params());
        null;
    } // End of the function
    function get params()
    {
        return (_aParams);
    } // End of the function
    function initialize(nIndex, aParams)
    {
        _nIndex = nIndex;
        _aParams = aParams;
        _sFeatEffectInfos = api.lang.getAlignmentFeatEffect(nIndex);
    } // End of the function
} // End of Class
#endinitclip
