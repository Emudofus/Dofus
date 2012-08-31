// Action script...

// [Initial MovieClip Action of sprite 811]
#initclip 5
class ank.gapi.core.UIAdvancedComponent extends ank.gapi.core.UIBasicComponent
{
    var _oAPI, __get__api, _parent, _sInstanceName, __get__instanceName, gapi, __set__api, __set__instanceName;
    function UIAdvancedComponent()
    {
        super();
    } // End of the function
    function set api(oAPI)
    {
        _oAPI = oAPI;
        //return (this.api());
        null;
    } // End of the function
    function get api()
    {
        if (_oAPI == undefined)
        {
            return (_parent.api);
        }
        else
        {
            return (_oAPI);
        } // end else if
    } // End of the function
    function set instanceName(sInstanceName)
    {
        _sInstanceName = sInstanceName;
        //return (this.instanceName());
        null;
    } // End of the function
    function get instanceName()
    {
        return (_sInstanceName);
    } // End of the function
    function callClose()
    {
        return (false);
    } // End of the function
    function unloadThis()
    {
        gapi.unloadUIComponent(_sInstanceName);
    } // End of the function
} // End of Class
#endinitclip
