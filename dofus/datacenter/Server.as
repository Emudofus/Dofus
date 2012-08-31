// Action script...

// [Initial MovieClip Action of sprite 927]
#initclip 139
class dofus.datacenter.Server
{
    var _nID, __get__id, _nState, __get__state, api, _nCompletion, __get__completion, __set__completion, __get__description, __set__id, __get__label, __get__language, __set__state, __get__stateStr;
    function Server(nID, nState, nCompletion)
    {
        this.initialize(nID, nState, nCompletion);
    } // End of the function
    function set id(nID)
    {
        _nID = nID;
        //return (this.id());
        null;
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function set state(nState)
    {
        _nState = nState;
        //return (this.state());
        null;
    } // End of the function
    function get state()
    {
        return (_nState);
    } // End of the function
    function get stateStr()
    {
        switch (_nState)
        {
            case dofus.datacenter.Server.SERVER_OFFLINE:
            {
                return (api.lang.getText("SERVER_OFFLINE"));
                break;
            } 
            case dofus.datacenter.Server.SERVER_ONLINE:
            {
                return (api.lang.getText("SERVER_ONLINE"));
                break;
            } 
            case dofus.datacenter.Server.SERVER_STARTING:
            {
                return (api.lang.getText("SERVER_STARTING"));
                break;
            } 
        } // End of switch
        return ("");
    } // End of the function
    function set completion(nCompletion)
    {
        _nCompletion = nCompletion;
        //return (this.completion());
        null;
    } // End of the function
    function get completion()
    {
        return (_nCompletion);
    } // End of the function
    function get label()
    {
        return (api.lang.getServerInfos(_nID).n);
    } // End of the function
    function get description()
    {
        return (api.lang.getServerInfos(_nID).d);
    } // End of the function
    function get language()
    {
        return (api.lang.getServerInfos(_nID).l);
    } // End of the function
    function initialize(nID, nState, nCompletion)
    {
        api = _global.API;
        _nID = nID;
        _nState = nState;
        _nCompletion = nCompletion;
    } // End of the function
    static var SERVER_OFFLINE = 0;
    static var SERVER_ONLINE = 1;
    static var SERVER_STARTING = 2;
} // End of Class
#endinitclip
