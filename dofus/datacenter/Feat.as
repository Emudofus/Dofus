// Action script...

// [Initial MovieClip Action of sprite 912]
#initclip 124
class dofus.datacenter.Feat extends Object
{
    var api, _nIndex, __get__index, _oFeatInfos, _nLevel, _aParams, __get__effect, __get__iconFile, __set__index, __get__level, __get__name;
    function Feat(nIndex, nLevel, aParams)
    {
        super();
        api = _global.API;
        this.initialize(nIndex, nLevel, aParams);
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
        return (_oFeatInfos.n);
    } // End of the function
    function get level()
    {
        return (_nLevel);
    } // End of the function
    function get effect()
    {
        return (new dofus.datacenter.FeatEffect(_oFeatInfos.e, _aParams));
    } // End of the function
    function get iconFile()
    {
        return (dofus.Constants.FEATS_PATH + _oFeatInfos.g + ".swf");
    } // End of the function
    function initialize(nIndex, nLevel, aParams)
    {
        _nIndex = nIndex;
        _nLevel = nLevel;
        _aParams = aParams;
        _oFeatInfos = api.lang.getAlignmentFeat(nIndex);
    } // End of the function
} // End of Class
#endinitclip
