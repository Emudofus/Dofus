// Action script...

// [Initial MovieClip Action of sprite 922]
#initclip 134
class dofus.aks.Handler extends dofus.utils.ApiElement
{
    var _oAKS, _oAPI, __get__aks;
    function Handler()
    {
        super();
    } // End of the function
    function get aks()
    {
        return (_oAKS);
    } // End of the function
    function initialize(oAKS, oAPI)
    {
        super.initialize(oAPI);
        _oAKS = oAKS;
        _oAPI = oAPI;
    } // End of the function
} // End of Class
#endinitclip
