// Action script...

// [Initial MovieClip Action of sprite 828]
#initclip 40
class dofus.utils.DofusConfiguration
{
    var _sPlayHost, __get__playHost, _sDLHost, __get__dlHost, __get__language, __set__dlHost, __get__dlHostLink, __get__isValid, __set__language, __set__playHost, __get__playHostLink;
    function DofusConfiguration()
    {
        if (_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] == undefined)
        {
            _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
        } // end if
    } // End of the function
    function set playHost(sPlayHost)
    {
        _sPlayHost = sPlayHost;
        //return (this.playHost());
        null;
    } // End of the function
    function get playHost()
    {
        return (_sPlayHost);
    } // End of the function
    function get playHostLink()
    {
        return ("http://" + _sPlayHost);
    } // End of the function
    function set dlHost(sDLHost)
    {
        _sDLHost = sDLHost;
        //return (this.dlHost());
        null;
    } // End of the function
    function get dlHost()
    {
        return (_sDLHost);
    } // End of the function
    function get dlHostLink()
    {
        return ("http://" + _sDLHost);
    } // End of the function
    function set language(sLanguage)
    {
        _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.language = sLanguage;
        //return (this.language());
        null;
    } // End of the function
    function get language()
    {
        var _loc2 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.language;
        if (_loc2 == undefined)
        {
            return (System.capabilities.language == "fr" ? ("fr") : ("en"));
        }
        else
        {
            return (_loc2);
        } // end else if
    } // End of the function
    function get isValid()
    {
        return (_sPlayHost != undefined && _sDLHost != undefined);
    } // End of the function
} // End of Class
#endinitclip
